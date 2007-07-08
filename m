From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] branch.autosetupmerge: allow boolean values, or "all"
Date: Sun, 8 Jul 2007 13:41:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081336020.4248@racer.site>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 14:48:54 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7WC5-0005LQ-J6
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 14:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbXGHMsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 08:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbXGHMsu
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 08:48:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:49382 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751085AbXGHMst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 08:48:49 -0400
Received: (qmail invoked by alias); 08 Jul 2007 12:48:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 08 Jul 2007 14:48:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/STcAGGg7SbSTZ4pV7/8V/8XAWzLqVRCcnWXQHcA
	Kylf49gRlW5aok
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcof2rur.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51878>


Junio noticed that switching on autosetupmerge unilaterally started
cluttering the config for local branches.  That is not the original
intention of branch.autosetupmerge, which was meant purely for
convenience when branching off of remote branches, but that semantics
got lost somewhere.

If you still want that "new" behavior, you can switch
branch.autosetupmerge to the value "all".  Otherwise, it is interpreted
as a boolean, which triggers setting up defaults _only_ when branching
off of a remote branch, i.e. the originally intended behavior.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sun, 8 Jul 2007, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > "git branch --track" will setup config variables when 
	> > branching from a remote branch, so that if you say "git pull" 
	> > while being on that branch, it automatically fetches the 
	> > correct remote, and merges the correct branch.
	> 
	> While I think it would have been the right thing to do if the
	> code did this only for a remote branch, I think there is a bug
	> somewhere.  I just saw this:
	> 
	> 	... some random changes ...
	>         master$ git commit -a -s -m 'Some work meant for topic.'
	>         master$ git branch jc/new-topic
	> 	Branch jc/new-topic set up to track local branch refs/heads/master
	> 
	> Eh?  I did not want this to get applied for my local branches.

	That is certainly unexpected and unwelcomed.  Alas, I think it is 
	one of the consequences of rarely executed (and thus, tested) 
	code.

	I rarely branch, but use one long running branch to commit and 
	revert, so that a "git log -S<keyword> -p" brings me back my huge 
	debug output changes, and therefore I did not catch it.

	> I do not necessarily think the command line --track is broken.

	Me, neither.  Therefore, this patch does not change the semantics 
	of that one.  But it was really unexpected for me to see that this 
	works with anything but remote branches.

	> I am very tempted to revert this, but won't do so tonight, yet.

	Well, I marked it as RFC, and was surprised to wake up to it being 
	applied.  But thanks for not reverting right away; I think this 
	patch should fix the issue.

 builtin-branch.c  |   18 ++++++++++++------
 t/t3200-branch.sh |    9 +++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 507b47c..49195a1 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -22,7 +22,7 @@ static const char builtin_branch_usage[] =
 static const char *head;
 static unsigned char head_sha1[20];
 
-static int branch_track_remotes = 1;
+static int branch_track = 1; /* 0 = none, 1 = remotes, 2 = all */
 
 static int branch_use_color;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -66,8 +66,12 @@ static int git_branch_config(const char *var, const char *value)
 		color_parse(value, var, branch_colors[slot]);
 		return 0;
 	}
-	if (!strcmp(var, "branch.autosetupmerge"))
-		branch_track_remotes = git_config_bool(var, value);
+	if (!strcmp(var, "branch.autosetupmerge")) {
+		if (!strcmp(value, "all"))
+			branch_track = 2;
+		else
+			branch_track = git_config_bool(var, value);
+	}
 
 	return git_default_config(var, value);
 }
@@ -525,7 +529,9 @@ static void create_branch(const char *name, const char *start_name,
 	/* When branching off a remote branch, set up so that git-pull
 	   automatically merges from there.  So far, this is only done for
 	   remotes registered via .git/config.  */
-	if (real_ref && track)
+	if (real_ref && (track == 2 ||
+				(track == 1 &&
+				 !prefixcmp(real_ref, "refs/remotes/"))))
 		set_branch_defaults(name, real_ref);
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
@@ -586,7 +592,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int i;
 
 	git_config(git_branch_config);
-	track = branch_track_remotes;
+	track = branch_track;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -598,7 +604,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			break;
 		}
 		if (!strcmp(arg, "--track")) {
-			track = 1;
+			track = 2;
 			continue;
 		}
 		if (!strcmp(arg, "--no-track")) {
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c6f472a..a19e961 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -148,6 +148,15 @@ test_expect_success 'test tracking setup via config' \
      test $(git config branch.my3.remote) = local &&
      test $(git config branch.my3.merge) = refs/heads/master'
 
+test_expect_success 'autosetupmerge = all' '
+	git config branch.autosetupmerge true &&
+	git branch all1 master &&
+	test -z "$(git config branch.all1.merge)" &&
+	git config branch.autosetupmerge all &&
+	git branch all2 master &&
+	test $(git config branch.all2.merge) = refs/heads/master
+'
+
 test_expect_success 'test overriding tracking setup via --no-track' \
     'git config branch.autosetupmerge true &&
      git config remote.local.url . &&
-- 
1.5.3.rc0.2742.g2050
