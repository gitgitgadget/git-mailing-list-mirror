From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 1/5] rev-parse: --is-bare-repository option
Date: Sat, 17 Mar 2007 15:42:17 +0100
Message-ID: <20070317144217.GA26290@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net> <20070317143452.GA21140@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 15:43:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSa86-0006TE-M3
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 15:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbXCQOnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 10:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbXCQOnU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 10:43:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:34621 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752675AbXCQOnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 10:43:19 -0400
Received: (qmail invoked by alias); 17 Mar 2007 14:43:17 -0000
X-Provags-ID: V01U2FsdGVkX18J9GU76McJ+JNEXzFltaO1QvbD96tYk4ov4c3P8N
	hAQRrVFM+ac2lb
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070317143452.GA21140@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42437>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-rev-parse.txt |    7 +++++++
 builtin-rev-parse.c             |    5 +++++
 git-sh-setup.sh                 |    6 +-----
 git-svn.perl                    |    2 +-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index ccc66aa..d024d93 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -89,6 +89,13 @@ OPTIONS
 --git-dir::
 	Show `$GIT_DIR` if defined else show the path to the .git directory.
 
+--is-inside-git-dir::
+	When the current working directory is below the repository
+	directory print "true", otherwise "false".
+
+--is-bare-repository::
+	When the repository is bare print "true", otherwise "false".
+
 --short, --short=number::
 	Instead of outputting the full SHA1 values of object names try to
 	abbreviate them to a shorter unique name. When no length is specified
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 37addb2..71d5162 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -352,6 +352,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 						: "false");
 				continue;
 			}
+			if (!strcmp(arg, "--is-bare-repository")) {
+				printf("%s\n", is_bare_repository() ? "true"
+						: "false");
+				continue;
+			}
 			if (!prefixcmp(arg, "--since=")) {
 				show_datestring("--max-age=", arg+8);
 				continue;
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index f24c7f2..9ac657a 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -29,11 +29,7 @@ set_reflog_action() {
 }
 
 is_bare_repository () {
-	git-config --bool --get core.bare ||
-	case "$GIT_DIR" in
-	.git | */.git) echo false ;;
-	*) echo true ;;
-	esac
+	git-rev-parse --is-bare-repository
 }
 
 cd_to_toplevel () {
diff --git a/git-svn.perl b/git-svn.perl
index e845789..c4e343a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -562,7 +562,7 @@ sub post_fetch_checkout {
 	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
 	return if -f $index;
 
-	chomp(my $bare = `git config --bool --get core.bare`);
+	chomp(my $bare = `git rev-parse --is-bare-repository`);
 	return if $bare eq 'true';
 	return if command_oneline(qw/rev-parse --is-inside-git-dir/) eq 'true';
 	command_noisy(qw/read-tree -m -u -v HEAD HEAD/);
-- 
1.5.0.4.414.g32da9
