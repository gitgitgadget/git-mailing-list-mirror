From: Matt McCutchen <hashproduct@gmail.com>
Subject: [PATCH] gitweb: make search form generate pathinfo-style URLs
Date: Thu, 28 Jun 2007 14:57:07 -0400
Message-ID: <1183057027.6108.4.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 28 20:57:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3zB3-0008SJ-Qa
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 20:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761249AbXF1S5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 14:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757104AbXF1S5M
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 14:57:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:40411 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077AbXF1S5K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 14:57:10 -0400
Received: by wx-out-0506.google.com with SMTP id h31so612613wxd
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 11:57:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=m6MRe5VFAWPJdhM/odZFRYtRQ0+FrO5izSj9CqEnXGi0ybtlLYdM2vPDAIKpS/6gOFn9rcORn187ZoileVKYYJTHcjW3GPzLWjCrVj9Ch2cV855PD1nvqcjVCCfLjWaeCUWGLdEocqqZLu2YyZO+US5ykFHs3+u6SF57ifoFVYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=DNRNwMCSpM4hZJk53XPiRVfnemEcvXSwDSarHS2ryw74C9BSn/Sa29yVlj3A76jwFcgLCpC/Zn5FEOvaWM0J73bLwpvG8EnLMC8+ETtUA9z8l6UwmxobDxXQqucLsQz9uc1ExIsPKU5D1clm5ndpnT5g8PxObx5wA24XjjA09I0=
Received: by 10.90.116.6 with SMTP id o6mr2252048agc.1183057030238;
        Thu, 28 Jun 2007 11:57:10 -0700 (PDT)
Received: from ?192.168.1.10? ( [71.163.72.121])
        by mx.google.com with ESMTP id 7sm13172320agc.2007.06.28.11.57.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jun 2007 11:57:09 -0700 (PDT)
X-Mailer: Evolution 2.10.2 (2.10.2-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51124>

The search form generated traditional-style URLs with a "p=" parameter
even when the pathinfo feature was on.  This patch makes it generate
pathinfo-style URLs when appropriate.

Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
---
 gitweb/gitweb.perl |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f36428e..7b0e110 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2215,12 +2215,18 @@ EOF
 		} else {
 			$search_hash = "HEAD";
 		}
+		my $action = $my_uri;
+		my ($use_pathinfo) = gitweb_check_feature('pathinfo');
+		if ($use_pathinfo) {
+			$action .= "/$project";
+		} else {
+			$cgi->param("p", $project);
+		}
 		$cgi->param("a", "search");
 		$cgi->param("h", $search_hash);
-		$cgi->param("p", $project);
-		print $cgi->startform(-method => "get", -action => $my_uri) .
+		print $cgi->startform(-method => "get", -action => $action) .
 		      "<div class=\"search\">\n" .
-		      $cgi->hidden(-name => "p") . "\n" .
+		      (!$use_pathinfo && $cgi->hidden(-name => "p") . "\n") .
 		      $cgi->hidden(-name => "a") . "\n" .
 		      $cgi->hidden(-name => "h") . "\n" .
 		      $cgi->popup_menu(-name => 'st', -default => 'commit',
-- 
1.5.2.2.552.gc32f
