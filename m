From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Distribution of longest common hash prefixes
Date: Mon, 2 Apr 2007 10:00:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
 <Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
 <86bqi6kae7.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 19:00:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYPtQ-0002L1-MM
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 19:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933822AbXDBRA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 13:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933834AbXDBRA3
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 13:00:29 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36514 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933822AbXDBRA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 13:00:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l32H0N1E006652
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 Apr 2007 10:00:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l32H0MrI004333;
	Mon, 2 Apr 2007 10:00:23 -0700
In-Reply-To: <86bqi6kae7.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=-0.462 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43605>



On Mon, 2 Apr 2007, Randal L. Schwartz wrote:
> 
> I don't have access to the linux-2.6 kernel, but on git.git at
> d8b6a1a10b93666246984a50d64a163e71163aeb I get this:
> 
>     $ git-rev-list --objects HEAD | sort | perl -lne '
>       substr($_, 40) = "";
>       ($p ^ $_) =~ /^(\0*)/;
>       $count[length $1]++;
>       $p = $_;
>       END { print "$_: $count[$_]" for 0..$#count }
>     '
>     0: 16
>     1: 240
>     2: 3839
>     3: 24458
>     4: 8275
>     5: 619
>     6: 45
>     7: 
>     8: 1
> 
> Yeay Perl. :)

No yay yet.. That counts hex digits, not bits.

However, both this and Peter's original thing show an interesting pattern 
in common: for the case where the data is dense (ie a few bits in common), 
you actually don't end up counting "bits in common", but "edges when the 
bits change in the sorted output".

For example, in the above, the 16/240/3839 comes simply from the fact that 
there are sixteen times that the first digit changes (and that makes the 
program think that it has zero bits in common). There are 256 times that 
the two first digit changes, but 16 of those the first one changed too, so 
only in 240 cases did just the second digit change).

And there are 4096 places where the three first digit change, but 256 of 
those were already counted, so you get 3840 for the third case (but the 
git repo didn't have enough objects, so you missed one, and then the next 
ones will hit a peak and then start an exponential decrease.

So with a nice random linear distribution (which we'd expect from a good 
hash), you should see an exponential increase to a maximum (which you'd 
expect to be at "floor(lnx(nr-objects))", and then an exponential decrease 
right back.

With the kernel, with 439342 objects reachable from HEAD, the peak should 
be around 4 (for a base-16 thing) and around 18 for the binary thing. 
Which is exactly what you get..

		Linus

--- for the kernel, using your nybble-counter ---
0: 16
1: 240
2: 3840
3: 61357
4: 293375
5: 74775
6: 5372
7: 350
8: 16
9: 1
