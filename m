From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] "am" state file fix with write_file() clean-up
Date: Mon, 24 Aug 2015 12:57:38 -0700
Message-ID: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
References: <20150824065033.GA4124@sigill.intra.peff.net>
	<1440436186-7894-1-git-send-email-gitster@pobox.com>
	<20150824174142.GA4794@sigill.intra.peff.net>
	<xmqqlhd04ko4.fsf@gitster.dls.corp.google.com>
	<20150824183554.GA5883@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 24 21:57:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTxsK-00043F-0O
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 21:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbbHXT5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 15:57:41 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33020 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbbHXT5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 15:57:40 -0400
Received: by pacti10 with SMTP id ti10so31091397pac.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2CR9Xgrjo7xJjRcG9T+foNRkccqD6c2joBCINWrMgLw=;
        b=04eit0oeXhl8kbNvNRX1fCjOQBj5IjS5M9RbBX7ljWSQNBa66e8Usleu+3DaZ70+wh
         0OLHkVW8gxnR+1+HcuoiXGnNELVgyl1XGLEjiNlGW5Hrc948OaFa363Po2Z2PwKCjHIp
         3c0vKtG/1HHPQomMJYA8VBRG8UEq5eQrgY2u+Yh9Bk3cbX8ovZNtHU1D1JF+K7MgygDH
         Ov3T0cJbsvY5qvfOBjWpKYFqoAYeU06rEZw8TIDgMxqvnqV/funT4BcZqJk1vacjHZQm
         LkLmitfKz6YHwUkrTKIZsTM/lbbYx8BDZ65lfztEkOyaXjQKcvZhSOGjxQb8iF8T+iaD
         ksIw==
X-Received: by 10.66.255.42 with SMTP id an10mr47956591pad.107.1440446260003;
        Mon, 24 Aug 2015 12:57:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id df2sm11920540pad.19.2015.08.24.12.57.39
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 12:57:39 -0700 (PDT)
In-Reply-To: <20150824183554.GA5883@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Aug 2015 14:35:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276479>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 24, 2015 at 11:15:55AM -0700, Junio C Hamano wrote:
>
>> > This all looks good to me. The topics-in-flight compatibility stuff in
>> > patches 3 and 5 is neatly done. Usually I would just cheat and change
>> > the order of arguments to make the compiler notice such problems, but
>> > that's hard to do here because of the varargs (you cannot just bump
>> > "flags" to the end).
>> 
>> Actually, I think my compatibility stuff is worthless.  It would not
>> catch new callers that wants to only probe and do their own error
>> handling by passing 0 (and besides, assert() is a shoddy way to do
>> this---there is no guarantee that tests will trigger all the
>> codepaths in the first place).
>
> Oh, hrm, you're right. I was focused on making sure the common 1-passers
> were not broken, but patch 3 does break 0-passers (obviously, because
> they needed updated in the same patch ;) ).
>
> And I do agree that build-time assertions are much better than run-time
> ones.
>
>> We should deprecate and remove write_file() by renaming the one with
>> the updated semantics to something else, possibly with a backward
>> compatiblity thin wrapper around it that is called write_file(), or
>> without it to force a link-time error.
>
> That sounds reasonable. Maybe "format_to_file" or something?

I am going into a slightly different tangent.  Binary support is not
something we need right now, so I'll keep the door open for that in
the future by

 - drop the "int fatal" altogether from write_file() without adding
   "unsigned flags";

 - add write_file_gently(), again without "unsigned flags";

 - make them call write_file_v() that takes "unsigned flags" and
   va_list.

I earlier said there were 2 oddball callers, one of them being
suspicious, but it turns out that there are 3 callers that want
write_file_gently().  Only the one in the setup codepath is asking
for "fatal=0" while discarding the error return, which is
suspicious; other two are handling an error themselves and are OK.
