From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: fix setup of option-parsing for --sort
Date: Sat, 10 Nov 2007 10:58:51 -0800
Message-ID: <7v7ikqlyfo.fsf@gitster.siamese.dyndns.org>
References: <1194713274-31200-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 19:59:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqvY8-0001E0-6f
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 19:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXKJS7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 13:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbXKJS7E
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 13:59:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54030 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbXKJS7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 13:59:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 154612F9;
	Sat, 10 Nov 2007 13:59:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5710F92484;
	Sat, 10 Nov 2007 13:59:17 -0500 (EST)
In-Reply-To: <1194713274-31200-1-git-send-email-hjemli@gmail.com> (Lars
	Hjemli's message of "Sat, 10 Nov 2007 17:47:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64367>

Lars Hjemli <hjemli@gmail.com> writes:

> The option value for --sort is already a pointer to a pointer to struct
> ref_sort, so just use it.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>
> On Nov 10, 2007 5:25 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Could you add a test for that too, please?
>
> Is this ok?
>

Testing "for that" would be kind of hard and semi pointless,
isn't it?

If it's mismatch of the expected number of times a pointer is
dereferenced between the caller and the callee, I'd imagine that
it will read from and write to random place in memory and would
lead to unpredictable behaviour.  If you are lucky you would not
get expected results but if you are unlucky who knows what would
happen.

But the new test makes sure --sort takes intended effect, which
is a good thing.

Thanks.

>  builtin-for-each-ref.c  |    2 +-
>  t/t6300-for-each-ref.sh |   22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index da8c794..e909e66 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> @@ -847,7 +847,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  		OPT_GROUP(""),
>  		OPT_INTEGER( 0 , "count", &maxcount, "show only <n> matched refs"),
>  		OPT_STRING(  0 , "format", &format, "format", "format to use for the output"),
> -		OPT_CALLBACK(0 , "sort", &sort_tail, "key",
> +		OPT_CALLBACK(0 , "sort", sort_tail, "key",
>  		            "field name to sort on", &opt_parse_sort),
>  		OPT_END(),
>  	};
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index d0809eb..c722635 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -148,4 +148,26 @@ test_expect_success 'Check format "rfc2822" date fields output' '
>  	git diff expected actual
>  '
>  
> +cat >expected <<\EOF
> +refs/heads/master
> +refs/tags/testtag
> +EOF
> +
> +test_expect_success 'Verify ascending sort' '
> +	git-for-each-ref --format="%(refname)" --sort=refname >actual &&
> +	git diff expected actual
> +'
> +
> +
> +cat >expected <<\EOF
> +refs/tags/testtag
> +refs/heads/master
> +EOF
> +
> +test_expect_success 'Verify descending sort' '
> +	git-for-each-ref --format="%(refname)" --sort=-refname >actual &&
> +	git diff expected actual
> +'
> +
> +
>  test_done
> -- 
> 1.5.3.5.623.g0a1d
