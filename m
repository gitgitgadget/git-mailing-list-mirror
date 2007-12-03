From: Benjamin Close <Benjamin.Close@clearchain.com>
Subject: Fix UTF Encoding issue
Date: Mon, 03 Dec 2007 20:32:01 +1030
Message-ID: <4753D419.80503@clearchain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 11:07:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz8DB-0000xy-8s
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 11:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbXLCKHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 05:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbXLCKHQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 05:07:16 -0500
Received: from ipmail04.adl2.internode.on.net ([203.16.214.57]:12643 "EHLO
	ipmail04.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393AbXLCKHP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 05:07:15 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2007 05:07:14 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAAdhU0d5LVoq/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.23,243,1194183000"; 
   d="scan'208";a="9996364"
Received: from ppp121-45-90-42.lns10.adl6.internode.on.net (HELO mail.clearchain.com) ([121.45.90.42])
  by ipmail04.adl2.internode.on.net with ESMTP; 03 Dec 2007 20:32:07 +1030
Received: from [192.168.155.249] (draco.internal.clearchain.com [192.168.155.249])
	(authenticated bits=0)
	by mail.clearchain.com (8.13.8/8.13.8) with ESMTP id lB3A259k061119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 3 Dec 2007 20:32:05 +1030 (CST)
	(envelope-from Benjamin.Close@clearchain.com)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
X-Virus-Scanned: ClamAV version 0.91.2, clamav-milter version 0.91.2 on pegasus.clearchain.com
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.2 (mail.clearchain.com [192.168.154.1]); Mon, 03 Dec 2007 20:32:05 +1030 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66897>

>From 83042abf3967b455953cddeab43e33c1d59c6f03 Mon Sep 17 00:00:00 2001
From: Benjamin Close <Benjamin.Close@clearchain.com>
Date: Sun, 2 Dec 2007 15:09:00 -0800
Subject: [PATCH] Gitweb: Fix encoding to always translate rather than 
sometimes fail

When performing the utf translation don't test if $res is defined.
It appears that it is defined even when the conversion fails. This causes
failures on the writing of the output stream which is expecting UTF.

Instead, immediately return if conversion is successful else force
the translation to the fallback encoding
---
  gitweb/gitweb.perl |    8 ++------
  1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 491a3f4..00bbcdf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -696,12 +696,8 @@ sub validate_refname {
  sub to_utf8 {
  	my $str = shift;
  	my $res;
-	eval { $res = decode_utf8($str, Encode::FB_CROAK); };
-	if (defined $res) {
-		return $res;
-	} else {
-		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
-	}
+	eval { return ($res = decode_utf8($str, Encode::FB_CROAK)); };
+	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
  }

  # quote unsafe chars, but keep the slash, even when it's not
-- 
1.5.3.6
