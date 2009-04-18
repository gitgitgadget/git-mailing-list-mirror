From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] Git.pm: Always set Repository to absolute path if autodetecting
Date: Sat, 18 Apr 2009 17:58:50 +0200
Message-ID: <1240070330-31446-2-git-send-email-frank@lichtenheld.de>
References: <1240070330-31446-1-git-send-email-frank@lichtenheld.de>
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 18 18:01:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvCy9-0002k4-9r
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226AbZDRP6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 11:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756107AbZDRP6u
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 11:58:50 -0400
Received: from aiolos.lenk.info ([85.214.124.154]:53630 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755553AbZDRP6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 11:58:49 -0400
Received: from mail.lenk.info ([78.47.143.197] ident=Debian-exim)
	by mx.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1LvCwK-0005i8-9V; Sat, 18 Apr 2009 17:58:48 +0200
Received: from p57b2734b.dip.t-dialin.net ([87.178.115.75] helo=penrose.djpig.de)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1LvCwG-0006SM-Aw; Sat, 18 Apr 2009 17:58:44 +0200
Received: from flichtenheld by penrose.djpig.de with local (Exim 4.69)
	(envelope-from <flichtenheld@astaro.com>)
	id 1LvCwN-0008Bg-1R; Sat, 18 Apr 2009 17:58:51 +0200
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1240070330-31446-1-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116834>

From: Frank Lichtenheld <flichtenheld@astaro.com>

So far we only set it to absolute paths in some cases which lead
to problems like wc_chdir not working.

Signed-off-by: Frank Lichtenheld <flichtenheld@astaro.com>
---
 perl/Git.pm     |    2 +-
 t/t9700/test.pl |   10 ++--------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 4313db7..e8df55d 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -185,7 +185,7 @@ sub repository {
 
 		if ($dir) {
 			$dir =~ m#^/# or $dir = $opts{Directory} . '/' . $dir;
-			$opts{Repository} = $dir;
+			$opts{Repository} = abs_path($dir);
 
 			# If --git-dir went ok, this shouldn't die either.
 			my $prefix = $search->command_oneline('rev-parse', '--show-prefix');
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index d9b29ea..6c70aec 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -86,18 +86,12 @@ close TEMPFILE;
 unlink $tmpfile;
 
 # paths
-is($r->repo_path, "./.git", "repo_path");
+is($r->repo_path, $abs_repo_dir . "/.git", "repo_path");
 is($r->wc_path, $abs_repo_dir . "/", "wc_path");
 is($r->wc_subdir, "", "wc_subdir initial");
 $r->wc_chdir("directory1");
 is($r->wc_subdir, "directory1", "wc_subdir after wc_chdir");
-TODO: {
-	local $TODO = "commands do not work after wc_chdir";
-	# Failure output is active even in non-verbose mode and thus
-	# annoying.  Hence we skip these tests as long as they fail.
-	todo_skip 'config after wc_chdir', 1;
-	is($r->config("color.string"), "value", "config after wc_chdir");
-}
+is($r->config("test.string"), "value", "config after wc_chdir");
 
 # Object generation in sub directory
 chdir("directory2");
-- 
1.6.2.1
