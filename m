From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/6] gitweb: Refactor untabifying - converting tabs to spaces
Date: Sun, 6 Aug 2006 02:08:31 +0200
Message-ID: <200608060208.31862.jnareb@gmail.com>
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
	id 1G9WJq-0003ZT-JH
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 02:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWHFAQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 20:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWHFAQe
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 20:16:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63281 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751417AbWHFAQd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 20:16:33 -0400
Received: by nf-out-0910.google.com with SMTP id p46so40344nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 17:16:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Vy/4fKBzbCAM7dyx45IfZ34gfA23nil/Zd+PEsq8SeEVFGe9FkaBXkyXFEyPofaI5l+nmP4TIUURoylzEyFqQXDmQvA6czdUUnJ3Kem+b8Kc5VxxkE/2Ild+oObrkgV3XIMaexeDW7xCwggeqhUi6StM+k3e78YnQDHbjCp+S3E=
Received: by 10.49.43.11 with SMTP id v11mr631935nfj;
        Sat, 05 Aug 2006 17:16:32 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r33sm4188262nfc.2006.08.05.17.16.31;
        Sat, 05 Aug 2006 17:16:32 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608060206.49086.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24945>

Add untabify subroutine and use it.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bf1b10f..60113da 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -222,6 +222,21 @@ sub unquote {
 	return $str;
 }
 
+# escape tabs (convert tabs to spaces)
+sub untabify {
+	my $line = shift;
+
+	while ((my $pos = index($line, "\t")) != -1) {
+		# one out of three implementations used ($pos - 1) instead of $pos
+		if (my $count = (8 - ($pos % 8))) {
+			my $spaces = ' ' x $count;
+			$line =~ s/\t/$spaces/;
+		}
+	}
+
+	return $line;
+}
+
 ## ----------------------------------------------------------------------
 ## HTML aware string manipulation
 
@@ -1255,12 +1270,7 @@ sub git_diff_print {
 				# skip errors
 				next;
 			}
-			while ((my $pos = index($line, "\t")) != -1) {
-				if (my $count = (8 - (($pos-1) % 8))) {
-					my $spaces = ' ' x $count;
-					$line =~ s/\t/$spaces/;
-				}
-			}
+			$line = untabify($line);
 			print "<div class=\"diff$diff_class\">" . esc_html($line) . "</div>\n";
 		}
 	}
@@ -1600,13 +1610,8 @@ HTML
 		$age_class  = age_class($age);
 		$author     = esc_html ($author);
 		$author     =~ s/ /&nbsp;/g;
-		# escape tabs
-		while ((my $pos = index($data, "\t")) != -1) {
-			if (my $count = (8 - ($pos % 8))) {
-				my $spaces = ' ' x $count;
-				$data =~ s/\t/$spaces/;
-			}
-		}
+
+		$data = untabify($data);
 		$data = esc_html ($data);
 
 		print <<HTML;
@@ -1728,12 +1733,7 @@ sub git_blob {
 	while (my $line = <$fd>) {
 		chomp $line;
 		$nr++;
-		while ((my $pos = index($line, "\t")) != -1) {
-			if (my $count = (8 - ($pos % 8))) {
-				my $spaces = ' ' x $count;
-				$line =~ s/\t/$spaces/;
-			}
-		}
+		$line = untabify($line);
 		printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n", $nr, $nr, $nr, esc_html($line);
 	}
 	close $fd or print "Reading blob failed.\n";
-- 
1.4.1.1
