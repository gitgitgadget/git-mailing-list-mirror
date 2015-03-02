From: David Lang <david@lang.hm>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Sun, 1 Mar 2015 17:05:30 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1503011653000.12474@nftneq.ynat.uz>
References: <1424747562-5446-1-git-send-email-sbeller@google.com> <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com> <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com> <xmqq1tl9gld9.fsf@gitster.dls.corp.google.com>
 <CACsJy8DKbfU7TBHhT5_qpL0QM3zbxkaF+B4x3hQDpomQ_9OSEg@mail.gmail.com> <CAGZ79kaHGw=OyrkktWeo-MR0V1_bASB1cioP+c2Ngpt6fkRxBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 02:05:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSEnk-0007YB-PZ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 02:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbbCBBFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 20:05:36 -0500
Received: from mail.lang.hm ([64.81.33.126]:50036 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbbCBBFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 20:05:36 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id t2215UgI021849;
	Sun, 1 Mar 2015 17:05:30 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CAGZ79kaHGw=OyrkktWeo-MR0V1_bASB1cioP+c2Ngpt6fkRxBA@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264572>

On Sun, 1 Mar 2015, Stefan Beller wrote:

> The way I understand Junio here is to have predefined points which
> makes it easier to communicate. There are lots of clients and they usually
> want to catch up a different amount of commits, so we need to recompute it
> all the time. The idea is then to compute a small pack from the original point
> to one of these predefined points.
> So a conversion might look like:
> Client: My newest commit is dated 2014-11-17.
> Server: ok here is a pack from 2014-11-17 until 2014-12-01 and then
> I have prepared packs I sent out all the time of 2014-12 and 2015-01
> and 2015-02 and then there will be another custom pack for you describing
> changes of 2015-02-01 until now.
>
> Mind that I choose dates instead of arbitrary sha1 values as I feel
> that explains the
> point better, the packs in between are precomputed because many
> clients need them.
>
> Personally I don't buy that idea, because it produces a lot of question, like
> how large should these packs be? Depending on time or commit counts?

I think this is going to depend on the project in question. I think that doing 
this based on public tags makes lots of sense. The precomputed packs should also 
change over time.

For example, with the linux kernel, as each -rc is released, there will be a lot 
of people wanting to upgrade from a prior -rc, so having a pack for each of 
these is probably worthwhile. You probably also want a precomputed pack to move 
from some of the -rc releases to the final release. And then a single pack to 
move from the prior final release to the newest one. There may also me a resons 
to make a pack that jumps several releases to go from one LTS kernel to the 
next.

Exactly what precomputed packs make sense, and how large the packs should be is 
going to be _very_ dependent on the update patterns of users. The only people 
who can decide exactly what packs they should use are the admins of the systems, 
and should be based on their logs of what requests are being made. I can see the 
git project creating scripts to analyze the logs of client connections to make 
recommendations on what packs would be useful to have pre-generated, ideally 
ordered by how much computation they would save (and the amount of disk space 
required to hold the packs, and then the admin of the site can indicate where 
they want the cutoff to be. Some extremely busy sites may have a lot of disk 
space compared to CPU and be willing to have lots of packs around, others are 
less busy and will only want to keep a few around.

David Lang
