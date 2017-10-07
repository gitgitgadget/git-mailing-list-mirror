Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDDD2036B
	for <e@80x24.org>; Sat,  7 Oct 2017 21:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbdJGVFH (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 17:05:07 -0400
Received: from imap.thunk.org ([74.207.234.97]:47790 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753231AbdJGVFG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 17:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cA9CNeOkTsUXNjOPvDA3gNtMFwEWXxWBeHh7CRJRqm4=; b=rTShi+8erAb/sa1eDLkjCB9XLw
        RJpakzU4uDtltlb3j/7BRYjuSxc3JSQSDcCKbv8NlgQZP4ygquiIJjeAk3R3McQ/3seYEpvDSjzfx
        fiZhBSA7op2LJ2gije7YzPYX15Qryj2FgwvP+yOrhesg1MAO8kypbcMEKfHetjjRcPtY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1e0wHN-0005Nn-5r; Sat, 07 Oct 2017 21:05:01 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 38B88C03095; Sat,  7 Oct 2017 17:05:00 -0400 (EDT)
Date:   Sat, 7 Oct 2017 17:05:00 -0400
From:   Theodore Ts'o <tytso@mit.edu>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
Message-ID: <20171007210500.s3s5q53qihtf2s32@thunk.org>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
 <20171007190402.GH3382@zaya.teonanacatl.net>
 <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
 <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
 <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 07, 2017 at 03:43:43PM -0400, Robert P. J. Day wrote:
> >   -r
> > 	Recursively remove the contents of any directories that match
> > 	`<file>`.
> >
> > or something.
> 
>   it's been a long week, so take this in the spirit in which it is
> intended ... i think the "git rm" command and its man page should be
> printed out, run through a paper shredder, then set on fire. i can't
> remember the last time i saw such a thoroughly badly-designed,
> badly-documented and non-intuitive utility.
> 
>   i'm going to go watch football now and try to forget this horror.

It sounds like the real issue here is that you are interpreting
"recursively" to mean "globbing".  Your original complaint seemed to
be a surprise that "git rm book/\*.asc" would delete all of the files
in the directory "book" that ended in .asc, even without the -r flag.

That's because the operation of matching *.asc is considered
"globbing".  Now if there were directories whose name ended in .asc,
then they would only be deleted if the -r flag is given.  Deleting
directories and their contents is what is considered "recursive
removal".

That's not particularly surprising to me as a long-time Unix/Linux
user/developer, since that's how things work in Unix/Linux:

% touch 1.d 2.d ; mkdir 3.d 4.d
% /bin/ls
1.d  2.d  3.d  4.d
% rm -r *.d
% touch 1.d 2.d ; mkdir 3.d 4.d
% rm *.d
rm: cannot remove '3.d': Is a directory
rm: cannot remove '4.d': Is a directory

I'm going to guess that you don't come from a Unix background?

        	     	   	    - Ted
