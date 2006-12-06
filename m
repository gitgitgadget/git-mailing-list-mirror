X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svn: error out when the SVN connection fails during a fetch
Date: Wed, 06 Dec 2006 11:01:03 -0800
Message-ID: <7v64co4zo0.fsf@assigned-by-dhcp.cox.net>
References: <20061128220605.GA1253@localdomain>
	<871wnget3b.fsf@mid.deneb.enyo.de> <20061204085253.GA31047@soma>
	<87zma4yr71.fsf@mid.deneb.enyo.de>
	<20061204090549.GB30316@hand.yhbt.net>
	<87psax3qmb.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 19:01:44 +0000 (UTC)
Cc: git@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87psax3qmb.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
	"Wed, 06 Dec 2006 18:01:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33506>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs21P-0005bu-EU for gcvg-git@gmane.org; Wed, 06 Dec
 2006 20:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937153AbWLFTBG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 14:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937167AbWLFTBG
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 14:01:06 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57181 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937154AbWLFTBE (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 14:01:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206190103.OWNX20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 14:01:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vX1D1V00u1kojtg0000000; Wed, 06 Dec 2006
 14:01:14 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> writes:

> * Eric Wong:
>
>> Florian Weimer <fw@deneb.enyo.de> wrote:
>>> * Eric Wong:
>>> 
>>> > Does the following patch help?
>>> 
>>> Don't think so.  The issue is not timing-related.  I've seen a failure
>>> every 1000 requests, which suggests to me that it's hitting the
>>> MaxKeepAliveRequests limit configured on the server.
>>
>> Actually, that's exactly what this patch should fix.  git-svn restarts a
>> child every 1000 revisions to avoid memory usage from going through the
>> roof.
>
> Oh.  My (limited) testing of the patch confirms that.

Ok, so this means I should apply this one, right?

-- >8 --
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
1.4.4.1.g6129
