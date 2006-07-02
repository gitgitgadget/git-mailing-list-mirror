From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-email: do not barf when Term::ReadLine does not like your terminal
Date: Sun, 02 Jul 2006 16:03:59 -0700
Message-ID: <7vpsgn1ue8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 01:04:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxAz8-0004U3-IR
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 01:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWGBXED (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 19:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWGBXEB
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 19:04:01 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43666 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751458AbWGBXEA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 19:04:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702230359.BJOI27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 19:03:59 -0400
To: Ryan Anderson <ryan@michonline.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23134>

As long as we do not need to readline from the terminal, we
should not barf when starting up the program.  Without this
patch, t9001 test on Cygwin occasionally died with the following
error message:

Unable to get Terminal Size. The TIOCGWINSZ ioctl didn't work. The COLUMNS and LINES environment variables didn't work. The resize program didn't work. at /usr/lib/perl5/vendor_perl/5.8/cygwin/Term/ReadKey.pm line 362.
Compilation failed in require at /usr/lib/perl5/vendor_perl/5.8/Term/ReadLine/Perl.pm line 58.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I do not use send-email myself that often so extra sets of
   eyeballs are appreciated.

 git-send-email.perl   |   18 +++++++++++++++++-
 t/t9001-send-email.sh |   11 +++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c5d9e73..b04b8f4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -22,6 +22,17 @@ use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
 
+package FakeTerm;
+sub new {
+	my ($class, $reason) = @_;
+	return bless \$reason, shift;
+}
+sub readline {
+	my $self = shift;
+	die "Cannot use readline on FakeTerm: $$self";
+}
+package main;
+
 # most mail servers generate the Date: header, but not all...
 $ENV{LC_ALL} = 'C';
 use POSIX qw/strftime/;
@@ -46,7 +57,12 @@ my $smtp_server;
 # Example reply to:
 #$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
 
-my $term = new Term::ReadLine 'git-send-email';
+my $term = eval {
+	new Term::ReadLine 'git-send-email';
+};
+if ($@) {
+	$term = new FakeTerm "$@: going non-interactive";
+}
 
 # Begin by accumulating all the variables (defined above), that we will end up
 # needing, first, from the command line:
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a61da1e..e9ea33c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -25,10 +25,13 @@ test_expect_success \
      git add fake.sendmail
      GIT_AUTHOR_NAME="A" git commit -a -m "Second."'
 
-test_expect_success \
-    'Extract patches and send' \
-    'git format-patch -n HEAD^1
-     git send-email -from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" ./0001*txt'
+test_expect_success 'Extract patches' '
+    patches=`git format-patch -n HEAD^1`
+'
+
+test_expect_success 'Send patches' '
+     git send-email -from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+'
 
 cat >expected <<\EOF
 !nobody@example.com!
-- 
1.4.1.gc92a
