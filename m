From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Mon, 22 Sep 2014 23:26:14 -0700
Message-ID: <CAPc5daUbXtNXSn8_tspvdF+SH5aeX+jVJTramtOm96Dc1wCqtg@mail.gmail.com>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
 <xmqqk34vlfhz.fsf@gitster.dls.corp.google.com> <CAPig+cTAFaG5H8rmf1jrvFwr_OOH7u19JMKDUE12UddokUmfaQ@mail.gmail.com>
 <20140923060407.GA23861@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 08:26:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWJYe-00057V-NW
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 08:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbaIWG0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 02:26:37 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:35265 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaIWG0g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 02:26:36 -0400
Received: by mail-la0-f53.google.com with SMTP id ge10so7877720lab.26
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 23:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UtAy/dKzrE8CKrZxtp9vTUfviXgTJAAhabtcBW17KQQ=;
        b=Kn9dNDBPV83C3k282m72QhRYcsVu3E9Huj5gd2fLRXL+PjWoOxqCBECIUN7ZbJ++VT
         jiAohaHVE/cATYKR1LLcuCVcm21Yp0lcAY7Dcy5hlpcpmO5odeDsyTIzm0RqAfvt03r1
         9z7/oyVqdV/MBiic/H/aOGVrPmQWve5IuZ3cz1hI7G/jfFJGU8/Zaa/dUZLCBoJY/AvM
         e7nUPzwGo7Eofe0A7ZBPIXMC9xP/i0EPOC+UVpuQot4yLg813C+KCrJvIVx6cTN7T1o0
         zaogfgfEM8eAmLVksHPWbFIPVDWV28eUMx2Rb9OWFThfbYlXmoGKyMxBE5ucI5/XksHb
         l2eQ==
X-Received: by 10.152.28.134 with SMTP id b6mr30356376lah.33.1411453594731;
 Mon, 22 Sep 2014 23:26:34 -0700 (PDT)
Received: by 10.112.209.35 with HTTP; Mon, 22 Sep 2014 23:26:14 -0700 (PDT)
In-Reply-To: <20140923060407.GA23861@peff.net>
X-Google-Sender-Auth: IA1U5WEx2jSaHwNGn0sPe-Qybko
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257394>

On Mon, Sep 22, 2014 at 11:04 PM, Jeff King <peff@peff.net> wrote:
>
> I don't mind silencing this one warning (even though I find it a little
> ridiculous). I'm slightly concerned that more brain-damage may be coming
> our way, but we can deal with that if it ever does.
>
> Like Junio, I prefer keeping strlen() rather than switching to sizeof,
> as it is less error-prone (no need for extra "-1" dance, and it won't
> silently do the wrong thing if the array is ever converted to a
> pointer).

I actually do not mind losing the sample[] array too much.

The early 45 bytes or so of that array (or a string constant) is not used
by the code at all; I didn't want to count "From " (that's 5), 40-hex and
then a SP -- ah, see, it is 46 bytes and I didn't want such miscounting.
The only real contents that matter in that sample[] array is the tail part
that is meant as the magic(5) cue. I'd be OK if the code checked the
length of the line against a hardcoded constant and then did strcmp()
starting from a hardcoded offset of the string and the magic cue string,
and that would also avoid the warning from Eric's compiler.

But personally, I think the way it is coded is much easier to read,
and is much harder to get it wrong while maintaining it.  So...
