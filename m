X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix dcommit losing changes when out-of-date from svn
Date: Thu, 9 Nov 2006 12:47:59 -0800
Message-ID: <20061109204759.GA8560@localdomain>
References: <455277A6.2000404@midwinter.com> <20061109091937.GA22853@localdomain> <7vfyctkki5.fsf@assigned-by-dhcp.cox.net> <455381C7.8080207@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 20:48:35 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <455381C7.8080207@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31202>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiGol-0003Hd-FE for gcvg-git@gmane.org; Thu, 09 Nov
 2006 21:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161841AbWKIUsH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 15:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161838AbWKIUsH
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 15:48:07 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36034 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S966056AbWKIUsE (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 15:48:04 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id AC0B37DC098; Thu,  9 Nov 2006 12:47:59 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 09 Nov 2006
 12:47:59 -0800
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> wrote:
> Junio C Hamano wrote:
> >Steven, I do not interact with real svn repository myself so I
> >can only judge from the test in this patch and Steven's test
> >case, so it would be more assuring for me if you can confirm it
> >fixes the issue for you.
> >  
> 
> It seems to; I can't make the problem happen any more. I am slightly 
> concerned -- but I don't know libsvn well enough to say for sure -- that 
> this doesn't actually *eliminate* the problem, but rather tightens the 
> window of opportunity down to some very small amount of time. Which is 
> certainly an improvement, of course!
> 
> Maybe only Eric can answer this, but from a cursory inspection, it 
> doesn't look like it actually locks the modified files before generating 
> the patch to apply. Is there still a possibility of losing a change that 
> hits the svn repository in the middle of git-svn dcommit running? Or 
> does locking happen implicitly somewhere I'm not seeing? (Again, I 
> haven't combed the code deeply, so it's entirely possible I've missed 
> something.)

The commit runs as a transaction on the server-side, where all the real
locking occurs.  SVN supports user-side locking (svn lock), but it is
only advisory and can be taken/unlocked by other users
(svn lock/unlock --force).

When SVN::Git::Editor is instantiated in commit_diff() (line 853), the
'r' parameter passed to it is the revision we'll generate our diffs
against.  Before, we were generating diffs against the latest revision.

We generate diffs against 'r' in SVN::Git::Editor::M() (line 3339) and
SVN::Git::Editor::chg_file (line 3383) passing the $fbat baton object
(which represents the file at revision 'r') around.

-- 
