From: mw-u2@gmx.de
Subject: Bug: git svn sends password + "\n" on windows
Date: Fri, 06 Jul 2012 09:39:08 +0200
Message-ID: <20120706073908.278660@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 09:39:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn38H-0005Uh-I0
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 09:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab2GFHjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 03:39:13 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:43504 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753991Ab2GFHjL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 03:39:11 -0400
Received: (qmail 16808 invoked by uid 0); 6 Jul 2012 07:39:10 -0000
Received: from 62.225.185.18 by www073.gmx.net with HTTP;
 Fri, 06 Jul 2012 09:39:08 +0200 (CEST)
X-Authenticated: #20538366
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX19EEiA2q9lEkrht0IRPY5DSeSMVsoTAMFQAgQbVnD
 /CZXbkOiOwv9d5ZXZEFsS/A7T8f0qch/qsOQ== 
X-GMX-UID: S/OEb74NeSEqb58AUnUhz3l+IGRvbwDm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201090>

Hi,

please go easy on me, this is my first bug report. I hope this is the right
place to post.

Problem: When using SshAskPass (from TortoiseGit, on Windows), git svn clone
fails with 

| git.exe svn clone "http://xxx/svn/Project"  "D:\Project"
| 
| Initialized empty Git repository in d:/Project/.git/
| Authentication realm: <http://xxx:80> Subversion Repository
| Authentication realm: <http://dew132:80> Subversion Repository
| Username: Use of uninitialized value in chomp at C:\Program Files\Git/libexec/git-core\git-svn line 4417.
| 0 [main] perl.exe" 7200 handle_exceptions: Exception: STATUS_ACCESS_VIOLATION
| 433 [main] perl.exe" 7200 open_stackdumpfile: Dumping stack trace to perl.exe.stackdump
| 
| git did not exit cleanly (exit code -1)

I have verified that the git svn client sends the base64 encoded string
"password" + "\n" as http header:
| Authorization: Basic dGVzdAo=
(Which should decode to "test\n". I had to replace my password with a manual
encoded version to show to you.)

I think there is a bug/issue in perl/Git/SVN/Prompt.pm. On windows only "\r" of
"\r\n" gets removed after calling GIT_ASKPASS. I have changed, 

diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
index 3a6f8af..8f49457 100644
--- a/perl/Git/SVN/Prompt.pm
+++ b/perl/Git/SVN/Prompt.pm
@@ -124,7 +124,7 @@ sub _read_password {
 	if (exists $ENV{GIT_ASKPASS}) {
 		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
 		$password = <PH>;
-		$password =~ s/[\012\015]//; # \n\r
+		$password =~ s/[\012\015][\012\015]?//; # \n\r
 		close(PH);
 	} else {
 		print STDERR $prompt;

and the clone worked, but think one should chomp (as sub username does):

diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
index 3a6f8af..30b6256 100644
--- a/perl/Git/SVN/Prompt.pm
+++ b/perl/Git/SVN/Prompt.pm
@@ -123,8 +123,7 @@ sub _read_password {
 	my $password = '';
 	if (exists $ENV{GIT_ASKPASS}) {
 		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
-		$password = <PH>;
-		$password =~ s/[\012\015]//; # \n\r
+		chomp($password = <PH>);
 		close(PH);
 	} else {
 		print STDERR $prompt;

Unfortunately I could not test the 2nd version, because somehow git saves the
successful credentials and I have not researched/found out, how to reset that
information yet.

Thanks for your consideration
Micha Wiedenmann

Versions:
TortoiseGit 1.7.10.0 
git version 1.7.10.msysgit.1 
