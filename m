From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] git clean: Don't automatically remove directories when run within subdirectory
Date: Sun, 13 Apr 2008 18:49:37 -0500
Message-ID: <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com>
References: <85fxtvj6y8.fsf_-_@lupus.strangled.net>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: jobh@broadpark.no
X-From: git-owner@vger.kernel.org Mon Apr 14 01:50:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlBxy-0001KL-6P
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 01:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbYDMXtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 19:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbYDMXtn
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 19:49:43 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:52288 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbYDMXtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 19:49:42 -0400
Received: by an-out-0708.google.com with SMTP id d31so353311and.103
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=v31Mus44RFtSPXchFNlsTc2BnuJRWWWecz7d8EzZqvY=;
        b=oyCXVtGdE4zjMCLOhtpuvXwxjMggZdoaTTFHFzdxZiIYYriWJlyeZgo6q3p+DACY3xO8z9t1evs0QRacsLXVq4aCe+cB0aSxjyhEJxDO3vV9ejorLGfhy5Y+MiR2rmqc/+AFooGNtLfNwR/KXecI3fhco4xnDPyHBiXh+jK+FL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=U3VMT5wfS1p36ZbgUcOHd1h+X0Um+6aPPz+KDF1HxU8NUzCFCglSZX0IH0O0XzNZUWszvms9Q182NwdAb/Y23p2PNpAIlf9Qkb8o0DXKpzXTmgK+nbsabTsQ6wYp3FN/KVzoW6lYbPKct+nBB4CQ7sDHBm+4j84dHWKNUKd3EHs=
Received: by 10.100.194.5 with SMTP id r5mr10919419anf.104.1208130581512;
        Sun, 13 Apr 2008 16:49:41 -0700 (PDT)
Received: from lintop ( [70.112.149.232])
        by mx.google.com with ESMTPS id i49sm3402939rne.0.2008.04.13.16.49.38
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Apr 2008 16:49:40 -0700 (PDT)
Received: by lintop (sSMTP sendmail emulation); Sun, 13 Apr 2008 18:49:38 -0500
X-Mailer: git-send-email 1.5.5.106.g42c8b
In-Reply-To: <85fxtvj6y8.fsf_-_@lupus.strangled.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79426>

When git clean is run from a subdirectory it should follow the normal
policy and only remove directories if they are passed in as a pathspec,
or -d is specified.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---


On Wed, Apr 09, 2008 at 07:04:15PM +0200, Joachim B Haga wrote:
> Joachim B Haga <jobh@broadpark.no> writes:
> I have tried to fix this, but I don't know the code. The previous logic was
> obviously (?) broken, as it had this (paraphrased):
>
> if (remove_directories || matches)
>       remove_dir_recursively(...);

git clean will remove directories if you specify -d (setting the
remove_directories flag), or if you explicitly passed the directory in
as a pathspec.  For example:

mkdir foo
git clean foo

After looking at the code a bit I think the real problem is with
match_pathspec, or at least with how git clean uses match_pathspec.
How does the following patch look?



 builtin-clean.c |   11 +++++------
 dir.c           |    2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index fefec30..5c5ec98 100644
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
 
@@ -127,18 +128,16 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
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
+			if (show_only && (remove_directories || (matches >= 2))) {
 				printf("Would remove %s\n", qname);
-			} else if (remove_directories || matches) {
+			} else if (remove_directories || (matches >= 2)) {
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
1.5.5.106.g42c8b
