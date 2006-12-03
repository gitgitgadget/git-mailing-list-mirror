X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Oops, get the commit first, then the tree.
Date: Sat, 2 Dec 2006 21:34:07 -0500
Message-ID: <20061203023407.GC26668@spearce.org>
References: <200612030145.45567.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 02:34:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612030145.45567.robin.rosenberg@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33087>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqhBG-0002hF-TZ for gcvg-git@gmane.org; Sun, 03 Dec
 2006 03:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934519AbWLCCeM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 21:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936613AbWLCCeL
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 21:34:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:64665 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S934519AbWLCCeK
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 21:34:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GqhB0-0000Rm-6s; Sat, 02 Dec 2006 21:33:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A263A20FB7F; Sat,  2 Dec 2006 21:34:07 -0500 (EST)
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This made the eclipse plugin unable to connect to Git.
...
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> @@ -168,7 +168,8 @@ public class Repository {
>      }
>  
>      public Tree mapTree(final String revstr) throws IOException {
> -	final ObjectId id = resolve(revstr);
> +	Commit commit = mapCommit(revstr);
> +	final ObjectId id = commit.getTreeId();
>  	return id != null ? mapTree(id) : null;

I don't want to apply the fix above because mapTree(String) should
be able to take an arbitrary SHA1 expression and return the Tree
object corresponding to that.  Your change only permits commits to
be resolved; but if the revstr resolved to a tag we'd need to peel
back the tag to get to the tree.  Ideally that should be done in
mapTree(ObjectId), based on the type of thing ObjectId points to.

I think the bug was caused by a recent breakage in Repository.mapTree
(42691339).  I fixed it in 020e0ee but neglected to push it out.
Actually I'm surprised mapTree(ObjectId) even works before 020e0ee;
I just don't see how its right...

-- 
