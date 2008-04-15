From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] git clean: Don't automatically remove directories when run within subdirectory
Date: Mon, 14 Apr 2008 22:14:09 -0500
Message-ID: <1208229249-32033-1-git-send-email-shawn.bohrer@gmail.com>
References: <20080414170643.GA10548@mediacenter>
Cc: git@vger.kernel.org, jobh@broadpark.no,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 15 05:15:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlbdN-0002GB-GP
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 05:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761808AbYDODON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 23:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761653AbYDODON
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 23:14:13 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:15195 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761615AbYDODOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 23:14:12 -0400
Received: by an-out-0708.google.com with SMTP id d31so488677and.103
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 20:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WQ009Nh1O9eXa5c1KSwt96tfJX701cVKqSkHrNvYf+M=;
        b=n+DpO2GoDDwEXY6WGfDNximcESYDuu/k+MEauTH1a4qGQkIcp/ZWSCDdX9Ib2fURj0L3n31eQqzdORyELaoHKRipA1gNJcc432FOL7m7q9q2+bkICDzNxBR5zSptwT0jnu6n62G+v5+8MySRybNPaZwdlMXHBkUt0DqtOWmHI58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fZDiXhPmgw+u9VcEFyMADv+yz+aVUAH2OaufA74WuWLS0SiYR386FSmJJ20LE3uNeb7RBysF/DswEO9t4IjvWRdoN4M57mqLxOtTwtwWgo/G753RWG0XmUpjqyonNseuH2f1t+tX0iqUbTlRuRFuEZd4iJQGN9E/XFq3cUQksZo=
Received: by 10.100.58.2 with SMTP id g2mr13756191ana.108.1208229251187;
        Mon, 14 Apr 2008 20:14:11 -0700 (PDT)
Received: from lintop ( [70.112.149.232])
        by mx.google.com with ESMTPS id a44sm659474rne.2.2008.04.14.20.14.08
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Apr 2008 20:14:10 -0700 (PDT)
Received: by lintop (sSMTP sendmail emulation); Mon, 14 Apr 2008 22:14:09 -0500
X-Mailer: git-send-email 1.5.5.106.g62ee2.dirty
In-Reply-To: <20080414170643.GA10548@mediacenter>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79561>

When git clean is run from a subdirectory it should follow the normal
policy and only remove directories if they are passed in as a pathspec,
or -d is specified.

The fix is to send len which could be shorter than ent->len because we
have stripped the trailing '/' that read_directory adds. Additionaly
match_one() was modified to allow a name[] that is not NUL terminated.
This allows us to check if the name matched the pathspec exactly
instead of recursively.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 builtin-clean.c |   13 +++++++------
 dir.c           |    2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index fefec30..6778a03 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -95,7 +95,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		int len, pos, matches;
+		int len, pos;
+		int matches = 0;
 		struct cache_entry *ce;
 		struct stat st;
 
@@ -127,18 +128,18 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 		if (pathspec) {
 			memset(seen, 0, argc > 0 ? argc : 1);
-			matches = match_pathspec(pathspec, ent->name, ent->len,
+			matches = match_pathspec(pathspec, ent->name, len,
 						 baselen, seen);
-		} else {
-			matches = 0;
 		}
 
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
 			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
-			if (show_only && (remove_directories || matches)) {
+			if (show_only && (remove_directories ||
+			    (matches == MATCHED_EXACTLY))) {
 				printf("Would remove %s\n", qname);
-			} else if (remove_directories || matches) {
+			} else if (remove_directories ||
+				   (matches == MATCHED_EXACTLY)) {
 				if (!quiet)
 					printf("Removing %s\n", qname);
 				if (remove_dir_recursively(&directory, 0) != 0) {
diff --git a/dir.c b/dir.c
index b5bfbca..63715c9 100644
--- a/dir.c
+++ b/dir.c
@@ -80,7 +80,7 @@ static int match_one(const char *match, const char *name, int namelen)
 	if (strncmp(match, name, matchlen))
 		return !fnmatch(match, name, 0) ? MATCHED_FNMATCH : 0;
 
-	if (!name[matchlen])
+	if (namelen == matchlen)
 		return MATCHED_EXACTLY;
 	if (match[matchlen-1] == '/' || name[matchlen] == '/')
 		return MATCHED_RECURSIVELY;
-- 
1.5.5.106.g62ee2.dirty
