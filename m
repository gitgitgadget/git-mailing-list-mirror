From: Shumkin Alexey <alex.crezoff@gmail.com>
Subject: Re: [PATCH] git-web--browser: avoid errors in terminal when running
 Firefox on Windows
Date: Sat, 26 Jan 2013 02:52:50 +0400
Message-ID: <CAEFUfsH9Xdd4R-uHZGYH4jXvv_z2SzRmtaZwj0_o0d4A9ynPBg@mail.gmail.com>
References: <20111111202636.GA20515@sigill.intra.peff.net>
	<3eeabf4989f7f1b4593e89e4c6bcfa8710a7b793.1359125053.git.Alex.Crezoff@gmail.com>
	<20130125220617.GA23626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 23:53:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tys94-0000Y0-8v
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 23:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab3AYWwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 17:52:53 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:39307 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab3AYWwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 17:52:51 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so298812oag.11
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 14:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=pWZRkimgkyzkxtfhEhA3B3cHGkhT8jeiIDLzHghF5f0=;
        b=i9flRQGo8tAriCHm6TgLiRusnZDCxeMApmEERS/xHyhJ27AEDOFN2unih50dw3BZ28
         qhVVNIOsKtY1SOxmi7Tfw6Uk8e0KRrS+YKc790lDmvntIlN6hpKBgTxtscTvwilu+6pc
         70JR/XWrpxeGt9/7XwaL1me3BGflp5l1EDu9h0RXEgZYBx94TzFOv+lg7TH9+U7omea/
         lxSWqGpuRP1vKSpJKrLJ41ZMNJ2TyPEgCZQ7U7GCc3F1+oiD6/NXMMX5JarcYBPPshSP
         j+MrWRAEBo/6X1imzFSQ0ohg5QoD97V84EO/h2GEjQJL/ByPoCKdgW9MZ1qFDbeQ19nz
         FywQ==
X-Received: by 10.182.23.101 with SMTP id l5mr254865obf.16.1359154371126; Fri,
 25 Jan 2013 14:52:51 -0800 (PST)
Received: by 10.76.121.71 with HTTP; Fri, 25 Jan 2013 14:52:50 -0800 (PST)
In-Reply-To: <20130125220617.GA23626@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214595>

2013/1/26 Jeff King <peff@peff.net>:
> On Fri, Jan 25, 2013 at 06:44:13PM +0400, Alexey Shumkin wrote:
>
>>  test_web_browse () {
>> -     # browser=$1 url=$2
>> +     # browser=$1 url=$2 sleep_timeout=$3
>> +     sleep_timeout="$3"
>>       git web--browse --browser="$1" "$2" >actual &&
>> +     # if $3 is set
>> +     # as far as Firefox is run in background (it is run with &)
>> +     # we trying to avoid race condition
>> +     # by waiting for "$sleep_timeout" seconds of timeout for
>> 'fake_browser_ran' file appearance
>> +     (test -z "$sleep_timeout" || (
>> +         for timeout in $(seq 1 $sleep_timeout); do
>> +                     test -f fake_browser_ran && break
>> +                     sleep 1
>> +             done
>> +             test $timeout -ne $sleep_timeout
>> +             )
>> +     ) &&
>>       tr -d '\015' <actual >text &&
>
> Gross, but I don't really see another way to handle the asynchronous
> nature of spawning background browsers.
>
> Two things, though:
>
>   1. Should test_web_browse just delete fake_browser_ran for us? Then
>      later tests do not have to remember to do so.
Yep, you're right
>
>   2. Seeing fake_browser_ran appeared, we know that the script has
>      started.  But there is still a race condition in which it may not
>      have written anything to "actual" yet.
Definitely right
>
> In this implementation:
>
>> +     cat >"fake browser" <<-\EOF &&
>> +     #!/bin/sh
>> +
>> +     : > fake_browser_ran
>> +     if test "$1" = "-version"; then
>> +             echo Fake Firefox browser version 1.2.3
>> +     else
>> +             # Firefox (in contrast to w3m) is run in background (with
>> &)
>> +             # so redirect output to "actual"
>> +             echo fake: "$@" > actual
>> +     fi
>> +     EOF
>
> There is a period where fake_browser_ran exists, but nothing is in
> actual. You can solve it by setting fake_browser_ran at the end rather
> than the beginning.
>
> Or you can drop fake_browser_ran entirely, and just atomically move
> actual into place, like:
>
>   echo "fake: $*" >actual.tmp
>   mv actual.tmp actual
>
> and then tes-t_web_browse can just spin waiting for "actual" to appear.
Not exactly, because, as I see, "actual" file is a result of redirection of
> git web--browse --browser="$1" "$2" >actual &&
command
>
> -Peff
