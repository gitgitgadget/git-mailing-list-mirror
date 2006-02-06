From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] git-send-email: Fully implement --quiet and document it.
Date: Sun, 5 Feb 2006 20:13:52 -0500
Message-ID: <1139188432972-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 02:14:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5uxd-0001MN-UT
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 02:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWBFBOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 20:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWBFBOX
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 20:14:23 -0500
Received: from mail.autoweb.net ([198.172.237.26]:55182 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750736AbWBFBOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 20:14:22 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F5uxK-0007lc-Br; Sun, 05 Feb 2006 20:14:15 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F5uxJ-00027t-Da; Sun, 05 Feb 2006 20:14:14 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F5uwz-0001JQ-1Y; Sun, 05 Feb 2006 20:13:53 -0500
In-Reply-To: 
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15647>

Also reorganizes the man page to list options alphabetically.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 Documentation/git-send-email.txt |   44 +++++++++++++++++++++-----------------
 git-send-email.perl              |   19 +++++++++++-----
 2 files changed, 37 insertions(+), 26 deletions(-)

3b91b8b4e04e5cf42b7e5bd22b1bdda9c50ed781
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index b9bec55..00537d8 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -24,25 +24,23 @@ OPTIONS
 -------
 The options available are:
 
---to::
-	Specify the primary recipient of the emails generated.
-	Generally, this will be the upstream maintainer of the
-	project involved.
+--chain-reply-to, --no-chain-reply-to::
+	If this is set, each email will be sent as a reply to the previous
+	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	the first will be sent as replies to the first email sent.  When using
+	this, it is recommended that the first file given be an overview of the
+	entire patch series.
+	Default is --chain-reply-to
+
+--compose::
+	Use $EDITOR to edit an introductory message for the
+	patch series.
 
 --from::
 	Specify the sender of the emails.  This will default to
 	the value GIT_COMMITTER_IDENT, as returned by "git-var -l".
 	The user will still be prompted to confirm this entry.
 
---compose::
-	Use \$EDITOR to edit an introductory message for the
-	patch series.
-
---subject::
-   	Specify the initial subject of the email thread.
-	Only necessary if --compose is also set.  If --compose
-	is not set, this will be prompted for.
-
 --in-reply-to::
 	Specify the contents of the first In-Reply-To header.
 	Subsequent emails will refer to the previous email 
@@ -50,18 +48,24 @@ The options available are:
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---chain-reply-to, --no-chain-reply-to::
-	If this is set, each email will be sent as a reply to the previous
-	email sent.  If disabled with "--no-chain-reply-to", all emails after
-	the first will be sent as replies to the first email sent.  When using
-	this, it is recommended that the first file given be an overview of the
-	entire patch series.
-	Default is --chain-reply-to
+--quiet::
+	Make git-send-email less verbose.  One line per email should be
+	all that is output.
 
 --smtp-server::
 	If set, specifies the outgoing SMTP server to use.  Defaults to
 	localhost.
 
+--subject::
+   	Specify the initial subject of the email thread.
+	Only necessary if --compose is also set.  If --compose
+	is not set, this will be prompted for.
+
+--to::
+	Specify the primary recipient of the emails generated.
+	Generally, this will be the upstream maintainer of the
+	project involved.
+
 
 Author
 ------
diff --git a/git-send-email.perl b/git-send-email.perl
index 2977b9a..3f1b3ca 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -186,7 +186,9 @@ for my $f (@ARGV) {
 }
 
 if (@files) {
-	print $_,"\n" for @files;
+	unless ($quiet) {
+		print $_,"\n" for (@files);
+	}
 } else {
 	print <<EOT;
 git-send-email [options] <file | directory> [... file | directory ]
@@ -213,6 +215,10 @@ Options:
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
 
+   --quiet	Make git-send-email less verbose.  One line per email should be
+		all that is output.
+
+
 Error: Please specify a file or a directory on the command line.
 EOT
 	exit(1);
@@ -268,7 +274,9 @@ sub send_message
 
 	sendmail(%mail) or die $Mail::Sendmail::error;
 
-	unless ($quiet) {
+	if ($quiet) {
+		printf "Sent %s\n", $subject;
+	} else {
 		print "OK. Log says:\n", $Mail::Sendmail::log;
 		print "\n\n"
 	}
@@ -280,7 +288,6 @@ make_message_id();
 $subject = $initial_subject;
 
 foreach my $t (@files) {
-	my $F = $t;
 	open(F,"<",$t) or die "can't open file $t";
 
 	@cc = ();
@@ -298,7 +305,7 @@ foreach my $t (@files) {
 
 				} elsif (/^(Cc|From):\s+(.*)$/) {
 					printf("(mbox) Adding cc: %s from line '%s'\n",
-						$2, $_);
+						$2, $_) unless $quiet;
 					push @cc, $2;
 				}
 
@@ -310,7 +317,7 @@ foreach my $t (@files) {
 				# So let's support that, too.
 				if (@cc == 0) {
 					printf("(non-mbox) Adding cc: %s from line '%s'\n",
-						$_, $_);
+						$_, $_) unless $quiet;
 
 					push @cc, $_;
 
@@ -330,7 +337,7 @@ foreach my $t (@files) {
 				chomp $c;
 				push @cc, $c;
 				printf("(sob) Adding cc: %s from line '%s'\n",
-					$c, $_);
+					$c, $_) unless $quiet;
 			}
 		}
 	}
-- 
1.1.6.ga5ec-dirty
