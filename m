From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Sat, 30 Aug 2014 18:10:33 -0700
Message-ID: <CAJo=hJu-DCMv=jepMJvcmR9EOedkynCyL0kD_hB+UGWxbErDfA@mail.gmail.com>
References: <20140829205538.GD29456@peff.net> <20140829205809.GB7060@peff.net>
 <xmqqegvz3qpp.fsf@gitster.dls.corp.google.com> <20140829220818.GA24834@peff.net>
 <CAJo=hJs3mM7=LcOop-WD=bipA=Wx-7MDh6ObQwFUE38tjurvcw@mail.gmail.com> <20140830131649.GA26833@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 03:11:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNtfg-0003Cz-CY
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 03:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbaHaBKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 21:10:54 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43116 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaHaBKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 21:10:53 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so4561930ieb.36
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 18:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Xa5qPmEZSb77UGzWP36nMe/WbRs1edc8nk3yco1Xzvg=;
        b=a3ieG3H+IzgyR+1EL63d8jDXUIq8KSyQXar4O9WhQgKD9riFBIP7n5xUKzoYu6BKgb
         TTYz8NRZbPZY/y6GFbqnY73iyFt1wHURRVCMdIsdxm3bSr1dw1wTg9uX85ArdQ39Oj1R
         TdF6Pqu7UtqxEuh/TWhxvkn3QIaO8gUGtca2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Xa5qPmEZSb77UGzWP36nMe/WbRs1edc8nk3yco1Xzvg=;
        b=hg0MTfpqicfmXvIF9TvZ5pjhIhHr7vd9DJj+Mh+qfJYQQZIWfk5JsWpM9dl2M2cd4u
         iimQL+1Ngeh0v0kpMyks9kqWh+jFbGHannF3EEF+KHnKXq85afVp5h0Tsu3oUUYTLKU2
         6DB8wtofgYEcu2iiWrXv+mfy/QHozz/plhaAgnlbMwQAVtF0EyQa5xQjNSBtv/vtYIGz
         jP0TCjcM3gD6jblIvYeaaSLP3WiUH2+KfSlWxjX205ynNr7+E5htgKPj66AYUEmfvo7w
         HBThjHz21UIzscEOVy/V7/lFxaSiFV7nos8X8iQA0iuZ4PUQdG12b9NgXmgPgu5CIjuQ
         hOYg==
X-Gm-Message-State: ALoCoQnvYDvY8vBHvKGs7xnQaAyKj3jZOqFkEmNFbulWIkpcJvtJMvJHCNDHj+cmxt1vpof01sai
X-Received: by 10.43.140.4 with SMTP id iy4mr18866684icc.23.1409447453068;
 Sat, 30 Aug 2014 18:10:53 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Sat, 30 Aug 2014 18:10:33 -0700 (PDT)
In-Reply-To: <20140830131649.GA26833@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256274>

On Sat, Aug 30, 2014 at 6:16 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 29, 2014 at 07:59:32PM -0700, Shawn Pearce wrote:
>
>> > I agree it is probably a bug on the sending side, but I think last time
>> > this came up we decided to try to be liberal in what we accept.  c.f.
>> > http://thread.gmane.org/gmane.comp.version-control.git/232305/focus=232310
>>
>> IIRC they aren't valid pack files to contain duplicates.
>>
>> Once upon a time JGit had a bug and android.googlesource.com returned
>> duplicate objects in a Linux kernel repository. This caused at least
>> some versions of git-core to fail very badly in binary search at
>> object lookup time or something. We had a lot of users angry with us.
>> :)
>>
>> I know Nico said its OK last year, but its really not. I don't think
>> implementations are capable of handling it.
>
> We do detect and complain if --strict is given. Should we make it the
> default instead? I think it is still worthwhile to have a mode that can
> handle these packs. It may be the only reasonable way to recover the
> data from such a broken pack (and that broken pack may be the only copy
> of the data you have, if you are stuck getting it out of a broken
> implementation on a remote server).

Eh, OK, that does make a lot of sense.

Unfortunately accepting it by default encourages broken
implementations to stay broken and ship packs with duplicate objects,
which they shouldn't do since there are readers out there that cannot
handle it.

In my opinion we should make --strict default, but its an excellent
point made that users should have an escape hatch to disable this
check, attempt accepting a broken pack and try fixing it locally with
repack.
