X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 18 Dec 2006 04:33:40 -0500
Message-ID: <20061218093339.GB9727@spearce.org>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <200612172341.27709.andyparkins@gmail.com> <7vac1l1v8e.fsf@assigned-by-dhcp.cox.net> <200612180917.46214.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 09:33:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612180917.46214.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34732>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwEsZ-0006op-QZ for gcvg-git@gmane.org; Mon, 18 Dec
 2006 10:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753629AbWLRJds (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 04:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbWLRJds
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 04:33:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56878 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753629AbWLRJdr (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 04:33:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwEsS-0004Hd-AB; Mon, 18 Dec 2006 04:33:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 596FD20FB65; Mon, 18 Dec 2006 04:33:41 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> I'm daft.  I've realised, pruning doesn't remove the ref, it removes one of 
> the hashes in the reflog.  I withdraw my comment.
> 
> I'd imagined it' as the opposite of a creation.
> 
> 000000 abcdef  branch created
> abcdef 000000  branch deleted

Except that branch deletion also deletes the reflog.  So yes, we
could log it as you show above, but right after we appended it to
the log we'd delete the log anyway.  :-)

The immediate log deletion is necessary to support something like:

	git branch foo
	git branch -d foo
	git branch foo/bar

as foo switches from being a file to a directory, which means that
.git/logs/refs/heads/foo also needs to switch from being a file to
being a directory.


The only way to fix the above situation is to make the reflog a
single log for the entire repository, rather than one log per ref.
This may cause locking problems for us as we need to lock not only
the ref but also the repository-wide reflog lock.  Note that right
now the reflog is also protected by the ref lock itself, killing
two birds with one stone.  :-)

-- 
