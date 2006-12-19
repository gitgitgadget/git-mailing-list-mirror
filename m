X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: [PATCH] gitk: pass --no-left-right to rev-list
Date: Tue, 19 Dec 2006 05:05:35 -0500
Message-ID: <20061219100534.GA9206@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 10:06:01 +0000 (UTC)
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34808>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gwbqz-0003c4-JV for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932721AbWLSKFi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWLSKFi
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:05:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:56094
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S932721AbWLSKFh (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 05:05:37 -0500
Received: (qmail 14340 invoked from network); 19 Dec 2006 05:05:36 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 19 Dec 2006 05:05:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Dec
 2006 05:05:35 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Now that rev-list does left-right marking by default on symmetric
differences, command lines like this:
  gitk master...origin
produce an error.

Signed-off-by: Jeff King <peff@peff.net>
---
I think there are three fixes:
  1. this patch (avoid using left-right)
  2. gitk can detect and parse the new format
  3. revert automatic use of left-right
The third makes the most sense to me.

People do use symmetric difference with various porcelains. For example,
I typically carry a few local patches in 'master'. My daily
sit-down-with-git workflow is:
  git-fetch
  gitk master...origin
  git-rebase origin
where the second step gives me a nice graph of what's new and which
patches I'm still carrying.

That means that porcelains which use git-rev-list are _all_ going to
break.

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 3dabc69..ec61a37 100755
--- a/gitk
+++ b/gitk
@@ -33,7 +33,7 @@ proc start_rev_list {view} {
 	set order "--date-order"
     }
     if {[catch {
-	set fd [open [concat | git rev-list --header $order \
+	set fd [open [concat | git rev-list --no-left-right --header $order \
 			  --parents --boundary --default HEAD $args] r]
     } err]} {
 	puts stderr "Error executing git rev-list: $err"
-- 
