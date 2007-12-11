From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 02:01:11 -0500
Message-ID: <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
	 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>, gcc@gcc.gnu.org
X-From: git-owner@vger.kernel.org Tue Dec 11 08:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1z7X-0006ZN-5g
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbXLKHBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbXLKHBN
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:01:13 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:26925 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbXLKHBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:01:12 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3827452wah
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 23:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JKqlJj5H3oyIM+Zfv9IPEOZRckRKf68Kt04z4aShzEw=;
        b=HUlD8QzX5k9NJwyUytdIdkTq8+nOnbRKDjQTGQGCz1UhgKnQoE2YuzbSzqDMskrgcE5YMBj2yxqkv3BEL/luQXjPFgXTEF7PFKafvI/EJpGfMv8wHdxmIxN0ax7G6tzwNAzpNLvcm+888JU4W58A4x8D7N1qj5kRquL9sjuIkhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l8wRfb1+q6r9VooPVNs+s01zV52LUnDCHyFMFbySHad0QLPs9thHib1xdJ7sE6904GurzM8IwPp+6P5/mtW8z0zChletWiNCpepj+lCavv1NYVwOu2hUOOVr5ckcHF+/5T7LiFBGjVGIjSOF7LVZMOcWcuDqCVbpIPsUQWXQHIk=
Received: by 10.115.77.1 with SMTP id e1mr490169wal.1197356471808;
        Mon, 10 Dec 2007 23:01:11 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Mon, 10 Dec 2007 23:01:11 -0800 (PST)
In-Reply-To: <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67811>

Switching to the Google perftools malloc
http://goog-perftools.sourceforge.net/

10%   30  828M
20%   15  831M
30%   10  834M
40%   50  1014M
50%   80  1086M
60%   80  1500M
70% 200  1.53G
80% 200  1.85G
90% 260  1.87G
95% 520  1.97G
100% 1335 2.24G

Google allocator knocked 600MB off from memory use.
Memory consumption did not fall during the write out phase like it did with gcc.

Since all of this is with the same code except for changing the
threading split, those runs where memory consumption went to 4.5GB
with the gcc allocator must have triggered an extreme problem with
fragmentation.

Total CPU time 196 CPU minutes vs 190 for gcc. Google's claims of
being faster are not true.

So why does our threaded code take 20 CPU minutes longer (12%) to run
than the same code with a single thread? Clock time is obviously
faster. Are the threads working too close to each other in memory and
bouncing cache lines between the cores? Q6600 is just two E6600s in
the same package, the caches are not shared.

Why does the threaded code need 2.24GB (google allocator, 2.85GB gcc)
with 4 threads? But only need 950MB with one thread? Where's the extra
gigabyte going?

Is there another allocator to try? One that combines Google's
efficiency with gcc's speed?


On 12/11/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> I added the gcc people to the CC, it's their repository. Maybe they
> can help up sort this out.
>
> On 12/11/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 12/10/07, Nicolas Pitre <nico@cam.org> wrote:
> > > On Mon, 10 Dec 2007, Jon Smirl wrote:
> > >
> > > > New run using same configuration. With the addition of the more
> > > > efficient load balancing patches and delta cache accounting.
> > > >
> > > > Seconds are wall clock time. They are lower since the patch made
> > > > threading better at using all four cores. I am stuck at 380-390% CPU
> > > > utilization for the git process.
> > > >
> > > > complete seconds RAM
> > > > 10%   60    900M (includes counting)
> > > > 20%   15    900M
> > > > 30%   15    900M
> > > > 40%   50    1.2G
> > > > 50%   80    1.3G
> > > > 60%   70    1.7G
> > > > 70%   140  1.8G
> > > > 80%   180  2.0G
> > > > 90%   280  2.2G
> > > > 95%   530  2.8G - 1,420 total to here, previous was 1,983
> > > > 100% 1390 2.85G
> > > > During the writing phase RAM fell to 1.6G
> > > > What is being freed in the writing phase??
> > >
> > > The cached delta results, but you put a cap of 256MB for them.
> > >
> > > Could you try again with that cache disabled entirely, with
> > > pack.deltacachesize = 1 (don't use 0 as that means unbounded).
> > >
> > > And then, while still keeping the delta cache disabled, could you try
> > > with pack.threads = 2, and pack.threads = 1 ?
> > >
> > > I'm sorry to ask you to do this but I don't have enough ram to even
> > > complete a repack with threads=2 so I'm reattempting single threaded at
> > > the moment.  But I really wonder if the threading has such an effect on
> > > memory usage.
> >
> > I already have a threads = 1 running with this config. Binary and
> > config were same from threads=4 run.
> >
> > 10% 28min 950M
> > 40% 135min 950M
> > 50% 157min 900M
> > 60% 160min 830M
> > 100% 170min 830M
> >
> > Something is hurting bad with threads. 170 CPU minutes with one
> > thread, versus 195 CPU minutes with four threads.
> >
> > Is there a different memory allocator that can be used when
> > multithreaded on gcc? This whole problem may be coming from the memory
> > allocation function. git is hardly interacting at all on the thread
> > level so it's likely a problem in the C run-time.
> >
> > [core]
> >         repositoryformatversion = 0
> >         filemode = true
> >         bare = false
> >         logallrefupdates = true
> > [pack]
> >         threads = 1
> >         deltacachesize = 256M
> >         windowmemory = 256M
> >         deltacachelimit = 0
> > [remote "origin"]
> >         url = git://git.infradead.org/gcc.git
> >         fetch = +refs/heads/*:refs/remotes/origin/*
> > [branch "trunk"]
> >         remote = origin
> >         merge = refs/heads/trunk
> >
> >
> >
> >
> > >
> > >
> > >
> > > >
> > > > I have no explanation for the change in RAM usage. Two guesses come to
> > > > mind. Memory fragmentation. Or the change in the way the work was
> > > > split up altered RAM usage.
> > > >
> > > > Total CPU time was 195 minutes in 70 minutes clock time. About 70%
> > > > efficient. During the compress phase all four cores were active until
> > > > the last 90 seconds. Writing the objects took over 23 minutes CPU
> > > > bound on one core.
> > > >
> > > > New pack file is: 270,594,853
> > > > Old one was: 344,543,752
> > > > It still has 828,660 objects
> > >
> > > You mean the pack for the gcc repo is now less than 300MB?  Wow.
> > >
> > >
> > > Nicolas
> > >
> >
> >
> > --
> > Jon Smirl
> > jonsmirl@gmail.com
> >
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
