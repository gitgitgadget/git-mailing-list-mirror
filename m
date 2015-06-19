From: =?ISO-8859-2?Q?Jakub_Nar=EAbski?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] Move unsigned long option parsing out of pack-objects.c
Date: Fri, 19 Jun 2015 20:47:16 +0200
Message-ID: <558463B4.3080904@gmail.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>	<1434705059-2793-3-git-send-email-charles@hashpling.org> <xmqq7fqza8bo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 20:47:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z61KH-0002xz-9v
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 20:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbbFSSri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 14:47:38 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38893 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbbFSSrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 14:47:36 -0400
Received: by wibdq8 with SMTP id dq8so26372568wib.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wyB8cdVu4prvgc9lSqKJ6OHhL4k2EhAlUjYVYyz+snY=;
        b=LqO7orpPsj8CvDA66sBT+eb0xKYdPBFKbwJwzu+tzN4F5B9whVGFiBHhrhjdUCQZie
         da4wElRfxEuJk+eo8Dd0H01T7NkJfy751uRMaFy+6rdXSexPSKqc1zjzxRFonpCYDQBB
         nu+I5oTTNt79ywYflNXANI4KdpHjtBA2FAjv76qY9akPkkolRSC2I48pCN5oLgDME4rG
         aZ0YDAuM2WZEbMgBCLPKg/Rpl4YuSMg+EV6DBvxA4/AEqyCKHQ6nhyQCuM0M0fxPIuXP
         wCXP/aCw32d/DOQmfP05xnW4V4X7R7TZ65/EwqI9d3hiASNKsaiUnRXbzR9I9OW+t/SZ
         UL6g==
X-Received: by 10.181.11.229 with SMTP id el5mr9381669wid.40.1434739655576;
        Fri, 19 Jun 2015 11:47:35 -0700 (PDT)
Received: from [192.168.1.53] (abre142.neoplus.adsl.tpnet.pl. [83.8.98.142])
        by mx.google.com with ESMTPSA id bc9sm18195427wjc.28.2015.06.19.11.47.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2015 11:47:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqq7fqza8bo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272182>

W dniu 2015-06-19 o 19:58, Junio C Hamano pisze:
> Charles Bailey <charles@hashpling.org> writes: 
[...]
>> +		if (!git_parse_ulong(arg, opt->value))
>> +			return opterror(opt, "expects a numerical value", flags);
> 
> This used to be:
> 
>> -		die(_("unable to parse value '%s' for option %s"),
>> -		    arg, opt->long_name);
> 
> but opterror() talks about which option, so there is no information
> loss by losing "for option %s" from here.  That means there is only
> one difference for pack-objects:
> 
>     $ git pack-objects --max-pack-size=1T
>     fatal: unable to parse value '1T' for option max-pack-size
>     $ ./git pack-objects --max-pack-size=1T
>     error: option `max-pack-size' expects a numerical value
>     usage: git pack-objects --stdout [options...
>     ... 30 more lines omitted ...
> 
> Eh, make that two:
> 
>  * We no longer say what value we did not like.  The user presumably
>    knows what he typed, so this is only a minor loss.

Well, in this case this is not a problem, but for longer commandline
invocation it might be hard to find the exact argument among all the
options (though I don't think there is any integer-accepting option
that can be repeated).
> 
>  * We used to stop without giving "usage", as the error message was
>    specific enough.  We now spew descriptions on other options
>    unrelated to the specific error the user may want to concentrate
>    on.  Perhaps this is a minor regression.
> 
> I wonder if "expects a numerical value" is the best way to say this.

Is "expects numerical value" easier to understand than "unable to
parse value"?
 
> Ponder:
> 
>  - we do not take "4.8"

   - we won't take locale specific "4,8" (for some locales)

   - "4O" is not numerical... "40" is

>  - we do not take "-4".
>  - people may not realize, from "numerical", that we take "5M".
> 
> Except for the minor nits above, I think this is a good change.
> 
> This is a totally unrelated tangent that does not have to be part of
> your series, but we probably should take "4.8M"; I do not think we
> currently do.
> 
> Oh, and perhaps 1T, too.
> 
