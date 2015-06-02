From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ewah/bitmap: silence warning about MASK macro redefinition
Date: Tue, 02 Jun 2015 15:15:09 -0700
Message-ID: <xmqqegltzriq.fsf@gitster.dls.corp.google.com>
References: <1433281675-24893-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 00:15:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzuSt-0005ZZ-88
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 00:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbbFBWPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 18:15:15 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35246 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbbFBWPN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 18:15:13 -0400
Received: by iesa3 with SMTP id a3so398309ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rfSowgo3aaflLoApOYJFr+UDPDq4Sy7KQmmn5QxcKHQ=;
        b=wuMOX9FNm0gZRJ+8fKU3JnRkvETw5g/COlZkouITMu/cTwroGdh9EmF687tKauTWT1
         V/R+Jk4m05Ft+riz1ZPTY9v8Hju4dFL6MRSV/YhGQMDlxHmIUpayIy0rPc9/Fwjd0qXT
         cIojyd7IFb6zxrGgbczYoIEo/9jkDR1sCQ30RQj8jk/x0eaYwad8NsUiW5CNMGhMILu3
         Pzm1D4Y+DBUSUkxHVnmTgCbEGpoy4HSDPwerGej8M29JLy97WinB63jT3tDCj2VDaCOY
         BFAo/yRbUWdY0tgOqAIAck0pofZ5si2clZldHsN35wmnf58pKLdbUAO9E0jsRxuqC0xp
         BpvQ==
X-Received: by 10.107.130.218 with SMTP id m87mr35166815ioi.62.1433283312427;
        Tue, 02 Jun 2015 15:15:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id k16sm10855090igf.19.2015.06.02.15.15.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 15:15:11 -0700 (PDT)
In-Reply-To: <1433281675-24893-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Tue, 2 Jun 2015 17:47:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270616>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On PowerPC Mac OS X (10.5.8 "Leopard" with Xcode 3.1), system header
> /usr/include/ppc/param.h[1] pollutes the preprocessor namespace with a
> macro generically named MASK. This conflicts with the same-named macro
> in ewah/bitmap.c.
>
> [1]: Included indirectly via:
>      git-compat-util.h ->
>      sys/sysctl.h ->
>      sys/ucred.h ->
>      sys/param.h ->
>      machine/param.h ->
>      ppc/param.h
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> The alternative is to rename MASK in ewah/bitmap.c to something less
> generic, resulting in a slightly more noisy patch. I chose the #undef
> approach since it's a relatively common idiom to #undef a macro before
> #defining it in order to avoid exactly this sort of redefinition
> problem.

I agree that there is nothing controversial against this use of
#undef; I however wonder if we are stomping on _their_ use of MASK
and breaking whatever Mac OS X wants to express with that macro,
though (in which case, hiding collision like this may not be
sufficient and we have to live with the poor implementation choice
made by the header file and change the macro _we_ use).

Will queue.  Thanks.

>  ewah/bitmap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/ewah/bitmap.c b/ewah/bitmap.c
> index 710e58c..b31cf75 100644
> --- a/ewah/bitmap.c
> +++ b/ewah/bitmap.c
> @@ -20,6 +20,8 @@
>  #include "git-compat-util.h"
>  #include "ewok.h"
>  
> +#undef MASK
> +#undef BLOCK
>  #define MASK(x) ((eword_t)1 << (x % BITS_IN_WORD))
>  #define BLOCK(x) (x / BITS_IN_WORD)
