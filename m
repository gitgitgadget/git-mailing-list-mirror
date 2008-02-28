From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] cvsimport: allow for multiple -M options
Date: Thu, 28 Feb 2008 11:18:22 +0100
Message-ID: <1204193904-3652-3-git-send-email-book@cpan.org>
References: <>
 <1204193904-3652-1-git-send-email-book@cpan.org>
 <1204193904-3652-2-git-send-email-book@cpan.org>
Cc: gitster@pobox.com, "Philippe Bruhat (BooK" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 11:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUfrU-0005MG-7p
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 11:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbYB1KS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 05:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754509AbYB1KS5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 05:18:57 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:34202 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbYB1KS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 05:18:56 -0500
Received: from localhost ([127.0.0.1] helo=plop.home.bruhat.net)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JUfrw-0007py-6e; Thu, 28 Feb 2008 11:20:04 +0100
Received: from book by plop.home.bruhat.net with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JUfqZ-0000aT-E5; Thu, 28 Feb 2008 11:18:39 +0100
X-Mailer: git-send-email 1.5.4.2.187.gfc276
In-Reply-To: <1204193904-3652-2-git-send-email-book@cpan.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75378>

From: Philippe Bruhat (BooK <book@cpan.org>

Use Getopt::Long instead of Getopt::Std to handle multiple -M options,
for all the cases when having a single custom regex is not enough.

For example, "merged (\w+)" and "(\w+) merged" can't be easily turned
into a single regular expression capturing the branch name in $1.
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
1.5.4.2.187.gfc276
