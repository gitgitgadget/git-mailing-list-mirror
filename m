From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH] fast-import.c: always honor the filename case
Date: Sun,  2 Feb 2014 07:13:04 -0600
Message-ID: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>
Cc: dpotapov@gmail.com, tboegi@web.de,
	Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 14:15:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9wtT-0004tE-Sm
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 14:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbaBBNOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 08:14:49 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35358 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaBBNOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 08:14:48 -0500
Received: by mail-ob0-f172.google.com with SMTP id vb8so6903060obc.31
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 05:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ve671Q0ctPXIrVvKzR9orAyeaaKctSxE11MaNfH1vN0=;
        b=bhqmxklSLwknDQNt++Xfj0pDBu5GQdeg1G/FyAURxWOJC8/ptG9VkBzwf0VY7wNtgy
         xcm2rhQkXMuksMUF5wyUZ+81T4PHnBKnifZIm31MCPdGtm1XeqzFZVLDa6len5scCDWC
         y1CPNRGVERo3EDLdr7YzYFiBIpAw44aB1QeaTRRuOZq8XGNaHbkt0Xdxm5gOidl6n+UC
         AeWy7s7xrFGr8Smm/FBL0AjNHjkVZJRzus0/d5A4cO4USnFD0/QRiuYZnrtr/gg30tOM
         ANm0N+a1OpEOI2wOuGtIqKNOI8xsvxERy0svrxUccciJllW0SAZGIRjAc61pUQ4d8bUh
         lkAw==
X-Received: by 10.60.119.73 with SMTP id ks9mr1067188oeb.45.1391346888315;
        Sun, 02 Feb 2014 05:14:48 -0800 (PST)
Received: from zoidberg ([72.183.120.155])
        by mx.google.com with ESMTPSA id m7sm28453683obo.7.2014.02.02.05.14.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 05:14:47 -0800 (PST)
Received: from zoidberg (localhost [127.0.0.1])
	by zoidberg (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s12DElgl012002;
	Sun, 2 Feb 2014 07:14:47 -0600
Received: (from reuben@localhost)
	by zoidberg (8.14.4/8.14.4/Submit) id s12DEkkY011997;
	Sun, 2 Feb 2014 07:14:46 -0600
X-Mailer: git-send-email 1.8.5.3.3.g8f06fb8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241372>

fast-import should not use strncmp_icase.  When it does, files with
similar names, but different case can be lost in the import.  For
example...

M 100644 :1 FileName.txt
D Filename.txt

...would end up deleting FileName from the index during the fast-
import when strncmp_icase is used and core.ignorecase=true.  The
intent in the above snippet is to rename the file, not delete it.

Replacing strncmp_icase with strncmp in fast-import.c fixes the
issue.

alternatives:
* check if the filesystem is case-preserving.  If it is, don't
  set core.ignorecase=true.  This, however, exposes another issue
  where git is tricked by stat into thinking that tracked files
  are untracked on case-preserving and case-insensitive filesystems.
---
 fast-import.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index f4d9969..62e28c0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1500,7 +1500,7 @@ static int tree_content_set(
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
 			if (!slash1) {
 				if (!S_ISDIR(mode)
 						&& e->versions[1].mode == mode
@@ -1593,7 +1593,7 @@ static int tree_content_remove(
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
 			if (slash1 && !S_ISDIR(e->versions[1].mode))
 				/*
 				 * If p names a file in some subdirectory, and a
@@ -1663,7 +1663,7 @@ static int tree_content_get(
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
 			if (!slash1)
 				goto found_entry;
 			if (!S_ISDIR(e->versions[1].mode))
-- 
1.8.5.3.1.gac93028.dirty
