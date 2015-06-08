From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] utf8.c: print warning about disabled iconv
Date: Mon, 08 Jun 2015 14:14:48 -0700
Message-ID: <xmqqoakp9a2f.fsf@gitster.dls.corp.google.com>
References: <1433624551-20730-1-git-send-email-max@max630.net>
	<xmqqfv62ch0v.fsf@gitster.dls.corp.google.com>
	<20150608210705.GA22850@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:15:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z24No-0004V2-Bn
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 23:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbbFHVOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 17:14:54 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33592 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbbFHVOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 17:14:51 -0400
Received: by iebgx4 with SMTP id gx4so2042578ieb.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fiDJnsN0eigzEGvBsEj+52gnEaQVbdblnz28O35T8bY=;
        b=LjXc5YQ9SkPN1pHEKyMMs8u9E5deS3cr/wlvDtExSKdzeXJxjvbOuW7Lg9bHUZifZd
         3MfheXWAEypfxdAW+tF7TQb3oMQB4hu2+bFD/Jzto88DKC5F4HJalZN5Q80oSJoxpDjA
         CzgYOwv+T/BNUDgADWZnlbhViB34+l5uOlKwRQHKLkqqK3K5iKsGDqnhYYJvNIbamhgy
         +3gzzA15i8vTRwCilsUU3tJZbzw5ILRO6dOzCfNYWGTo0NO5u3+FC26r+ZbO9bIRo+dP
         IRpdvt0Ti3qSIwQjsE2mvCrL4cS0GS2I41MdlxqrDtX/h6BAeU1zJOhbFaT6KUY/qaFe
         /y2Q==
X-Received: by 10.107.29.79 with SMTP id d76mr15285032iod.78.1433798090410;
        Mon, 08 Jun 2015 14:14:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id x4sm2542843iod.26.2015.06.08.14.14.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 14:14:49 -0700 (PDT)
In-Reply-To: <20150608210705.GA22850@wheezy.local> (Max Kirillov's message of
	"Tue, 9 Jun 2015 00:07:05 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271134>

Max Kirillov <max@max630.net> writes:

> User, in theory, can be not the same person who builds, or
> can be not aware that the case needs recoding.

Because you can pretty much say the same for build with iconv
enabled, I think that line of argument is futile.  The users do not
have control over platform's iconv (and sysadmin's choice of locale
packages) what charset/encoding can be converted to what other ones.

>> I actually am OK if the user gets exactly the same warning between
>> the two cases:
>> 
>>  - iconv failed to convert in the real reencode_string_len()
>> 
>>  - we compiled out iconv() and real conversion was asked.
>
> Does 'exactly the same' mean the same text?

No, I was trying to point out the total lack of corresponding
warnings in the iconv-enabled build.

After all, if you had to convert between UTF-8 and ISO-2022-JP, the
latter of which your system does not support, whether you use
iconv-disabled build of Git or iconv-enabled build of Git, we pass
the bytestream through, right?  Your patch gives warning for the
former (which is a good starting point if we want to warn "user
expected them to be converted, we didn't" case) but does not do
anything to the latter, even though users of the iconv-disabled
build is more likely to be aware of the potential issue (and are
likely to be willing to accept that) than the ones with
iconv-enabled build that runs on a sysmet that cannot convert the
specific encoding.
