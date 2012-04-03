From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/9] read-cache.c: write index v4 format
Date: Tue,  3 Apr 2012 15:53:16 -0700
Message-ID: <1333493596-14202-10-git-send-email-gitster@pobox.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCbh-0006ve-TH
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab2DCWxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187Ab2DCWxf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F7227F94
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Vb0V
	TCuZcI78Of06IV0kmJ/FpiE=; b=vTjmApiYXwKLvYMwRlBuSI2gcoTXmUnXAMaP
	JKybvUy2OUNgX6WvNTCEWbLRMuLGY3M4lc/0pJXyHdD0m3LF6svTlcyovNrl7Dl7
	SfwA1oTxlWFIeMFbyMiujfd/7qqBAzRfeFtFMLXVwMrnSPLOfpb+sad+tq53TaF7
	txEKPug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Qyq0xi
	BssYyTVnL2roPFZ2yKFKN7fVroRDp4lMOLpdO9D0a/gFkwkMa0+DakGNaNI6/qYc
	wxKkC8UwhIKLQwjPn4up3Iaal0mzzRokLqOusDmNHZmx+sjdDDlXkFxR8Ruo4A0v
	J39YMPzxgg9t9iI0FFVA3WVUMTH8o9n/8amL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06D807F93
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DBC37F90 for
 <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D76D89BE-7DDF-11E1-A981-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194666>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/update-index.c |    2 ++
 cache.h                |    4 ++++
 config.c               |   11 ++++++++++
 environment.c          |    1 +
 read-cache.c           |   56 ++++++++++++++++++++++++++++++++++++++++--------
 5 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6a23fa..b663f45 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -791,6 +791,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			"(for porcelains) forget saved unresolved conflicts",
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			resolve_undo_clear_callback},
+		OPT_INTEGER(0, "index-format", &preferred_index_format,
+			    "write index in this format"),
 		OPT_END()
 	};
 
diff --git a/cache.h b/cache.h
index 65a7aba..bdec32c 100644
--- a/cache.h
+++ b/cache.h
@@ -105,6 +105,9 @@ struct cache_header {
 	unsigned int hdr_entries;
 };
 
+#define SUPPORTED_INDEX_FORMAT_LB 2
+#define SUPPORTED_INDEX_FORMAT_UB 4
+
 /*
  * The "cache_time" is just the low 32 bits of the
  * time. It doesn't matter if it overflows - we only
@@ -537,6 +540,7 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
+extern int preferred_index_format;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
diff --git a/config.c b/config.c
index 68d3294..0244a85 100644
--- a/config.c
+++ b/config.c
@@ -564,6 +564,17 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.indexformat")) {
+		int val = git_config_int(var, value);
+		if (val < SUPPORTED_INDEX_FORMAT_LB ||
+		    SUPPORTED_INDEX_FORMAT_UB < val)
+			return error("%s not in supported range: %d..%d",
+				     var, SUPPORTED_INDEX_FORMAT_LB,
+				     SUPPORTED_INDEX_FORMAT_UB);
+		preferred_index_format = val;
+		return 0;
+	}
+
 	if (!strcmp(var, "core.quotepath")) {
 		quote_path_fully = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index c93b8f4..4ecf8e6 100644
--- a/environment.c
+++ b/environment.c
@@ -20,6 +20,7 @@ int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = 7;
 int ignore_case;
 int assume_unchanged;
+int preferred_index_format;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
diff --git a/read-cache.c b/read-cache.c
index 1c173f7..fdac89a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1676,15 +1676,45 @@ static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	}
 }
 
-static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
+static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
+			  struct strbuf *previous_name)
 {
-	int size = ondisk_ce_size(ce);
-	struct ondisk_cache_entry *ondisk = xcalloc(1, size);
+	int size;
+	struct ondisk_cache_entry *ondisk;
 	char *name;
 	int result;
 
-	name = copy_cache_entry_to_ondisk(ondisk, ce);
-	memcpy(name, ce->name, ce_namelen(ce));
+	if (!previous_name) {
+		size = ondisk_ce_size(ce);
+		ondisk = xcalloc(1, size);
+		name = copy_cache_entry_to_ondisk(ondisk, ce);
+		memcpy(name, ce->name, ce_namelen(ce));
+	} else {
+		int common, to_remove, prefix_size;
+		unsigned char to_remove_vi[16];
+		for (common = 0;
+		     (ce->name[common] &&
+		      common < previous_name->len &&
+		      ce->name[common] == previous_name->buf[common]);
+		     common++)
+			; /* still matching */
+		to_remove = previous_name->len - common;
+		prefix_size = encode_varint(to_remove, to_remove_vi);
+
+		if (ce->ce_flags & CE_EXTENDED)
+			size = offsetof(struct ondisk_cache_entry_extended, name);
+		else
+			size = offsetof(struct ondisk_cache_entry, name);
+		size += prefix_size + (ce_namelen(ce) - common + 1);
+
+		ondisk = xcalloc(1, size);
+		name = copy_cache_entry_to_ondisk(ondisk, ce);
+		memcpy(name, to_remove_vi, prefix_size);
+		memcpy(name + prefix_size, ce->name + common, ce_namelen(ce) - common);
+
+		strbuf_splice(previous_name, common, to_remove,
+			      ce->name + common, ce_namelen(ce) - common);
+	}
 
 	result = ce_write(c, fd, ondisk, size);
 	free(ondisk);
@@ -1720,10 +1750,11 @@ int write_index(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
-	int i, err, removed, extended;
+	int i, err, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
 	struct stat st;
+	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -1737,24 +1768,31 @@ int write_index(struct index_state *istate, int newfd)
 		}
 	}
 
+	if (preferred_index_format)
+		hdr_version = preferred_index_format;
+	else
+		hdr_version = extended ? 3 : 2;
+
+
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
-	/* for extended format, increase version so older git won't try to read it */
-	hdr.hdr_version = htonl(extended ? 3 : 2);
+	hdr.hdr_version = htonl(hdr_version);
 	hdr.hdr_entries = htonl(entries - removed);
 
 	git_SHA1_Init(&c);
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
+	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
 		if (ce->ce_flags & CE_REMOVE)
 			continue;
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
-		if (ce_write_entry(&c, newfd, ce) < 0)
+		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
 			return -1;
 	}
+	strbuf_release(&previous_name_buf);
 
 	/* Write extension data here */
 	if (istate->cache_tree) {
-- 
1.7.10.rc4.54.g1d5dd3
