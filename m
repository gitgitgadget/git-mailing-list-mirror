From: Stefan Dotterweich <stefandotterweich@gmx.de>
Subject: Re: [PATCH v2] gitk: Fix missing commits when using -S or -G
Date: Fri, 6 May 2016 14:16:54 +0200
Message-ID: <572C8B36.2000106@gmx.de>
References: <572C8665.8090707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:05:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayeVg-0002xl-JL
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 14:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758359AbcEFMF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 08:05:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:52712 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758083AbcEFMF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 08:05:28 -0400
Received: from [192.168.1.68] ([2.242.37.191]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MDFB2-1ar05A0VeG-00GXLi; Fri, 06 May 2016 14:05:24
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <572C8665.8090707@gmx.de>
X-Provags-ID: V03:K0:raSYEkzplDukTTWUFoTBEfHiFkpC4SYkZeBDOJ/a9dT4lgQooT9
 NPmAROolFxgq1j9zgoIgbngIPmkdi3Dju6kPS1q0xg6ZeO9jL4+/vd+IbI7kQaldlFi2Z5h
 jDRkVeP0t79Ddobu1TTywEFpdgVuy0Uc/Pg5eTHBqYqUxKjxVL7GOpPAaUZ/TSGL9Ilndxf
 /DVFe6Jqd540gbEQQNvrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0RtFL7aACwM=:ZsUZbShSgyEIdTE/l16MJl
 EhV4FLjRx2PGQ8r4XxOrPpoEhhLV/dsw5re+2fhDH2JkwKG+1x2AdOc2sddlyf+FN00tGe7JV
 ULFIuSEnDoNmsRy1eNSFdI9XdF1eKnbr1ETRPb88W3Nf+EX8qpfDg52Bz7aFmJjNtj2HE3g7u
 kyP68/yqt8J0BbbbpHuzmKofRwDmtWvTINZaqV/NAiS7XpJPfNvHzkh0KDAw0c5+Tpg9picoN
 UBEQscP5tkQWJQp6U1VuKC+xSW2LuU7cV/nP2LYFD3WyFSxPfYayrPVWfa3GTsyZQdTDkki6V
 GTvcHtcfUtuoCklJIpTktAwz2qDdwTggOi95iy5yXPvOfbnjySVVl5BrWsvvYnEX0SP1Vtyyk
 TuPjqymBFoLAf0XBNBD8P1de0xPik/4cnW6mR1xxu7u8LplsO0xVPlXgDyuKJQ9oje2IxR2VP
 PPZLuJUU3h3w/UwiVRrOQHqWu7yBewWOxHu1a9VEg6C3QukQyySxXVimC6rxSDRD5oCjSvQCf
 UhTNuQvUgy7DNJTiMP1x0GGlZRwM2fkpzItRRmGEynEAWwoex3kksmOPdAw8JQRkiInn2bBqv
 WIjJSmVwieY5L/Fsj7qk8YeyELhk0LkPMpi4IBPFqhRkYNii5P80iJAqygQeMTLhvqN0aa5wI
 dlGs4zSi4a8/REX5Nh5gYHT4gnpyoHDvOjLGKL6Xh6q8OCyeiid8OhAlwkyDWrtewkUlJZ//n
 c3zgdF/MngN2NLw+2+CS1WYoqqbC9HmqOxLmr9crghkFMLcafwm4Xpyvp5IqQkqeyQ9BOF6A 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293764>

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
 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 805a1c7..b0da174 100755
--- a/gitk
+++ b/gitk
@@ -1315,7 +1315,7 @@ proc commitonrow {row} {
 
 proc closevarcs {v} {
     global varctok varccommits varcid parents children
-    global cmitlisted commitidx vtokmod
+    global cmitlisted commitidx vtokmod numcommits
 
     set missing_parents 0
     set scripts {}
@@ -1339,7 +1339,7 @@ proc closevarcs {v} {
 		modify_arc $v $b
 	    }
 	    lappend varccommits($v,$b) $p
-	    incr commitidx($v)
+	    set numcommits [incr commitidx($v)]
 	    set scripts [check_interest $p $scripts]
 	}
     }
-- 
2.7.4
