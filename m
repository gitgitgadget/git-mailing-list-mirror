X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Thoughts about memory requirements in traversals [Was: Re: [RFC] Submodules in GIT]
Date: Sun, 3 Dec 2006 04:21:18 +0100
Message-ID: <200612030421.18662.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <200612030307.26429.Josef.Weidendorfer@gmx.de> <20061203024655.GD26668@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 03:21:46 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Martin Waitz <tali@admingilde.org>,
	sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <20061203024655.GD26668@spearce.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33089>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqhv9-0006zX-EJ for gcvg-git@gmane.org; Sun, 03 Dec
 2006 04:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936629AbWLCDVX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 22:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936630AbWLCDVW
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 22:21:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:60622 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S936629AbWLCDVW (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 22:21:22 -0500
Received: (qmail invoked by alias); 03 Dec 2006 03:21:20 -0000
Received: from p5496A934.dip0.t-ipconnect.de (EHLO noname) [84.150.169.52] by
 mail.gmx.net (mp006) with SMTP; 03 Dec 2006 04:21:20 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Sunday 03 December 2006 03:46, Shawn Pearce wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > Thinking even one step further:
> > Would it make sense to define an encoding format for the content of
> > commit and tree objects inside of packs, where the SHA1 is replaced by the
> > offset of the object in this pack?
> > As exactly the SHA1 is the least compressable thing, this could promise
> > quite a benefit.
> [...]
> 
> This means that when we start to write out a commit we need to know
> the offset to the tree that commit references.  But git-pack-objects
> sorts object by type: commit, tree, blob (I forget where tags go,
> but they aren't important in this context).  So generally *all*
> commits appear before the first tree.  So when we write out the first
> commit we need to know exactly how many bytes every commit will need
> (compressed mind you) in this pack so we can determine the position
> of the first tree.  Now do this for every commit and every tree
> that those commits use...  yes, its a lot of work to precompute
> and store all offsets before you even write out the first byte.

Yes, it looks like a hen-and-egg problem, but IMHO you can
handle it nicely with another redirection, i.e. a table you build
up while repacking the file, and storing this table at the end.

You simply sequentially renumber any object SHA, starting from 0
in the order you see them. You can do two renumberings, one for
the objects contained in the original pack (1), and one for the
external ones (2). Put these new numbers (with a bit distinguishing
(1) and (2)) as replacement into commit/tree objects.
At the end, you have the new offsets for objects in (1). Put
redirection tables for (1) [new number -> new offset]
and (2) [other new number->SHA1 of external object] at the end
of the new pack.
This way, you effectivly have removed all incompressable SHAs from
the pack file aside from one entry in the redirection tables for
each external object.

The only problem I see is how to decode the objects, i.e. how to
get the original SHA1 from an offset: we can not recalculate the
SHA1 from the object content as we changed the content itself.
But there should be a way to store the SHA1 in front of the object
somehow, perhaps it is already given by the current format? 

Am I missing something here?

