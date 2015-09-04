From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] remote: add get-url subcommand
Date: Fri, 04 Sep 2015 15:40:58 -0700
Message-ID: <xmqqwpw5erk5.fsf@gitster.mtv.corp.google.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
	<1441377024-23832-1-git-send-email-mathstuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Boeckel <mathstuf@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 00:41:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXzfN-0006Nz-TE
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 00:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933916AbbIDWlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 18:41:01 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34239 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932848AbbIDWlA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 18:41:00 -0400
Received: by padhy16 with SMTP id hy16so34170102pad.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Y12Td0Iq0mlxONRRu9WT0IFyPMwvREI32c+1+YqekjA=;
        b=F1SE81cRZhqWzVGmhYt19CJJUc4cAALGzOsr2t0O+al+Otf7XW1g+fFXU9IuOrmEuY
         Zf62A5NNdJ4hP6B1Uvc7TVxcD3Nfffpqqrn7FERFZszxYA4VY3nQKhxCD/45elSJOF+J
         sHxx6WRyX1b+EUEcpZWm+8BjGwSmGUEeby+WV2BlyutJU3PROQmW9BmSW46Aww6+yCMi
         l2aJrcpgCrtUih1VB5fyxtJaNNVJ2pHgWw0vJwdyxla/FCrpE/qgvwrWjAqJCa3McI+Z
         20WkH/QKvp15lGXtTBlmMkG90XbenA+k4W65++6n5Lyo+E8lRqf+speQkJP1u+JCIV3R
         bUDw==
X-Received: by 10.68.143.70 with SMTP id sc6mr13043805pbb.87.1441406460048;
        Fri, 04 Sep 2015 15:41:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id j1sm3673743pde.48.2015.09.04.15.40.59
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 15:40:59 -0700 (PDT)
In-Reply-To: <1441377024-23832-1-git-send-email-mathstuf@gmail.com> (Ben
	Boeckel's message of "Fri, 4 Sep 2015 10:30:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277346>

Ben Boeckel <mathstuf@gmail.com> writes:

> +	url_nr = 0;
> +	if (push_mode) {
> +		url = remote->pushurl;
> +		url_nr = remote->pushurl_nr;
> +	}
> +
> +	/* Fall back to the fetch URL if no push URLs are set. */
> +	if (!url_nr) {
> +		url = remote->url;
> +		url_nr = remote->url_nr;
> +	}

While the code does the right thing, the comment and the logic
looked somewhat on the side of funny than cute.  url_nr would be
zero when we are asking for fetch URL, and it would be zero also
when we are asking for push URL but there is no push URL defined.
So this statement covers both cases, but "Fall back to" talks only
about the case where the user asked for push URL.

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 7a8499c..2cfd3cb 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -919,6 +919,18 @@ test_expect_success 'new remote' '
>  	cmp expect actual
>  '
>  
> +test_expect_success 'get-url on new remote' '
> +	echo foo >expect &&
> +	git remote get-url someremote >actual &&
> +	cmp expect actual &&
> +	git remote get-url --all someremote >actual &&
> +	cmp expect actual &&
> +	git remote get-url --push someremote >actual &&
> +	cmp expect actual &&
> +	git remote get-url --push --all someremote >actual &&
> +	cmp expect actual
> +'

In the pre-context of this hunk, I can see that you inherited this
habit from existing tests, but breakage can be made easier to see
if you used test_cmp instead of cmp.

> @@ -961,6 +973,24 @@ test_expect_success 'remote set-url --push zot' '
>  	cmp expect actual
>  '
>  
> +test_expect_success 'get-url with different urls' '
> +	echo baz >expect &&
> +	echo "YYY" >>expect &&
> +	echo baz >>expect &&
> +	echo "YYY" >>expect &&
> +	echo zot >>expect &&
> +	echo "YYY" >>expect &&
> +	echo zot >>expect &&
> +	git remote get-url someremote >actual &&
> +	echo "YYY" >>actual &&
> +	git remote get-url --all someremote >>actual &&
> +	echo "YYY" >>actual &&
> +	git remote get-url --push someremote >>actual &&
> +	echo "YYY" >>actual &&
> +	git remote get-url --push --all someremote >>actual &&
> +	cmp expect actual
> +'

I am not sure what these YYY are about. Is this an attempt to make
it easier to see which of the output from four logically separate
tests are broken?

I am wondering if something along this line might be easier to read
and maintain:

	get_url_test () {
		cat >expect &&
		test_expect_success "get-url $*" '
	                git remote get-url $* >actual &&
	                test_cmp expect actual
		'
	}

	echo baz | get_url_test someremote
	echo baz | get_url_test --all someremote

Then later when you have more than one pushURL to someremote, you
would do something like:

	get_url_test --all --push someremote <<\-EOF
	foo
        aaa
        EOF

This comment applies to the remainder of this patch that has YYY
sprinkled all over it.

Thanks.
