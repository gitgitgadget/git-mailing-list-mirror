From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 11:21:34 -0700
Message-ID: <xmqqeghq48nl.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-3-git-send-email-sbeller@google.com>
	<CAPig+cQKOEYYR3j-uEeFzF3-qAfqq4SdQrH8LPmSP0VmAOCtzw@mail.gmail.com>
	<xmqqh9mm5tus.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaJmy4EijFuLCXOzPbi3EoqSwarFj3_3r+ghUwVA+88Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 20:21:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeSCE-0003Ab-1X
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759337AbbIVSVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 14:21:38 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33676 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758251AbbIVSVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:21:36 -0400
Received: by pacex6 with SMTP id ex6so16045732pac.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=n5CO0+CdsPdU7RtptNlH+IoGA1ZuX79lzLvU87TghyY=;
        b=Ws1P/gFefjMHDm3q4S6dm6a8gfOBDgWfGbIAf3rz/UUPZ1qSHMnSSADr6tUUhB/Vki
         yyf/TTG78IKab+lZzkWokGPLc4KnvicBPAmtID1LQMyquZckqDSpQiYsyr4fgL4OvP9y
         J+sSQnLcVhdrZKW3v8XUgdRKjfbNfSuneF4PuCuauTOfN2fDM66Ey6503y5MNAN7LrG2
         Utrh5PWKY6rUiwSNDWcOM9Ji76gpq06LTQDvHy4PaJ72dvEOlrw3QEWyK96h78KQkhXh
         MCMe4Qrz3B9Fj1is0N8oRvM4QK9hROKR6oeS5+Pkt71nisCri1Ui/ektfl43TRQBkXdR
         99pw==
X-Received: by 10.66.216.39 with SMTP id on7mr32203379pac.73.1442946095859;
        Tue, 22 Sep 2015 11:21:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id lw13sm3566317pab.29.2015.09.22.11.21.35
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 11:21:35 -0700 (PDT)
In-Reply-To: <CAGZ79kaJmy4EijFuLCXOzPbi3EoqSwarFj3_3r+ghUwVA+88Mg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 22 Sep 2015 10:38:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278408>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Sep 22, 2015 at 8:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>>>         while (1) {
>>>>                 nr = read(fd, buf, len);
>>>> -               if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
>>>> -                       continue;
>>>> +               if (nr < 0) {
>>>> +                       if (errno == EINTR)
>>>> +                               continue;
>>>> +                       if (errno == EAGAIN || errno == EWOULDBLOCK) {
>>>> +                               struct pollfd pfd;
>>>> +                               int i;
>>>> +                               pfd.events = POLLIN;
>>>> +                               pfd.fd = fd;
>>>> +                               i = poll(&pfd, 1, 100);
>>>
>>> Why is this poll() using a timeout? Isn't that still a busy wait of
>>> sorts (even if less aggressive)?
>
> True. Maybe we could have just a warning for now?
>
>     if (errno == EAGAIN) {
>         warning("Using xread with a non blocking fd");
>         continue; /* preserve previous behavior */
>     }

It is very likely that you will hit the same EAGAIN immediately by
continuing and end up spewing tons of the same warning, no?

We may want to slow down and think before sending a knee-jerk
response (this applies to both of us).

I actually think a blocking poll(2) here would not be such a bad
idea.  It would preserves the previous behaviour for callers who
unknowingly inherited a O_NONBLOCK file descriptor from its
environment without forcing them to waste CPU cycles.
