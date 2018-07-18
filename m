Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3711F597
	for <e@80x24.org>; Wed, 18 Jul 2018 13:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeGRO21 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 10:28:27 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:21398 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbeGRO21 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 10:28:27 -0400
Received: from [192.168.2.240] ([92.22.19.104])
        by smtp.talktalk.net with SMTP
        id fmqVf0yUxoI6LfmqWfnAo4; Wed, 18 Jul 2018 14:50:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1531921825;
        bh=rFkMgFCoR9gbzvq3fWjVMZV6IYbTv1xV2Ebt54Tz/Lw=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aRSi5F6J6gCXJgtenpb+L7bGzLnUJI3kavYey4OJXdtVnTxCSR5uwmtX2RYuKJTIn
         Dd8w8zbsGA1/ClhELh7uNhw3oWO3ug+/l/8u+tzP43ezRbEXZFr3jcInF/kp4rVzJO
         Xyyv+FE6NOsgCZVpsPneesM/4Z4ORwqJneVhJBDU=
X-Originating-IP: [92.22.19.104]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=f/8ZdrXn5sPnqdHA06GUHw==:117
 a=f/8ZdrXn5sPnqdHA06GUHw==:17 a=IkcTkHD0fZMA:10 a=cETuxoCwAAAA:8
 a=j_GHiRUQb_sQYw79FbEA:9 a=QEXdDO2ut3YA:10 a=tb6VMGFFq-HsUJGUQiVL:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script
 properly
To:     Akinori MUSHA <knu@iDaemons.org>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <86a7qwpt9g.knu@iDaemons.org>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <aad05e61-db99-429e-bbe6-a8f91ef18e3f@talktalk.net>
Date:   Wed, 18 Jul 2018 14:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86a7qwpt9g.knu@iDaemons.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNFhBkRfv0SLmXA7VVznV6iyUopvA4KRGgpYE2Jc0PjOXI/9D94aSlYU/i3Xl02AqSJkFfJV/4j5Bg21xPiOZ6ghq4ocRtA0F/WvtVEguA3nORB2F3nT
 o/8gKOOrhys/XjDKvTFc+sKylU5+UyCpzwu3b7f8vwwLcKP9hx8jdRjCQCVJxALA3+6OfXZ3TKzbyj3oq4HUXxbsDQvfdJHRHn9CnqTiUpz9RQDpj0UVqyN9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Akinori
On 12/07/18 12:18, Akinori MUSHA wrote:
> 
> It looks like write_author_script() intends to write out a file in
> Bourne shell syntax, but it doesn't put a closing single quote on the
> last line.
> 
> This patch makes .git/rebase-merge/author-script actually parsable by
> sh(1) by adding a single quote and a linefeed to terminate the line
> properly.
> 
> Signed-off-by: Akinori MUSHA <knu@idaemons.org>
> ---
>   sequencer.c                   |  1 +
>   t/t3404-rebase-interactive.sh | 13 +++++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 4034c0461..5f32b6df1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -651,6 +651,7 @@ static int write_author_script(const char *message)
>   			strbuf_addch(&buf, *(message++));
>   		else
>   			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +	strbuf_addstr(&buf, "'\n");
>   	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
>   	strbuf_release(&buf);
>   	return res;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 352a52e59..345b103eb 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -75,6 +75,19 @@ test_expect_success 'rebase --keep-empty' '
>   	test_line_count = 6 actual
>   '
>   
> +test_expect_success 'rebase -i writes out .git/rebase-merge/author-script in "edit" that sh(1) can parse' '
> +	test_when_finished "git rebase --abort ||:" &&
> +	git checkout master &&
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
> +	test -f .git/rebase-merge/author-script &&
> +	unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> +	eval "$(cat .git/rebase-merge/author-script)" &&
> +	test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
> +	test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
> +	test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"
> +'

Have you checked that this test fails without your fix being applied? I 
just ran

sh -c 'eval "$(cat .git/rebase-merge/author-script)"; echo 
"$GIT_AUTHOR_NAME"'

while a rebase was stopped for an edit and it worked despite the fact 
that there is a missing quote at the end of the GIT_AUTHOR_DATE in the 
author script file.

Best Wishes

Phillip

>   test_expect_success 'rebase -i with the exec command' '
>   	git checkout master &&
>   	(
> 

