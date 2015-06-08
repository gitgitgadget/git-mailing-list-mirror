From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] object name: introduce '^{/!-<negative pattern>}' notation
Date: Mon, 08 Jun 2015 09:39:58 -0700
Message-ID: <xmqqbngqcfxd.fsf@gitster.dls.corp.google.com>
References: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
	<1433550295-15098-3-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:40:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z205n-0005Tp-Na
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbbFHQkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:40:03 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33410 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbbFHQkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:40:01 -0400
Received: by iebgx4 with SMTP id gx4so101679243ieb.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WiOK0P/GHgtdg4kERqIXmXfTKFPyp1FDCjTXHUaWP4I=;
        b=axq1v8gW59sXaJcpaiYJW8VhLar6JclqbBZh+GMIvw2QpSy4lIOryVceMEqENTHW3B
         NVvG3rMMzvKxiNTFVsHmwnuLUMEguP3eUSnj6uk5RP8l62ZIqzSxypzNh3YEfwIYcyfL
         EIXRGSJcCZCHTFAF/na8V931DgdWNelXjUJY7O/xxDhrG+i8v8db9wpJyYAkbYU5sr7Q
         YUNwqTqjsiSDzbeaQsXDnn8dLLhjS8AQSCdRex51g4fCbsqMg10WBD1r5elxA+NI5M0b
         ucCtGJpuXGeKK7Ti9Y/9tRTap2TMf7Crz4NHtCo+WL2kzfv/l/9MtFXaW4pVc2Oztl2n
         PqqQ==
X-Received: by 10.107.3.81 with SMTP id 78mr20459098iod.33.1433781601031;
        Mon, 08 Jun 2015 09:40:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d91a:edb1:b738:fb03])
        by mx.google.com with ESMTPSA id qh9sm663436igb.20.2015.06.08.09.39.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 09:40:00 -0700 (PDT)
In-Reply-To: <1433550295-15098-3-git-send-email-wmpalmer@gmail.com> (Will
	Palmer's message of "Sat, 6 Jun 2015 01:24:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271071>

Will Palmer <wmpalmer@gmail.com> writes:

> - * For future extension, ':/!' is reserved. If you want to match a message
> - * beginning with a '!', you have to repeat the exclamation mark.
> + * For negative-matching, prefix the pattern-part with '!-', like: ':/!-WIP'.
> + *
> + * For a literal '!' character at the beginning of a pattern, you have to repeat
> + * that, like: ':/!!foo'
> + *
> + * For future extension, all other sequences beginning with ':/!' are reserved.
>   */

Good.

> diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
> index e0fe102..8a5983f 100755
> --- a/t/t1511-rev-parse-caret.sh
> +++ b/t/t1511-rev-parse-caret.sh
> @@ -19,13 +19,17 @@ test_expect_success 'setup' '
>  	echo modified >>a-blob &&
>  	git add -u &&
>  	git commit -m Modified &&
> +	git branch modref &&

This probably belongs to the previous step, no?

> +test_expect_success 'ref^{/!-}' '
> +	test_must_fail git rev-parse master^{/!-}
> +'

Hmmmm, we must fail because...?  We are looking for something that
does not contain an empty string, which by definition does not
exist.

Funny, but is correct ;-).


> +test_expect_success 'ref^{/!-.}' '
> +	test_must_fail git rev-parse master^{/!-.}
> +'

Likewise.  I however wonder if we catch a commit without any message
(which you probably have to craft with either commit-tree or
hash-object), but that falls into the "curiosity" not the
"practicality" category.

> +test_expect_success 'ref^{/!-non-existent}' '
> +	git rev-parse master >expected &&
> +	git rev-parse master^{/!-non-existent} >actual &&
> +	test_cmp expected actual
> +'

OK.

> +test_expect_success 'ref^{/!-Changed}' '
> +	git rev-parse expref >expected &&
> +	git rev-parse master^{/!-Changed} >actual &&
> +	test_cmp expected actual
> +'

OK.

> +test_expect_success 'ref^{/!-!Exp}' '
> +	git rev-parse modref >expected &&
> +	git rev-parse expref^{/!-!Exp} >actual &&
> +	test_cmp expected actual
> +'

OK.

>  test_done
