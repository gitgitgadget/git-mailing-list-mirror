Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A6CC433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 08:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbiA2IIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 03:08:39 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:62507 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241955AbiA2IIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 03:08:38 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Jm6Qr0CjWz5tl9;
        Sat, 29 Jan 2022 09:08:34 +0100 (CET)
Message-ID: <f7468ea3-d9f6-96be-168d-de610d535e72@kdbg.org>
Date:   Sat, 29 Jan 2022 09:08:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/4] i18n: factorize more 'incompatible options'
 messages
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
 <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
 <844e01391e1198960072844536d736f51573cac6.1643408644.git.gitgitgadget@gmail.com>
 <7f46e276-b669-e8fe-21fd-6b43f5bfb33b@kdbg.org> <xmqqee4rtnts.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqee4rtnts.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.01.22 um 00:58 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> A bit of code duplication could be avoided if die_if_incompatible_opt3()
>> forwarded with an additional pair 0, "" to die_if_incompatible_opt4().
> 
> I wondered if a single varargs function
> 
>     void die_if_incompatible_optN(const char *name1, int opt1, ...);
> 
> that takes a name=NULL terminated sequence of <name, opt> would
> work, but
> 
>  (1) it would require the caller to always spell out the terminating
>      NULL, which may be ugly.
> 
>  (2) it would tempt people to programatically generate message for N
>      options, which leads to sentence lego, which is the exact
>      opposite of what this series wants to achieve.

The reason I did not suggest a varargs version is because

  (3) it is not typesafe.

A varargs implementation could be used as an implementation helper, but
should not be a public interface.

> In any case, I do agree with you that the callers of _opt3()
> variants can just pass (0, "unused") in the 4-th slot.  If this were
> made varargs, then it only needs to pass NULL at the end, so that
> might be an improvement, though.
> 
> Also, isn't "if" in the name of the function misleading?  as far as
> I can tell, this function is not "check if these options are
> compatible and die if some are incompatible with each other", but
> the caller is convinced that these options are incompatible before
> it decides to call this function and there is no "if" in what this
> function can do.

Good point.

> void die_for_incompatible_opts(const char *name1, int opt1, ...)
> {
> 	const char *name[4];
> 	int count = 0;
>         va_list params;
> 
>         va_start(params, name1);
> 
>         if (opt1)
> 	        name[count++] = name1;
>         while (count < ARRAY_SIZE(name)) {
>                 const char *n = va_arg(params, const char *);
> 
>                 if (!n)
> 			break;
>                 if (va_arg(params, int))
> 	                name[count++] = n;
>         }
>         va_end(params);
> 
>         switch (count) {
> 	default:
> 		BUG("die-for-incompatible-opts can only take up to %d args",
> 		    ARRAY_SIZE(name));

The problems here are: (1) this case triggers only if there is an actual
invocation with all 5+ incompatible options, and (2) at that time, the
out-of-bounds write to the name array has already happened.

I know this implementation is just a rough show-case. But since it's
been written by a very proficient mind, I'm now convinced: it's not
sufficiently easy to write the varargs version, so let's not go there.

> 	case 4:
> 		die(_("options '%s', '%s', '%s', and '%s'"
> 		      " cannot be used together"),
> 		    name[0], name[1], name[2], name[3]);
> 		break;
> 	case 3:
> 		die(_("options '%s', '%s', and '%s'"
> 		      " cannot be used together"),
> 		    name[0], name[1], name[2]);
> 		break;
> 	...
> 	}
> }
> 
> might be easier to extend when somebody discovers there needs the
> "opt5" variant. 

-- Hannes
