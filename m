From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Fri, 21 Aug 2015 13:12:15 -0700
Message-ID: <CAGZ79katsSYno3H1+yxoKk4K-1VxH99p-F8uwaDiakeWTKs-fw@mail.gmail.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-2-git-send-email-sbeller@google.com>
	<xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
	<20150821194454.GB26466@sigill.intra.peff.net>
	<CAGZ79kYM6m-Me=okbxMAY_NKDm40JwfgRutwTzYfT5=ez42=jg@mail.gmail.com>
	<20150821195135.GA26720@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:12:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSsfw-000697-E6
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 22:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbbHUUMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 16:12:16 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36559 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbHUUMP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 16:12:15 -0400
Received: by ykfw73 with SMTP id w73so81744095ykf.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4pTOHIfvv/JDsTVTiHxPTjee8hupZ/5KMYqwERmxhw0=;
        b=O0mzXIEM9L8vMNnZQ/sIhGnuE10F3zjc7yhgh3J5dHZpUZSucELaYBh/8qOFBv/d0N
         9mKU/JP5jp/P/6DxkhDeT80PgFDMRRRaf2vaKxH7EavDcyT78ENNlQQ+GLnlHurA5a8k
         3Ggm9KhfJY0ouG1v+t/clxZU2stuwmVsvBmC4U2AjxRa87l5+TLkaDsDlG5QL4zhQvie
         BnhHJlcBpuKJecUB5tjl/trPMtrUscr1w7Q9ULMWJ06yFddK8vZY6dD1Z8pmKXjSTsJu
         EIPMAn/hVwHpTELAUGDdQGFeVhoMC7p2TN+DS9ePtjjFo9k9sOx7DcFCHf0Q1Pc02G75
         w6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4pTOHIfvv/JDsTVTiHxPTjee8hupZ/5KMYqwERmxhw0=;
        b=YCjIc6OnFvUDqEgfroLww7BeBm2Q+L+6gAi17eGTkd2vHTWpL4wTY+C5aAnz50UbbO
         tHew2cJGovBpEcut+hCiOoHVwze0ZtJ+i7rSCubCK5Bao/MPzesAraGpBSoi3fx30eh4
         U1FIca3sbvfUpxZumcuxlneF5L/t1ijEtpp9LIUeRBwUtJMaAR1t8duPhgzfSOAec8Mz
         omTwQwQDQOg8dPnr7hEEr/PvNuwOsDFxszAgrMJE9T7pzrij4Y2qfriYqZmXmpKVjSao
         qDcrtI37kyiy5V5UXGmNYtJnX70X2a4tqgqiLNuK0s0leMI4XV6Cf1+sffiaK0Z5P29E
         zMEA==
X-Gm-Message-State: ALoCoQnkh78LHjx5P9m2z4WutC+JQI9eiyPeGlvyabu7YvZ+z5NVEl8naZSii+T9WnEan3XG73kI
X-Received: by 10.129.101.7 with SMTP id z7mr13689699ywb.81.1440187935118;
 Fri, 21 Aug 2015 13:12:15 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 21 Aug 2015 13:12:15 -0700 (PDT)
In-Reply-To: <20150821195135.GA26720@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276327>

On Fri, Aug 21, 2015 at 12:51 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 21, 2015 at 12:48:23PM -0700, Stefan Beller wrote:
>
>> > Before even looking at the implementation, my first question would be
>> > whether this pattern is applicable in several places in git (i.e., is it
>> > worth the extra complexity of abstracting out in the first place). I
>> > think there are a few task-queue patterns already in git; for example
>> > the delta search in pack-objects. Is the interface given here sufficient
>> > to convert pack-objects? Is the result nicer to read? Is it as
>> > efficient?
>> >
>> > We do not need to convert all possible call-sites to the new abstracted
>> > code at once. But I find that converting at least _one_ is a good litmus
>> > test to confirm that a new interface is generally useful.
>>
>> Ok, I'll head off to convert one place.
>
> Thanks. By the way, reading over what I wrote, it sounds a little
> harsher than I meant.

It did not sound harsh at all. I was just reading an internal mailing list,
which cites over generalizing as a very bad practice worse than
premature optimization, so I totally understand your concern and
agree.

> It is not "if you do not convert an existing site,
> we cannot accept a new interface, period". But I would like at least
> some explanation as an alternative, like "I'm pretty sure we can convert
> site X to this, but it is not a good time to do so now because of Y".
> Where "Y" might be "we need to do this other refactoring work first", or
> "it would be disruptive to other work in the area".
>
> -Peff
