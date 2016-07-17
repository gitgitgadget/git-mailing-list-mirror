Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58111FEAA
	for <e@80x24.org>; Sun, 17 Jul 2016 00:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbcGQAZg (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 20:25:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55568 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbcGQAZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 20:25:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37CEC1FEAA;
	Sun, 17 Jul 2016 00:25:34 +0000 (UTC)
Date:	Sun, 17 Jul 2016 00:25:34 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: [PATCH] list: avoid incompatibility with *BSD sys/queue.h
Message-ID: <20160717002533.GA14200@whir>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
 <FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com>
 <20160716210454.GA7849@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160716210454.GA7849@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Lars Schneider <larsxschneider@gmail.com> wrote:
> > It looks like as if this topic breaks the OS X build because 
> > it defines LIST_HEAD. LIST_HEAD is already defined in 
> > /usr/include/sys/queue.h. 
> 
> Oops, I suppose GIT_LIST_HEAD is an acceptable name?
> (looks a bit like a refname, though...).
> 
> Or maybe CDS_LIST_HEAD (since I originally took it from the cds
> namespace under urcu)

Naming things is hard; I think it's better to just undef an
existing LIST_HEAD, instead, since it's unlikely we'd ever use
sys/queue.h from *BSD.  (sys/queue.h is branchier, and IMHO
sys/queue.h macros are uglier than list_entry (container_of))

> I also wonder where we use sys/queue.h, since I use
> LIST_HEAD from ccan/list/list.h in a different project
> without conflicts...

Still wondering... Checking sys/mman.h in an old FreeBSD source
tree I had lying around reveals "#include <sys/queue.h>" is
guarded by "#if defined(_KERNEL)", so it mman.h wouldn't pull
it in for userspace builds...

-----8<------
Subject: [PATCH] list: avoid incompatibility with *BSD sys/queue.h

Somehow, the OS X build pulls in sys/queue.h and causes
conflicts with the LIST_HEAD macro, here.

ref: http://mid.gmane.org/FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Eric Wong <e@80x24.org>
---
 list.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/list.h b/list.h
index f65edce..a226a87 100644
--- a/list.h
+++ b/list.h
@@ -36,6 +36,8 @@ struct list_head {
 	struct list_head *next, *prev;
 };
 
+/* avoid conflicts with BSD-only sys/queue.h */
+#undef LIST_HEAD
 /* Define a variable with the head and tail of the list. */
 #define LIST_HEAD(name) \
 	struct list_head name = { &(name), &(name) }
-- 
EW
