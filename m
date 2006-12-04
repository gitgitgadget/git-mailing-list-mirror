X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Re: Moving a directory into another fails
Date: Mon, 4 Dec 2006 15:54:07 -0500
Message-ID: <20061204205407.GB6764@spearce.org>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com> <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de> <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com> <20060728014350.GI13776@pasky.or.cz> <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com> <el1qtr$bca$1@sea.gmane.org> <Pine.LNX.4.63.0612042001320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <el1rmm$bca$2@sea.gmane.org> <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 20:54:32 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33247>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrKpL-0003t8-TU for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937362AbWLDUyN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 15:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937187AbWLDUyN
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:54:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47622 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937362AbWLDUyM (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 15:54:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GrKpy-0001rg-2l; Mon, 04 Dec 2006 15:54:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4DA8520FB7F; Mon,  4 Dec 2006 15:54:07 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> You guys are ignoring the _real_ problem. 
> 
> It has nothing at all to do with dependencies on external packages. The 
> REAL problem is that if you do locale-dependent trees and other git 
> objects, git will STOP WORKING.

Yes!

In jgit I assumed all tree entry names were encoded in UTF8.
Then I later learned they aren't.  Foolish me.

As Linus points out its a HUGE problem that the caller of
git-write-tree gets to decide what encoding should be used for
that tree.  Especially if someone else wants to use a different
encoding for the same filename (think ISO-8859-1 vs. UTF-8)!

I'd rather just force the tree entry names to be encoded in UTF-8
always, as its compact for most western texts (which many filenames
are), and at least degrades to supporting the non western texts.

A per-project setting is essentially impossible as we have
no such concept today, and a per-repository setting (like
i18n.commitEncoding) lets two different users encode the same
filename differently, which means two different tree SHA1s with
the exact same content... not correct!
 
> This is true for all levels of the git archive. It's true for blob 
> content, it's true for filenames in trees, and it is true for commits. The 
> commit message is actually somewhat easier (because we have nothing to 
> "compare" it to afterwards in the checked-out tree), so the commit message 
> is the _one_ thing we can kind of play games with, but even there, once 
> it's done, it's done, and it's just a stream of bytes.

Commit encoding is a problem.  Clearly the "header parts"
(tree, parent) are US-ASCII but the author and committer lines
can be anything.  So can the body.  And we have no way of knowing
what encoding was used years later, we can only guess and display
it wrong.

We really should either normalize all commit messages to a single
encoding (again, UTF-8) or embed the encoding as part of the headers
somehow (e.g. look at how XML embeds the document encoding in the
start of the document).

-- 
