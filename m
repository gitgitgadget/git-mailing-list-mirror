X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Wed, 08 Nov 2006 15:34:13 -0800
Message-ID: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 23:34:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31166>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghww5-0007Cc-DA for gcvg-git@gmane.org; Thu, 09 Nov
 2006 00:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161749AbWKHXeR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 18:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161747AbWKHXeQ
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 18:34:16 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:32453 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1161748AbWKHXeP
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 18:34:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061108233414.YJBG296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 18:34:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kPaK1V00f1kojtg0000000; Wed, 08 Nov 2006
 18:34:20 -0500
To: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

This reuses the quot_cec to protect blob and text diff output
from leaking control characters.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * requesting extra sets of eyeballs.

 gitweb/gitweb.perl |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f46d678..b5b1011 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -597,11 +597,10 @@ sub esc_html ($;%) {
 
 	$str = to_utf8($str);
 	$str = escapeHTML($str);
-	$str =~ s/\014/^L/g; # escape FORM FEED (FF) character (e.g. in COPYING file)
-	$str =~ s/\033/^[/g; # "escape" ESCAPE (\e) character (e.g. commit 20a3847d8a5032ce41f90dcc68abfb36e6fee9b1)
 	if ($opts{'-nbsp'}) {
 		$str =~ s/ /&nbsp;/g;
 	}
+	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
 	return $str;
 }
 
@@ -1900,17 +1899,17 @@ sub git_print_page_path {
 			$fullname .= ($fullname ? '/' : '') . $dir;
 			print $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
 			                             hash_base=>$hb),
-			              -title => $fullname}, esc_path($dir));
+			              -title => esc_html($fullname)}, esc_path($dir));
 			print " / ";
 		}
 		if (defined $type && $type eq 'blob') {
 			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
 			                             hash_base=>$hb),
-			              -title => $name}, esc_path($basename));
+			              -title => esc_html($name)}, esc_path($basename));
 		} elsif (defined $type && $type eq 'tree') {
 			print $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
 			                             hash_base=>$hb),
-			              -title => $name}, esc_path($basename));
+			              -title => esc_html($name)}, esc_path($basename));
 			print " / ";
 		} else {
 			print esc_path($basename);
-- 
1.4.4.rc1.g659d

