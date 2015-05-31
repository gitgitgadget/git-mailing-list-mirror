From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 7/9] send-email: implement sendmail aliases line continuation support
Date: Sun, 31 May 2015 18:29:29 -0400
Message-ID: <1433111371-19573-8-git-send-email-sunshine@sunshineco.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 00:30:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBkp-0005p2-5i
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758607AbbEaWac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:30:32 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36554 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758560AbbEaWaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:30:25 -0400
Received: by ieclw1 with SMTP id lw1so1790465iec.3
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Csn/CqjwWGMa84Frk9duNo4qvmsiRaXW2ltBfqShaCQ=;
        b=IfYAtHL4fI2Gk5pBGq7VOOwrbr/7AxPBxa4aLj1xpfdFbOHeeVAOyeVFP66v13ZmaZ
         nRz43CrZFKOay6u81QzZ/vGLcSXjcNqeAGmEurW6oPu39jpMUQo2kOgfbqcsiy3o+KyC
         glM4B9gAfL3rdG3Yxr0Z/OHxXT6iuUiK8o+eLP9WGR0EKZFLffo6/hwZUTci9GnEghdI
         VwlzZDEBNYB3MQMakQDQMRY9RQ9dDUSBaOAZ+MQbYuDL/zfY3qZpDW66KnsM3UZOd2Lh
         XBnEmZc358ZewFDpUiPlX0VTV/R6ooC/jAnxlncSF21o213MCWiCvyP/CHI1zEjtx2bS
         3UkA==
X-Received: by 10.107.5.210 with SMTP id 201mr22471170iof.88.1433111424174;
        Sun, 31 May 2015 15:30:24 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id j20sm6571830igt.5.2015.05.31.15.30.23
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 15:30:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.325.gb038f2f
In-Reply-To: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270360>

Logical lines in sendmail aliases files can be spread over multiple
physical lines[1]. A line beginning with whitespace is folded into the
preceding line. A line ending with '\' consumes the following line.

[1]: https://www.freebsd.org/cgi/man.cgi?query=aliases&sektion=5

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This implementation silently and "sanely" tolerates continuation line
scenarios for which behavior is not defined by [1]. In particular, an
indented line which is the first (non-comment) line in the file is
treated as a single logical line. Ditto for a line ending with '\' which
is the last (non-comment) line in the file.

An earlier iteration emitted warnings for such cases, but it wasn't
clear if warning about undefined behavior was useful; and it made the
implementation much more noisy, so this version silently tolerates such
anomalies.

 Documentation/git-send-email.txt |  2 --
 git-send-email.perl              | 10 +++++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index e6d466e..7ae467b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -394,8 +394,6 @@ described below:
 sendmail;;
 *	Quoted aliases and quoted addresses are not supported: lines that
 	contain a `"` symbol are ignored.
-*	Line continuations are not supported: lines that start with
-	whitespace characters, or end with a `\` symbol are ignored.
 *	Redirection to a file (`/path/name`) or pipe (`|command`) is not
 	supported.
 *	File inclusion (`:include: /path/name`) is not supported.
diff --git a/git-send-email.perl b/git-send-email.perl
index e777bd3..eb1d678 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -492,8 +492,6 @@ sub parse_sendmail_alias {
 	local $_ = shift;
 	if (/"/) {
 		print STDERR "warning: sendmail alias with quotes is not supported: $_\n";
-	} elsif (/^\s|\\$/) {
-		print STDERR "warning: sendmail continuation line is not supported: $_\n";
 	} elsif (/^(\S+?)\s*:\s*(.+)$/) {
 		my ($alias, $addr) = ($1, $2);
 		$aliases{$alias} = [ split_addrs($addr) ];
@@ -504,10 +502,16 @@ sub parse_sendmail_alias {
 
 sub parse_sendmail_aliases {
 	my $fh = shift;
+	my $s = '';
 	while (<$fh>) {
+		chomp;
 		next if /^\s*$/ || /^\s*#/;
-		parse_sendmail_alias($_);
+		$s .= $_, next if $s =~ s/\\$// || s/^\s+//;
+		parse_sendmail_alias($s) if $s;
+		$s = $_;
 	}
+	$s =~ s/\\$//; # silently tolerate stray '\' on last line
+	parse_sendmail_alias($s) if $s;
 }
 
 my %parse_alias = (
-- 
2.4.2.538.g5f4350e
