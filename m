From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-relink status (or bug?)
Date: Sat, 21 Jun 2008 12:22:09 -0700
Message-ID: <7v4p7ma90e.fsf@gitster.siamese.dyndns.org>
References: <20080621103636.GA696@kernoel.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Zonzon <marc.zonzon+git@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 21:23:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA8gc-0005pZ-6e
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 21:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbYFUTW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 15:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbYFUTW1
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 15:22:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbYFUTWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 15:22:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4749ECC17;
	Sat, 21 Jun 2008 15:22:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 46AF1CC16; Sat, 21 Jun 2008 15:22:18 -0400 (EDT)
In-Reply-To: <20080621103636.GA696@kernoel.dyndns.org> (Marc Zonzon's message
 of "Sat, 21 Jun 2008 12:36:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 60026D9A-3FC7-11DD-9AF0-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85722>

Marc Zonzon <marc.zonzon+git@gmail.com> writes:

> I found very few information about git relink, but as it appears in
> changelog of v1.5.4 I suppose it is not obsoleted.

I do not think anybody uses it these days.  Instead either they clone with
reference (or -s), or perhaps use new-workdir.

Here is a totally untested fix.

The "careful" part can be made much more clever and efficient by learning
implementation details about the .idx file (it has the checksum for itself
and the checksum for its .pack file at the end) but I did not bother.

I do not think this in its current shape is committable, without
improvements and success reports from the list.  Hint, hint...


 git-relink.perl |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/git-relink.perl b/git-relink.perl
index 15fb932..68e0f0e 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -10,10 +10,11 @@ use 5.006;
 use strict;
 use warnings;
 use Getopt::Long;
+use File::Compare;
 
 sub get_canonical_form($);
 sub do_scan_directory($$$);
-sub compare_two_files($$);
+sub compare_and_link($$$);
 sub usage();
 sub link_two_files($$);
 
@@ -67,6 +68,7 @@ sub do_scan_directory($$$) {
 
 	my $sfulldir = sprintf("%sobjects/%s/",$srcdir,$subdir);
 	my $dfulldir = sprintf("%sobjects/%s/",$dstdir,$subdir);
+	my $careful = ($subdir eq 'pack');
 
 	opendir(S,$sfulldir)
 		or die "Failed to opendir $sfulldir: $!";
@@ -75,14 +77,14 @@ sub do_scan_directory($$$) {
 		my $sfilename = $sfulldir . $file;
 		my $dfilename = $dfulldir . $file;
 
-		compare_two_files($sfilename,$dfilename);
+		compare_and_link($sfilename, $dfilename, $careful);
 
 	}
 	closedir(S);
 }
 
-sub compare_two_files($$) {
-	my ($sfilename, $dfilename) = @_;
+sub compare_and_link($$$) {
+	my ($sfilename, $dfilename, $careful) = @_;
 
 	# Perl's stat returns relevant information as follows:
 	# 0 = dev number
@@ -100,12 +102,20 @@ sub compare_two_files($$) {
 
 	if ( ($sstatinfo[0] == $dstatinfo[0]) &&
 	     ($sstatinfo[1] != $dstatinfo[1])) {
-		if ($sstatinfo[7] == $dstatinfo[7]) {
+		my $differs = undef;
+		if ($sstatinfo[7] != $dstatinfo[7]) {
+			$differs = "size";
+		}
+		if (!$differs && $careful) {
+			if (File::Compare::compare($sfilename, $dfilename)) {
+				$differs = "contents";
+			}
+		}
+		if (!$differs) {
 			link_two_files($sfilename, $dfilename);
-
 		} else {
-			my $err = sprintf("ERROR: File sizes are not the same, cannot relink %s to %s.\n",
-				$sfilename, $dfilename);
+			my $err = sprintf("ERROR: File differs (%s), cannot relink %s to %s.\n",
+					  $differs, $sfilename, $dfilename);
 			if ($fail_on_different_sizes) {
 				die $err;
 			} else {
