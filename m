From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 2/2][Perlers?] git-send-email: SIG{TERM,INT} handlers
Date: Fri,  1 Feb 2008 23:06:01 -0500
Message-ID: <1201925161-9864-2-git-send-email-mfwitten@mit.edu>
References: <7vve586tbz.fsf@gitster.siamese.dyndns.org>
 <1201925161-9864-1-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org, Michael Witten <mfwitten@mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 05:07:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL9ec-0002ta-Dl
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 05:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759099AbYBBEGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 23:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758836AbYBBEGL
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 23:06:11 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:53903 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758271AbYBBEGK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2008 23:06:10 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m12465Wv023894;
	Fri, 1 Feb 2008 23:06:05 -0500 (EST)
Received: from localhost.localdomain (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m12462ia018415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 1 Feb 2008 23:06:05 -0500 (EST)
X-Mailer: git-send-email 1.5.4.rc5.17.g8ca921-dirty
In-Reply-To: <1201925161-9864-1-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72219>

A single signal handler is used for both SIGTERM
and SIGINT in order to clean up after an uncouth
termination of git-send-email.

In particular, the handler resets the text color
(this cleanup was already present), turns on tty
echoing (in case termination occurrs during a
masked Password prompt), and informs the user of
of any temporary files created by --compose.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---

	Perlers, please comment.

 git-send-email.perl |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ed0a473..a0c9e8f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -24,8 +24,6 @@ use Data::Dumper;
 use Term::ANSIColor;
 use Git;
 
-$SIG{INT} = sub { print color("reset"), "\n"; exit };
-
 package FakeTerm;
 sub new {
 	my ($class, $reason) = @_;
@@ -201,6 +199,29 @@ my %config_settings = (
     "aliasesfile" => \@alias_files,
 );
 
+# Handle Uncouth Termination
+sub signal_handler{
+	
+	# Make text normal
+	print color("reset"), "\n";
+
+	# SMTP password masked
+	system "stty echo";
+
+	# tmp files from --compose
+	if (-e $compose_filename) {
+		print "'$compose_filename' contains an intermediate version of the email you were composing.\n";
+	}
+	if (-e ($compose_filename . ".final")) {
+		print "'$compose_filename.final' contains the composed email.\n"
+	}
+
+	exit;
+};
+
+$SIG{TERM} = \&signal_handler;
+$SIG{INT}  = \&signal_handler;
+
 # Begin by accumulating all the variables (defined above), that we will end up
 # needing, first, from the command line:
 
-- 
1.5.4.rc5.17.g8ca921-dirty
