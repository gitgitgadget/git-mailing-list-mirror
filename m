From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-export: ensure we traverse commits in topological 
	order
Date: Wed, 11 Feb 2009 08:23:22 -0700
Message-ID: <51419b2c0902110723y75d0c4a4r34cf92cf371313ea@mail.gmail.com>
References: <1234332233-10017-1-git-send-email-newren@gmail.com>
	 <1234332233-10017-2-git-send-email-newren@gmail.com>
	 <alpine.DEB.1.00.0902111125410.10279@pacific.mpi-cbg.de>
	 <e2b179460902110248m8055b3amdebcfc550438cff2@mail.gmail.com>
	 <20090211135640.GA19600@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 16:25:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXGxN-0004PI-PB
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 16:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbZBKPX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 10:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755648AbZBKPX0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 10:23:26 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:32904 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbZBKPXY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 10:23:24 -0500
Received: by yw-out-2324.google.com with SMTP id 5so116815ywh.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 07:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=29Qlta/75rm82WSzTTuKevVaJbXskqR0LT1zRgNIMGY=;
        b=pZCZxdK8Y1S3UOtwFr/G/2qv+NJNdsnC5EbS0yaU/U41l06GDF27m4fO8Xv40+4rXl
         mTpJ/uh6yzy2jKTwKeIEtMjRa7pU52iObWhGAG+MuBmBRXDsrPywRZ7y2vjZbVhWvzmY
         cfFjl1E6nfw7qXoopDjRv2q0al9f8chm348Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MeumzpKar7LLiHTB6Yc5d9F9ikcY+2ra4ZT0e1qk2I0AXbq/+4XzG794jDXGpeOeMb
         yntyeHvmpMjp3R1AKCLgcstd2b8TeQnglk03NxCdNWxDFR84kZbAElbFXB+EgMNlCKod
         0QZnh32miZdG0MD4YD3LUnEs91utuzyS0gB28=
Received: by 10.150.11.6 with SMTP id 6mr4819ybk.30.1234365803097; Wed, 11 Feb 
	2009 07:23:23 -0800 (PST)
In-Reply-To: <20090211135640.GA19600@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109424>

On Wed, Feb 11, 2009 at 6:56 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 11, 2009 at 10:48:18AM +0000, Mike Ralphson wrote:
>
>> > On Tue, 10 Feb 2009, newren@gmail.com wrote:
>> > fast-export will only list as parents those commits which have already
>> > been traversed (making it appear as if merges have been squashed if not
>> > all parents have been traversed).  To avoid this silent squashing of
>> > merge commits, we request commits in topological order.
>>
>> Any comparative timings? We don't need to rename this to 'git
>> reasonably-speedy-export'? 8-)
>
> Hmm.
>
> In git.git:
>
>  $ time git fast-export --all --signed-tags=strip >/dev/null
>  real    1m6.013s
>  user    1m3.840s
>  sys     0m2.140s
>
>  $ time git fast-export --all --signed-tags=strip --topo-order >/dev/null
>  real    0m49.018s
>  user    0m47.987s
>  sys     0m0.888s
>
> I certainly didn't expect it to be _faster_.  More efficient use of the
> delta cache, maybe?

Yeah, I also saw a speed-up, though the difference was less pronounced
-- 19.7 seconds versus 19.5 (that was the average for 5 runs, after
first doing a run that I ignored to make sure I was comparing
hot-cache to hot-cache).

I'm a little surprised why my numbers were so much lower than yours,
though.  I don't think of my hard drive and CPU as being all that
quick -- is this a difference in packing, by chance, with your
repository not having recently been repacked?
