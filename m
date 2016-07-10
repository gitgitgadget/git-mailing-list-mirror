Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A382018E
	for <e@80x24.org>; Sun, 10 Jul 2016 23:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287AbcGJX2N (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 19:28:13 -0400
Received: from imap.thunk.org ([74.207.234.97]:57096 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757269AbcGJX2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 19:28:12 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=+cnHHugQLgMvFSozjbRkQ+REbjtdz6h7ij15ShZhDtY=;
	b=jS0kSDOL2WgzL/GCmXeKrIwkJDfBWszcpvEWW3GvBFZT1BofEjrPfhE16RBZeTCIAD5aG6fB1FcPvhRxeF8rGy8B6KLwgri3do6o3r523GVEAuYR+X+bVzswx+lXl3AnQl/VYZ8GmkdnFu6APyh0cZm17BPM7vKuOImiw6zanqY=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bMO8w-0003fi-Di; Sun, 10 Jul 2016 23:28:10 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 957BF82CBAF; Sun, 10 Jul 2016 19:28:09 -0400 (EDT)
Date:	Sun, 10 Jul 2016 19:28:09 -0400
From:	Theodore Ts'o <tytso@mit.edu>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] pretty: add format specifiers: %gr, %gt, %gI, gi
Message-ID: <20160710232809.GM26097@thunk.org>
References: <20160710055402.32684-1-tytso@mit.edu>
 <20160710061644.GA19640@sigill.intra.peff.net>
 <20160710142622.GE26097@thunk.org>
 <CACsJy8CSqjTztFu1fOXqyS1jXjt=D_pgAC4MXpnECAcu+dRu2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CSqjTztFu1fOXqyS1jXjt=D_pgAC4MXpnECAcu+dRu2w@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 06:05:31PM +0200, Duy Nguyen wrote:
> On Sun, Jul 10, 2016 at 4:26 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> > One other long-term thought.  Maybe past a certain point, we should
> > just make it easy to get the data from git-log into a perl or pythons
> > script, where it becomes possible to do conditionals, more flexible
> > padding rules, etc.  So some kind of --format=yaml or --format=json
> > sort of thing.
> 
> I thought libgit2 would already give you all the information you need.

libgit2 isn't really all that useful if you are writing a shell
script.  Even from perl or python, setting up SWIG bindings and then
linking libgit2 into perl or python isn't exactly the most convenient
thing in the world.

Also, my original use case was something I could drop into
~/.gitconfig as an git alias, although I don't object to having a
separate shell script if that was the only way to do what I wanted.

> Putting everything in columns is my thing :) We can do something like
> that. It should not be so hard to put titles on top and draw some
> lines, I think, if you set fixed column widths. I'm just not sure if
> it will be really helpful. What sort of use case do you have in mind
> (besides git-log --oneline with customizable columns)?

I didn't; it was the example of something which was over the top.  :-)

That being said, it is nice if you can have columns where the
pretty-printer auto-sizes the column widths.  Most databases which
have a REP loop for SQL statements will do this, as does gcloud's
--format='table[box]...' scheme.  That unfortunately means a two-pass
scheme, although I could imagine something which looks at the first N
commits to be printed, figured out column widths, and then either
truncates or autowraps if there are commits after the first N which
have require a field wider than what was autosized.

It may be too much to think that all of this should be in git's core
implementation, though.  This is where it might be simpler to easily
get the information into perl or python, and then do the final
formatting in perl/pyhton.  Hence my suggestion for some kind of yaml
or json format.  Although I suppose a CPAN or Python Module that
dlopen's libgit2 could also work, so long as it was super-easy for
someone who just wants to create a git-log like report can just do so
without having to create their own C program or C language bindings to
libgit2....

					- Ted
