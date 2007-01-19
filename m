From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] prune: --expire=time
Date: Fri, 19 Jan 2007 11:49:35 +0100
Message-ID: <20070119104935.GA5189@moooo.ath.cx>
References: <20070118171830.GA13521@moooo.ath.cx> <20070118172408.GG15428@spearce.org> <20070118174244.GA14287@moooo.ath.cx> <20070118175134.GH15428@spearce.org> <20070118222919.GA22060@moooo.ath.cx> <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net> <20070119034404.GA17521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 11:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7rJX-00084x-OU
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 11:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbXASKtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 05:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbXASKtk
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 05:49:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:35092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965051AbXASKtj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 05:49:39 -0500
Received: (qmail invoked by alias); 19 Jan 2007 10:49:37 -0000
Received: from pD9EBA5EB.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.165.235]
  by mail.gmx.net (mp004) with SMTP; 19 Jan 2007 11:49:37 +0100
X-Authenticated: #5358227
To: "Shawn O. Pearce" <spearce@spearce.org>
Mail-Followup-To: "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070119034404.GA17521@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37172>

This option specifies the minimum age of an object before it
may be removed by prune.  The default value is 24 hours and
may be changed using gc.pruneexpire.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Shawn O. Pearce <spearce@spearce.org> wrote:
> Given that 'git gc' is the encouraged way to maintain a repository,
> and that 'repack -a -d' is safe, and prune-packed is equally safe,
> I think we should try to make prune safe too.  Matthias' patch
> does this by giving the ref update process a fairly large window
> to perform its action within.
Ah, git repack -a -d is safe now too?

> Junio C Hamano <junkio@cox.net> wrote:
> > If this is something we would want, it might make sense if we
> > allowed "prune --expire='1.day'" syntax ;-).
> 
> Yes, I agree.
> 
> Matthias you can take a look at builtin-reflog.c's argument handling
> for an example.  I think you just need to use approxidate() in both
> your config function and in your command line argument handling.
> Then the default becomes '2.hours.ago' instead of just "2" (at
> least from a documentation perspective).
> 
> Though the more I think about this perhaps the default should be
> '1.day'.  24 hours is a hellva large window for any current ref
> update to complete in, even if the ref update was some massive rsync
> which is doing a such a large volume of data on a small bandwidth
> link that it takes 20 hours to complete.  Besides, users could
> always force it to be much lower with the command line option if
> they really need to prune _right_now_.
Thanks for the advice, this is much better than specifying seconds.
Here is the new version.

Things I'm not sure about, any further comments/discussion?
- default value for gc.pruneexpire
- special value(s) for gc.pruneexpire/--expire which mean 'do not
  check for the age', currently it is 'off'
---
 builtin-prune.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 6f0ba0d..410b3b2 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -5,8 +5,9 @@
 #include "builtin.h"
 #include "reachable.h"
 
-static const char prune_usage[] = "git-prune [-n]";
+static const char prune_usage[] = "git-prune [-n] [--expire=time]";
 static int show_only;
+static int prune_expire;
 
 static int prune_object(char *path, const char *filename, const unsigned char *sha1)
 {
@@ -38,6 +39,7 @@ static int prune_dir(int i, char *path)
 		char name[100];
 		unsigned char sha1[20];
 		int len = strlen(de->d_name);
+		struct stat st;
 
 		switch (len) {
 		case 2:
@@ -60,6 +62,11 @@ static int prune_dir(int i, char *path)
 			if (lookup_object(sha1))
 				continue;
 
+			if (prune_expire > 0 &&
+			    !stat(mkpath("%s/%s", path, de->d_name), &st) &&
+			    st.st_mtime > prune_expire)
+				continue;
+
 			prune_object(path, de->d_name, sha1);
 			continue;
 		}
@@ -79,10 +86,25 @@ static void prune_object_dir(const char *path)
 	}
 }
 
+static int git_prune_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "gc.pruneexpire")) {
+		if (!strcmp(value, "off"))
+			prune_expire = 0;
+		else
+			prune_expire = approxidate(value);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct rev_info revs;
+	prune_expire = time(NULL)-24*60*60;
+
+	git_config(git_prune_config);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -90,6 +112,13 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 			show_only = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--expire=", 9)) {
+			if (!strcmp(arg+9, "off"))
+				prune_expire = 0;
+			else
+				prune_expire = approxidate(arg+9);
+			continue;
+		}
 		usage(prune_usage);
 	}
 
-- 
1.4.4.4
