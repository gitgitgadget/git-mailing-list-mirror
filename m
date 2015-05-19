From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-bitmaps: plug memory leak, fix allocation size for recent_bitmaps
Date: Tue, 19 May 2015 12:45:46 -0700
Message-ID: <xmqqoalg73md.fsf@gitster.dls.corp.google.com>
References: <555A7499.7090900@web.de> <20150519022321.GA29026@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Vicent Marti <tanoku@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 19 21:46:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YunSb-0002eN-Re
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 21:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbbESTpt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2015 15:45:49 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34310 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbESTps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 15:45:48 -0400
Received: by igbhj9 with SMTP id hj9so43048160igb.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=qh2e3orhh+Z6OJnZgwr6LFaOubTfS29ExY0XJs5frlQ=;
        b=lqagQwiFzpeOocTxPIKEIu3kuX4L0fXyuhYED11/HQ9sVDFME+H3TlyxFozgrX4Sau
         J2rOwqfMVrTtqMQrsL8te0NngFytU18f/H9M0JxKj4FYtN2j8SKYUfoVR/bKIeqbXZGY
         HgAKOWZ0FwBCKiuNXDCOMjW/JRW4vBmGgqMsi9uyugoVDxZRlRNN/NKUNrJ/9yTylkhq
         Eu0wE5vYjzqddOlam2Fkhjr4lmObx0no1968XEsaNvOmlFrC8hgIfIaRw5Bfr207e8VT
         u8IAiiPHCq1S7InSLw0+FApkqygx1uET+sP0qOpgC5pHkKG/Iu/RX9E8Ld6kViAgxlFM
         fL8Q==
X-Received: by 10.50.80.19 with SMTP id n19mr23616380igx.30.1432064747671;
        Tue, 19 May 2015 12:45:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id f126sm10667286ioe.21.2015.05.19.12.45.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 12:45:47 -0700 (PDT)
In-Reply-To: <20150519022321.GA29026@peff.net> (Jeff King's message of "Mon,
	18 May 2015 22:23:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269394>

Jeff King <peff@peff.net> writes:

> On Tue, May 19, 2015 at 01:24:09AM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Use an automatic variable for recent_bitmaps, an array of pointers.
>> This way we don't allocate too much and don't have to free the memor=
y
>> at the end.  The old code over-allocated because it reserved enough
>> memory to store all of the structs it is only pointing to and never
>> freed it.  160 64-bit pointers take up 1280 bytes, which is not too
>> much to be placed on the stack.
>>=20
>> MAX_XOR_OFFSET is turned into a preprocessor constant to make it
>> constant enough for use in an non-variable array declaration.
>>=20
>> Noticed-by: Stefan Beller <stefanbeller@gmail.com>
>> Suggested-by: Jeff King <peff@peff.net>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> This seems to have fallen through the cracks, or did I just miss it?
>
> Thanks, this looks good.
>
> I looked over the function one more time to make sure it is the funct=
ion
> that is wrong, and not my suggestion. :) The current code seems prett=
y
> obviously wrong.

I actually cannot guess what the current code is trying to do.  Was
it an attempt to cache that many entries, but instead allocated and
discarded the space it tried to use as a cache every time?
