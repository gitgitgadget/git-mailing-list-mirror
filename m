From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 29 Sep 2011 10:38:44 -0600
Organization: CAF
Message-ID: <201109291038.45290.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 29 18:38:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9JdM-0003zT-Vs
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 18:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757059Ab1I2Qir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 12:38:47 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:62376 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752Ab1I2Qiq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 12:38:46 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6483"; a="123316398"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 29 Sep 2011 09:38:46 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 0EAC310004BE;
	Thu, 29 Sep 2011 09:38:46 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182407>

On Wednesday, September 28, 2011 08:19:16 pm Julian Phillips 
wrote:
> On Wed, 28 Sep 2011 19:37:18 -0600, Martin Fick wrote:
> > On Wednesday 28 September 2011 18:59:09 Martin Fick 
wrote:
> >> Julian Phillips <julian@quantumfyre.co.uk> wrote:
> -- snip --
> 
> >> I've created a test repo with ~100k refs/changes/...
> >> style refs, and ~40000 refs/heads/... style refs, and
> >> checkout can walk the list of ~140k refs seven times
> >> in 85ms user time including doing whatever other
> >> processing is needed for checkout. The real time is
> >> only 114ms - but then my test repo has no real data
> >> in.
> > 
> > If I understand what you are saying, it sounds like you
> > do not have a very good test case. The amount of time
> > it takes for checkout depends on how long it takes to
> > find a ref with the sha1 that you are on. If that sha1
> > is so early in the list of refs that it only took you
> > 7 traversals to find it, then that is not a very good
> > testcase. I think that you should probably try making
> > an orphaned ref (checkout a detached head, commit to
> > it), that is probably the worst testcase since it
> > should then have to search all 140K refs to eventually
> > give up.
> > 
> > Again, if I understand what you are saying, if it took
> > 85ms for 7 traversals, then it takes approximately
> > 10ms per traversal, that's only 100/s! If you have to
> > traverse it 140K times, that should work out to 1400s
> > ~ 23mins.
> 
> Well, it's no more than 10ms per traversal - since the
> rest of the work presumably takes some time too ...
> 
> However, I had forgotten to make the orphaned commit as
> you suggest - and then _bang_ 7N^2, it tries seven
> different variants of each ref (which is silly as they
> are all fully qualified), and with packed refs it has to
> search for them each time, all to turn names into hashes
> that we already know to start with.
> 
> So, yes - it is that list traversal.
> 
> Does the following help?
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5e356a6..f0f4ca1 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -605,7 +605,7 @@ static int
> add_one_ref_to_rev_list_arg(const char *refname,
>                                         int flags,
>                                         void *cb_data)
>   {
> -       add_one_rev_list_arg(cb_data, refname);
> +       add_one_rev_list_arg(cb_data,
> strdup(sha1_to_hex(sha1))); return 0;
>   }


Yes, but in some strange ways. :)

First, let me clarify that all the tests here involve your 
"sort fix" from 2 days ago applied first.

In the packed ref repo, it brings the time down to about 
~10s (from > 5 mins).  In the unpacked ref repo, it brings 
it down to about the same thing ~10s, but it was only 
starting at about ~20s.

So, I have to ask, what does that change do, I don't quite 
understand it?  Does it just do only one lookup per ref by 
normalizing it?  Is the list still being traversed, just 
about 7 time less now?  Should the packed_ref list simply be 
put in an array which could be binary searched instead, it 
is a fixed list once loaded, no?  

I prototyped a packed_ref implementation using the hash.c 
provided in the git sources and it seemed to speed a 
checkout up to almost instantaneous, but I was getting a few 
collisions so the implementation was not good enough.  That 
is when I started to wonder if an array wouldn't be better 
in this case?



Now I also decided to go back and test a noop fetch (a 
refetch) of all the changes (since this use case is still 
taking way longer than I think it should, even with the 
submodule fix posted earlier).  Up until this point, even 
the sorting fix did not help.  So I tried it with this fix.  
In the unpackref case, it did not seem to change (2~4mins).  
However, in the packed ref change (which was previously also 
about 2-4mins), this now only takes about 10-15s!

Any clues as to why the unpacked refs would still be so slow 
on noop fetches and not be sped up by this?


-Martin


-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
