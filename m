From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sat, 20 Jan 2007 22:55:42 -0800
Message-ID: <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
References: <20070118171830.GA13521@moooo.ath.cx>
	<20070118172408.GG15428@spearce.org>
	<20070118174244.GA14287@moooo.ath.cx>
	<20070118175134.GH15428@spearce.org>
	<20070118222919.GA22060@moooo.ath.cx>
	<7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
	<20070119034404.GA17521@spearce.org>
	<20070119104935.GA5189@moooo.ath.cx>
	<7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
	<20070120111832.GA30368@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 07:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8WcN-0000Mg-LT
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 07:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbXAUGzo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 01:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbXAUGzo
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 01:55:44 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48466 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbXAUGzn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 01:55:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121065543.WXAR3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jan 2007 01:55:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Diun1W00G1kojtg0000000; Sun, 21 Jan 2007 01:54:48 -0500
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <20070120111832.GA30368@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sat, 20 Jan 2007 12:18:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37307>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>...
>> Maybe an alternative:
>> 
>> 	git prune --retain=1.day
>> 	git prune --retain=off
>> 
>> perhaps?  I dunno.
>
> Perhaps we could also use 'none' or 'all, e.g. --retain=none or
> --expire=all.

I am considering to commit the attached instead.

The command "prune" is about expiring loose objects that are
unreachable, and the option introduces a grace period for the
expiration process.  Other places that we do use the word
'expire' to specify the time do mean the expiration timeout.

As long as you do not rewind/rebase too much, there is not much
you can gain from 'git-prune' ('git-repack -a -d' would give you
much more disk savings and performance gain).  I do not think it
makes sense to run uncontrolled 'git-prune' from automated cron
jobs.  Even if you rewind/rebase often, 1.5.0 will protect the
objects reflog entries refer to, so there will be even less to
be gained from 'git-prune'.  I am having a feeling that it might
even make sense not to run 'git-prune' from 'git-gc'.

While I sympathize with what Simon says to certain degree, I
tend to think the complication it needs to introduce is really
not worth it.  Perfect is the enemy of the good.

By the way.

While updating the documentation, I noticed that we lost the
'extra heads' support when git-prune was rewritten as a built-in
in commit ba84a797 (July 6th 2006).  The example (commented out
in the patch) is a valid way to safely prune a repository whose
objects are borrowed via the alternates mechanism by some other
repository, albeit not really scalable.

The way we might want to address this would be when 'clone -s'
makes a new repository that borrows from an existing repository,
we could make a symlink under .git/refs/borrowers/ in the
original repository that points at .git/refs directory of the
cloned repository -- you can do that by hand today and it would
be much nicer than having to specify the other repository when
running 'git prune' as the example suggests.

For this reason, I would say losing that 'extra heads' support
from git-prune, which happened half year ago, was Ok.

So far, we have been telling not to rewind refs in repositories
whose objects are borrowed by other repositories via the
alternates mechanism, and I think that advice is still a very
reasonable one to give, but we probably should make it more
prominent.  As long as we do that, we would not even need the
'refs/borrowers/*' symlinks.

-- >8 --
From: Matthias Lederhofer <matled@gmx.net>
[PATCH] prune: --grace=time

This option gives grace period to objects that are unreachable
from the refs from getting pruned.

The default value is 24 hours and may be changed using
gc.prunegrace.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-prune.txt |    9 ++++++++-
 builtin-prune.c             |   31 ++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index a11e303..fbd344d 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -8,7 +8,7 @@ git-prune - Prunes all unreachable objects from the object database
 
 SYNOPSIS
 --------
-'git-prune' [-n] [--] [<head>...]
+'git-prune' [-n] [--grace=<time>]
 
 DESCRIPTION
 -----------
@@ -28,6 +28,12 @@ OPTIONS
 	Do not remove anything; just report what it would
 	remove.
 
+--grace=<time>::
+	Do not prune loose objects that are younger than the
+	specified time.  This gives a grace period to newly
+	created objects from getting pruned.
+
+////////////////////////////////////////////
 \--::
 	Do not interpret any more arguments as options.
 
@@ -46,6 +52,7 @@ borrows from your repository via its
 ------------
 $ git prune $(cd ../another && $(git-rev-parse --all))
 ------------
+////////////////////////////////////////////
 
 Author
 ------
diff --git a/builtin-prune.c b/builtin-prune.c
index 6f0ba0d..7929af1 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -5,8 +5,9 @@
 #include "builtin.h"
 #include "reachable.h"
 
-static const char prune_usage[] = "git-prune [-n]";
+static const char prune_usage[] = "git-prune [-n] [--grace=time]";
 static int show_only;
+static int prune_grace_period;
 
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
 
+			if (prune_grace_period > 0 &&
+			    !stat(mkpath("%s/%s", path, de->d_name), &st) &&
+			    st.st_mtime > prune_grace_period)
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
+	if (!strcmp(var, "gc.prunegrace")) {
+		if (!strcmp(value, "off"))
+			prune_grace_period = 0;
+		else
+			prune_grace_period = approxidate(value);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct rev_info revs;
+	prune_grace_period = time(NULL)-24*60*60;
+
+	git_config(git_prune_config);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -90,6 +112,13 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 			show_only = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--grace=", 8)) {
+			if (!strcmp(arg+8, "off"))
+				prune_grace_period = 0;
+			else
+				prune_grace_period = approxidate(arg+8);
+			continue;
+		}
 		usage(prune_usage);
 	}
 
-- 
1.5.0.rc1.g40ab
