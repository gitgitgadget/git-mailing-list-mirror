From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strtoul_ui: reject negative values
Date: Thu, 17 Sep 2015 09:18:17 -0700
Message-ID: <xmqqpp1hj9yu.fsf@gitster.mtv.corp.google.com>
References: <1442500646-15293-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, max@max630.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:18:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcbtA-0003NV-M3
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbbIQQSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:18:20 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33919 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbIQQST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:18:19 -0400
Received: by padhy16 with SMTP id hy16so23775097pad.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 09:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=omK1iiMk704GG9cmhSfuX8YyMxLmrkpgFcdqHBT+rNw=;
        b=epNJ3qmTfypklMcuXNrg8M10MFOIchvZi5UvM4ngB6a8tpUDvj5E8hLQ8EO8ewpm62
         /KRVviCaCdfTaUph37vrdAmyHdBWkxnuru61Vle/ITAo625ufLOW7dbyMzB8Gtgz2bGw
         CMOvI1GSxkixGB/takQPBDG/qp+rcaojVwxTmKeKVxf2o1h8WZpsgMMbOYSI7u8vXpJV
         xO8zbKVJUAiztMoXettZQky04A/PwcJCfjDpKVqlbD0Z/ToORnIQAL7i2qWaMI5tEHx9
         9TVYKZVA38mR7nM7WCkB9KSqy6weCr/tSl8WVYTS2cL8PPdcxWeNDsvSABa2nSm3DtOf
         +85g==
X-Received: by 10.68.111.3 with SMTP id ie3mr74757002pbb.63.1442506698847;
        Thu, 17 Sep 2015 09:18:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id iy1sm4267210pbb.85.2015.09.17.09.18.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 09:18:18 -0700 (PDT)
In-Reply-To: <1442500646-15293-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 17 Sep 2015 16:37:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278129>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This patch catches negative values before it's too late, i.e. before
> calling strtoul. We still silently accept very large integers that wrap
> to a valid "unsigned int".

Is the last statement correct?  A very large long uint that wrap to
uint would not fit in long uint and you would get ERANGE, no?

> So, here's a proper patch (I mean, a band-aid patch, but properly
> send ;-) ).

Yup.

> It should be merged before Kartik's series (or inserted at the start
> of the series) so that we get the fix before the test breakage.

Which one of his series?

>
>  git-compat-util.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f649e81..1df82fa 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -814,6 +814,9 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>  	char *p;
>  
>  	errno = 0;
> +	/* negative values would be accepted by strtoul */
> +	if (strchr(s, '-'))
> +		return -1;
>  	ul = strtoul(s, &p, base);
>  	if (errno || *p || p == s || (unsigned int) ul != ul)
>  		return -1;
