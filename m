From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 18:23:11 +0200
Message-ID: <aec7e5c305042609231a5d3f0@mail.gmail.com>
References: <20050426004111.GI21897@waste.org>
	 <200504260713.26020.mason@suse.com>
	 <aec7e5c305042608095731d571@mail.gmail.com>
	 <200504261138.46339.mason@suse.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Mike Taht <mike.taht@timesys.com>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 18:26:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQSqx-0002eP-Go
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 18:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVDZQ2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 12:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVDZQYg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 12:24:36 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:23377 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261658AbVDZQXO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 12:23:14 -0400
Received: by wproxy.gmail.com with SMTP id 49so92300wri
        for <git@vger.kernel.org>; Tue, 26 Apr 2005 09:23:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BPWzYhvCeKrLr0IctWIZhkzH4uozT+4Vds3LSOaTW/i74PnwcNMszrHjQm4EFCxy6pTE7qSo3VQxiBMKG4KqY1iF9VVPUP/86DUkwUd1+KKsq1seRARR8/fpzzGW4frfiFIFjHSO3zmMnNyHINOil2WUIT/nk9kutwFDMxRkHt8=
Received: by 10.54.17.66 with SMTP id 66mr69484wrq;
        Tue, 26 Apr 2005 09:23:11 -0700 (PDT)
Received: by 10.54.17.63 with HTTP; Tue, 26 Apr 2005 09:23:11 -0700 (PDT)
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504261138.46339.mason@suse.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/26/05, Chris Mason <mason@suse.com> wrote:
> On Tuesday 26 April 2005 11:09, Magnus Damm wrote:
> > On 4/26/05, Chris Mason <mason@suse.com> wrote:
> > > This agrees with my tests here, the time to apply patches is somewhat
> > > disk bound, even for the small 100 or 200 patch series.  The io should be
> > > coming from data=ordered, since the commits are still every 5 seconds or
> > > so.
> >
> > Yes, as long as you apply the patches to disk that is. I've hacked up
> > a small backend tool that applies patches to files kept in memory and
> > uses a modifed rabin-karp search to match hunks. So you basically read
> > once and write once per file instead of moving data around for each
> > applied patch. But it needs two passes.
> >
> > And no, the source code for the entire Linux kernel is not kept in
> > memory - you need a smart frontend to manage the file cache. Drop me a
> > line if you are interested.
> 
> Sorry, you've lost me.  Right now the cycle goes like this:

Ehrm, maybe I'm way off. =)

> 1) patch reads patch file, reads source file, writes source file
> 2) update-cache reads source file, writes git file

Ok.

> Which of those writes are you avoiding?  We have a smart way to manage the
> cache already for the source files...the vm does pretty well.  There's
> nothing to manage for the git files.  For the apply a bunch of patches
> workload, they are write once, read never (except for the index).

Well, maybe I misunderstood everything, but I thought you were
applying a lot of patches and complained that it took a lot of time
due to the data order.

When I applied a lot of patches to the kernel recently the cpu load
dropped to zero after a while and the HD worked hard a sec or two and
then things came back again. My primitive guess is that it was because
the ext3 journal became full. To workaround this fact I started
hacking on this in-memory patcher.

In the cycle above, I'm trying to speed up step 1:
If the patch modifies each source file multiple times (either using
multiple hunks or multiple ---/+++) then the lines below the hunk in
the source file will be moved multiple times. And if the source file
is written to disk after each hunk or ---/+++ is applied then this
will generate a lot of writes that can be avoided if the entire patch
procedure is broken down into a first pass that analyzes the patches
and a second pass that applies the patches and keeps source files in
memory.

But my rather trivial observation above is of course only suitable if
you have a lot of patches that should be applied and you are only
interested in the final version of the patched source files. If you
apply one patch at a time and import each source file as a new
revision then my little hack is probably not for you.

/ magnus
