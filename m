From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-email: add a few config variables.
Date: Mon, 30 Apr 2007 14:00:06 -0700
Message-ID: <7vzm4pbmsp.fsf_-_@assigned-by-dhcp.cox.net>
References: <r6q2xgws.fsf@cante.net>
	<Pine.LNX.4.64.0704301333400.29859@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 23:01:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiczj-0001hy-QC
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 23:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946826AbXD3VAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 17:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946840AbXD3VAx
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 17:00:53 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37766 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946836AbXD3VAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 17:00:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070430210007.OJYN1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 17:00:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tZ061W0021kojtg0000000; Mon, 30 Apr 2007 17:00:06 -0400
In-Reply-To: <Pine.LNX.4.64.0704301333400.29859@racer.site> (Johannes
	Schindelin's message of "Mon, 30 Apr 2007 13:36:19 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45879>

This adds from, to, suppressfrom and nosignedoffcc configuration
variables to git-send-email, so that these common options do not
have to be given from the command line all the time.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I do not use send-email myself that often, but it irritated
   me enough that there do not seem to be a way to set these
   common things in the configuration.  Maybe I was missing
   something obvious and this patch is not needed.  I dunno.

 Documentation/git-send-email.txt |   17 +++++++++++++++++
 git-send-email.perl              |   30 +++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 795db87..3435b8c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -119,6 +119,23 @@ sendemail.chainreplyto::
 	Boolean value specifying the default to the '--chain_reply_to'
 	parameter.
 
+sendemail.fromme::
+	Boolean; when set, use your authorname and authoremail
+	(typically found in `.git/config` as user.name and
+	user.email variables) if `--from` option is not given.
+
+sendemail.to::
+	When `--to` is not specified on the command line, use
+	this address instead.
+
+sendemail.suppressfrom::
+	Boolean; when set, act as if `--suppress-from` is given
+	on the command line.
+
+sendemail.nosignedoffcc::
+	Boolean; when set, act as if `--no-signed-off-cc` is
+	given on the command line.
+
 sendemail.smtpserver::
 	Default smtp server to use.
 
diff --git a/git-send-email.perl b/git-send-email.perl
index a6e3e02..785fb75 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -164,6 +164,18 @@ if (!@bcclist or !$bcclist[0]) {
     @bcclist = ();
 }
 
+my $fromme;
+
+for my $ent (['fromme', \$fromme],
+	     ['suppressfrom', \$suppress_from],
+	     ['nosignedoffcc', \$no_signed_off_cc]) {
+	my $val = $repo->config_boolean('sendemail.' . $ent->[0]);
+	my $var = $ent->[1];
+	${$var} = (! ($val && $val eq 'false'));
+}
+
+my $default_to = $repo->config('sendmail.to');
+
 # Begin by accumulating all the variables (defined above), that we will end up
 # needing, first, from the command line:
 
@@ -187,6 +199,19 @@ unless ($rc) {
     usage();
 }
 
+# Now, let's fill any that aren't set in with defaults:
+
+my ($author) = $repo->ident_person('author');
+my ($committer) = $repo->ident_person('committer');
+
+if ($fromme && !defined $from) {
+	$from = $author;
+}
+
+if (!@to && $default_to ne '') {
+	push @to, $default_to;
+}
+
 # Verify the user input
 
 foreach my $entry (@to) {
@@ -201,11 +226,6 @@ foreach my $entry (@bcclist) {
 	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
 }
 
-# Now, let's fill any that aren't set in with defaults:
-
-my ($author) = $repo->ident_person('author');
-my ($committer) = $repo->ident_person('committer');
-
 my %aliases;
 my @alias_files = $repo->config('sendemail.aliasesfile');
 my $aliasfiletype = $repo->config('sendemail.aliasfiletype');
-- 
1.5.2.rc0.781.g5868
