From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-repack explain what it's doing during prune
Date: Fri, 12 Jan 2007 14:55:43 -0800
Message-ID: <7v8xg7rh1s.fsf@assigned-by-dhcp.cox.net>
References: <20070112024623.GA9787@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 23:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5VJk-0000OW-SE
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 23:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbXALWzq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 17:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbXALWzq
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 17:55:46 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43874 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161155AbXALWzp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 17:55:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112225544.VZVK25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 17:55:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ANus1W00u1kojtg0000000; Fri, 12 Jan 2007 17:54:53 -0500
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <20070112024623.GA9787@midwinter.com> (Steven Grimm's message of
	"Thu, 11 Jan 2007 18:46:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36723>

Steven Grimm <koreth@midwinter.com> writes:

> git-pack-objects reports its progress as it runs, but as soon as it
> finishes and git-repack (with -d option) runs git-prune-packed, the
> user is left in the dark about what's going on. That makes git-repack
> feel inconsistent: it starts off with a bunch of progress reports then
> appears to just sit there for a while before finishing.

I think this is a very good idea, but why don't we go all the
way?  Perhaps like this?

-- >8 --

diff --git a/git-repack.sh b/git-repack.sh
index 375434b..da8e67f 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -110,7 +110,7 @@ then
 		  done
 		)
 	fi
-	git-prune-packed
+	git-prune-packed $quiet
 fi
 
 case "$no_update_info" in
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 24e3b0a..e67d371 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -4,7 +4,10 @@
 static const char prune_packed_usage[] =
 "git-prune-packed [-n]";
 
-static void prune_dir(int i, DIR *dir, char *pathname, int len, int dryrun)
+#define DRY_RUN 01
+#define VERBOSE 02
+
+static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 {
 	struct dirent *de;
 	char hex[40];
@@ -20,7 +23,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int dryrun)
 		if (!has_sha1_pack(sha1, NULL))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
-		if (dryrun)
+		if (opts & DRY_RUN)
 			printf("rm -f %s\n", pathname);
 		else if (unlink(pathname) < 0)
 			error("unable to unlink %s", pathname);
@@ -29,7 +32,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int dryrun)
 	rmdir(pathname);
 }
 
-void prune_packed_objects(int dryrun)
+void prune_packed_objects(int opts)
 {
 	int i;
 	static char pathname[PATH_MAX];
@@ -48,22 +51,29 @@ void prune_packed_objects(int dryrun)
 		d = opendir(pathname);
 		if (!d)
 			continue;
-		prune_dir(i, d, pathname, len + 3, dryrun);
+		prune_dir(i, d, pathname, len + 3, opts);
 		closedir(d);
+		if (opts == VERBOSE)
+			fprintf(stderr, "Prune-packed %d%%...\015",
+				((i+1) * 100) / 256);
 	}
+	if (opts == VERBOSE)
+		fprintf(stderr, "\nDone.\n");
 }
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int dryrun = 0;
+	int opts = VERBOSE;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
 		if (*arg == '-') {
 			if (!strcmp(arg, "-n"))
-				dryrun = 1;
+				opts |= DRY_RUN;
+			else if (!strcmp(arg, "-q"))
+				opts &= ~VERBOSE;
 			else
 				usage(prune_packed_usage);
 			continue;
@@ -72,6 +82,6 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 		usage(prune_packed_usage);
 	}
 	sync();
-	prune_packed_objects(dryrun);
+	prune_packed_objects(opts);
 	return 0;
 }
