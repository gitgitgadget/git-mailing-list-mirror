X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] change the unpack limit treshold to a saner value
Date: Wed, 06 Dec 2006 16:08:56 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612061420410.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 6 Dec 2006 21:09:05 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33520>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs40j-0007eo-0a for gcvg-git@gmane.org; Wed, 06 Dec
 2006 22:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937641AbWLFVI6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 16:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937644AbWLFVI6
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 16:08:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31993 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937641AbWLFVI6 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 16:08:58 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9V00FI8EQWKA10@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Wed,
 06 Dec 2006 16:08:57 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


Let's assume the average object size is x. Given n objects, the needed 
storage size is n*(x + b), where b is the average wasted block size on 
disk.

If those objects are packed, the needed storage becomes n*x + b so we 
save on the block overhead.  But there is the pack index which is 
1024 + n*24 + b.

Trying to find the value of n where packed objects become an advantage, 
we have:

	n*x + n*b > n*x + n*24 + 2*b + 1024

	n*b - 2*b > n*24 + 1024

	(n - 2)*b > n*24 + 1024

So given this we need at least 3 objects for the whole to use more space 
than a pack, and only if b is greater than 1096.  Since a common block 
size is 4096 then the value of b is likely to converge towards 2048. 3 
objects is also where more directory entries are used over an constant 
of 2 for a pack (assuming that both objects would end up with the same 
first 2 bytes of hash which is overly optimistic).  So 3 should be the 
optimal number of objects for not exploding a pack.  And of course 
larger packs are likely to take even less space due to delta compression 
kicking in.

This is why I think the current default treshold should be 3 instead of 
the insane value of 5000.  But since it feels a bit odd to go from 5000 
to 3 I setled on 10.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Sidenote: I think it is OK for pushes to _not_ use thin packs.  When 
not exploding thin packs, they must be completed by adding objects 
creating duplicates and using more disk space.  The penalty for not 
using thin packs is a slight increase in bandwidth for push operations, 
but since pushes are normally much less frequent than fetches it seems 
OK to penalize the push a bit for a better disk usage on servers.

diff --git a/receive-pack.c b/receive-pack.c
index d62ed5b..9140312 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -11,7 +11,7 @@
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
 static int deny_non_fast_forwards = 0;
-static int unpack_limit = 5000;
+static int unpack_limit = 10;
 static int report_status;
 
