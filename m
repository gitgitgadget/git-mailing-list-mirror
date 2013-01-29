From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Tue, 29 Jan 2013 00:06:33 -0800
Message-ID: <CAJo=hJtDn_6qsQ7uj2Pi=vnjNXR7WPN1VH1Mb8YdneD_bHUK8w@mail.gmail.com>
References: <20130126224011.GA20675@sigill.intra.peff.net> <7vlibfxhit.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:07:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U06Dt-0000RL-6w
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 09:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab3A2IGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 03:06:55 -0500
Received: from mail-ia0-f182.google.com ([209.85.210.182]:37702 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174Ab3A2IGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 03:06:54 -0500
Received: by mail-ia0-f182.google.com with SMTP id w33so206376iag.27
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 00:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=NYVZmNYTE7ogZqWd5qj/pRY9OvAuLZ7mWCZtMT/4km4=;
        b=c7SwU8E7BGa0bkg0ACQADTGc3TdY3zlc7j/OUNhaK93SviMSUZaW8OmydVZM9bJG3y
         NBBUsy09jLKqPpfFxcj+hPxIoC+FEty6r/OIBjR4SChNlQZDQgVwjXyAdN+lGCkw00Lb
         F4GoEOeZP3iXGlzo23ADN5bykXvNx7LGPoELQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=NYVZmNYTE7ogZqWd5qj/pRY9OvAuLZ7mWCZtMT/4km4=;
        b=nBWkI0Zm7EfRF5Y8FWJDtPbZkSUQCS2uI0yowIZmqoJ4OD2Zz8xbpLI1ndpTWFVpoi
         iIKWXDkb3RUmaq+9/KpBDWJVkPJyNXGKdbvMTIGxIA1Of7HlhRZ9vPd/It2ro7oG8+E5
         abKAFmyZGtadPohvrnx6HOi0l0+PMjK2Qth0I1YP3iYHC8sfyz2t0/e3WCPfR0D7SMl0
         cYL/fSP/MMKBsNuJQpIq98qHORTRDn3J9dT62w2ZHroU3ikbM9J0oEULjTBkN1hp+XqY
         VYE4woLdnjdNXHHTU0MMer5dnrEFTtrA1nxHiorh9A/U7P1WgNb8ejslhD3McKa5t5O5
         57Qw==
X-Received: by 10.43.7.7 with SMTP id om7mr69168icb.25.1359446813847; Tue, 29
 Jan 2013 00:06:53 -0800 (PST)
Received: by 10.64.170.100 with HTTP; Tue, 29 Jan 2013 00:06:33 -0800 (PST)
In-Reply-To: <7vlibfxhit.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkWc3Vdz5u5ek4Z8dvvUZRPqD1aYpbjQf9I5+Cl4pNdtcb+sG7saYfbxMEdWIQevjWhSUA8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214910>

On Sat, Jan 26, 2013 at 10:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> This is a repost from here:
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/211176
>>
>> which got no response initially. Basically the issue is that read-only
>> repos (e.g., a CI server) whose workflow is something like:
>>
>>   git fetch $some_branch &&
>>   git checkout -f $some_branch &&
>>   make test
>>
>> will never run git-gc, and will accumulate a bunch of small packs and
>> loose objects, leading to poor performance.
...
> I also wonder if we would be helped by another "repack" mode that
> coalesces small packs into a single one with minimum overhead, and
> run that often from "gc --auto", so that we do not end up having to
> have 50 packfiles.

Yes. This does help....

> When we have 2 or more small and young packs, we could:
>
>  - iterate over idx files for these packs to enumerate the objects
>    to be packed, replacing read_object_list_from_stdin() step;
>
>  - always choose to copy the data we have in these existing packs,
>    instead of doing a full prepare_pack(); and
>
>  - use the order the objects appear in the original packs, bypassing
>    compute_write_order().

Hmm, sounds familiar. Seems like its what we do in JGit for Android. :-)
