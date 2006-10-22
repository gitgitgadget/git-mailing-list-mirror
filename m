From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: prune/prune-packed
Date: Sun, 22 Oct 2006 19:14:22 -0400
Message-ID: <20061022231422.GA9375@fieldses.org>
References: <20061022035919.GA4420@fieldses.org> <7vy7r954k7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 01:14:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbmWS-00033b-41
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 01:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWJVXOY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 19:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWJVXOY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 19:14:24 -0400
Received: from mail.fieldses.org ([66.93.2.214]:25815 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750764AbWJVXOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 19:14:23 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1GbmWM-0002iP-LU; Sun, 22 Oct 2006 19:14:22 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7r954k7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29804>

On Sat, Oct 21, 2006 at 09:59:20PM -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > Both "man prune" and everyday.txt say that git-prune also runs
> > git-prune-packed.  But that doesn't seem to be true.  Is the bug in the
> > documentation?
> 
> I think it is a regression when prune was rewritten as a
> built-in.

So would it be as simple as this?

--b.

>From d8a01cf8e2d4ccc02dc52fe5dd22b8462997c1ca Mon Sep 17 00:00:00 2001
From: J. Bruce Fields <bfields@citi.umich.edu>
Date: Sun, 22 Oct 2006 19:01:23 -0400
Subject: [PATCH] Make prune also run prune-packed

Both the git-prune manpage and everday.txt say that git-prune should also prune
unpacked objects that are also found in packs, by running git prune-packed.

Junio thought this was "a regression when prune was rewritten as a built-in."

So modify prune to call prune-packed again.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 builtin-prune-packed.c |   11 +++++------
 builtin-prune.c        |    2 ++
 builtin.h              |    1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 960db49..e12b6cf 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -4,9 +4,7 @@ #include "cache.h"
 static const char prune_packed_usage[] =
 "git-prune-packed [-n]";
 
-static int dryrun;
-
-static void prune_dir(int i, DIR *dir, char *pathname, int len)
+static void prune_dir(int i, DIR *dir, char *pathname, int len, int dryrun)
 {
 	struct dirent *de;
 	char hex[40];
@@ -31,7 +29,7 @@ static void prune_dir(int i, DIR *dir, c
 	rmdir(pathname);
 }
 
-static void prune_packed_objects(void)
+void prune_packed_objects(int dryrun)
 {
 	int i;
 	static char pathname[PATH_MAX];
@@ -50,7 +48,7 @@ static void prune_packed_objects(void)
 		d = opendir(pathname);
 		if (!d)
 			continue;
-		prune_dir(i, d, pathname, len + 3);
+		prune_dir(i, d, pathname, len + 3, dryrun);
 		closedir(d);
 	}
 }
@@ -58,6 +56,7 @@ static void prune_packed_objects(void)
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	int dryrun;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -73,6 +72,6 @@ int cmd_prune_packed(int argc, const cha
 		usage(prune_packed_usage);
 	}
 	sync();
-	prune_packed_objects();
+	prune_packed_objects(dryrun);
 	return 0;
 }
diff --git a/builtin-prune.c b/builtin-prune.c
index 6228c79..7290e6d 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -255,5 +255,7 @@ int cmd_prune(int argc, const char **arg
 
 	prune_object_dir(get_object_directory());
 
+	sync();
+	prune_packed_objects(show_only);
 	return 0;
 }
diff --git a/builtin.h b/builtin.h
index f9fa9ff..f71b962 100644
--- a/builtin.h
+++ b/builtin.h
@@ -11,6 +11,7 @@ extern int mailinfo(FILE *in, FILE *out,
 extern int split_mbox(const char **mbox, const char *dir, int allow_bare, int nr_prec, int skip);
 extern void stripspace(FILE *in, FILE *out);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
+extern void prune_packed_objects(int);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
-- 
1.4.3.1.g87b78
