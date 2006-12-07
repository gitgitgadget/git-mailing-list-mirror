X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH take 2] change the unpack limit treshold to a saner value
Date: Wed, 06 Dec 2006 23:01:00 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612062244090.2630@xanadu.home>
References: <Pine.LNX.4.64.0612061420410.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 7 Dec 2006 04:01:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0612061420410.2630@xanadu.home>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33548>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsARX-0004qd-4Z for gcvg-git@gmane.org; Thu, 07 Dec
 2006 05:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968697AbWLGEBE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 23:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968701AbWLGEBE
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 23:01:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11555 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968697AbWLGEBB (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 23:01:01 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9V00A1KXTOOG90@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Wed,
 06 Dec 2006 23:01:01 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Currently the treshold is 5000.  The likelihood of this value to ever be 
crossed for a single push is really small making it not really useful.

The optimal treshold for a pure space saving on a filesystem with 4kb 
blocks is 3.  However this is likely to create many small packs 
concentrating a large number of files in a single directory compared to 
the same objects which are spread over 256 directories when loose.  This 
means we would need 512 objects per pack on average to approximagte the 
same directory cost (a pack has 2 files because of the index).

But 512 is a really high value just like 5000 since most pushes are 
unlikely to have that many objects.  So let's try with a value of 100 
which should have a good balance between small pushes going to be 
exploded into loose objects and large pushes kept as whole packs.

This is not a replacement for periodic repacks of course.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/receive-pack.c b/receive-pack.c
index d62ed5b..9140312 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -11,7 +11,7 @@
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
 static int deny_non_fast_forwards = 0;
-static int unpack_limit = 5000;
+static int unpack_limit = 100;
 static int report_status;
 
