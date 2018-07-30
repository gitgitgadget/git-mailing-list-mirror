Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4421D1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeG3NzZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 09:55:25 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:3786 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbeG3NzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 09:55:25 -0400
Received: from [192.168.2.201] ([92.22.39.78])
        by smtp.talktalk.net with SMTP
        id k7AFfpXakpXFjk7AFfVyku; Mon, 30 Jul 2018 13:20:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532953240;
        bh=Kjff1itnByHxxk/8mp2jzs1ESDaZyqf2C4M5o/tPuNc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XDZeO+2FPxb4EN2w7YvI3zbnyBVYO5MIlx7KFD8pvmgNiXq4YwmModkBvnCEI4CRc
         T4JUawIaevPKbxf8kO16Ajj35TR30GfvbMJ/vK+R50DuMX6CbBYsQQBRr4c+XKl/ms
         yssdE+8sRZz18dcJXrQQCrOdKsf6X8OCm7mSmms0=
X-Originating-IP: [92.22.39.78]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=uA7GO7HkTMgiH16tn5xvbw==:117
 a=uA7GO7HkTMgiH16tn5xvbw==:17 a=IkcTkHD0fZMA:10 a=A1X0JdhQAAAA:8
 a=BCjA09oAAAAA:8 a=FWSdfzw-ZOY0nY0y7HwA:9 a=QEXdDO2ut3YA:10
 a=Df3jFdWbhGDLdZNm0fyq:22 a=jYKBPJSq9nmHKCndOPe9:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] sequencer: fix "rebase -i --root" corrupting author
 header timezone
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Akinori MUSHA <knu@iDaemons.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180730092929.71114-1-sunshine@sunshineco.com>
 <20180730092929.71114-3-sunshine@sunshineco.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <f079bf7b-d627-20dc-cd93-dfa3496f6877@talktalk.net>
Date:   Mon, 30 Jul 2018 13:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730092929.71114-3-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfM/SVZXRck6GTk3Z7QyPV/GPMNGxempZHUb7SqEMmowynPwgttbPLaONfgaJnKZ2yxV0PhZn2ByEC3jU+HZen9+il5ogrFVIVCGCrFXiR1kUBaX6BwR/
 RCnoQhZ6OUoh3b6An0G1hDdSrNfCDlII8lUdVbw9KjxVudER/8LdRmQIbA/C1OY2gb7HYgNWk/yxC02hy+m93StHkGpIR7hDzftJNnAxcmWVLTPKSVIQTGuM
 /UUq1JqlgseRlKbIFgjTMONNb/tG10pP2WX2ngES8DyzYbp3ClszQYyfPN8d8Oo22oj3oiWqUlA9ZajH/+rwrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric
On 30/07/18 10:29, Eric Sunshine wrote:
> When "git rebase -i --root" creates a new root commit, it corrupts the
> "author" header's timezone by repeating the last digit:
> 
>     author A U Thor <author@example.com> @1112912773 -07000
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
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  sequencer.c                   | 7 ++++++-
>  t/t3404-rebase-interactive.sh | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 78864d9072..1008f6d71a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -654,6 +654,7 @@ static int write_author_script(const char *message)
>  			strbuf_addch(&buf, *(message++));
>  		else
>  			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +	strbuf_addch(&buf, '\'');
>  	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
>  	strbuf_release(&buf);
>  	return res;
> @@ -724,7 +725,11 @@ static const char *read_author_ident(struct strbuf *buf)
>  
>  		eol = strchrnul(in, '\n');
>  		*eol = '\0';
> -		sq_dequote(in);
> +		if (!sq_dequote(in)) {
> +			warning(_("bad quoting on %s value in '%s'"),
> +				keys[i], rebase_path_author_script());
> +			return NULL;

I think we want to handle the broken author script properly rather than
returning NULL. If we had a single function
int read_author_script(const char **name, const char **author, const
char **date)
to read the author script that tried sq_dequote() and then fell back to
code based on read_env_script() that handled the missing "'" at the end
and also the bad quoting of "'" if sq_dequote() failed it would make it
easier to fix the existing bugs, rather than having to fix
read_author_ident() and read_env_script() separately. What do you think?

Best Wishes

Phillip

> +		}
>  		len = strlen(in);
>  
>  		if (i > 0) /* separate values by spaces */
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8509c89a26..37796bb4c1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1420,7 +1420,7 @@ test_expect_success 'valid author header after --root swap' '
>  	set_fake_editor &&
>  	FAKE_LINES="2 1" git rebase -i --root &&
>  	git cat-file commit HEAD^ >out &&
> -	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9]*$" out
> +	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
>  '
>  
>  test_done
> 

