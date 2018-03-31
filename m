Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9161F404
	for <e@80x24.org>; Sat, 31 Mar 2018 16:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeCaQ02 (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 12:26:28 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:5775 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbeCaQ01 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 12:26:27 -0400
Received: from [192.168.2.240] ([92.22.46.114])
        by smtp.talktalk.net with SMTP
        id 2JKifWjDxlWlT2JKifDiKl; Sat, 31 Mar 2018 17:26:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1522513585;
        bh=zYxlVPgBdQ5MEC1TsgeDbPe9UKh6w1+Uu4jO4L7CBGw=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JySgHHvpaowMyebsq6cKidSgMx5cFVDy+JwcE7Z0JYvo5MH5ms5Se7X7qKZj0lPlx
         PisVJ/oZhETz6KHgi+nSQHPKjabDcxtgFPYcK/LtVaGvab12lAeaI0DjOktRgacLT3
         3ziqkj9mBC2YHbcSokg3n0H9CRoO3Hls5u1C+BXU=
X-Originating-IP: [92.22.46.114]
X-Spam: 0
X-OAuthority: v=2.3 cv=N4gH6V1B c=1 sm=1 tr=0 a=KUgcAvQ5w6cTYeaau6oCBw==:117
 a=KUgcAvQ5w6cTYeaau6oCBw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=sskFmYGrgnlK9S6yxVQA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] add -p: fix 2.17.0-rc* regression due to moved code
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180331123605.30076-1-avarab@gmail.com>
 <20180331125058.4506-1-avarab@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <f60a2014-3b02-3eae-76cb-950330113afa@talktalk.net>
Date:   Sat, 31 Mar 2018 17:26:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180331125058.4506-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfP1RLd30D3bEV9iG29fvhphAYJIyf68DaWB2faMcedJoqCtb1aLti9gEAjTkzb6VR97QxJy9QF0z8+/th3DIZoW6qmdFsGgtA5vcN+QZ6nwLL16Xj5ET
 2xV/2t+BoxjzUYLMfRfPfE6P8V0l339koHuOCQrESHtC9KFhGBLL8rwvWVkBFJIkedCRExpSsYY63BUVzzNaXSF7ya63IHPRW1ooDxCblwRllvTQnpsWLNkq
 ESpzHEl4fPKmUERfxGORcTw0YuMIONLQ+LvTqbqZBdU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/03/18 13:50, Ævar Arnfjörð Bjarmason wrote:
> Fix a regression in 88f6ffc1c2 ("add -p: only bind search key if
> there's more than one hunk", 2018-02-13) which is present in
> 2.17.0-rc*, but not 2.16.0.
> 
> In Perl, regex variables like $1 always refer to the last regex
> match. When the aforementioned change added a new regex match between
> the old match and the corresponding code that was expecting $1, the $1
> variable would always be undef, since the newly inserted regex match
> doesn't have any captures.
> 
> As a result the "/" feature to search for a string in a hunk by regex
> completely broke, on git.git:

Good catch, I could have sworn I'd tested my patch but I obviously 
didn't notice the warning (I've got interactive.singlekey set so it 
prints the warning and then prompts as it always has done). Calling it 
completely broken is perhaps a little harsh as it does work if you enter 
the regex again and with interactive.singlekey set you only have to 
enter the regex once.

Thanks for fixing it

Phillip
> 
>      $ perl -pi -e 's/Git/Tig/g' README.md
>      $ ./git --exec-path=$PWD add -p
>      [..]
>      Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,?]? s
>      Split into 4 hunks.
>      [...]
>      Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,?]? /Many
>      Use of uninitialized value $1 in string eq at /home/avar/g/git/git-add--interactive line 1568, <STDIN> line 1.
>      search for regex? Many
> 
> I.e. the initial "/regex" command wouldn't work, and would always emit
> a warning and ask again for a regex, now it works as intended again.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> Of course I just noticed the grammar errors in the commit message
> after sending. Here's a v2 with that fixed, also genreated the patch
> with -U6 to make it clear what's going on.
> 
>   git-add--interactive.perl | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index d190469cd8..c1f52e457f 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1561,13 +1561,13 @@ sub patch_update_file {
>   			elsif ($line =~ m|^/(.*)|) {
>   				my $regex = $1;
>   				unless ($other =~ m|/|) {
>   					error_msg __("No other hunks to search\n");
>   					next;
>   				}
> -				if ($1 eq "") {
> +				if ($regex eq "") {
>   					print colored $prompt_color, __("search for regex? ");
>   					$regex = <STDIN>;
>   					if (defined $regex) {
>   						chomp $regex;
>   					}
>   				}
> 

