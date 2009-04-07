From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Tue,  7 Apr 2009 16:25:17 -0500
Message-ID: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 23:28:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrIpt-0002qz-Um
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760634AbZDGVZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 17:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759610AbZDGVZj
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:25:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:61365 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757642AbZDGVZi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 17:25:38 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2931737rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=rpD++cklC0XYlKrix3XtpK8pg34eueHuvyu69lKX22I=;
        b=deDFZ5GPFWP+yqn7dgCti0yCyQ4tyeZTJJLKTZYdJ1umD/RXN1L1NFZvO0UchNIfM/
         rmMtsYmOZqQs5Mmhti5WvWfba7NWfHqkCI2WCJDb8MjcVG0ZrzXZyCxQb67C6/sRmshK
         EluP5HXZpAwbT8efkcDRrnE5ooqjglPlh6wpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=r2hcbGSLw3hxuaah0yw0F1+G/GMr9YnAz0aG5OBJ2mEimz8muWfSDnARCMJcape0rV
         tY6xTDok6gWJtugmJBbl+5aPcahtPupbjnLZHDzIiGVfFbkHh5LtsD/HrCrnlO6Fgk9x
         mKqSwbdSmXDZrxe2x2MJtvuo+I1BssYZxurNI=
Received: by 10.114.59.1 with SMTP id h1mr300389waa.87.1239139537346;
        Tue, 07 Apr 2009 14:25:37 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-21.mpls.qwest.net [97.116.125.21])
        by mx.google.com with ESMTPS id j39sm7381340waf.28.2009.04.07.14.25.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 14:25:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.448.g61445.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115988>

When sending a patch series, the emails often arrive at the final
destination out of order; though these emails should be chained
via the In-Reply-To headers, some mail-viewing systems display
by order of arrival instead.

The --delay option provides a means for specifying that there
should be a certain number of seconds of delay between sending
emails, so that the arrival order can be controlled better.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    5 +++++
 git-send-email.perl              |   17 +++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 10dfd66..4b656ca 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -97,6 +97,11 @@ The --to option must be repeated for each user you want on the to list.
 Sending
 ~~~~~~~
 
+--delay::
+	Specify the minimum number of seconds of delay that should occur
+	between sending emails. This number should be an integer >= zero.
+	Default is the value of the 'sendemail.delay' configuration variable.
+
 --envelope-sender::
 	Specify the envelope sender used to send the emails.
 	This is useful if your default address is not the address that is
diff --git a/git-send-email.perl b/git-send-email.perl
index 172b53c..273c8c7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -56,6 +56,7 @@ git send-email [options] <file | directory | rev-list options >
     --compose                      * Open an editor for introduction.
 
   Sending:
+    --delay                 <int>  * Delay (seconds) between sending emails.
     --envelope-sender       <str>  * Email envelope sender.
     --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
                                      is optional. Default 'localhost'.
@@ -180,7 +181,7 @@ sub do_edit {
 }
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
+my ($delay, $thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate, $confirm);
@@ -196,6 +197,7 @@ my %config_bool_settings = (
 );
 
 my %config_settings = (
+    "delay" => \$delay,
     "smtpserver" => \$smtp_server,
     "smtpserverport" => \$smtp_server_port,
     "smtpuser" => \$smtp_authuser,
@@ -247,6 +249,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "cc=s" => \@initial_cc,
 		    "bcc=s" => \@bcclist,
 		    "chain-reply-to!" => \$chain_reply_to,
+		    "delay=i" => \$delay,
 		    "smtp-server=s" => \$smtp_server,
 		    "smtp-server-port=s" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
@@ -973,8 +976,9 @@ $references = $initial_reply_to || '';
 $subject = $initial_subject;
 $message_num = 0;
 
-foreach my $t (@files) {
-	open(F,"<",$t) or die "can't open file $t";
+for (my $index = 0; $index < @files; $index++) {
+	my $file = $files[$index];
+	open(F,"<",$file) or die "can't open file $file";
 
 	my $author = undef;
 	my $author_encoding;
@@ -1083,7 +1087,7 @@ foreach my $t (@files) {
 	close F;
 
 	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
-		open(F, "$cc_cmd $t |")
+		open(F, "$cc_cmd $file |")
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
 		while(<F>) {
 			my $c = $_;
@@ -1128,6 +1132,11 @@ foreach my $t (@files) {
 
 	send_message();
 
+	if ($delay && $index < $#files) {
+		my $this_long = $delay;
+		while (($this_long -= sleep $this_long) > 0) {}
+	}
+
 	# set up for the next message
 	if ($chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
 		$reply_to = $message_id;
-- 
1.6.2.2.448.g61445.dirty
