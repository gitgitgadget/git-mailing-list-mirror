From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] index-pack --verify: read anomalous offsets from v2 idx
 file
Date: Mon, 28 Feb 2011 01:49:43 -0800
Message-ID: <1298886583-30965-6-git-send-email-gitster@pobox.com>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 10:50:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtzkH-00016P-RN
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab1B1JuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:50:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab1B1JuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 04:50:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C12DA3550;
	Mon, 28 Feb 2011 04:51:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=f8DW
	mxja7A0PBm3yfG3oOlHWEmc=; b=xmVKgpYAxeAZ7vSkvqTgG17+bHyRmvbK4z36
	6HKCJPpZcBq2ZCE/h32mt6XtPlxltgzQaaezDwupAzRf6N6FgEEbXVk2U0CpggtD
	XlWpCITUVqM2r5bIOmsAiHuEValfIE4E5qwZLjmmjPs3dtsyNhjJftSq7NQQVpCF
	B1uJR70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	IAjb3DF4yFK7ucprRk3IHQsyshi8+jyKPudD1kd4k6unxC0snVzHxWrteC1rGVSj
	cDrVhE6E9ASkmqinGOqrS5DWDVVPghoarSqrFX8ixzCXk+H+hCn1p+WgwhAhrqIW
	PyHVphS9arzLaMREnSBxmYKFFJAF7DCLzQV3BFAq07o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD1E5354D;
	Mon, 28 Feb 2011 04:51:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B29F1354C; Mon, 28 Feb 2011
 04:51:25 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.249.g4aa72
In-Reply-To: <1298886583-30965-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4FB9E846-4320-11E0-A8BC-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168091>

A pack v2 .idx file usually records offset using 64-bit representation
only when the offset does not fit within 31-bit, but you can handcraft
your .idx file to record smaller offset using 64-bit, storing all zero
in the upper 4-byte.  By inspecting the original idx file when running
index-pack --verify, encode such low offsets that do not need to be in
64-bit but are encoded using 64-bit just like the original idx file so
that we can still validate the pack/idx pair by comparing the idx file
recomputed with the original.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This "fixes" the shortcoming of 3/5 that breaks on a handcrafted .idx
   in a way that does not even depend on the off32_limit logic.

 builtin/index-pack.c  |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 pack-write.c          |   18 +++++++++++++++++-
 pack.h                |    8 ++++++++
 t/t5302-pack-index.sh |    2 +-
 4 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 24a9a16..513fbbc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -891,6 +891,51 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 	return git_default_config(k, v, cb);
 }
 
+static int cmp_uint32(const void *a_, const void *b_)
+{
+	uint32_t a = *((uint32_t *)a_);
+	uint32_t b = *((uint32_t *)b_);
+
+	return (a < b) ? -1 : (a != b);
+}
+
+static void read_v2_anomalous_offsets(struct packed_git *p,
+				      struct pack_idx_option *opts)
+{
+	const uint32_t *idx1, *idx2;
+	uint32_t i;
+
+	/* The address of the 4-byte offset table */
+	idx1 = (((const uint32_t *)p->index_data)
+		+ 2 /* 8-byte header */
+		+ 256 /* fan out */
+		+ 5 * p->num_objects /* 20-byte SHA-1 table */
+		+ p->num_objects /* CRC32 table */
+		);
+
+	/* The address of the 8-byte offset table */
+	idx2 = idx1 + p->num_objects;
+
+	for (i = 0; i < p->num_objects; i++) {
+		uint32_t off = ntohl(idx1[i]);
+		if (!(off & 0x80000000))
+			continue;
+		off = off & 0x7fffffff;
+		if (idx2[off * 2])
+			continue;
+		/*
+		 * The real offset is ntohl(idx2[off * 2]) in high 4
+		 * octets, and ntohl(idx2[off * 2 + 1]) in low 4
+		 * octets.  But idx2[off * 2] is Zero!!!
+		 */
+		ALLOC_GROW(opts->anomaly, opts->anomaly_nr + 1, opts->anomaly_alloc);
+		opts->anomaly[opts->anomaly_nr++] = ntohl(idx2[off * 2 + 1]);
+	}
+
+	if (1 < opts->anomaly_nr)
+		qsort(opts->anomaly, opts->anomaly_nr, sizeof(uint32_t), cmp_uint32);
+}
+
 static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 {
 	struct packed_git *p = add_packed_git(pack_name, strlen(pack_name), 1);
@@ -903,6 +948,9 @@ static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 	/* Read the attributes from the existing idx file */
 	opts->version = p->index_version;
 
+	if (opts->version == 2)
+		read_v2_anomalous_offsets(p, opts);
+
 	/*
 	 * Get rid of the idx file as we do not need it anymore.
 	 * NEEDSWORK: extract this bit from free_pack_by_name() in
diff --git a/pack-write.c b/pack-write.c
index 92e7eef..9cd3bfb 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -16,9 +16,25 @@ static int sha1_compare(const void *_a, const void *_b)
 	return hashcmp(a->sha1, b->sha1);
 }
 
+static int cmp_uint32(const void *a_, const void *b_)
+{
+	uint32_t a = *((uint32_t *)a_);
+	uint32_t b = *((uint32_t *)b_);
+
+	return (a < b) ? -1 : (a != b);
+}
+
 static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
 {
-	return (offset >> 31) || (opts->off32_limit < offset);
+	uint32_t ofsval;
+
+	if ((offset >> 31) || (opts->off32_limit < offset))
+		return 1;
+	if (!opts->anomaly_nr)
+		return 0;
+	ofsval = offset;
+	return !!bsearch(&ofsval, opts->anomaly, opts->anomaly_nr,
+			 sizeof(ofsval), cmp_uint32);
 }
 
 /*
diff --git a/pack.h b/pack.h
index dddafdd..722a54e 100644
--- a/pack.h
+++ b/pack.h
@@ -41,6 +41,14 @@ struct pack_idx_option {
 
 	uint32_t version;
 	uint32_t off32_limit;
+
+	/*
+	 * List of offsets that would fit within off32_limit but
+	 * need to be written out as 64-bit entity for byte-for-byte
+	 * verification.
+	 */
+	int anomaly_alloc, anomaly_nr;
+	uint32_t *anomaly;
 };
 
 extern void reset_pack_idx_option(struct pack_idx_option *);
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 7c5fa03..76bcaca 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -107,7 +107,7 @@ test_expect_success OFF64_T 'index-pack --verify on 64-bit offset v2 (cheat)' '
 	git index-pack --verify --index-version=2,0x40000 "test-3-${pack3}.pack"
 '
 
-test_expect_failure OFF64_T 'index-pack --verify on 64-bit offset v2' '
+test_expect_success OFF64_T 'index-pack --verify on 64-bit offset v2' '
 	git index-pack --verify "test-3-${pack3}.pack"
 '
 
-- 
1.7.4.1.249.g4aa72
