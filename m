From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 18/19] gitweb: Remove git_diff_print subroutine
Date: Fri, 25 Aug 2006 21:15:27 +0200
Message-ID: <200608252115.27881.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 21:35:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGhSw-0005vB-NP
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422811AbWHYTfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbWHYTfj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:35:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:35986 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422811AbWHYTfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 15:35:36 -0400
Received: by nf-out-0910.google.com with SMTP id o25so877284nfa
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:35:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ckpINi+BdjyiN+Cdib/ieSgYTCbnrcBGITQpfnK3rIX4Nlc3vbV726J289oMtQGRMkRqmxG466bv7AastV4/gBtlhJoX4rCPOPUxJ3TfJqqqJnlcJrCw0zLM7znZcr1D4sLn+xyOBS51BVRpv0Q2vI6so7jt5dves9VZr+etGn4=
Received: by 10.49.21.8 with SMTP id y8mr5821376nfi;
        Fri, 25 Aug 2006 12:35:35 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id d2sm2934344nfe.2006.08.25.12.35.35;
        Fri, 25 Aug 2006 12:35:35 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26010>

Remove git_diff_print subroutine, used to print diff in previous
versions of "diff" actions, namely git_commitdiff,
git_commitdiff_plain, git_blobdiff, git_blobdiff_plain.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   71 ----------------------------------------------------
 1 files changed, 0 insertions(+), 71 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b20640e..2f932f0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1975,77 +1975,6 @@ sub git_heads_body {
 	print "</table>\n";
 }
 
-## ----------------------------------------------------------------------
-## functions printing large fragments, format as one of arguments
-
-sub git_diff_print {
-	my $from = shift;
-	my $from_name = shift;
-	my $to = shift;
-	my $to_name = shift;
-	my $format = shift || "html";
-
-	my $from_tmp = "/dev/null";
-	my $to_tmp = "/dev/null";
-	my $pid = $$;
-
-	# create tmp from-file
-	if (defined $from) {
-		$from_tmp = "$git_temp/gitweb_" . $$ . "_from";
-		open my $fd2, "> $from_tmp";
-		open my $fd, "-|", $GIT, "cat-file", "blob", $from;
-		my @file = <$fd>;
-		print $fd2 @file;
-		close $fd2;
-		close $fd;
-	}
-
-	# create tmp to-file
-	if (defined $to) {
-		$to_tmp = "$git_temp/gitweb_" . $$ . "_to";
-		open my $fd2, "> $to_tmp";
-		open my $fd, "-|", $GIT, "cat-file", "blob", $to;
-		my @file = <$fd>;
-		print $fd2 @file;
-		close $fd2;
-		close $fd;
-	}
-
-	open my $fd, "-|", "/usr/bin/diff -u -p -L \'$from_name\' -L \'$to_name\' $from_tmp $to_tmp";
-	if ($format eq "plain") {
-		undef $/;
-		print <$fd>;
-		$/ = "\n";
-	} else {
-		while (my $line = <$fd>) {
-			chomp $line;
-			my $char = substr($line, 0, 1);
-			my $diff_class = "";
-			if ($char eq '+') {
-				$diff_class = " add";
-			} elsif ($char eq "-") {
-				$diff_class = " rem";
-			} elsif ($char eq "@") {
-				$diff_class = " chunk_header";
-			} elsif ($char eq "\\") {
-				# skip errors
-				next;
-			}
-			$line = untabify($line);
-			print "<div class=\"diff$diff_class\">" . esc_html($line) . "</div>\n";
-		}
-	}
-	close $fd;
-
-	if (defined $from) {
-		unlink($from_tmp);
-	}
-	if (defined $to) {
-		unlink($to_tmp);
-	}
-}
-
-
 ## ======================================================================
 ## ======================================================================
 ## actions
-- 
1.4.1.1
