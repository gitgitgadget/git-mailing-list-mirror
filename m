From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] status: give more information during rebase -i
Date: Wed, 01 Jul 2015 09:36:24 -0700
Message-ID: <xmqqvbe3al87.fsf@gitster.dls.corp.google.com>
References: <vpq7fqkz48f.fsf@anie.imag.fr>
	<1435739433-18853-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435739433-18853-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com>
	<CAPig+cSXzN84C4tOi5oZaK_1UJGcNXywE_-V7CyDQUMXox1Acw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 18:36:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAKzw-0006Ud-BZ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 18:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbbGAQg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 12:36:27 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33465 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbbGAQg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 12:36:26 -0400
Received: by igcur8 with SMTP id ur8so96082700igc.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wDG3IiN7Nr4Oywrk/9wr/aK1WCap1q+DNjjB04YCXOA=;
        b=rREdvuUHm9CUTpd5MryFBmfPZC0p6H1cEGp8XW8nT+XH0WRRve0zH8Ew9i+wwjlT+9
         pmS56HtY2RzAeB2zVIyq+iayNVAI0k9UkBp0iQtFDTXRQAn/rVgjkAyFgOK4YIYd7Phr
         CI5u7uQgnF0Hp0IL4ZzOYWXgufrIM927hq0pWbIgEX0SnChLC1/JJKKLkTdegMYG55ZI
         zqnRFNYgyY5r4ABJet1k/QmTYJYTEDbrCiyQOMKkGpWsMn2FpQTlbOej9Xb7SzucCo50
         1x0ajxPsgTcweoUb/IrZE+RPBA4VdbZioRqvfzhfRwU08/jLHtzJ3+S985KBD749cC1J
         X/bQ==
X-Received: by 10.43.66.5 with SMTP id xo5mr5172420icb.57.1435768585934;
        Wed, 01 Jul 2015 09:36:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id b140sm1720749ioe.9.2015.07.01.09.36.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 09:36:25 -0700 (PDT)
In-Reply-To: <CAPig+cSXzN84C4tOi5oZaK_1UJGcNXywE_-V7CyDQUMXox1Acw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 1 Jul 2015 12:33:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273160>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I was about to mention the same shortcoming, but you beat me to it.
>
>> Perhaps be more strict and do this instead (without
>> leading strbuf_trim):
>>
>>         if (!get_sha1_hex(split[1]->buf, sha1) &&
>>             !strcmp(split[1]->buf + 40, " ") {
>>                 replace split[1] with "%s " abbrev
>>         }
>
> Isn't it dangerous to assume that you can index 40 characters into
> split[1]? If (for some reason), the user botched the todo line such
> that the SHA1 is no longer a valid hex string, then split[1] will be
> that botched string, which might be shorter than 40 characters. For
> instance, if the user-edited todo line is:
>
>     pick oops nothing
>
> then git-rebase--interactive.sh:transform_todo_ids() will leave "oops"
> as-is, since it can't unabbreviate it, and then this code will place
> "oops" into split[1].

Yeah, that is why get_sha1_hex() is checked before we try to make
sure buf[40] has " " in the code snippet you quoted.

Isn't that how && short-cut works?
