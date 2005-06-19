From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sat, 18 Jun 2005 22:03:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
 <2cfc403205061817181e4d6d5e@mail.gmail.com> <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 19 06:56:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Djrqi-0002nL-31
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 06:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVFSFBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 01:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVFSFBf
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 01:01:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261836AbVFSFBT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 01:01:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5J51FjA001348
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 18 Jun 2005 22:01:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5J51Eto025368;
	Sat, 18 Jun 2005 22:01:15 -0700
To: jon@blackcubes.dyndns.org
In-Reply-To: <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 18 Jun 2005, Linus Torvalds wrote:
> 
> Now, I say "roughly", because there may not _be_ any commit that exactly 
> bisects the case. For a trivial case, let's say that we know that 'A' is 
> bad, and 'B' is good, but the graph in between them looks like this:

Let's make a different case, just to make it even more obvious.

Let's say that the graph is


        A
       / \
      a1  b1
      |   |
      a2  b2
      |   |
      a3  b3
      |   |
      a4  b4
      |   |
      a5  b5
      |   |
      a6  b6
      |   |
      a7  b7
      |   |
      a8  b8
      |   |
      a9  b9
       \ /
        B

and we know that "A" is bad, and "B" is good, but we don't know which of 
a1-a9/b1-b9 are buggy.

Where do we start testing?

We start testing at either 'a1' or 'b1', because those are the two values 
that bisect the list either into the "a1-a9" series, or the "b1-b9" 
series. Any other starting point would be a bug.

Or, let's say that the graph is

        A
       / \
      |   b1
      |   |
      |   b2
      |   |
      |   b3
      |   |
      a1  b4
      |   |
      a2  b5
      |   |
      a3  b6
      |   |
      |   b7
      |   |
      |   b8
      |   |
      |   b9
       \ /
        B


and in this case the right place to pick is 'b4', because that's the one
that reaches 6 commits (b4-b9), while it leaves 6 commits unreachable
(a1-a3, b1-b3): that's a perfect bisection, and now it's totally 
unambiguous (in the previous case a1 and b1 were equally good choices, in 
this case there is only one valid choice).

It gets more interesting when you have intermediate merges:

        A
       / \
      |   b1
      |   |
      |   b2
      |   |
      |   b3
      |   |
      a1  b4
      |   |
      a2  b5
      | / |
      a3  b6
      |   |
      |   b7
      |   |
      |   b8
      |   |
      |   b9
       \ /
        B

The above graph _looks_ very similar, but now the right place to bisect is
'b5', because that reaches six commits (a3 + b5-b9), and again there are
six commits unreachable (a1-a2 + b1-b4). Again, this is unambiguous -
there is one clearly superior choice.

The current --bisect algorithm may not always pick that best choice: I
think I should subtract one from the total number of commits, since right
now it counts the "good" commit too, ie 'A'. But I think it's at most
off-by-one.

The bigger problem is that the algorithm is something like O(N^3) in cost
- albeit with a fairly cheap constant factor. In other words, it might not
be worthwhile bisecting three years worth of development with it, and you
migth be better off starting with a rougher half-way-point algorithm
("let's try some release a year and a half ago first").

The performance problem seems to really be pretty theoretical: I can
bisect the developemnt from 2.6.12-rc2 to current head in 0.59 seconds, so
it's not like it's horribly slow for something like a couple of months
worth of development.

			Linus
