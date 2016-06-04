From: Stefan Dotterweich <stefandotterweich@gmx.de>
Subject: [PATCH v3] gitk: Fix missing commits when using -S or -G
Date: Sat, 4 Jun 2016 10:47:16 +0200
Message-ID: <1f857709-3c47-d4a1-b858-3288347416f8@gmx.de>
References: <572C8665.8090707@gmx.de> <572C8B36.2000106@gmx.de>
 <20160509034519.GC12515@fergus.ozlabs.ibm.com>
 <fea42c3e-a028-3204-690f-88843d31c264@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@ozlabs.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 10:47:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b97Eh-0000ly-86
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 10:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbcFDIrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2016 04:47:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:49668 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbcFDIrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 04:47:07 -0400
Received: from [192.168.1.68] ([2.242.238.254]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MI5rO-1bBs7c2L3G-003uCJ; Sat, 04 Jun 2016 10:47:02
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <fea42c3e-a028-3204-690f-88843d31c264@gmx.de>
X-Provags-ID: V03:K0:TTkTB4rQeYD5fwedg9MGIAedsshVW9IWazvmJZyiuZ3rVtArA8w
 RqUdJdmYtmoqXFDMQDOQCWMnjYqDIe3R/nyO1dq/oUhK6gUMlvNCMskFPQ7GGjlxTOZ0Wio
 CiuTxAZ1fdAPbW5h0V4u2tx0iAZGVQUdlWPLwHJCzMLKdJLwJVQPCc1hpBqGSgVBqQ+sRiV
 svI5qN2L7/Eq+EyjIGSUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E0LPbd5S4e0=:8nTO/zWHgztG4dnZS1br/4
 XXCKbDbPOG5gau7VjC+/Xd2I4ltyfU1hxcnNHxwKHfqwgud+xaqxpzFRG5LVFFL7gtgx6OBkP
 MLCYprk1FgL1k5cTCZYKqvp4m77VScwMeR8/YnkwdZ3Hf7Sg/kpWIJd8bb7iC+XkTGbKakCWH
 Ez9kdPmeEDIivyWiUUZvw1bMIck21XGZSFpP+i4X/NmpvNLUTGKDhqCj0ZjkWk7HM7KfcpU01
 ydI1HgbU4JOnth9RIBFg3o6+adLkDRvQQGlUimJOZrqYbhMeygEzQ8xbo+RJI6WHDw35OJvYn
 /9MR3Pea23CetiuigIRlV5hebmz2poDshG2h6UBGPQXaj3rKH42hT6W9DCZ4/uQqNET8JfhTL
 9hrLgbuK1LtZnKvRX7y8IT9l4zOZt/46FoyDFfp79IKEQuzy4zRVH3LkGIBnm9O81spE8PCD3
 6wnNVe4igRhOFsQK/Os40k6ZtNljFCrW8ZOmtstUDmsHMMQglQK/fSzen+UA0/tC8rRgHq7R6
 K3ZQ4T0/ixv2CunnLpjYvzt7YEzm8Q6HHISCMv11vsScaeDNqejEGXX+9+Ah0Yvj5Awo2AnkA
 Y1EMSvESCh8pZv4ANdOx01u7oqT554nUJgWtZZHsFwDv1qrkdEqDTzLligxSLIdy2FhZpsJ40
 9IDn+EWqjHPqEUl5WE5hqaqAhUbTkLciw0AIEsr4joF+W8Kg2sdVPIGVagFMpJY4bR9TWr2Xz
 03Z0O1iGT6maQwv8zZRz5yjlYDOcZtYryREscygh4D0yYe0CmgfXB0NKTELeAHskkz0Uc+Gt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296443>

When -S or -G is used as a filter option, the resulting commit list
rarely contains all matching commits. Only a certain number of commits
are displayed and the rest are missing.

"git log --boundary -S" does not return as many boundary commits as you
might expect. gitk makes up for this in closevargs() by adding missing
parent (boundary) commits. However, it does not change $numcommits,
which limits how many commits are shown. In the end, some commits at the
end of the commit list are simply not shown.

Change $numcommits whenever a missing parent is added.

Signed-off-by: Stefan Dotterweich <stefandotterweich@gmx.de>
---

Here is an updated version of the patch. Feel free to change it if
anything is missing.

 gitk-git/gitk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 805a1c7..572da4a 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1315,7 +1315,7 @@ proc commitonrow {row} {
 
 proc closevarcs {v} {
     global varctok varccommits varcid parents children
-    global cmitlisted commitidx vtokmod
+    global cmitlisted commitidx vtokmod curview numcommits
 
     set missing_parents 0
     set scripts {}
@@ -1340,6 +1340,9 @@ proc closevarcs {v} {
 	    }
 	    lappend varccommits($v,$b) $p
 	    incr commitidx($v)
+	    if {$v == $curview} {
+		set numcommits $commitidx($v)
+	    }
 	    set scripts [check_interest $p $scripts]
 	}
     }
-- 
2.8.0
