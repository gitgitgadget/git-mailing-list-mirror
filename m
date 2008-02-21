From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] cvsimport: allow for multiple -M options
Date: Thu, 21 Feb 2008 15:25:49 +0100
Message-ID: <1203603949-27790-1-git-send-email-book@cpan.org>
Cc: gitster@pobox.com, "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 15:26:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSCNr-0002C4-Pp
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 15:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbYBUO0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 09:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbYBUO0L
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 09:26:11 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:53083 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbYBUO0K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 09:26:10 -0500
Received: from localhost ([127.0.0.1] helo=plop.home.bruhat.net)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JSCIH-0004eu-K4; Thu, 21 Feb 2008 15:21:01 +0100
Received: from book by plop.home.bruhat.net with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JSCN0-0007Ec-E9; Thu, 21 Feb 2008 15:25:54 +0100
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74617>

Use Getopt::Long instead of Getopt::Std to handle multiple -M options,
for all the cases when having a single custom regex is not enough.

For example, "merged (\w+)" and "(\w+) merged" can't be easily turned
into a single regular expression capturing the branch name in $1.

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
---
 git-cvsimport.perl |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 3d013a7..f138a01 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -15,7 +15,7 @@
 
 use strict;
 use warnings;
-use Getopt::Std;
+use Getopt::Long;
 use File::Spec;
 use File::Temp qw(tempfile tmpnam);
 use File::Path qw(mkpath);
@@ -29,7 +29,7 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r);
+our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r);
 my (%conv_author_name, %conv_author_email);
 
 sub usage(;$) {
@@ -112,7 +112,12 @@ sub read_repo_config {
 
 my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:";
 read_repo_config($opts);
-getopts($opts) or usage();
+Getopt::Long::Configure( 'no_ignore_case' );
+
+# turn the Getopt::Std specification in a Getopt::Long one,
+# with support for multiple -M options
+GetOptions( map { s/:/=s/; /M/ ? "$_\@" : $_ } split( /(?!:)/, $opts ) )
+    or usage();
 usage if $opt_h;
 
 if (@ARGV == 0) {
@@ -166,8 +171,8 @@ our @mergerx = ();
 if ($opt_m) {
 	@mergerx = ( qr/\b(?:from|of|merge|merging|merged) ([-\w]+)/i );
 }
-if ($opt_M) {
-	push (@mergerx, qr/$opt_M/);
+if (@opt_M) {
+	push (@mergerx, map { qr/$_/ } @opt_M);
 }
 
 # Remember UTC of our starting time
-- 
1.5.4.1
