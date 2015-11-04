From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Wed, 4 Nov 2015 14:08:21 -0600
Message-ID: <CAEtYS8S_ys3jT5ziWd7_u6Dn8b3LwnZYO7Pz6EegsmWpUM5riw@mail.gmail.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
	<1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
	<xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
	<xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
	<CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
	<xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8Rp0Eb7uHB8kJ=muVWy6u+beB7kAAWZqPgTYqfuKx3P2A@mail.gmail.com>
	<20151104200249.GC16101@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:08:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu4M6-0005Oi-JS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 21:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965401AbbKDUIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 15:08:22 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:36421 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965309AbbKDUIV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 15:08:21 -0500
Received: by ioll68 with SMTP id l68so67297319iol.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 12:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mceZ27TrGfIbPiV7M6ZCcXcPMZY/5hAYk2XQ5zZ/zJg=;
        b=kcWCITcH6SeEPcKrPPgx/B+2PWoYYUDL5CCQNm0lxeRmpfQs3CbfpeV85hiIGXQCAW
         k16ZnRIx7u0BMl+dUMKzdGuJwMzEVGr5nVelFNgoHoXYW9MmfLpQMOPO3GJ63ChQW5lB
         Hdag850Pf4a7abJWwmfVHFyz6uHuJcIYrbOtblEUazgcztOd/ipeT1hEQrDCDb2NGLsr
         Z0QTaF5x1Sy1TQUjQAzJzrvbfAl9hiTXWFmmApBBQOsBY0wIUZ6hJ7dTlip7BXrIUdyx
         cYWG5l82TdfNyBsxk/oGq6u6odYqcpgzFL5rbYkAO0zevtge10m7OQDAC2vJhBT6Mwss
         AR+Q==
X-Received: by 10.107.138.84 with SMTP id m81mr5428149iod.40.1446667701189;
 Wed, 04 Nov 2015 12:08:21 -0800 (PST)
Received: by 10.79.38.129 with HTTP; Wed, 4 Nov 2015 12:08:21 -0800 (PST)
In-Reply-To: <20151104200249.GC16101@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280878>

On Wed, Nov 4, 2015 at 2:02 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 04, 2015 at 01:56:38PM -0600, Doug Kelly wrote:
>
>> > I did wonder if we want to say anything about .bitmap files, though.
>> > If there is one without matching .idx and .pack, shouldn't we report
>> > just like we report .idx without .pack (or vice versa)?
>>
>> I think you're right -- this would be something worth following up on.
>> At least, t5304 doesn't cover this case explicitly, but when I tried
>> adding an empty bitmap with a bogus name, I did see a "no
>> corresponding .idx or .pack" error, similar to the stale .keep file.
>
> Yeah, that should be harmless warning (although note because the bitmap
> code only really handles a single bitmap, it can prevent loading of the
> "real" bitmap; so you'd want to clean it up, for sure).
>
>> I'd trust your (and Jeff's) knowledge on this far more than my own,
>> but would it be a bad idea to clean up .keep and .bitmap files if the
>> .idx/.pack pair are missing?  I think we may have had a discussion
>> previously on how things along these lines might be racey -- but I
>> don't know what order the .keep file is created in relation to the
>> .idx/.pack.
>
> Definitely cleaning up the .bitmap is sane and not racy (it's in the
> same boat as the .idx, I think).
>
> .keep files are more tricky. I'd have to go over the receive-pack code
> to confirm, but I think they _are_ racy. That is, receive-pack will
> create them as a lockfile before moving the pack into place. That's OK,
> though, if we use mtimes to give ourselves a grace period (I haven't
> looked at your series yet).
>
> But moreover, .keep files can be created manually by the user. If the
> pack they referenced goes away, they are not really serving any purpose.
> But it's possible that the user would want to salvage the content of the
> file, or know that it was there.
>
> So I'd argue we should leave them. Or at least leave ones that do not
> have the generic "{receive,fetch}-pack $pid on $host comment in them,
> which were clearly created as lockfiles.
>
> -Peff

Currently there's no mtime-guarding logic (I dug up that conversation
earlier, though, but after I'd done the respin on this series)... OK,
in that case, I'll create a separate patch that tests/cleans up
.bitmap, but doesn't touch .keep.  This might be a small series since
I think the logic for finding pack garbage doesn't know anything about
.bitmap per-se, so it's looking like I'll extend that relevant code,
before adding the handling in gc and appropriate tests.
