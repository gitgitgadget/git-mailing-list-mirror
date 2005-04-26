From: Chris Mason <mason@suse.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 13:39:33 -0400
Message-ID: <200504261339.34680.mason@suse.com>
References: <20050426004111.GI21897@waste.org> <200504260713.26020.mason@suse.com> <Pine.LNX.4.58.0504260939440.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mike Taht <mike.taht@timesys.com>, Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261498AbVDZRt6@vger.kernel.org Tue Apr 26 19:51:50 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261498AbVDZRt6@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUDD-00021p-Ho
	for glk-linux-kernel@gmane.org; Tue, 26 Apr 2005 19:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVDZRt6 (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Tue, 26 Apr 2005 13:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDZRsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:48:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:26062 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261725AbVDZRjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:39:40 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 9263E985E;
	Tue, 26 Apr 2005 19:39:39 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 09EE814B73C; Tue, 26 Apr 2005 19:39:37 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504260939440.18901@ppc970.osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2005 12:42, Linus Torvalds wrote:
> On Tue, 26 Apr 2005, Chris Mason wrote:
> > This agrees with my tests here, the time to apply patches is somewhat
> > disk bound, even for the small 100 or 200 patch series.  The io should be
> > coming from data=ordered, since the commits are still every 5 seconds or
> > so.
>
> Yes, ext3 really does suck in many ways.
>
> One of my (least) favourite suckage is a process that does "fsync" on a
> single file (mail readers etc), which apparently causes ext3 to sync all
> dirty data, because it can only sync the whole log. So if you have stuff
> that writes out things that aren't critical, it negatively affects
> something totally independent that _does_ care.
>
> I remember some early stuff showing that reiserfs was _much_ better for
> BK. I'd be willing to bet that's probably true for git too.

reiserfs shares the same basic data=ordered idea as ext3, so the fsync will do 
the same on reiser as it does on ext3.  I do have code in there to try and 
keep the data=ordered writeback a little less bursty than it is in ext3 so 
you might not notice the fsync as much.

I haven't compared reiser vs ext3 for git.  reiser tails should help 
performance because once you read the object inode you've also got the data.  
But, I would expect the biggest help to come from mounting reiserfs -o 
alloc=skip_busy.  This basically allocates all new files one right after the 
other on disk regardless of which subdir they are in.  The effect is to time 
order most of your files.

As an example, here's the time to apply 300 patches on ext3.  This was with my 
packed patches applied, but vanilla git should show similar percentage 
differences.

data=writeback  32s			
data=ordered    44s

With a long enough test, data=ordered should fall into the noise, but 10-40 
second runs really show it.

-chris
