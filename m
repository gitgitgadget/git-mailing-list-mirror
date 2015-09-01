From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] submodule: implement `module_clone` as a builtin helper
Date: Tue, 1 Sep 2015 14:35:17 -0400
Message-ID: <CAPig+cSZ9et=7DNF15MJo-Ef5o1bjbLxAoTgxJV6q1BEUiBGcA@mail.gmail.com>
References: <1441048767-29729-1-git-send-email-sbeller@google.com>
	<1441048767-29729-4-git-send-email-sbeller@google.com>
	<CAPig+cQVe+qmTsqqdnTXDABxNkQoeEqz07pP2pYbY_n11XMDWA@mail.gmail.com>
	<CAGZ79kYDYO-q6QEmRQ4YW4ED2HAmMjZNyRaY52ix6YU1=WVNHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 20:35:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqOx-0004Ml-BY
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbbIASfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:35:19 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:32944 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbbIASfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:35:19 -0400
Received: by vkbf67 with SMTP id f67so56858063vkb.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Jhc8LTdM+MO8wAJg3TrSxJy8lIexSgBRVF3NSjvtl/M=;
        b=NSiOWnP7F3AiNk/hm+720h2IRTRQ5JtJr4+tUi111mGl5IM65n6XnOsRQf7R6lTTH0
         EJhGp/xOOOkWoxLCkn/OucHRZZX3nSBax1Rm4jr9eo4fLIYjPx4kor4SqFE+0Lmpwm+a
         Cg7rH7wW9xMkTYwYwQot2cCM0vgXcGXQh2q4oneRKIdi9enj6m3k9JU1Th75p9f6p6XS
         5l3H0JERikLUeppnZ70tWzoNtw6xSdVRpvd/tGH3m2gNrKnUdJ3QCzKEI5k1rREVYMLK
         O49Iw3gvLyXIS3v0VrGDdC/DlzJG6iLFpXcstm3eew7VCtEEYuvoeFU2O04BZg0qFP3B
         kZcw==
X-Received: by 10.129.92.8 with SMTP id q8mr29478622ywb.163.1441132517988;
 Tue, 01 Sep 2015 11:35:17 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Tue, 1 Sep 2015 11:35:17 -0700 (PDT)
In-Reply-To: <CAGZ79kYDYO-q6QEmRQ4YW4ED2HAmMjZNyRaY52ix6YU1=WVNHw@mail.gmail.com>
X-Google-Sender-Auth: dqZoUAInyY6abDhfj7piMyWajtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277025>

On Tue, Sep 1, 2015 at 1:49 PM, Stefan Beller <sbeller@google.com> wrote:
> took all suggestions except the one below.
>
>>
>>     if (strbuf_getcwd(&sb))
>>         die_errno(...);
>>     strbuf_addf(&sb, "/%s, sm_gitdir);
>>     free(sm_gitdir);
>>     sm_gitdir = strbuf_detach(&sb, NULL);
>>
>>> +       }
>>> +
>>> +       if (strbuf_getcwd(&sb))
>>> +               die_errno("unable to get current working directory");
>>
>> The conditional block just above here also gets 'cwd'. If you move
>> this code above the !is_absolute_path(sm_gitdir) conditional block,
>> then you can avoid the duplication.
>
> I don't get it. We need to have strbuf_getcwd twice no matter how we
> arrange the code
> as we strbuf_detach will empty the strbuf.
>
> Do you mean to call strbuf_getcwd just once and then xstrdup the value,
> then reset the strbuf to just contain the cwd and append the other string ?

Sorry, I have no idea what you are asking.

All I am saying is that you're unnecessarily invoking getcwd() twice.
It's value doesn't change between invocations, so the second call is
entirely redundant and wasteful. You can instead call it just once and
use the result in both places.
