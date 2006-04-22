From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 10:17:01 -0400
Message-ID: <67A687D6-8C1D-4028-9770-DC86867BF6B5@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <Pine.LNX.4.64.0604212308080.2215@localhost.localdomain> <A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com> <7v7j5hkglq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604220835190.2215@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 21:18:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXNcU-0007xf-70
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 21:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWDVTSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 15:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWDVTQx
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 15:16:53 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:29113 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750974AbWDVTQe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 15:16:34 -0400
Received: from nile.gnat.com (nile.gnat.com [205.232.38.5])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MEHXv6023747
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 14:17:44 GMT
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id D569A48CE15;
	Sat, 22 Apr 2006 10:17:02 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 07628-01-7; Sat, 22 Apr 2006 10:17:02 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 8C12548CDC5;
	Sat, 22 Apr 2006 10:17:02 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0604220835190.2215@localhost.localdomain>
To: Nicolas Pitre <nico@cam.org>
X-Mailer: Apple Mail (2.749.3)
X-Virus-Scanned: ClamAV 0.88/1415/Sat Apr 22 11:34:01 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19044>


On Apr 22, 2006, at 08:45, Nicolas Pitre wrote:
> The idea to avoid memory pressure is to reverse the window processing
> such that the object to delta against is constant for the entire  
> window
> instead of the current logic where the target object is constant.   
> This
> way there would be only one index in memory at all time.

Right, this is essential. In my measurements, diff-delta
spends about 70% of time generating the index, and 30%
matching.

Right now, for 10 candidates per file, we'd do 11 units of
work, since we repeat the final delta. When reusing the
index, and keeping the smallest delta around, we'd use
0.7 + 3 = 3.7 units of work. This is almost a 3x speedup.
There's no way we can get decent performance without this.
With the similarity fingerprints, another factor 2x should
be attainable, by only considering the 3 files with the
nearest fingerprints.

   -Geert
