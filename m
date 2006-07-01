From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: allow a local target directory to be specified for init
Date: Fri, 30 Jun 2006 21:42:53 -0700
Message-ID: <11517289734157-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Luca Barbato <lu_zero@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jul 01 06:43:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwXJy-0006lX-Vh
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 06:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWGAEm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 00:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWGAEm4
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 00:42:56 -0400
Received: from hand.yhbt.net ([66.150.188.102]:23943 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932093AbWGAEmz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 00:42:55 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C37567DC021;
	Fri, 30 Jun 2006 21:42:53 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 30 Jun 2006 21:42:53 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.rc1.g7fe3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23041>

Original patch by Luca Barbato, cleaned up and made to work for
the current version of git-svn by me (Eric Wong).

Luca Barbato <lu_zero@gentoo.org> wrote:
> Since I'm lazy I just hacked a bit git-svn in order to create a target
> dir and init it if is passed as second parameter.
>
> git-svn init url://to/the/repo local-repo
>
> will create the local-repo dir if doesn't exist yet and populate it as
> expected.
>
> Maybe someone else could find it useful

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index b3d3f47..1e19aa1 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -264,9 +264,19 @@ when you have upgraded your tools and ha
 }
 
 sub init {
-	$SVN_URL = shift or die "SVN repository location required " .
+	my $url = shift or die "SVN repository location required " .
 				"as a command-line argument\n";
-	$SVN_URL =~ s!/+$!!; # strip trailing slash
+	$url =~ s!/+$!!; # strip trailing slash
+
+	if (my $repo_path = shift) {
+		unless (-d $repo_path) {
+			mkpath([$repo_path]);
+		}
+		$GIT_DIR = $ENV{GIT_DIR} = $repo_path . "/.git";
+		init_vars();
+	}
+
+	$SVN_URL = $url;
 	unless (-d $GIT_DIR) {
 		my @init_db = ('git-init-db');
 		push @init_db, "--template=$_template" if defined $_template;
-- 
1.4.1.rc1.g7fe3
