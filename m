From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] refs.c: repack_without_refs may be called without error
 string buffer
Date: Thu, 20 Nov 2014 10:36:52 -0800
Message-ID: <CAL=YDWkZcoXBreoPyf1EnSmYcaUPFCPW8tGkCNaD+is2hOiR_g@mail.gmail.com>
References: <1416506666-5989-1-git-send-email-sbeller@google.com>
	<1416507040-6576-1-git-send-email-sbeller@google.com>
	<20141120183523.GD15945@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWbB-0004B6-RR
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757939AbaKTSgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:36:54 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:37302 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757530AbaKTSgx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:36:53 -0500
Received: by mail-vc0-f170.google.com with SMTP id hy4so1090493vcb.15
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 10:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QRviqxZeVumrYiB+1qeXatLYulnebFeMlkgonEXbBZU=;
        b=NhHfb9dKIOl2gF2vtwI0kWjnDtaBtWdDBH4OcuOg1eox+EUx/YW9TtiOd5zprktcZB
         9MGNeLIw624LSGlAQ3071JGSXafTaWn8Kz6XNtBNLB41lk4AK05zPOLgO2MbsgNWUHjO
         DDiX03Rnzr1d6O8IU5k9LQDGkBEvu+BYq5v7H8C5wVJ7f4cCgv76RY8m64b6ARu9qC5M
         uTdfgtGXv3+N2QCu/DP4mW76tH9jvIxlS+Mzb1cUI6NYvy8DiYwojn2gXxEHkzdX8OOG
         A2mvzMUMpT7whDUNRqwt7Np5FBblx1HKzAFqjH/pv8L+aDA0UppYK2y67nr0GwX+naZZ
         tYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QRviqxZeVumrYiB+1qeXatLYulnebFeMlkgonEXbBZU=;
        b=C+gKl6rzQbySVmLw5TO73+5z3pizBfb6lcgRTw3gnF6IX513q0wXGA10p9yxRmhiV1
         iOzzDMQVvf89HMw93qC3P18wKaWTh+Sq3tZVIF/HDwMKruF0O4TzxSQrT+npwJ01fEbr
         syJ9Y4Aqv0PqkIkL5XMNLnU+6uwVeHdhWj5I8PVJxvB1tVJZG1sq3BUBNDPTS1/DGx8q
         CeLlgzwt9VAjuEfMKdXYcjCIzy+HTGBTgvsgjo7II27UtFE0WLK9LAduiVGXyb0uuK6Y
         TSm8ibOWKZA4VlRgZsZUfuJES48jVvwIUTSF2fziw6YO3ljHiU0yxeVzR929JKogXRob
         e9IA==
X-Gm-Message-State: ALoCoQm+hoTZE5nEyiQXROPz49ovMytRS3XliuNRI9jhrsKONJ26fpXy3YVLiO2TjvuS2rCs2tFz
X-Received: by 10.53.13.10 with SMTP id eu10mr38455165vdd.21.1416508612543;
 Thu, 20 Nov 2014 10:36:52 -0800 (PST)
Received: by 10.52.76.167 with HTTP; Thu, 20 Nov 2014 10:36:52 -0800 (PST)
In-Reply-To: <20141120183523.GD15945@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 10:35 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> If we don't pass in the error string buffer, we skip over all
>> parts dealing with preparing error messages.
>
> Please no.
>
> We tried this with the ref transaction code.  When someone wants
> to silence the message, it is cheap enough to do
>
>         struct strbuf ignore = STRBUF_INIT;
>
>         if (thing_that_can_fail_in_an_ignorable_way(..., &ignore)) {
>                 ... handle the failure ...
>         }
>
> The extra lines of code make it obvious that the error message is
> being dropped, which is a very good thing.  The extra work to format a
> message in the error case is not so bad and can be mitigated if the
> error is a common normal case by passing a flag to not consider it an
> error.
>
> Silently losing good diagnostic messages when err == NULL would have
> the opposite effect: when there isn't a spare strbuf to put errors in
> around, it would be tempting for people coding in a hurry to just pass
> NULL, and to readers it would look at first glance like "oh, an
> optional paramter was not passed and we are getting the good default
> behavior".
>
> This is not a theoretical concern --- it actually happened.
>

Fair enough.
Un-LGTM my message above.



> My two cents,
> Jonathan
