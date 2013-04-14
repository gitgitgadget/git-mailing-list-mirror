From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] Add public function
 read_blob_data_from_index_path()
Date: Sat, 13 Apr 2013 22:49:36 -0700
Message-ID: <7vwqs56418.fsf@alter.siamese.dyndns.org>
References: <1365787573-597-1-git-send-email-git@cryptocrack.de>
 <1365859712-8400-1-git-send-email-git@cryptocrack.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Sun Apr 14 08:05:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URG46-0001T9-H3
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 08:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172Ab3DNGFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 02:05:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab3DNGFK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 02:05:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1716E3F7;
	Sun, 14 Apr 2013 06:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=o59JrZ6z5q+9BFFx+6YU5+AaOrc=; b=GdoVqm31YP1VjP/KID0B
	8XEZAq1crsy+Epwq775fKi00bDY04qSGpwYaRGgJb+mHVRuUDoAr42ecVzFxi5Vs
	SFRWBAq1M5weZootQnCVi1jl6e1YKoWqWmGkMKCTiRGNxP/lOqEiXG7GWwnuDFkK
	wr+7BsVBc2Q+gj9tU3kW+SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=yTts6n9CyF/8S1+Qgni/NbjDfpxEcllflNDstmwQHZ1iAj
	gtmpuwubya2tLhIj/5sWGTEtyhOtWMKLQmppRiKXM7MgdFrMDFatedKG1PKQU0Py
	H0L2cEpVuuGH4S5M53V34RnXM6OQVv15FH/8MPJP+YE0NYSN21VZvcEMFycpQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6ED5E3F5;
	Sun, 14 Apr 2013 06:05:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47F19E3F2; Sun, 14 Apr 2013
 06:05:09 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42F172FC-A4C9-11E2-92E4-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221084>

Thanks. I'll queue with the following API fix-up on this, with
obvious adjustments necessary for the later ones.

 * read_blob_data_from_index() is descriptive enough. If you read a
   blob from the index, you would ask for it with a path; there is
   no other sensible key to do so.

 * A function in read-cache API that works on an index should have
   the istate as the first argument and called with name "index";

 * If callers want to operate on the default index, macro with a
   similar name but replacing "index" with "cache" can be supplied,
   e.g.

   #define distim_cache(x) distim_index(&the_index, x)
---
 attr.c       | 2 +-
 cache.h      | 3 ++-
 read-cache.c | 4 +---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index a668a63..46bde57 100644
--- a/attr.c
+++ b/attr.c
@@ -387,7 +387,7 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	char *buf, *sp;
 	int lineno = 0;
 
-	buf = read_blob_data_from_index_path(path, use_index);
+	buf = read_blob_data_from_index(use_index, path);
 	if (!buf)
 		return NULL;
 
diff --git a/cache.h b/cache.h
index 85ddb13..5d66c74 100644
--- a/cache.h
+++ b/cache.h
@@ -307,6 +307,7 @@ extern void free_name_hash(struct index_state *istate);
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
+#define read_blob_data_from_cache(path) read_blob_data_from_index(&the_index, (path))
 #endif
 
 enum object_type {
@@ -452,7 +453,7 @@ extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 extern int index_name_is_other(const struct index_state *, const char *, int);
-extern void *read_blob_data_from_index_path(const char *path, struct index_state *use_index);
+extern void *read_blob_data_from_index(struct index_state *, const char *);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/read-cache.c b/read-cache.c
index cbeb248..48d87e8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1896,14 +1896,12 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 	return 1;
 }
 
-void *read_blob_data_from_index_path(const char *path,
-				     struct index_state *use_index)
+void *read_blob_data_from_index(struct index_state *istate, const char *path)
 {
 	int pos, len;
 	unsigned long sz;
 	enum object_type type;
 	void *data;
-	struct index_state *istate = use_index ? use_index : &the_index;
 
 	len = strlen(path);
 	pos = index_name_pos(istate, path, len);
-- 
1.8.2.1-514-gf369d36
