Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB82C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 06:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577106139A
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 06:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFAG1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 02:27:17 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:42003 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhFAG1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 02:27:16 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4FvMbc2HlVz5tlC;
        Tue,  1 Jun 2021 08:25:32 +0200 (CEST)
Subject: Re: [PATCH] builtin/fsck.c: don't conflate "int" and "enum" in
 callback
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <patch-1.1-f109a61b11-20210601T000433Z-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <de9dea3a-6138-5e2f-7dc8-8a2ddf28bb84@kdbg.org>
Date:   Tue, 1 Jun 2021 08:25:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <patch-1.1-f109a61b11-20210601T000433Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.06.21 um 02:05 schrieb Ævar Arnfjörð Bjarmason:
> Fix a warning on AIX's xlc compiler that's been emitted since my
> a1aad71601a (fsck.h: use "enum object_type" instead of "int",
> 2021-03-28):
> 
>     "builtin/fsck.c", line 805.32: 1506-068 (W) Operation between
>     types "int(*)(struct object*,enum object_type,void*,struct
>     fsck_options*)" and "int(*)(struct object*,int,void*,struct
>     fsck_options*)" is not allowed.
> 
> I.e. it complains about us assigning a function with a prototype "int"
> where we're expecting "enum object_type". Enums are just ints in C,
> but it seems xlc is more picky than some about conflating them at the
> source level.

Is that true? I thought compilers were allowed to use whatever data type
is sufficient to represent all enumeration values. For this reason, you
sometimes see

   enum X { A, B, X_MAX = 0x7fffffff };

that ensures that an int must be used for representation of enum X. So,
AFAICS, your patch is an actual fix, not just cosmetic.

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> This is new in v2.32.0, so sending this during the rc phase, just a
> warning though, so unless you're using fatal warnings on that
> OS/platform it won't impact anything, and even then it's just a minor
> annoyance...
> 
>  builtin/fsck.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 87a99b0108..b42b6fe21f 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -109,7 +109,8 @@ static int fsck_error_func(struct fsck_options *o,
>  
>  static struct object_array pending;
>  
> -static int mark_object(struct object *obj, int type, void *data, struct fsck_options *options)
> +static int mark_object(struct object *obj, enum object_type type,
> +		       void *data, struct fsck_options *options)
>  {
>  	struct object *parent = data;
>  
> 

