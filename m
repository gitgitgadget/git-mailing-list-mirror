From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 2/7] rev-parse: introduce --is-bare-repository
Date: Sun, 3 Jun 2007 16:46:36 +0200
Message-ID: <20070603144636.GB20061@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 16:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HurPA-0008NF-1n
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 16:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758606AbXFCOql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 10:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759203AbXFCOql
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 10:46:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:51824 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759192AbXFCOqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 10:46:39 -0400
Received: (qmail invoked by alias); 03 Jun 2007 14:46:37 -0000
Received: from pD9EB8AF4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.244]
  by mail.gmx.net (mp042) with SMTP; 03 Jun 2007 16:46:37 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19lVCNVUM5lKKmzOtezrD0tLB7tjBeA59DVHgKpIT
	0VlZdGPD/IuXXp
Content-Disposition: inline
In-Reply-To: <20070603144401.GA9518@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49002>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 Documentation/git-rev-parse.txt |    3 +++
 builtin-rev-parse.c             |    5 +++++
 git-sh-setup.sh                 |    6 +-----
 git-svn.perl                    |    3 +--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 5fcec19..c817d16 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -93,6 +93,9 @@ OPTIONS
 	When the current working directory is below the repository
 	directory print "true", otherwise "false".
 
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
index e350061..e3a5cbb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -594,8 +594,7 @@ sub post_fetch_checkout {
 	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
 	return if -f $index;
 
-	chomp(my $bare = `git config --bool --get core.bare`);
-	return if $bare eq 'true';
+	return if command_oneline(qw/rev-parse --is-bare-repository/) eq 'true';
 	return if command_oneline(qw/rev-parse --is-inside-git-dir/) eq 'true';
 	command_noisy(qw/read-tree -m -u -v HEAD HEAD/);
 	print STDERR "Checked out HEAD:\n  ",
-- 
1.5.0.3
