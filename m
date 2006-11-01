X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 9/n] gitweb: Better support for non-CSS aware web browsers
Date: Wed, 1 Nov 2006 14:33:21 +0100
Message-ID: <200611011433.22279.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 13:33:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lXq+ouTqKkCFrkXtf7dk++cnHJLjl24QcWHLX4Oj7AL06PLAqU8tKrmbZupOUjWVFG1jlRhifmgBAYU+XiO52bt7I6Spnl3/dkA+15ojWt7Ij23xUVjOzZmCgmFc4XCAbfOBgNLscEUk+syGwVcxOSldbLASJQJc35kcjUuI+u4=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301953.01875.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30635>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfGDf-00058b-TT for gcvg-git@gmane.org; Wed, 01 Nov
 2006 14:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752180AbWKANdP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 08:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbWKANdO
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 08:33:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:2170 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752180AbWKANdN
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 08:33:13 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1706537ugm for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 05:33:12 -0800 (PST)
Received: by 10.66.224.19 with SMTP id w19mr8115425ugg; Wed, 01 Nov 2006
 05:33:11 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id e23sm635828ugd.2006.11.01.05.33.10; Wed, 01 Nov
 2006 05:33:11 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Add option to replace SPC (' ') with hard (non-breakable) space HTML
entity '&nbsp;' in esc_html subroutine.

Replace ' ' with '&nbsp;' for the code/diff display part in git_blob
and git_patchset_body; this is to be able to view code and diffs in
web browsers which doesn't understand "white-space: pre;" CSS
declaration.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
For people who want to use non-CSS aware browsers, like w3m, elinks, links
text browsers, for looking at "blob" and "commitdiff"/"blobdiff" views
of gitweb.

HTH.

 gitweb/gitweb.perl |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5c82093..b8fcafc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -554,12 +554,17 @@ sub esc_url {
 }
 
 # replace invalid utf8 character with SUBSTITUTION sequence
-sub esc_html {
+sub esc_html ($;%) {
 	my $str = shift;
+	my %opts = @_;
+
 	$str = to_utf8($str);
 	$str = escapeHTML($str);
 	$str =~ s/\014/^L/g; # escape FORM FEED (FF) character (e.g. in COPYING file)
 	$str =~ s/\033/^[/g; # "escape" ESCAPE (\e) character (e.g. commit 20a3847d8a5032ce41f90dcc68abfb36e6fee9b1)
+	if ($opts{'-nbsp'}) {
+		$str =~ s/ /&nbsp;/g;
+	}
 	return $str;
 }
 
@@ -840,7 +845,7 @@ sub format_diff_line {
 		$diff_class = " incomplete";
 	}
 	$line = untabify($line);
-	return "<div class=\"diff$diff_class\">" . esc_html($line) . "</div>\n";
+	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
 }
 
 ## ----------------------------------------------------------------------
@@ -2985,7 +2990,7 @@ sub git_blob {
 		$nr++;
 		$line = untabify($line);
 		printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
-		       $nr, $nr, $nr, esc_html($line);
+		       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
 	}
 	close $fd
 		or print "Reading blob failed.\n";
-- 
1.4.3.3
