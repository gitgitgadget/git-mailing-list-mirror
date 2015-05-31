From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 5/9] send-email: refactor sendmail aliases parser
Date: Sun, 31 May 2015 18:29:27 -0400
Message-ID: <1433111371-19573-6-git-send-email-sunshine@sunshineco.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 00:30:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBkq-0005p2-Vj
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758624AbbEaWam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:30:42 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38702 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758489AbbEaWaX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:30:23 -0400
Received: by igbjd9 with SMTP id jd9so48926592igb.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1wcdT5yc0e6MilcmifZPWsZ24F5DVKvdGcPqDMHGSsc=;
        b=Q3vZASXaaLMn53uxHAINCNgbIKQtkkNum1/S+3AKyyLOmUhIL9IBr9xJjLS4NjiGBI
         c6DrRjOm0oZVZT8X6vqkRS2cUfkY6uctilwknhIGED6yPK7YA7ZS5vSuunWBqEhyQABj
         5j0nKsZiqaqN28tK1H5PbhSAjZEU9Pj1hAXB8NFrcbYCugMv2Z896RnSWQtmrLRIfweB
         8DONCT3jB0sb2XLciST7Ne+9D5yikLf90dj4SztP3MPvsseKAcA0sC27PNnnkZSbUG1v
         kJoUemetw/EqG38zTC9jSo8SOsYoSrHCG73uCU8HJJzO1fBJANwpRsOUphGQ8+JgB7sw
         NfFw==
X-Received: by 10.107.168.92 with SMTP id r89mr23222708ioe.20.1433111422620;
        Sun, 31 May 2015 15:30:22 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id j20sm6571830igt.5.2015.05.31.15.30.21
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 15:30:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.325.gb038f2f
In-Reply-To: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270361>

The sendmail aliases parser inlined into %parse_alias is already
uncomfortably large and is expected to grow as additional functionality
is implemented, so extract it to improve manageability.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 git-send-email.perl | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1380e6e..76bb499 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -487,6 +487,29 @@ sub split_addrs {
 }
 
 my %aliases;
+
+sub parse_sendmail_alias {
+	local $_ = shift;
+	if (/"/) {
+		print STDERR "warning: sendmail alias with quotes is not supported: $_\n";
+	} elsif (/^\s|\\$/) {
+		print STDERR "warning: sendmail continuation line is not supported: $_\n";
+	} elsif (/^(\S+?)\s*:\s*(.+)$/) {
+		my ($alias, $addr) = ($1, $2);
+		$aliases{$alias} = [ split_addrs($addr) ];
+	} else {
+		print STDERR "warning: sendmail line is not recognized: $_\n";
+	}
+}
+
+sub parse_sendmail_aliases {
+	my $fh = shift;
+	while (<$fh>) {
+		if (/^\s*(?:#.*)?$/) { next; }
+		parse_sendmail_alias($_);
+	}
+}
+
 my %parse_alias = (
 	# multiline formats can be supported in the future
 	mutt => sub { my $fh = shift; while (<$fh>) {
@@ -515,20 +538,7 @@ my %parse_alias = (
 			       $aliases{$alias} = [ split_addrs($addr) ];
 			  }
 		      } },
-
-	sendmail => sub { my $fh = shift; while (<$fh>) {
-		if (/^\s*(?:#.*)?$/) {
-		} elsif (/"/) {
-			print STDERR "warning: sendmail alias with quotes is not supported: $_\n";
-		} elsif (/^\s|\\$/) {
-			print STDERR "warning: sendmail continuation line is not supported: $_\n";
-		} elsif (/^(\S+?)\s*:\s*(.+)$/) {
-			my ($alias, $addr) = ($1, $2);
-			$aliases{$alias} = [ split_addrs($addr) ];
-		} else {
-			print STDERR "warning: sendmail line is not recognized: $_\n";
-		}}},
-
+	sendmail => \&parse_sendmail_aliases,
 	gnus => sub { my $fh = shift; while (<$fh>) {
 		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
 			$aliases{$1} = [ $2 ];
-- 
2.4.2.538.g5f4350e
