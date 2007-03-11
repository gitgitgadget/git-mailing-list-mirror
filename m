From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] rev-parse: --is-bare-repository option
Date: Sun, 11 Mar 2007 16:05:27 +0100
Message-ID: <20070311150527.GA23224@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <fcaeb9bf0703110627r6500d621rf6710c58e9e8d65b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 16:05:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQPc6-0001Jz-BD
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 16:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721AbXCKPFb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 11:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933730AbXCKPFb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 11:05:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:40136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933721AbXCKPFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 11:05:30 -0400
Received: (qmail invoked by alias); 11 Mar 2007 15:05:28 -0000
Received: from pD9EB9C1C.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.156.28]
  by mail.gmx.net (mp017) with SMTP; 11 Mar 2007 16:05:28 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18S9DU29ysSbKUCvHc/u1PXTIGai5eiFjJcmwRgyt
	mXZDqOU3zyRM1y
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0703110627r6500d621rf6710c58e9e8d65b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41930>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Um.. git-sh-setup.sh may need special treatment because its
> is_bare_directory doesn't call this function.
Here is rev-parse --is-bare-repository to fix this.

I'm not sure if git-sh-setup.sh:is_bare_repository should do other
checks if git-rev-parse --is-bare-repository fails.
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
index 326e89f..ea5da95 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -559,7 +559,7 @@ sub post_fetch_checkout {
 	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
 	return if -f $index;
 
-	chomp(my $bare = `git config --bool --get core.bare`);
+	chomp(my $bare = `git rev-parse --is-bare-repository`);
 	return if $bare eq 'true';
 	return if command_oneline(qw/rev-parse --is-inside-git-dir/) eq 'true';
 	command_noisy(qw/read-tree -m -u -v HEAD HEAD/);
-- 
1.5.0.3.355.g8488f-dirty
