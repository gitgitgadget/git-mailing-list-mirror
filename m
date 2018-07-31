Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADBFC1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 10:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbeGaLpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 07:45:30 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:15565 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeGaLpa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 07:45:30 -0400
Received: from [192.168.2.240] ([92.22.0.63])
        by smtp.talktalk.net with SMTP
        id kRXNfkMwSbZX5kRXOf0bzv; Tue, 31 Jul 2018 11:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533031555;
        bh=g+9MtZLq3qAGIKR6aekfMBZAHb3LmEZtFtCUzIcofi4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hEwwpF0m2tTUe9bOqs1Sfb9zgZiW/OhSdSwAe044KRfF5meAARymKHCaTRTfgutTx
         z00PeK5HBgGT7ruAx3odFhkwM2cU9Q7T2IjYwo0rGsKakXDGh3GQ0c6RJkuftO8PvC
         iGsDI2VZphZgs372xrDdBwVPwQRvRdpK5FijWNig=
X-Originating-IP: [92.22.0.63]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=ohMtzhKkgcX7CUCE/LoB2A==:117
 a=ohMtzhKkgcX7CUCE/LoB2A==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=BCjA09oAAAAA:8 a=nN7BH9HXAAAA:8 a=LuDDS1vldMgGmqdpN8UA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=jYKBPJSq9nmHKCndOPe9:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@idaemons.org>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <f9a7e77d-3c67-082e-ed8d-701f4d0d1759@talktalk.net>
Date:   Tue, 31 Jul 2018 11:05:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731073331.40007-1-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOCZXMLvJw4Z0cOdSGN2CnbuVgu+XzVF7JnJRimCEqzsHzw2WDwqHOGs+4Bycp2gWf7rgremtVPVwvVcBcRMaV9rna7kg3U9ePukbi1+qhqeqcWWNe9C
 0Mu5Qf04cxy/lbXyuji2COtWYLNEfHkUbP9Dtutl3EcTg+hxRZbEqOHPbXkt9JWx9SnbUorFMzZa+a8gGTRgvYo81foqkNOva2YPrW4B9CtDgMg66pQWAYmW
 Azo7qWh4K3+XKpDmZmR9yXzkeaP+1hOVcUS2AO9wNHvEu2Tgg62HRS3jCD9vH+73+Cv4LlIpwqO/pDFtMy6TgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 31/07/18 08:33, Eric Sunshine wrote:
> This is a re-roll of [1] which fixes sequencer bugs resulting in commit
> object corruption when "rebase -i --root" swaps in a new commit as root.
> Unfortunately, those bugs made it into v2.18.0 and have already
> corrupted at least one repository (a local project of mine). Patches 3/4
> and 4/4 are new.
> 
> v1 fixed these bugs:
> 
> * trailing garbage on the commit's "author" header
> 
> * extra trailing digit on "author" header's timezone (caused by two
>    separate bugs)
> 
> v2 fixes those same bugs, plus:
> 
> * eliminates a bogus "@" prepended to the "author" header timestamp
>    which renders the header corrupt
> 
> * takes care to validate information coming from
>    "rebase-merge/author-script" before incorporating it into the "author"
>    header since that file may be hand-edited, and bogus hand-edited
>    values could corrupt the commit object.
> 
> Patch 2/4 of this series conflicts with Akinori MUSHA's
> 'am/sequencer-author-script-fix' which takes a stab at fixing one of the
> four (or so) bugs fixed by this series (namely, adding a missing closing
> quote to GIT_AUTHOR_DATE in "rebase-merge/author-script"). That patch
> probably ought to be dropped (without prejudice) in favor of this series
> for the following reasons:
> 
> * It has the undesirable property of adding an unwanted extra blank line
>    to "rebase-merge/author-script"; this series doesn't make that
>    mistake.
> 
> * The fix in this series (patch 2/4) is more complete, also ensuring
>    that the return value of sq_dequote() is checked.
> 
> * And, most importantly, this series sells the change as a fix for a
>    genuine serious bug (commit object corruption), whereas that patch
>    talks only about adjusting the file content to make it parseable by
>    the shell. It's important for future readers of this change to
>    understand that the bug (missing closing quote) had much more dire
>    consequences than merely being syntactically invalid as a shell
>    script.
> 
> The test added by Akinori MUSHA's patch may still have value, and it may
> make sense to re-submit it, however, doing so need not hold up this
> (higher priority) series.

Yes I think it does, also the patch that Johannes and I have on top of 
it to fix the quoting of "'" in write_author_script() relies on fixing 
the missing trailing quote and handling of "'" at the same time, 
hopefully we can get that rebased on top of these asap.

Best Wishes

Phillip

> Phillip's proposed[2] unification of parsers and other fixes and
> cleanups can easily be built atop this series and, likewise, need not
> prevent these (higher priority) patches from graduating independently.
> 
> [1]: https://public-inbox.org/git/20180730092929.71114-1-sunshine@sunshineco.com/
> [2]: https://public-inbox.org/git/1f172fc1-4b51-cdf7-e841-5ca41e209be4@talktalk.net/
> 
> Eric Sunshine (4):
>    sequencer: fix "rebase -i --root" corrupting author header
>    sequencer: fix "rebase -i --root" corrupting author header timezone
>    sequencer: fix "rebase -i --root" corrupting author header timestamp
>    sequencer: don't die() on bogus user-edited timestamp
> 
>   sequencer.c                   | 39 +++++++++++++++++++++--------------
>   t/t3404-rebase-interactive.sh | 10 ++++++++-
>   2 files changed, 33 insertions(+), 16 deletions(-)
> 
> Range-diff against v1:
> 1:  ba10ae4e5d ! 1:  8c47555bcf sequencer: fix "rebase -i --root" corrupting author header
>      @@ -11,8 +11,8 @@
>           This is a result of read_author_ident() neglecting to NUL-terminate the
>           buffer into which it composes the "author" header.
>       
>      -    (Note that the extra "0" in the timezone is a separate bug which will be
>      -    fixed subsequently.)
>      +    (Note that the "@" preceding the timestamp and the extra "0" in the
>      +    timezone are separate bugs which will be fixed subsequently.)
>       
>           Security considerations: Construction of the "author" header by
>           read_author_ident() happens in-place and in parallel with parsing the
>      @@ -26,6 +26,7 @@
>           inserted as part of the parsing process.
>       
>           Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>      +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>       
>       diff --git a/sequencer.c b/sequencer.c
>       --- a/sequencer.c
>      @@ -61,7 +62,7 @@
>       +	set_fake_editor &&
>       +	FAKE_LINES="2 1" git rebase -i --root &&
>       +	git cat-file commit HEAD^ >out &&
>      -+	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9]*$" out
>      ++	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9]*$" out
>       +'
>       +
>        test_done
> 2:  c0400cda85 ! 2:  1d4064147e sequencer: fix "rebase -i --root" corrupting author header timezone
>      @@ -22,6 +22,9 @@
>           a NUL-terminator at the end of the shifted content, which explains the
>           duplicated last digit in the timezone.
>       
>      +    (Note that the "@" preceding the timestamp is a separate bug which
>      +    will be fixed subsequently.)
>      +
>           Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>       
>       diff --git a/sequencer.c b/sequencer.c
>      @@ -56,8 +59,8 @@
>        	set_fake_editor &&
>        	FAKE_LINES="2 1" git rebase -i --root &&
>        	git cat-file commit HEAD^ >out &&
>      --	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9]*$" out
>      -+	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
>      +-	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9]*$" out
>      ++	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
>        '
>        
>        test_done
> -:  ---------- > 3:  cb65c7dd98 sequencer: fix "rebase -i --root" corrupting author header timestamp
> -:  ---------- > 4:  3a624da9f4 sequencer: don't die() on bogus user-edited timestamp
> 

