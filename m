From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [eclipse7@gmx.net: [PATCH] diff: Only count lines in show_shortstats()]
Date: Thu, 07 Jun 2012 21:05:25 +0200
Message-ID: <4FD0FB75.4090906@in.waw.pl>
References: <20120607122149.GA3070@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: mj@ucw.cz, Johannes Sixt <j.sixt@viscovery.net>
To: Alexander Strasser <eclipse7@gmx.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 21:05:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sci1b-0003fi-Gw
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 21:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761346Ab2FGTFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 15:05:34 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:38144 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761304Ab2FGTFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 15:05:34 -0400
Received: from aayq27.neoplus.adsl.tpnet.pl ([83.6.128.27] helo=[192.168.1.13])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1Sci1U-0004am-Ef; Thu, 07 Jun 2012 21:05:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <20120607122149.GA3070@akuma>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199439>

On 06/07/2012 02:21 PM, Alexander Strasser wrote:
> Hello Zbigniew,
> 
>   could you have a look at the patch below? I submitted to it to the
> Git mailing list and you could probably comment there?
Hi Alexander,
sure, thanks for finding (and fixing) the bug.

>   I think I should have put you in CC. But I am not so sure about
> Git patch submission policies.
The policy is to CC everyone who might be interested, and also to add
TO:gitster@pobox.com, if the patch is intended for merging, as yours is.
So basically taking the address list from the discussion of e18872b
would be the simplest and most effective choice.

>   Do not mix byte and line counts. Binary files have byte counts;
> skip them when accumulating line insertions/deletions.
> 
>   The regression was introduced in e18872b.
Yeah, it seems that the condition for !binary was lost in the refactoring
of the code.

> Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
Small note: normally the paragraphs are not indented.

> ---
> 
>   I hope this does retain the original intent of e18872b while
> not messing up the insertions/deletions output by --shortstat.
> 
>   Output of --stat was never affected AFAICT.
> 
>  diff.c                 | 2 +-
>  t/t4012-diff-binary.sh | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/diff.c b/diff.c
> index 77edd50..1a594df 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1700,7 +1700,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
>  			continue;
>  		if (!data->files[i]->is_renamed && (added + deleted == 0)) {
>  			total_files--;
> -		} else {
> +		} else if (!data->files[i]->is_binary) { /* don't count bytes */
>  			adds += added;
>  			dels += deleted;
>  		}
> diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
> index 8b4e80d..1a994f0 100755
> --- a/t/t4012-diff-binary.sh
> +++ b/t/t4012-diff-binary.sh
> @@ -36,6 +36,14 @@ test_expect_success '"apply --stat" output for binary file change' '
>  	test_i18ncmp expected current
>  '
>  
> +cat > expected <<\EOF
> + 4 files changed, 2 insertions(+), 2 deletions(-)
> +EOF
> +test_expect_success 'diff with --shortstat' '
> +	git diff --shortstat >current &&
> +	test_cmp expected current
> +'
> +
The test is OK, and follows the style of surrounding tests, but current
style is slightly different:
- no space after '>'
- expected output is inlined if it is short
- test_i18ncmp is used, even if the message is not yet i18n-ized

Something like this:
test_expect_success 'diff --shortstat output for binary file change' '
	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expect &&
	git diff --shortstat >current &&
	test_i18ncmp expect current
'

>  test_expect_success 'apply --numstat notices binary file change' '
>  	git diff >diff &&
>  	git apply --numstat <diff >current &&

Zbyszek
