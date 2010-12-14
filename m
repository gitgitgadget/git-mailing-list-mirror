From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 07/14] t7800-difftool.sh: Fix a test failure on Cygwin
Date: Tue, 14 Dec 2010 18:27:48 +0000
Message-ID: <4D07B724.8000901@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, davvid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:46:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZsu-0004t2-DR
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758281Ab0LNSpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:45:53 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:38061 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756880Ab0LNSpw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:45:52 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZsl-0001r5-aQ; Tue, 14 Dec 2010 18:45:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163666>


In particular, test 14 'difftool last flag wins' fails. This is
caused by git-difftool.perl passing both GIT_DIFFTOOL_NO_PROMPT
(='true') and GIT_DIFFTOOL_PROMPT (='true') to the difftool helper
script. Despite the appropriate key being deleted from the ENV
hash, it seems that once a key has been set in the hash, it gets
passed along to the system() call. (ie deleting the key does not
do the equivalent of unsetenv()).

In order to fix the problem, we keep track of the required prompt
state while processing the arguments, and then set the relevant
ENV hash key only once at the end.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 git-difftool.perl |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index e95e4ad..ced1615 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -52,6 +52,7 @@ sub generate_command
 	my @command = (exe('git'), 'diff');
 	my $skip_next = 0;
 	my $idx = -1;
+	my $prompt = '';
 	for my $arg (@ARGV) {
 		$idx++;
 		if ($skip_next) {
@@ -89,13 +90,11 @@ sub generate_command
 			next;
 		}
 		if ($arg eq '-y' || $arg eq '--no-prompt') {
-			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
-			delete $ENV{GIT_DIFFTOOL_PROMPT};
+			$prompt = 'no';
 			next;
 		}
 		if ($arg eq '--prompt') {
-			$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
-			delete $ENV{GIT_DIFFTOOL_NO_PROMPT};
+			$prompt = 'yes';
 			next;
 		}
 		if ($arg eq '-h' || $arg eq '--help') {
@@ -103,6 +102,11 @@ sub generate_command
 		}
 		push @command, $arg;
 	}
+	if ($prompt eq 'yes') {
+		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
+	} elsif ($prompt eq 'no') {
+		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+	}
 	return @command
 }
 
-- 
1.7.3
