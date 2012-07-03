From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 12/25] sha1_name.c: teach get_short_sha1() a commit-only
 option
Date: Tue,  3 Jul 2012 14:37:02 -0700
Message-ID: <1341351435-31011-13-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAnj-0005Tg-3W
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274Ab2GCViQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529Ab2GCVhl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49C72865C
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+nj4
	9Lc3YHR4gGw/KvNz8OLIwUg=; b=qHWvcfISZgh2XNTQU2076Ca+J4NjqCSa0hPL
	S55lTwEBDQfEPNGqIbTMfcsay8xAYZBsYaSGRvDt7CeX8hnoi2eDQk4Ln8cewzed
	nqy5CdNHjttp2jkn7QdurM3R0+kfgfVG6dw+xZ5oLcrt+otNXDL7iLnFFbxCvmAn
	uiaCwBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Jd4n8I
	4EoRt01Z10vqjEBSjU1LW5XkXB2+m2PkBfALuRq/8Opi9lRe1CaGaLiJRI2tylmS
	JWJgBJoE/swTmbtjzBJSvUu7nmpL4tyNwS2Hr187tmf7yNnT58F4dvq8pWBXGYzU
	7PXDgS2sUaa/taVZ8d4e/E4IR8o6rHsZPYNvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41923865B
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C89B5865A for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 50EC504A-C557-11E1-BD07-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200953>

When the caller knows that the parameter is meant to name a commit,
e.g. "56789a" in describe name "v1.2.3-4-g56789a", pass that as a
hint so that lower level can use it to disambiguate objects when
there is only one commit whose name begins with 56789a even if there
are objects of other types whose names share the same prefix.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     | 1 +
 sha1_name.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/cache.h b/cache.h
index 1bafa45..2d91dbd 100644
--- a/cache.h
+++ b/cache.h
@@ -812,6 +812,7 @@ struct object_context {
 };
 
 #define GET_SHA1_QUIETLY 01
+#define GET_SHA1_COMMIT 02
 
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
diff --git a/sha1_name.c b/sha1_name.c
index 793d80c..174d3df 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -218,6 +218,12 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	return 0;
 }
 
+static int disambiguate_commit_only(const unsigned char *sha1, void *cb_data_unused)
+{
+	int kind = sha1_object_info(sha1, NULL);
+	return kind == OBJ_COMMIT;
+}
+
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
 {
@@ -253,6 +259,9 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	prepare_alt_odb();
 
 	memset(&ds, 0, sizeof(ds));
+	if (flags & GET_SHA1_COMMIT)
+		ds.fn = disambiguate_commit_only;
+
 	find_short_object_filename(len, hex_pfx, &ds);
 	find_short_packed_object(len, bin_pfx, &ds);
 	status = finish_object_disambiguation(&ds, sha1);
-- 
1.7.11.1.229.g706c98f
