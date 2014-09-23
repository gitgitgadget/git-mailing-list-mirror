From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Tue, 23 Sep 2014 03:58:11 -0400
Message-ID: <CAPig+cRZ++QF0az2+1H1QqECqPVdK-99T=R7EN02FfReV7C6UA@mail.gmail.com>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
	<xmqqk34vlfhz.fsf@gitster.dls.corp.google.com>
	<CAPig+cTAFaG5H8rmf1jrvFwr_OOH7u19JMKDUE12UddokUmfaQ@mail.gmail.com>
	<20140923060407.GA23861@peff.net>
	<CAPc5daUbXtNXSn8_tspvdF+SH5aeX+jVJTramtOm96Dc1wCqtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 09:58:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWKzO-00032Z-4m
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 09:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbaIWH6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 03:58:13 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:33989 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbaIWH6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 03:58:12 -0400
Received: by mail-yh0-f42.google.com with SMTP id b6so2550678yha.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 00:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uqFV/LD/2wD56yina2kI+G59dLTsltZqm+L0EcB/jOc=;
        b=hQ9L8GEBPRR9Hyi2jer/idsWTci7lrv8K1544zQ0+EeQmNA5ckpzmzrFeP+ohM5FlS
         iyRk8Kwd1HqwVTHNvDwCcgnEtCPqSt6vMExpAg4GFi/SsQ89KiFR+2hBCuaHk44XID8U
         +CEDMi0bb4VL1TAmIXLF/XNdUBQU3Po2NjAfq75DcrXvTs1/0rIDmnyvjv4dR9+W9dMV
         NEwQ0NP0b2uISF/yoxbaQkzAvtRiMnVjl3QeN5GD13x4LI2Fv09t6lSlB0hEQiFCIDS7
         2Y6VkDdU0omXTkFxLYMNEBU0uF41aU6Huj+jVVnWvf3fEewqdiDZq/T6mE5wL/G8F3yR
         hAiQ==
X-Received: by 10.236.82.132 with SMTP id o4mr7578630yhe.86.1411459091500;
 Tue, 23 Sep 2014 00:58:11 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Tue, 23 Sep 2014 00:58:11 -0700 (PDT)
In-Reply-To: <CAPc5daUbXtNXSn8_tspvdF+SH5aeX+jVJTramtOm96Dc1wCqtg@mail.gmail.com>
X-Google-Sender-Auth: -Tod6EalEPVaHsz-8CwMLC_HqV8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257400>

On Tue, Sep 23, 2014 at 2:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Sep 22, 2014 at 11:04 PM, Jeff King <peff@peff.net> wrote:
>>
>> I don't mind silencing this one warning (even though I find it a little
>> ridiculous). I'm slightly concerned that more brain-damage may be coming
>> our way, but we can deal with that if it ever does.
>>
>> Like Junio, I prefer keeping strlen() rather than switching to sizeof,
>> as it is less error-prone (no need for extra "-1" dance, and it won't
>> silently do the wrong thing if the array is ever converted to a
>> pointer).
>
> I actually do not mind losing the sample[] array too much.
>
> The early 45 bytes or so of that array (or a string constant) is not used
> by the code at all; I didn't want to count "From " (that's 5), 40-hex and
> then a SP -- ah, see, it is 46 bytes and I didn't want such miscounting.
> The only real contents that matter in that sample[] array is the tail part
> that is meant as the magic(5) cue. I'd be OK if the code checked the
> length of the line against a hardcoded constant and then did strcmp()
> starting from a hardcoded offset of the string and the magic cue string,
> and that would also avoid the warning from Eric's compiler.

The -Wstring-plus-int option is "smart" enough to suppress the warning
if the hardcoded offset falls within the bounds of the string literal,
so this could work (but it feels a bit fragile compared to the current
code).

> But personally, I think the way it is coded is much easier to read,
> and is much harder to get it wrong while maintaining it.  So...
