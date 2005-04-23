From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix git log time display for western timezones
Date: Fri, 22 Apr 2005 23:06:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504222300010.26129@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 05:02:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPAuA-0005kq-47
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 05:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVDWDGh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 23:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVDWDGg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 23:06:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12064 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261465AbVDWDGf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 23:06:35 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFD00AEMPYR1O@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Apr 2005 23:06:27 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It appears that the date command doesn't know how to substract time and 
always adds it.  The time zone fixup has to be done separately otherwise 
time displayed in a negative time zone is wrong.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: gitlog.sh
===================================================================
--- 2a91836b5814ffacb1fde000dfb1e55457761c88/gitlog.sh  (mode:100755 sha1:53b55be31b38b2ab88434cf1ac0a868700e64525)
+++ uncommitted/gitlog.sh  (mode:100775)
@@ -56,8 +56,9 @@
 
 				date=(${rest#*> })
 				sec=${date[0]}; tz=${date[1]}
-				dtz=${tz/+/+ }; dtz=${dtz/-/- }
-				pdate="$(date -Rud "1970-01-01 UTC + $sec sec $dtz" 2>/dev/null)"
+				dtz=${tz/+/}
+				lsec=$(expr $dtz / 100 \* 3600 + $dtz % 100 \* 60 + $sec)
+				pdate="$(date -Rud "1970-01-01 UTC + $lsec sec" 2>/dev/null)"
 				if [ "$pdate" ]; then
 					echo -n $color$key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"
 					echo $coldefault
