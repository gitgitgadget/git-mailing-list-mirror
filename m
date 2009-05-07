From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH RESEND] Git.pm: Always set Repository to absolute path if autodetecting
Date: Thu,  7 May 2009 15:41:28 +0200
Message-ID: <1241703688-6892-2-git-send-email-frank@lichtenheld.de>
References: <1241703688-6892-1-git-send-email-frank@lichtenheld.de>
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 07 21:29:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29HU-0003LZ-KQ
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421AbZEGT2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 15:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756859AbZEGT2G
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:28:06 -0400
Received: from aiolos.lenk.info ([85.214.124.154]:60326 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761598AbZEGT2A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 15:28:00 -0400
Received: from mail.lenk.info ([78.47.143.197] ident=Debian-exim)
	by mx.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1M29GB-0002Pn-GY; Thu, 07 May 2009 21:27:59 +0200
Received: from p57b25cad.dip.t-dialin.net ([87.178.92.173] helo=penrose.djpig.de)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1M29G9-0004gN-CE; Thu, 07 May 2009 21:27:57 +0200
Received: from flichtenheld by penrose.djpig.de with local (Exim 4.69)
	(envelope-from <flichtenheld@astaro.com>)
	id 1M23qr-0001ne-3Y; Thu, 07 May 2009 15:41:29 +0200
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1241703688-6892-1-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118507>

From: Frank Lichtenheld <flichtenheld@astaro.com>

So far we only set it to absolute paths in some cases which lead
to problems like wc_chdir not working.

Signed-off-by: Frank Lichtenheld <flichtenheld@astaro.com>
---
 perl/Git.pm     |    2 +-
 t/t9700/test.pl |   10 ++--------
 2 files changed, 3 insertions(+), 9 deletions(-)

Resent unchanged. There was one comment which I've reponded too and
argued that it didn't apply and there was no further objections.

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
