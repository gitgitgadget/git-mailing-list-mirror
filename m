X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: error out when the SVN connection fails during a fetch
Date: Mon, 4 Dec 2006 00:52:53 -0800
Message-ID: <20061204085253.GA31047@soma>
References: <20061128220605.GA1253@localdomain> <871wnget3b.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 08:53:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <871wnget3b.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33172>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr9ZL-0006L1-UH for gcvg-git@gmane.org; Mon, 04 Dec
 2006 09:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759714AbWLDIw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 03:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759720AbWLDIw5
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 03:52:57 -0500
Received: from hand.yhbt.net ([66.150.188.102]:161 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1759695AbWLDIwz (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 03:52:55 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 234DB2DC034; Mon,  4 Dec 2006 00:52:54 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon,  4 Dec 2006
 00:52:53 -0800
To: Florian Weimer <fw@deneb.enyo.de>
Sender: git-owner@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> wrote:
> * Eric Wong:
> 
> > finish_report does seem to return a useful value indicating success
> > or failure, so we'll just set a flag when close_edit is called
> > (it is not called on failures, nor is abort_edit) and check
> > the flag before proceeding.
> 
> It seems that this needs some kind of fine-tuning.  Now that git-svn
> uses HTTP keepalive connections, you get a HTTP request error once you
> run into the server-side request limit.  It seems a bit excessive to
> stop completely in this case.

Does the following patch help?

From: Eric Wong <normalperson@yhbt.net>
Date: Mon, 4 Dec 2006 00:51:16 -0800
Subject: [PATCH] git-svn: avoid network timeouts for long-running fetches

Long-running fetches run inside children to avoid memory leaks.
When we refork, the connection in the parent can be idle for a
long time; attempting to reuse it in the next child can result
in timeouts.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d0bd0bd..747daf0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -459,6 +459,7 @@ sub fetch_lib {
 		$min = $max + 1;
 		$max += $inc;
 		$max = $head if ($max > $head);
+		$SVN = libsvn_connect($SVN_URL);
 	}
 	restore_index($index);
 	return { revision => $last_rev, commit => $last_commit };
-- 
