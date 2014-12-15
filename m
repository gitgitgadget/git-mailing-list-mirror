From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/5] receive-pack.c: add protocol support to negotiate atomic-push
Date: Mon, 15 Dec 2014 14:30:31 -0800
Message-ID: <CAGZ79kYJjnTaUJMhLWt5q76odqQ_zBifEgVbNLJFdv8BViCCQw@mail.gmail.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
	<1418673368-20785-2-git-send-email-sbeller@google.com>
	<xmqqy4q8d493.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 23:30:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0eA0-0005ue-Cc
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 23:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbaLOWad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 17:30:33 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:32886 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaLOWac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 17:30:32 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so11714542ier.27
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 14:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T26WNDAaWOpeMkERX5izpeKYttd34+O6BXGqgd5WRY4=;
        b=UTvWUd62LF74dVR2hO3uQpSEb2WLd5gBsHrBtHn3w2E0AMrSyfFzgPr5Hvm0XgF1I6
         quSLWIfy1cSO/1oLsWhjwn+M7F48NOySDvHmM4Jx2haqyxVwTTrk9jyEbQvSKFkyIP0o
         0u0BQ5UYY9S9/0xknR69FViEAa87nQ+c+jgiVepIFszj9Wl45n953vOlsx/dvP0KjrxC
         5hfgH6xr0sWMriw6n2hAKhe7TGyGkjonUhwjm+4yya6vC6vFOmkuXdhHSghql8PExU8l
         WKwMaO61QN0RRQvb3JrvmNPN36kqg6u94hIfe05Qm1kN6pGRyJbJIHFaFBGoBOwwbrmH
         0KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=T26WNDAaWOpeMkERX5izpeKYttd34+O6BXGqgd5WRY4=;
        b=e9ea1o1yI+fOoUhepbcEP9ekSPoVB1YtSrKwWneYVdKfJbALsX/RACtYkklmYylM4v
         wJf4jJGmtoZYT4MTvJGRQh3ha0skLC5KIH4LwSXXeNlaIlrtlFnGp4YvTajshVqGE4Yg
         fjJjk+tMTSzJbtJUxsShno92Jc9POfTlk/IlY6FHASt7yLwUX8auT5VLkspr+tj/EfsY
         wKpskJnGt44ffdGKupK89/IikUzOvZjMOU3Zuic/62dP4d/RUlQfgTbm/zXzQizODWoM
         K/3HzaU1vfiyfTPCAnC0NITF1gWT67kIquBCLTy/yS3GFKWEvCF4fiH52MkiV3QrP+zu
         Gw8g==
X-Gm-Message-State: ALoCoQlDi1/uv97ZvMVN7b2wRwyZ71ngO1oNcbIhdKFI/QcdB4OOCWDl6fKQV5S+Ir3Ko9Rzl78V
X-Received: by 10.43.82.72 with SMTP id ab8mr30285752icc.76.1418682631524;
 Mon, 15 Dec 2014 14:30:31 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 15 Dec 2014 14:30:31 -0800 (PST)
In-Reply-To: <xmqqy4q8d493.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261430>

On Mon, Dec 15, 2014 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Hmph, am I reading the patch to send-pack.c correctly?
>
> It detects if the other side supports the capability and leaves it
> in atomic_push_supported variable for later use, and also requests
> the feature to be activated when atomic_push is set, but I see no
> logic to link these two together, e.g. error out when atomic_push
> is true and atomic_push_supported is false (or turn it off with a
> warning, or whatever).


This is what you mean by

>
>> +     if (args->use_atomic_push && !atomic_push_supported) {
>> +             fprintf(stderr, "Server does not support atomic-push.");
>> +             return -1;
>> +     }
>
> This check logically belongs to the previous step, no?

from the next patch? If so it will be part of the next reroll.

Thanks,
Stefan
