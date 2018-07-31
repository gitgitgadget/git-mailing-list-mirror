Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0799C1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 09:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbeGaLaV (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 07:30:21 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:61909 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbeGaLaV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 07:30:21 -0400
Received: from [192.168.2.240] ([92.22.0.63])
        by smtp.talktalk.net with SMTP
        id kRIjfkLKKbZX5kRIkf0bYS; Tue, 31 Jul 2018 10:50:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533030648;
        bh=K0Gtn8pXV+NlyJMBEjz4M8hFmTywD3yMNL4Sk99OgZ4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j7ZDG8T/xL9fDsXXuwF8WTTtCh94vvVJ17q68JHrhyVbj/h8HZufbnweFPSh2xnNS
         YaJU0qM2SoXkSTvcr1z4qrJBtaVhsu/HMn7UIq9vjmmXKnX3bGknGxx5Xu1Zau6/mf
         krLX8nELLVUHS6fCD7wl1Ei1RouZy9bckyC5Bb20=
X-Originating-IP: [92.22.0.63]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=ohMtzhKkgcX7CUCE/LoB2A==:117
 a=ohMtzhKkgcX7CUCE/LoB2A==:17 a=IkcTkHD0fZMA:10 a=A1X0JdhQAAAA:8
 a=BCjA09oAAAAA:8 a=ExSEzxC0viY7h4MwdyUA:9 a=QEXdDO2ut3YA:10
 a=Df3jFdWbhGDLdZNm0fyq:22 a=jYKBPJSq9nmHKCndOPe9:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/4] sequencer: fix "rebase -i --root" corrupting
 author header timezone
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@idaemons.org>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731073331.40007-3-sunshine@sunshineco.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <c80cf729-1bbe-10f5-6837-b074d371b91c@talktalk.net>
Date:   Tue, 31 Jul 2018 10:50:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731073331.40007-3-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJDVDjZcIBsLuose7zJEF1VSMOf+LGhL4eiCNqIEdfzrRoH5o99XOVm06ug5dD3TNGW0ItUcTArm7GyLH5L5AIRzq0bdcVL18Y3ApRiKVhSJfN5ccBzO
 a7j5yEIW1Nmj40xzDuIJ1kvKLTb0Dzd+ldkXBDei0ASyHgWuQZpXg4WiSmqjCv/tnEyZiIoMLZiq5wuMkfbtaAiRFE9o/iY59luqK6nVrIQAm+yXGv6Ke+3U
 08Meq5aiG7+5OymEcH0DfHAxC6cA/BLrBdC589SZl227rjouwQw6PW1ByhWba3EwJmTJh4NaDQCvvgv9zka6jw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/07/18 08:33, Eric Sunshine wrote:
> When "git rebase -i --root" creates a new root commit, it corrupts the
> "author" header's timezone by repeating the last digit:
> 
>      author A U Thor <author@example.com> @1112912773 -07000
> 
> This is due to two bugs.
> 
> First, write_author_script() neglects to add the closing quote to the
> value of GIT_AUTHOR_DATE when generating "rebase-merge/author-script".
> 
> Second, although sq_dequote() correctly diagnoses the missing closing
> quote, read_author_ident() ignores sq_dequote()'s return value and
> blindly uses the result of the aborted dequote.
> 
> sq_dequote() performs dequoting in-place by removing quoting and
> shifting content downward. When it detects misquoting (lack of closing
> quote, in this case), it gives up and returns an error without inserting
> a NUL-terminator at the end of the shifted content, which explains the
> duplicated last digit in the timezone.
> 
> (Note that the "@" preceding the timestamp is a separate bug which
> will be fixed subsequently.)
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>   sequencer.c                   | 7 ++++++-
>   t/t3404-rebase-interactive.sh | 2 +-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 78864d9072..1008f6d71a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -654,6 +654,7 @@ static int write_author_script(const char *message)
>   			strbuf_addch(&buf, *(message++));
>   		else
>   			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +	strbuf_addch(&buf, '\'');
>   	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
>   	strbuf_release(&buf);
>   	return res;
> @@ -724,7 +725,11 @@ static const char *read_author_ident(struct strbuf *buf)
>   
>   		eol = strchrnul(in, '\n');
>   		*eol = '\0';
> -		sq_dequote(in);
> +		if (!sq_dequote(in)) {
> +			warning(_("bad quoting on %s value in '%s'"),
> +				keys[i], rebase_path_author_script());
> +			return NULL;

Unfortunately the caller does not treat NULL as an error, so this will 
change the date and potentially the author of the commit. While that 
isn't corruption in the sense that it creates a sane commit, it does 
corrupt the author data compared to its expected value. I think it would 
be better to die in the short term, or fix the caller.

> +		}
>   		len = strlen(in);
>   
>   		if (i > 0) /* separate values by spaces */
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index d6e9b52740..fd3a18154e 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1420,7 +1420,7 @@ test_expect_success 'valid author header after --root swap' '
>   	set_fake_editor &&
>   	FAKE_LINES="2 1" git rebase -i --root &&
>   	git cat-file commit HEAD^ >out &&
> -	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9]*$" out
> +	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
>   '
>   
>   test_done
> 

