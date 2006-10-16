From: Jim Meyering <jim@meyering.net>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many changes
Date: Mon, 16 Oct 2006 20:24:20 +0200
Message-ID: <873b9op19n.fsf@rho.meyering.net>
References: <87slhopcws.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610160904400.3962@g5.osdl.org>
	<87mz7wp6ek.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
	<87ejt8p5l9.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 20:24:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZX8S-0007US-OW
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 20:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWJPSYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 14:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422779AbWJPSYW
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 14:24:22 -0400
Received: from mx.meyering.net ([82.230.74.64]:38364 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1422769AbWJPSYV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 14:24:21 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 19B492734E; Mon, 16 Oct 2006 20:24:20 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 16 Oct 2006 10:56:14 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28980>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Mon, 16 Oct 2006, Jim Meyering wrote:
>>
>> That helps a little.
>> Now, instead of taking 63s, my test takes ~30s.
>> (32 for XDL_MAX_EQLIMIT = 16, 30 for XDL_MAX_EQLIMIT = 8)
>
> Btw, what architecture is this on?
>
> I'm testing those two files, and I get much more reasonable numbers with
> both ppc32 and x86. Both 32-bit:
>
> 	[torvalds@macmini test-perf]$ time git show | wc -l
> 	25221
>
> 	real    0m1.437s
> 	user    0m1.436s
> 	sys     0m0.012s
>
> ie it generated the diff in less than a second and a half. Not wonderful,
> but certainly not your 63s either.
>
> HOWEVER. On x86-64, it takes forever (still not 63 seconds, but it takes
> 17 seconds on my 2GHz merom machine).
>
> So I think there's something seriously broken with hashing on 64-bit.

amd_64 @ 2.0GHz

> Try this patch. And make sure to do a "make clean" first, since I think
> the dependencies on xdiff may be broken.

Yep.  Dependencies are definitely broken.
Applied your patch.  No improvement after a plain "make",
but doing "make clean && make" solved the problem.

Now, my diff-tree takes 2s (it's comparing other files, too).
Thank you!

IMHO, my "&& vs. ||" patch is still worth applying.
If not, then the existing code doesn't make sense, and
there can be significant simplification in the affected loops.
With my patch, I get an additional 3x speed-up: diff-tree takes 0.7s
