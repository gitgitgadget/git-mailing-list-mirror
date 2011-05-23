From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCHv4 09/10] pack-objects: Estimate pack size; abort early if
 pack size limit is exceeded
Date: Mon, 23 May 2011 09:11:15 -0700
Message-ID: <BANLkTimQURetDxYeAJr5sVRB-ja9yuqT7Q@mail.gmail.com>
References: <1306111923-16859-1-git-send-email-johan@herland.net> <1306111923-16859-10-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 23 18:11:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOXjJ-0002jF-MR
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 18:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677Ab1EWQLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 12:11:36 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38112 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab1EWQLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 12:11:35 -0400
Received: by vws1 with SMTP id 1so4207450vws.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 09:11:35 -0700 (PDT)
Received: by 10.52.6.136 with SMTP id b8mr520818vda.17.1306167095113; Mon, 23
 May 2011 09:11:35 -0700 (PDT)
Received: by 10.52.167.228 with HTTP; Mon, 23 May 2011 09:11:15 -0700 (PDT)
In-Reply-To: <1306111923-16859-10-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174249>

On Sun, May 22, 2011 at 17:52, Johan Herland <johan@herland.net> wrote:
> Currently, when pushing a pack to the server that has specified a pack size
> limit, we don't detect that we exceed that limit until we have already
> generated (and started transmitting) that much pack data.
>
> Ideally, we should be able to predict the approximate pack size _before_ we
> start generating and transmitting the pack data, and abort early if the
> estimated pack size exceeds the pack size limit.
>
> This patch tries to provide such an estimate: It looks at the objects that
> are to be included in the pack, and for already-packed objects, it assumes
> that their compressed in-pack size is a good estimate of how much they will
> contribute to the pack currently being generated. This assumption should be
> valid as long as the objects are reused as-is.

This looks good to me.

> I'm not really happy with excluding loose objects in the pack size
> estimate. However, the size contributed by loose objects varies wildly
> depending on whether a (good) delta is found. Therefore, any estimate
> done at an early stage is bound to be wildly inaccurate. We could maybe
> use some sort of absolute minimum size per object instead, but I
> thought I should publish this version before spending more time futzing
> with it...
>
> A drawback of not including loose objects in the pack size estimate,
> is that pushing loose objects is a very common use case (most people
> push more often than they 'git gc'). However, for the pack sizes that
> servers are most likely to refuse (hundreds of megabytes), most of
> those objects will probably already be packed anyway (e.g. by
> 'git gc --auto'), so I still hope the pack size estimate will be useful
> when it really matters.

That is my impression too. Most servers using this feature will
probably put a limit of at least 10MB. Once you get into the 25-100M
range, the client probably has already packed the bulk of that
content. Especially if we also have Junio's new stream large blobs to
packs during git add patch. So as you point out, cases where this is
mostly useful (really huge push) this is likely to still trigger
correctly.

We can still get a tighter estimate if we wanted to. I wouldn't mix it
into this patch, but make a new one on top of it. During delta
compression we hold onto deltas, or at least compute and retain the
size of the chosen delta. We could re-check the pack size after the
Compressing phase by including the delta sizes in the estimate, and if
we are over, abort before writing.

For non-delta, non-reuse we may be able to guess by just using the
loose object size. The loose object is most likely compressed at the
same compression ratio as the outgoing pack stream will use, so a
deflate(inflate(loose)) cycle is going to be very close in total bytes
used. If we over shoot the limit by more than some fudge factor (say
8K in 1M limit or 0.7%), abort before writing.

-- 
Shawn.
