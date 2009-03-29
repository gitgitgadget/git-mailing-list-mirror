From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/2] send-email: refactor and ensure prompting doesn't loop forever
Date: Sat, 28 Mar 2009 21:39:10 -0400
Message-ID: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 03:41:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnk1F-0004jB-W3
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 03:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117AbZC2Bj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 21:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754348AbZC2Bj2
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 21:39:28 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:45137 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbZC2BjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 21:39:25 -0400
Received: by qyk16 with SMTP id 16so2808613qyk.33
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 18:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=BhApp4Wa4m0GVf0SPSdI7fxoLwd+W6yGyXEmDIMmSyI=;
        b=RThp34FDSHn4BNGctVdj7AyNPPg6MhXlN25kkpQBW9rAZo0QFJVqC158DlvdxrBE4k
         pQhFIYgdmoZQOSdIziqJF/o4JJDBeVFmBD5n1YPQMbd7UeAffEsbK4EbpgjDSA4OHqLX
         nkYdAfxId2Wb7p4YFB8FgW9JdLQPcE8o0kLMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=xazu2xmXU6r3Xog5UkwACnWLfI34Du2POku7wQAmyJ0BWWcFzTScqPcxSnkfIBuG3L
         s4VKsx+s7qIG3U67PsCzp7mY1g5J4ICOHfSFSHpMHvCpdJOjATrrs9kOBsyqYgfsHJyi
         qUadzVhydabvMNetaBGngw7V/Q2VMgaxdAODE=
Received: by 10.224.45.144 with SMTP id e16mr4695340qaf.53.1238290758923;
        Sat, 28 Mar 2009 18:39:18 -0700 (PDT)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 7sm4033358qwb.41.2009.03.28.18.39.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 18:39:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.406.g8b07c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114994>

Several places in send-email prompt for input, and will do so forever
when the input is EOF. This is poor behavior when send-email is run
unattended (say from cron).

This patch refactors the prompting to an ask() function which takes a
prompt, an optional default, and an optional regex to validate the
input. The function returns on EOF, or if a default is provided and the
user simply types return, or if the input passes the validating regex
(which accepts all input by default). The ask() function gives up after
10 tries in case of invalid input.

There are three callers of the function:

1) "Who should the emails appear to be from?" which provides a default
sender. Previously the user would have to type ctrl-d to accept the
default. Now the user can just hit return, or type ctrl-d.

2) "Who should the emails be sent to?". Previously this prompt passed a
second argument ("") to $term->readline() which was ignored. I believe
the intent was to allow the user to just hit return. Now the user
can do so, or type ctrl-d.

3) "Send this email?". Previously this prompt would loop forever until
it got a valid reply. Now it stops prompting on EOF or a valid reply. In
the case where confirm = "inform", it now defaults to "y" on EOF or the
user hitting return, otherwise an invalid reply causes send-email to
terminate.

A followup patch adds tests for the new functionality.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-send-email.perl |   66 ++++++++++++++++++++++++++------------------------
 1 files changed, 34 insertions(+), 32 deletions(-)

This and the next patch address the bug reported by Matthieu in
http://article.gmane.org/gmane.comp.version-control.git/114577

Of course, I've been wanting to refactor the prompting for a while, so I used
the bug fix as an excuse to do so.

j.

diff --git a/git-send-email.perl b/git-send-email.perl
index 546d2eb..f0405c8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -606,32 +606,40 @@ EOT
 	do_edit(@files);
 }
 
+sub ask {
+	my ($prompt, %arg) = @_;
+	my $valid_re =$arg{valid_re} || ""; # "" matches anything
+	my $default = $arg{default};
+	my $resp;
+	my $i = 0;
+	while ($i++ < 10) {
+		$resp = $term->readline($prompt);
+		if (!defined $resp) { # EOF
+			print "\n";
+			return defined $default ? $default : undef;
+		}
+		if ($resp eq '' and defined $default) {
+			return $default;
+		}
+		if ($resp =~ /$valid_re/) {
+			return $resp;
+		}
+	}
+	return undef;
+}
+
 my $prompting = 0;
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
-
-	while (1) {
-		$_ = $term->readline("Who should the emails appear to be from? [$sender] ");
-		last if defined $_;
-		print "\n";
-	}
-
-	$sender = $_ if ($_);
+	$sender = ask("Who should the emails appear to be from? [$sender] ",
+	              default => $sender);
 	print "Emails will be sent from: ", $sender, "\n";
 	$prompting++;
 }
 
 if (!@to) {
-
-
-	while (1) {
-		$_ = $term->readline("Who should the emails be sent to? ", "");
-		last if defined $_;
-		print "\n";
-	}
-
-	my $to = $_;
-	push @to, parse_address_line($to);
+	my $to = ask("Who should the emails be sent to? ");
+	push @to, parse_address_line($to) if defined $to; # sanitized/validated later
 	$prompting++;
 }
 
@@ -651,13 +659,8 @@ sub expand_aliases {
 @bcclist = expand_aliases(@bcclist);
 
 if ($thread && !defined $initial_reply_to && $prompting) {
-	while (1) {
-		$_= $term->readline("Message-ID to be used as In-Reply-To for the first email? ", $initial_reply_to);
-		last if defined $_;
-		print "\n";
-	}
-
-	$initial_reply_to = $_;
+	$initial_reply_to = ask(
+		"Message-ID to be used as In-Reply-To for the first email? ");
 }
 if (defined $initial_reply_to) {
 	$initial_reply_to =~ s/^\s*<?//;
@@ -839,8 +842,10 @@ X-Mailer: git-send-email $gitversion
 
 	if ($needs_confirm && !$dry_run) {
 		print "\n$header\n";
+		my $ask_default;
 		if ($needs_confirm eq "inform") {
 			$confirm_unconfigured = 0; # squelch this message for the rest of this run
+			$ask_default = "y"; # assume yes on EOF since user hasn't explicitly asked for confirmation
 			print "    The Cc list above has been expanded by additional\n";
 			print "    addresses found in the patch commit message. By default\n";
 			print "    send-email prompts before sending whenever this occurs.\n";
@@ -851,13 +856,10 @@ X-Mailer: git-send-email $gitversion
 			print "    To retain the current behavior, but squelch this message,\n";
 			print "    run 'git config --global sendemail.confirm auto'.\n\n";
 		}
-		while (1) {
-			chomp ($_ = $term->readline(
-				"Send this email? ([y]es|[n]o|[q]uit|[a]ll): "
-			));
-			last if /^(?:yes|y|no|n|quit|q|all|a)/i;
-			print "\n";
-		}
+		$_ = ask("Send this email? ([y]es|[n]o|[q]uit|[a]ll): ",
+		         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
+		         default => $ask_default);
+		die "Send this email reply required" unless defined $_;
 		if (/^n/i) {
 			return;
 		} elsif (/^q/i) {
-- 
1.6.2.313.g33352
