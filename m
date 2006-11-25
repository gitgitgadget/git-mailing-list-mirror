X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Calling all bash completion experts..
Date: Sat, 25 Nov 2006 02:13:51 -0500
Message-ID: <20061125071351.GE4528@spearce.org>
References: <Pine.LNX.4.64.0611230935520.27596@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 07:14:01 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611230935520.27596@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32262>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnrjb-0004m7-RR for gcvg-git@gmane.org; Sat, 25 Nov
 2006 08:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757866AbWKYHN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 02:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757867AbWKYHN5
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 02:13:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:3758 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757866AbWKYHN4
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 02:13:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GnrjV-0003dk-SH; Sat, 25 Nov 2006 02:13:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 F270A20FB09; Sat, 25 Nov 2006 02:13:51 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> So I do "git repa<tab>" and get "git repack", which is fine, but I really 
> _wanted_ to get "git repack " (with the space at the end), since I've now 
> got a unique command, and that's the normal completion behaviour (ie I 
> want it to act the same way that "git-repa<tab>" would have acted).
[snip]
> Now, without knowing the completion syntax, I assume it's the "-o nospace" 
> things in the completion file. So I'm wondering _why_ that "nospace" is 
> there, and whether this could be fixed?

Yes, its the "-o nospace".

I added the nospace option because of the completion for fetch/push,
cat-file, diff-tree and ls-tree.

The problem is the file completion for e.g. cat-file.  We don't
want a space added after we complete a directory name, so you can
complete further, e.g.:

  git cat-file -p ma<tab>con<tab>comp<tab>git-com<tab>

gives us:

  git cat-file -p master:contrib/completion/git-completion.sh

but if I omitted the "-o nospace" then we would instead need:

  git cat-file ma<tab><bs>con<tab><bs>comp<tab><bs>git-com<tab>

as each successive <tab> would add a trailing space that you would need
to remove before you can complete again.

So as a user I decided that adding the space myself was less
annoying then needing to delete the space during completion down
through a tree.  But perhaps that was wrong.

I did try to inject the space myself in the completion code when
I knew something was unique, but bash didn't like that (it tossed
the space).

To be honest, I'm not really sure how to fix it.

One option would be to perform a `ls-tree -r` through whatever part
of the path we have now and offer up EVERYTHING in the tree as a
possible completion, but that is insane as it will take a little
while to generate and on a large tree (e.g. the Linux kernel) you
will get a large number of proposed completions back which aren't
really relevant.

-- 
