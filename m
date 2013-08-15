From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] dir.c: use the cache_* macro to access the current index
Date: Thu, 15 Aug 2013 14:28:08 -0700
Message-ID: <1376602090-19142-2-git-send-email-gitster@pobox.com>
References: <7v8v02rb2g.fsf@alter.siamese.dyndns.org>
 <1376602090-19142-1-git-send-email-gitster@pobox.com>
Cc: Petr Baudis <pasky@ucw.cz>, Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 23:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA55f-0000ba-7O
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 23:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab3HOV2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 17:28:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43283 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab3HOV2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 17:28:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCFB9397D4;
	Thu, 15 Aug 2013 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=BJI/
	AFFeE0+7O/F6Xes32QdKxv8=; b=G863+tvAG32xhASa4Bn2P0SompUeosAqEuZB
	2h2gwM3ullN7GqETfQNm29mDT0Yfm/CjfmmF/xn9B/0Aw/ikHnZqAXDouQlwwiuL
	oXJ42ubvHRBCItp2pvUbGdSoQqmxCpl6f3mNDE5Wy+jxXfd+UuslEzlazsMWMyNE
	o5B9wd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	f8kylbstbJ5ZRHaw4XZU4p5GzePeWDHhVLTS9Ms2oYuD1ISjGHjAIRqfkZoEHkRL
	lRIikNWwTmDk/4l10crZGk2oiJHOxELciRC77qOGueHvhY7RqiMWi8+2GHwtLnou
	ZKfQ7Cyxaib6vE9VFYx1Z+JQep0b8VUg7HXFH7pUf9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D05F5397D3;
	Thu, 15 Aug 2013 21:28:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ADBA397CE;
	Thu, 15 Aug 2013 21:28:13 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc3-232-ga8053f8
In-Reply-To: <1376602090-19142-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 97A31574-05F1-11E3-9037-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232371>

These codepaths always start from the_index and use index_*
functions, but there is no reason to do so.  Use the compatibility
cache_* macro to access the current in-core index like everybody
else.

While at it, fix typo in the comment for a function to check if a
path within a directory appears in the index.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index a5926fb..2f82cd1 100644
--- a/dir.c
+++ b/dir.c
@@ -472,15 +472,14 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size)
 	unsigned long sz;
 	enum object_type type;
 	void *data;
-	struct index_state *istate = &the_index;
 
 	len = strlen(path);
-	pos = index_name_pos(istate, path, len);
+	pos = cache_name_pos(path, len);
 	if (pos < 0)
 		return NULL;
-	if (!ce_skip_worktree(istate->cache[pos]))
+	if (!ce_skip_worktree(active_cache[pos]))
 		return NULL;
-	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
+	data = read_sha1_file(active_cache[pos]->sha1, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
@@ -924,13 +923,13 @@ enum exist_status {
 };
 
 /*
- * Do not use the alphabetically stored index to look up
+ * Do not use the alphabetically sorted index to look up
  * the directory name; instead, use the case insensitive
  * name hash.
  */
 static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
 {
-	struct cache_entry *ce = index_name_exists(&the_index, dirname, len + 1, ignore_case);
+	struct cache_entry *ce = cache_name_exists(dirname, len + 1, ignore_case);
 	unsigned char endchar;
 
 	if (!ce)
-- 
1.8.4-rc3-232-ga8053f8
