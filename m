Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D0D1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 10:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbeGaLke (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 07:40:34 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:42541 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbeGaLke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 07:40:34 -0400
Received: from [192.168.2.240] ([92.22.0.63])
        by smtp.talktalk.net with SMTP
        id kRScfkMPibZX5kRScf0brG; Tue, 31 Jul 2018 11:01:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533031260;
        bh=aFcdAW7KiXrlDrYYk/qI2j9nUhXMHhRgUswDzH53yjE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cEFFu4OlgHsIpQ8Duo4s1VO8y6vW3Oenp7EVbx3WpLaywi2IhZoyxPilM3eoVGFvd
         LzZQQMxirdPzi3J3/Y0dGqGF1fezEQDoi9siidpWA3JF19jJ2CeDwE5VhfcDrtMrQO
         QFtApKCHV/H3Id/HdzexFN/ySV2l4GQLzceKLyXY=
X-Originating-IP: [92.22.0.63]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=ohMtzhKkgcX7CUCE/LoB2A==:117
 a=ohMtzhKkgcX7CUCE/LoB2A==:17 a=IkcTkHD0fZMA:10 a=A1X0JdhQAAAA:8
 a=BCjA09oAAAAA:8 a=tHPVvQcjeCPXCk1IqmQA:9 a=QEXdDO2ut3YA:10
 a=Df3jFdWbhGDLdZNm0fyq:22 a=jYKBPJSq9nmHKCndOPe9:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] sequencer: fix "rebase -i --root" corrupting
 author header timestamp
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@idaemons.org>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731073331.40007-4-sunshine@sunshineco.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <31870bca-329f-2451-750a-56d917153844@talktalk.net>
Date:   Tue, 31 Jul 2018 11:00:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731073331.40007-4-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOY2/SDklhnKIRkUwjRZkILzXa4RB3xzmO+nEjXf+GkzyRfIibJrqt6H0hxPEQs9An/FviIHa5HkGg9C7veBznk4MGid/bkPmz1Uo1HvEOulxXMLDGh5
 jNb9gxFpu8GnuwdRlGyPiRcimEFuSruTzAGWda8jXZPMM7k0d63tpOR2Uz+AecsI6Cx6uqL4pcj4URuOx4C5PyS4kQ+52Xgmxo2Z653PJrKJAOYmFuN4BghS
 N876++BVFmZrApMXTpo7yu5cNdk1YPr/imUY56rQeatJneFuv3uwrfAsXnCPwyvmsPR/nFlxwuSWM/fWI1ig2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/07/18 08:33, Eric Sunshine wrote:
> When "git rebase -i --root" creates a new root commit, it corrupts the
> "author" header's timestamp by prepending a "@":
> 
>      author A U Thor <author@example.com> @1112912773 -0700
> 
> The commit parser is very strict about the format of the "author"
> header, and does not allow a "@" in that position.
> 
> The "@" comes from GIT_AUTHOR_DATE in "rebase-merge/author-script",
> signifying a Unix epoch-based timestamp, however, read_author_ident()
> incorrectly allows it to slip into the commit's "author" header, thus
> corrupting it.
> 
> One possible fix would be simply to filter out the "@" when constructing
> the "author" header timestamp, however, a more correct fix is to parse
> the GIT_AUTHOR_DATE date (via parse_date()) and format the parsed result
> into the "author" header. Since "rebase-merge/author-script" may be
> edited by the user, this approach has the extra benefit of catching
> other potential timestamp corruption due to hand-editing.
> 
> We can do better than calling parse_date() ourselves and constructing
> the "author" header manually, however, by instead taking advantage of
> fmt_ident() which does this work for us.
> 
> The benefits of using fmt_ident() are twofold. First, it simplifies the
> logic considerably by allowing us to avoid the complexity of building
> the "author" header in parallel with and in the same buffer from which
> "rebase-merge/author-script" is being parsed. Instead, fmt_ident() is
> invoked to compose the header after parsing is complete.
> 
> Second, fmt_ident() is careful to prevent "crud" from polluting the
> composed ident. As with validating GIT_AUTHOR_DATE, this "crud"
> avoidance prevents other (possibly hand-edited) bogus author information
> from "rebase-merge/author-script" from corrupting the commit object.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>   sequencer.c                   | 23 +++++++++--------------
>   t/t3404-rebase-interactive.sh |  2 +-
>   2 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 1008f6d71a..15a66a334c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -709,14 +709,16 @@ static const char *read_author_ident(struct strbuf *buf)
>   	const char *keys[] = {
>   		"GIT_AUTHOR_NAME=", "GIT_AUTHOR_EMAIL=", "GIT_AUTHOR_DATE="
>   	};
> -	char *in, *out, *eol;
> -	int i = 0, len;
> +	struct strbuf out = STRBUF_INIT;
> +	char *in, *eol;
> +	const char *val[3];
> +	int i = 0;
>   
>   	if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
>   		return NULL;
>   
>   	/* dequote values and construct ident line in-place */
> -	for (in = out = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
> +	for (in = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
>   		if (!skip_prefix(in, keys[i], (const char **)&in)) {
>   			warning("could not parse '%s' (looking for '%s'",
>   				rebase_path_author_script(), keys[i]);
> @@ -730,16 +732,7 @@ static const char *read_author_ident(struct strbuf *buf)
>   				keys[i], rebase_path_author_script());
>   			return NULL;
>   		}
> -		len = strlen(in);
> -
> -		if (i > 0) /* separate values by spaces */
> -			*(out++) = ' ';
> -		if (i == 1) /* email needs to be surrounded by <...> */
> -			*(out++) = '<';
> -		memmove(out, in, len);
> -		out += len;
> -		if (i == 1) /* email needs to be surrounded by <...> */
> -			*(out++) = '>';
> +		val[i] = in;
>   		in = eol + 1;
>   	}
>   
> @@ -749,7 +742,9 @@ static const char *read_author_ident(struct strbuf *buf)
>   		return NULL;
>   	}
>   
> -	strbuf_setlen(buf, out - buf->buf);
> +	strbuf_addstr(&out, fmt_ident(val[0], val[1], val[2], 0));
> +	strbuf_swap(buf, &out);
> +	strbuf_release(&out);
>   	return buf->buf;
>   }

This is a welcome simplification

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index fd3a18154e..d340018781 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh

Now that the author is correct, can we test_cmp() it against its 
expected value to make sure there are no hidden surprises in the name 
and email in the future. (It would be reassuring to test an author with 
"'" in the name as well but that is out of scope for this series.)

> @@ -1420,7 +1420,7 @@ test_expect_success 'valid author header after --root swap' '
+	git cat-file commit HEAD^ |grep ^author >expected &&
>   	set_fake_editor &&
>   	FAKE_LINES="2 1" git rebase -i --root &&
>   	git cat-file commit HEAD^ >out &&
-	git cat-file commit HEAD^ >out &&
> -	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
+	git cat-file commit HEAD^ |grep ^author >out &&
+	test_cmp expected out	
> +	grep "^author ..*> [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
>   ' >   test_done
> 

