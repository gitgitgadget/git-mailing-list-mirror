From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] show-branch: take default arguments from configuration file.
Date: Mon, 09 Jan 2006 18:53:13 -0800
Message-ID: <7vr77gbxpi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 10 03:53:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew9dO-0005vG-PA
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 03:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWAJCxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 21:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWAJCxQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 21:53:16 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:8174 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750835AbWAJCxP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 21:53:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110025050.EOMA17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 21:50:50 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14399>

This lets showbranch.default multivalued configuration item to
be used as the default set of parameters to git-show-branch when
none is given on the command line.

I keep many topic branches (e.g. zzz/pack, net/misc) and
branches used only as a reference under subdirectories
(e.g. hold/{html,man,todo} track the same from git.git, but
clutters the show-branch output when shown along with the main
development; ko/master tracks what I have pushed out already and
refetched from the kernel.org server), and often run:

	$ git show-branch ko/master heads/*

to view only the ko/master head and branches I keep immediately
under $GIT_DIR/refs/heads.  With this change, I can have this in
my $GIT_DIR/config file:

	[showbranch]
		default = ko/master
		default = heads/*

and say

	$ git show-branch

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is "master" aka "toward 1.2" material, not meant for
   1.1.1, but maybe we should allow trivial backports?  I
   haven't decided.

 show-branch.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

680c6ea5291057fcba95f00455260ab1c1b242eb
diff --git a/show-branch.c b/show-branch.c
index 15b1968..f43c406 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -7,6 +7,10 @@
 static const char show_branch_usage[] =
 "git-show-branch [--all] [--heads] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [<refs>...]";
 
+static int default_num = 0;
+static int default_alloc = 0;
+static char **default_arg = NULL;
+
 #define UNINTERESTING	01
 
 #define REV_SHIFT	 2
@@ -508,6 +512,21 @@ static void append_one_rev(const char *a
 	die("bad sha1 reference %s", av);
 }
 
+static int git_show_branch_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "showbranch.default")) {
+		if (default_alloc <= default_num + 1) {
+			default_alloc = default_alloc * 3 / 2 + 20;
+			default_arg = xrealloc(default_arg, sizeof *default_arg * default_alloc);
+		}
+		default_arg[default_num++] = strdup(value);
+		default_arg[default_num] = NULL;
+		return 0;
+	}
+
+	return git_default_config(var, value);
+}
+
 int main(int ac, char **av)
 {
 	struct commit *rev[MAX_REVS], *commit;
@@ -527,11 +546,22 @@ int main(int ac, char **av)
 	int shown_merge_point = 0;
 	int topo_order = 0;
 
+	git_config(git_show_branch_config);
 	setup_git_directory();
 
+	/* If nothing is specified, try the default first */
+	if (ac == 1 && default_num) {
+		ac = default_num + 1;
+		av = default_arg - 1; /* ick; we would not address av[0] */
+	}
+
 	while (1 < ac && av[1][0] == '-') {
 		char *arg = av[1];
-		if (!strcmp(arg, "--all"))
+		if (!strcmp(arg, "--")) {
+			ac--; av++;
+			break;
+		}
+		else if (!strcmp(arg, "--all"))
 			all_heads = all_tags = 1;
 		else if (!strcmp(arg, "--heads"))
 			all_heads = 1;
-- 
1.1.0
