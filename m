From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Commands requiring a work tree must not run in GIT_DIR
Date: Tue, 23 Jan 2007 13:30:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231312170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87r6trsu7n.wl@mail2.atmark-techno.com> <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
 <45B07875.9030506@fs.ei.tum.de> <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
 <45B0C7E6.4020509@op5.se> <1169214414.18684.25.camel@localhost.localdomain>
 <Pine.LNX.4.63.0701191600020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vtzymhma2.fsf@assigned-by-dhcp.cox.net> <878xfuuhco.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Matthias Kestenholz <lists@spinlock.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 13:30:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9KnD-0000IW-KZ
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 13:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbXAWMaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 07:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbXAWMaY
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 07:30:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:43860 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964798AbXAWMaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 07:30:23 -0500
Received: (qmail invoked by alias); 23 Jan 2007 12:30:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 23 Jan 2007 13:30:21 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <878xfuuhco.wl@mail2.atmark-techno.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37504>


This patch helps when you accidentally run something like git-clean
in the git directory instead of the work tree.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Tue, 23 Jan 2007, Yasushi SHOJI wrote:
	
	> At Fri, 19 Jan 2007 11:03:17 -0800,
	> Junio C Hamano wrote:
	> > 
	> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> > 
	> > > On Fri, 19 Jan 2007, Matthias Kestenholz wrote:
	> > > ...
	> > >> Why not check for /.git/ somewhere inside the current 
	> > >> working directory (pwd) ? That's the way mercurial does it 
	> > >> currently, and I think that is a sane thing to do _if_ you 
	> > >> want to protect the user from his own stupidity.
	> > >
	> > > There are valid reasons why you might want to have a 
	> > > (possibly temporary) repository _inside_ the GIT_DIR. You'd 
	> > > break these cases.
	> > 
	> > You are right that strstr(here, "/.git/") is not a good check.
	> > 
	> > If we really care about this problem (and I am not yet 
	> > starting to think we might, but who knows, I reserve the right 
	> > to change my mind every once in a while), we could make the 
	> > commands that deal with working trees (that is, among the 
	> > things under discussion in this thread, 'git-clean' always is, 
	> > and 'git-ls-files' only when it is given options like '-o', 
	> > '-k', '-m', '-i') when the cwd is GIT_DIR or a subdirectory of 
	> > it.
	> 
	> I believe it should be done.

	I only did that for the mentioned commands; your homework: find 
	all other commands (or options) which need that.

 builtin-ls-files.c  |   10 +++++++++-
 builtin-rev-parse.c |    5 +++++
 git-sh-setup.sh     |    3 ++-
 git.c               |    5 +++--
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 21c2a6e..ac89eb2 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -323,7 +323,7 @@ static const char ls_files_usage[] =
 int cmd_ls_files(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int exc_given = 0;
+	int exc_given = 0, require_work_tree = 0;
 	struct dir_struct dir;
 
 	memset(&dir, 0, sizeof(dir));
@@ -363,14 +363,17 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "-m") || !strcmp(arg, "--modified")) {
 			show_modified = 1;
+			require_work_tree = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
 			show_others = 1;
+			require_work_tree = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
 			dir.show_ignored = 1;
+			require_work_tree = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
@@ -379,6 +382,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
 			show_killed = 1;
+			require_work_tree = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--directory")) {
@@ -447,6 +451,10 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
+	if (require_work_tree &&
+			(is_bare_repository() || is_inside_git_dir()))
+		die("This operation must be run in a work tree");
+
 	pathspec = get_pathspec(prefix, argv + i);
 
 	/* Verify that the pathspec matches the prefix */
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 3b716fb..d53deaa 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -347,6 +347,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				printf("%s/.git\n", cwd);
 				continue;
 			}
+			if (!strcmp(arg, "--is-inside-git-dir")) {
+				printf("%s\n", is_inside_git_dir() ? "true"
+						: "false");
+				continue;
+			}
 			if (!strncmp(arg, "--since=", 8)) {
 				show_datestring("--max-age=", arg+8);
 				continue;
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6b1c142..9114c49 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -48,7 +48,8 @@ cd_to_toplevel () {
 }
 
 require_work_tree () {
-	test $(is_bare_repository) = false ||
+	test $(is_bare_repository) = false &&
+	test $(git-rev-parse --is-inside-git-dir) = false ||
 	die "fatal: $0 cannot be used without a working tree."
 }
 
diff --git a/git.c b/git.c
index 5133a07..2027d1c 100644
--- a/git.c
+++ b/git.c
@@ -302,8 +302,9 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 			prefix = setup_git_directory();
 		if (p->option & USE_PAGER)
 			setup_pager();
-		if ((p->option & NOT_BARE) && is_bare_repository())
-			die("%s cannot be used in a bare git directory", cmd);
+		if ((p->option & NOT_BARE) &&
+				(is_bare_repository() || is_inside_git_dir()))
+			die("%s must be run in a work tree", cmd);
 		trace_argv_printf(argv, argc, "trace: built-in: git");
 
 		exit(p->fn(argc, argv, prefix));
