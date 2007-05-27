From: Johan Herland <johan@herland.net>
Subject: [PATCH 05/15] git-note: (Plumbing) Add support for git notes to
 git-rev-parse and git-show-ref
Date: Sun, 27 May 2007 16:12:13 +0200
Message-ID: <200705271612.13612.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJTs-0006xT-KJ
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbXE0OMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbXE0OMS
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:12:18 -0400
Received: from smtp.getmail.no ([84.208.20.33]:48799 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109AbXE0OMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:12:17 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00007E4H7A00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:12:17 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP004Y8E4D9OC0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:12:14 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000ITE4DJB50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:12:13 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48545>

Teach git-rev-parse and git-show-ref to show notes by adding a '--notes'
option. The '--notes' option is analogous to the '--tags' option for the
respective commands.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-rev-parse.c |    5 +++++
 builtin-show-ref.c  |   16 +++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 37addb2..4ab88af 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -43,6 +43,7 @@ static int is_rev_argument(const char *arg)
 		"--max-count=",
 		"--min-age=",
 		"--no-merges",
+		"--notes",
 		"--objects",
 		"--objects-edge",
 		"--parents",
@@ -310,6 +311,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_tag_ref(show_reference, NULL);
 				continue;
 			}
+			if (!strcmp(arg, "--notes")) {
+				for_each_note_ref(show_reference, NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--remotes")) {
 				for_each_remote_ref(show_reference, NULL);
 				continue;
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 9463ff0..8a7d0e7 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -4,10 +4,11 @@
 #include "tag.h"
 #include "path-list.h"
 
-static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*] < ref-list";
+static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--notes] [--] [pattern*] < ref-list";
 
 static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0,
-	found_match = 0, verify = 0, quiet = 0, hash_only = 0, abbrev = 0;
+	notes_only = 0, found_match = 0, verify = 0, quiet = 0, hash_only = 0,
+	abbrev = 0;
 static const char **pattern;
 
 static void show_one(const char *refname, const unsigned char *sha1)
@@ -25,11 +26,12 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	const char *hex;
 	unsigned char peeled[20];
 
-	if (tags_only || heads_only) {
+	if (tags_only || heads_only || notes_only) {
 		int match;
 
-		match = heads_only && !prefixcmp(refname, "refs/heads/");
-		match |= tags_only && !prefixcmp(refname, "refs/tags/");
+		match  = heads_only && !prefixcmp(refname, "refs/heads/");
+		match |= tags_only  && !prefixcmp(refname, "refs/tags/");
+		match |= notes_only && !prefixcmp(refname, "refs/notes/");
 		if (!match)
 			return 0;
 	}
@@ -213,6 +215,10 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 			heads_only = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--notes")) {
+			notes_only = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--exclude-existing"))
 			return exclude_existing(NULL);
 		if (!prefixcmp(arg, "--exclude-existing="))
-- 
1.5.2.101.gee49f
