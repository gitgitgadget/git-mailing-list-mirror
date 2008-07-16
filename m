From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] Fix buffer overflow in git-grep
Date: Wed, 16 Jul 2008 19:33:29 +0400
Message-ID: <1216222409-31785-1-git-send-email-dpotapov@gmail.com>
References: <alpine.DEB.1.00.0807161232110.8503@eeepc-johanness>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 17:34:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ91Y-0002op-3h
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 17:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589AbYGPPdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 11:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756661AbYGPPdg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 11:33:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:58075 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756376AbYGPPdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 11:33:35 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2730170ywe.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lRC0gcCqQsbj4RuwVYBX+7vyvST6hKyj6zdu/ecjUIQ=;
        b=Fr1mv07DfNHrFVWrplcbmtmVwayn5kVVuUjc/ov2jkF3o0jQZw0YV/q/ZwlE9ErTKe
         srQ/jTmQjQDTCg13APXat2mekd/PpY/IYJT/ucvnkVA2hbumVujBB3H6q5fZ5/Q8N6Ml
         yQ7GykgkEo2tlggOqy8BEHsiXa8fPOy0qxml8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tWGfuWs/JfN9HJxCOvjns+9vIt0gCgRXl4skvL6+BqqJT567iv0iLPVEMMlQXCR9IR
         M63w+c2GRp7W0vHRWeibcuP5Om351ik+twk+vApSzAv9grv6vsOGie47JrNe+1wwfk4E
         QeTHTjd9V3swzhtt4u/uo4ueZi5c2iNM+POwM=
Received: by 10.103.203.15 with SMTP id f15mr1021665muq.0.1216222413725;
        Wed, 16 Jul 2008 08:33:33 -0700 (PDT)
Received: from localhost ( [85.141.237.219])
        by mx.google.com with ESMTPS id s10sm2924729muh.10.2008.07.16.08.33.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 08:33:32 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3.1.g4e6bb
In-Reply-To: <alpine.DEB.1.00.0807161232110.8503@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88689>

If PATH_MAX on your system is smaller than any path stored in the git
repository, that can cause memory corruption inside of the grep_tree
function used by git-grep.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
I have converted grep_tree code to use path_buf.

 builtin-grep.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index ef29910..507bb95 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -427,33 +427,35 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 	struct name_entry entry;
 	char *down;
 	int tn_len = strlen(tree_name);
-	char *path_buf = xmalloc(PATH_MAX + tn_len + 100);
+	struct strbuf pathbuf;
+
+	strbuf_init(&pathbuf, PATH_MAX + tn_len);
 
 	if (tn_len) {
-		tn_len = sprintf(path_buf, "%s:", tree_name);
-		down = path_buf + tn_len;
-		strcat(down, base);
-	}
-	else {
-		down = path_buf;
-		strcpy(down, base);
+		strbuf_add(&pathbuf, tree_name, tn_len);
+		strbuf_addch(&pathbuf, ':');
+		tn_len = pathbuf.len;
 	}
-	len = strlen(path_buf);
+	strbuf_addstr(&pathbuf, base);
+	len = pathbuf.len;
 
 	while (tree_entry(tree, &entry)) {
-		strcpy(path_buf + len, entry.path);
+		int te_len = tree_entry_len(entry.path, entry.sha1);
+		pathbuf.len = len;
+		strbuf_add(&pathbuf, entry.path, te_len);
 
 		if (S_ISDIR(entry.mode))
 			/* Match "abc/" against pathspec to
 			 * decide if we want to descend into "abc"
 			 * directory.
 			 */
-			strcpy(path_buf + len + tree_entry_len(entry.path, entry.sha1), "/");
+			strbuf_addch(&pathbuf, '/');
 
+		down = pathbuf.buf + tn_len;
 		if (!pathspec_matches(paths, down))
 			;
 		else if (S_ISREG(entry.mode))
-			hit |= grep_sha1(opt, entry.sha1, path_buf, tn_len);
+			hit |= grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
 		else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
 			struct tree_desc sub;
-- 
1.5.6.3.1.g4e6bb
