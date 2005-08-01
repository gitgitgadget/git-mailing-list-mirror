From: barkalow@iabervon.org
Subject: [RFC PATCH 0/2] Parallel pull core
Date: Sun, 31 Jul 2005 21:11:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0507312055030.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 03:09:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzOnq-0003N3-C2
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 03:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVHABIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 21:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVHABIs
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 21:08:48 -0400
Received: from iabervon.org ([66.92.72.58]:62482 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261971AbVHABI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 21:08:29 -0400
Received: (qmail 24990 invoked by uid 1000); 31 Jul 2005 21:11:25 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jul 2005 21:11:25 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series makes the core of the pull programs parallel. It should not 
actually make any difference yet. It arranges to call prefetch() for each 
object as soon as it is determined to be needed, and then call fetch() on 
each object once there is nothing left to prefetch. By implementing 
prefetch(), an implementation can make additional requests while waiting 
for the data from the earlier ones to come in. Additionally, fetch() will 
be called in the same order that prefetch() was called, so the 
implementation can just make a series of requests and get responses.

If anyone else is also interested in working on this, it could go into 
-pu; I've tested it reasonably well, and I'm pretty sure that it doesn't 
have any effect until the implementations are changed to have prefetch() 
do something. I'm working on support for it in ssh-pull, and haven't 
started looking at http-pull support.

 1: Adds support to the struct object code to produce struct objects when 
    the type is unknown and the content is unavailable; this allocates 
    memory for the union of the supported types, so it is slightly less 
    efficient, but allows the pull code to track objects it doesn't know 
    anything about (such as the targets to tags).
 2: Parallelizes the pull algorithm.

	-Daniel
