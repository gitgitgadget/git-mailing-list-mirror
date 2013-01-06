From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2] status: always report ignored tracked directories
Date: Sun,  6 Jan 2013 23:09:39 +0100
Message-ID: <1357510179-22852-1-git-send-email-apelisse@gmail.com>
References: <20130105230303.GA5195@sigill.intra.peff.net>
Cc: Antoine Pelisse <apelisse@gmail.com>, tboegi@web.de,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 23:11:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TryR4-00024J-1C
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 23:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab3AFWKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 17:10:21 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:56993 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab3AFWKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 17:10:20 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so8886127wgb.25
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 14:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=DdUxWlz8c/fPpZVLWh0XyXpKgifx/MRQHHrEmUa4x8Y=;
        b=MCEw7uB2RRPXeiImxNwx5gK255Jhy95T4c3Y7Wte9bApn0bMC8TgxEZgKBN5fHhZyj
         MbmWerp7YyycT1lNSWMUBvzFA9VkRlS/btxsU+S0YU6nlWL23iylaLWFHgJAJPVsthCA
         OOo3NSuAo0SxrgiMzBO4YXhoPihej0mttKOih8MtoE8AX5sBwSjQurQkyRdE2cvWIpUD
         NQfk/gXKfyXkho/nxFqj+EneiO0yd4HwYMELxQHKkkW0v6U1TztlSEZ+umlEiMvocNHD
         3HiV1QfAJuwO8dCF3uDJ4frBazzFsErCyrnKgHVUn+NGC1HncA0kH/mVZCU36NDy8xSx
         OsJg==
X-Received: by 10.194.90.238 with SMTP id bz14mr83913345wjb.9.1357510218926;
        Sun, 06 Jan 2013 14:10:18 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id dm3sm9393951wib.9.2013.01.06.14.10.17
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 06 Jan 2013 14:10:18 -0800 (PST)
X-Mailer: git-send-email 1.7.12.4.3.g90f5e2d
In-Reply-To: <20130105230303.GA5195@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212850>

Tracked directories (i.e. directories containing tracked files) that
are ignored must be reported as ignored if they contain untracked files.

Currently, files in the index can't be reported as ignored and are
automatically dropped from the list:

 - When core.ignorecase is false, directories (which are not directly
 tracked) are not listed as part of the index, and the directory can be
 shown as ignored.

 - When core.ignorecase is true on the other hand, directories are
 reported as part of the index, and the directory is dropped, thus not
 displayed as ignored.

Fix that behavior by allowing indexed file to be added when looking for
ignored files.

 - Ignored tracked and untracked directories are treated the same way
 when looking for ignored files, so we should not care about their index
 status.
 - Files are dismissed by treat_file() if they belong to the
 index, so that step would have been a no-op anyway.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 dir.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 9b80348..f836590 100644
--- a/dir.c
+++ b/dir.c
@@ -672,7 +672,8 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)

 static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_exists(pathname, len, ignore_case))
+	if (!(dir->flags & DIR_SHOW_IGNORED) &&
+	    cache_name_exists(pathname, len, ignore_case))
 		return NULL;

 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
@@ -877,11 +878,7 @@ static int treat_file(struct dir_struct *dir, struct strbuf *path, int exclude,
 	if (exclude)
 		exclude_file = !(dir->flags & DIR_SHOW_IGNORED);
 	else if (dir->flags & DIR_SHOW_IGNORED) {
-		/*
-		 * Optimization:
-		 * Don't spend time on indexed files, they won't be
-		 * added to the list anyway
-		 */
+		/* Always exclude indexed files */
 		struct cache_entry *ce = index_name_exists(&the_index,
 		    path->buf, path->len, ignore_case);

--
1.7.12.4.3.g90f5e2d
