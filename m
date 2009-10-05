From: Joe Perches <joe@perches.com>
Subject: [PATCH] git-send-email.perl: Fold long header lines to 78 chars
Date: Mon, 05 Oct 2009 09:24:58 -0700
Message-ID: <1254759898.1799.449.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 18:32:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuqUO-0007D8-6f
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 18:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbZJEQZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 12:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbZJEQZg
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 12:25:36 -0400
Received: from mail.perches.com ([173.55.12.10]:1847 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbZJEQZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 12:25:36 -0400
Received: from [192.168.1.151] (Joe-Laptop.home [192.168.1.151])
	by mail.perches.com (Postfix) with ESMTP id 399D924368;
	Mon,  5 Oct 2009 09:24:50 -0700 (PDT)
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129572>

Some MTAs reject or filter long header lines which can
be generated if the cc list is only a few entries.

Fold long header lines to 78 chars to be more rfc compliant.

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/git-send-email.perl b/git-send-email.perl
index dd821f7..cb8b48b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -814,6 +814,41 @@ sub sanitize_address
 
 }
 
+# Fold header lines to 78 chars if possible for better RFC 2822 compliance
+# Does not terminate last line with newline
+sub fold_header
+{
+    my ($folded_line, $separator, @entries) = @_;
+    my $folded_header = "";
+    my $count = 0;
+    my $trim_sep = $separator;
+
+    $trim_sep =~ s/\s+$//;
+
+    foreach my $entry (@entries) {
+	if ($count == 0) {
+	    $folded_line = "$folded_line$entry";
+	} elsif ((length($folded_line) + length($entry)) > 78) {
+	    if ($folded_header ne "") {
+		$folded_header = "$folded_header$trim_sep\n";
+	    }
+	    $folded_header = "$folded_header$folded_line";
+	    $folded_line = " $entry";
+	} else {
+	    $folded_line = "$folded_line$separator$entry";
+	}
+	$count++;
+    }
+
+    if ($count == 0) {
+	$folded_header = "$folded_line";
+    } else {
+	$folded_header = "$folded_header$trim_sep\n$folded_line";
+    }
+
+    return "$folded_header";
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -835,10 +870,10 @@ sub send_message
 	    $gitversion = Git::version();
 	}
 
-	my $cc = join(", ", unique_email_list(@cc));
+	@cc = unique_email_list(@cc);
 	my $ccline = "";
-	if ($cc ne '') {
-		$ccline = "\nCc: $cc";
+	if (@cc gt 0) {
+		$ccline = fold_header("\nCc: ", ", ", @cc);
 	}
 	my $sanitized_sender = sanitize_address($sender);
 	make_message_id() unless defined($message_id);
@@ -976,7 +1011,7 @@ X-Mailer: git-send-email $gitversion
 		if ($smtp_server !~ m#^/#) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
-			print "RCPT TO:".join(',',(map { "<$_>" } @recipients))."\n";
+			print fold_header("RCPT TO:", ",", map { "<$_>" } @recipients)."\n";
 		} else {
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
 		}
