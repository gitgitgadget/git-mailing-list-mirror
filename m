From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/4] status: give more information during rebase -i
Date: Wed, 1 Jul 2015 12:37:44 -0400
Message-ID: <CAPig+cTAQ8UkymNdp6_rwhs=7LOG7SiHmdhMX79GSu9NZ6g2cw@mail.gmail.com>
References: <vpq7fqkz48f.fsf@anie.imag.fr>
	<1435739433-18853-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435739433-18853-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com>
	<CAPig+cSXzN84C4tOi5oZaK_1UJGcNXywE_-V7CyDQUMXox1Acw@mail.gmail.com>
	<xmqqvbe3al87.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 18:37:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAL1C-0007DI-PT
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 18:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbbGAQhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 12:37:47 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34094 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbGAQhp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 12:37:45 -0400
Received: by ykfy125 with SMTP id y125so44084889ykf.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pfIGG5Bj4B3oHUHcjvS3TdOqXpns/B4c5o+xMcYjQLA=;
        b=q0FPZueRZU61eUgeIKV/nRczUfOPm8e5hVvZab8X9jN3C4CMoZ3QccsepDoCJORdwG
         LZbuWuOg7PEwT6hEf0QRWrOz8N4bys8All3F8JOu5h0pyDv2bkn5Zd+5CXQHv5drICYm
         CkHYhxwRohfU/IO+x08adVLGAaQS1LhP/vdjWg/s4nQ2vKDQwxPNoQpGE2zwh/Ir3Xmn
         DhKy6vwadrDFXZRF4/UYEgyL7oyNiuj31InwaDD3G288BAnA8CTSiLzLVE0oy+cRkxbB
         eS9+tnuaB+eBCAXsvXprwCbA0v735UwqDJPqdVZyOtVVUxXrxTs4J8X6NaRoIYQSV3Gy
         iNyQ==
X-Received: by 10.129.50.207 with SMTP id y198mr33180191ywy.39.1435768664782;
 Wed, 01 Jul 2015 09:37:44 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 1 Jul 2015 09:37:44 -0700 (PDT)
In-Reply-To: <xmqqvbe3al87.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: QO3A3CYtOpJNA3x3wGnO74frd0E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273161>

On Wed, Jul 1, 2015 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> I was about to mention the same shortcoming, but you beat me to it.
>>
>>> Perhaps be more strict and do this instead (without
>>> leading strbuf_trim):
>>>
>>>         if (!get_sha1_hex(split[1]->buf, sha1) &&
>>>             !strcmp(split[1]->buf + 40, " ") {
>>>                 replace split[1] with "%s " abbrev
>>>         }
>>
>> Isn't it dangerous to assume that you can index 40 characters into
>> split[1]? If (for some reason), the user botched the todo line such
>> that the SHA1 is no longer a valid hex string, then split[1] will be
>> that botched string, which might be shorter than 40 characters. For
>> instance, if the user-edited todo line is:
>>
>>     pick oops nothing
>>
>> then git-rebase--interactive.sh:transform_todo_ids() will leave "oops"
>> as-is, since it can't unabbreviate it, and then this code will place
>> "oops" into split[1].
>
> Yeah, that is why get_sha1_hex() is checked before we try to make
> sure buf[40] has " " in the code snippet you quoted.
>
> Isn't that how && short-cut works?

Argh, I misread the code. Sorry for the noise.
