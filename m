From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/6] gitweb: Simplify git_diff_print
Date: Sun, 6 Aug 2006 02:11:38 +0200
Message-ID: <200608060211.38604.jnareb@gmail.com>
References: <200608060206.49086.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 02:16:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9WJr-0003ZT-AT
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 02:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWHFAQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 20:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWHFAQe
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 20:16:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:12338 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751429AbWHFAQd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 20:16:33 -0400
Received: by nf-out-0910.google.com with SMTP id p46so40346nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 17:16:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Qe5gKOEId+Yxf9MukMczsavv2fZXAHM7Uk19J3r8AT2cqfbW+vugIy2mQCkxPfaF1P2A3r9bU/hIQW96Bgh4a6L/YKtto5Bx8Ij3p8KVKb4eMWoOF628SmABgUMjQImJLrJL+K4iA4XncWTnag+PIwCah/iiTxv0wSqQkkiRCbI=
Received: by 10.49.91.6 with SMTP id t6mr6984227nfl;
        Sat, 05 Aug 2006 17:16:32 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r33sm4188262nfc.2006.08.05.17.16.32;
        Sat, 05 Aug 2006 17:16:32 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608060206.49086.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24946>

Copy to temporaty file more directly, not using temporary variable @file.
Use list form of open for diff invocation (we cannot use git-diff because
first it doesn't support -L/--label option, and we cannot generate diff
between /dev/null and blob given by it's sha1 identifier). 

Use "local $/ = undef;" for (temporary) slurp mode.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 60113da..b72f12f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1230,31 +1230,31 @@ sub git_diff_print {
 
 	# create tmp from-file
 	if (defined $from) {
+		local $/ = undef;
 		$from_tmp = "$git_temp/gitweb_" . $$ . "_from";
 		open my $fd2, "> $from_tmp";
 		open my $fd, "-|", $GIT, "cat-file", "blob", $from;
-		my @file = <$fd>;
-		print $fd2 @file;
+		print { $fd2 } <$fd>;
 		close $fd2;
 		close $fd;
 	}
 
 	# create tmp to-file
 	if (defined $to) {
+		local $/ = undef;
 		$to_tmp = "$git_temp/gitweb_" . $$ . "_to";
 		open my $fd2, "> $to_tmp";
 		open my $fd, "-|", $GIT, "cat-file", "blob", $to;
-		my @file = <$fd>;
-		print $fd2 @file;
+		print { $fd2 } <$fd>;
 		close $fd2;
 		close $fd;
 	}
 
-	open my $fd, "-|", "/usr/bin/diff -u -p -L \'$from_name\' -L \'$to_name\' $from_tmp $to_tmp";
+	open my $fd, "-|", "/usr/bin/diff",
+		'-u', '-p', '-L', $from_name, '-L', $to_name, $from_tmp, $to_tmp;
 	if ($format eq "plain") {
-		undef $/;
+		local $/ = undef;
 		print <$fd>;
-		$/ = "\n";
 	} else {
 		while (my $line = <$fd>) {
 			chomp $line;
-- 
1.4.1.1
