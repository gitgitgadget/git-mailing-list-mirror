Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C18C6379F
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjBJUVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 15:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjBJUVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 15:21:25 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2336D7E3E5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676060423; bh=wk5MJdG7G3ll4ZbfSYNglzaAVLBuZDQjnLnyAwxsOJ8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qPG3GibhMVKwzrOS3WZMJOKuJ38NjVwNmiYGSetFeVbZnEh8VylxrWqDnNlgbrcEE
         LwiEs/VsaB0xJfu9W+XKMvqxjxuuGndb6W8+2DLp/GVTQhY8C9i3w4qxEj+q1PeYrx
         6cOQ+zxIGIR62T8ugmHFxZ7yPIgirTBRTIbOCva47iU1ws3f6xRhSpV/K3Dny9DIxU
         kDXnRoTIjW8jJBJEM09+QmfuSF2t4imz+poGwj+Q+eIeIoPCEPViaBsWKPridPWEgM
         wzGzagTOdEQWs/p/TAW9NJiCYJhHuyQNuA1pfW0Qt7xYc0VCgaOjdU4G8bJ3W6PUgj
         mYA54I7OSIXtA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59iy-1pPTPu3MBQ-001ADA; Fri, 10
 Feb 2023 21:20:22 +0100
Message-ID: <e6785722-da0d-4b7c-fcd2-06e76b1f1757@web.de>
Date:   Fri, 10 Feb 2023 21:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Victoria Dye <vdye@github.com>
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
 <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
 <b1a3e684-26f9-0053-9446-751d73e83961@github.com>
 <xmqq357i8vyv.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq357i8vyv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IBoHy/CJIykhFLaFJqUbe7Ql1S4vPdKMfNb5uexFA3Px9KAOXbY
 TUHWbY2RWMXX70+ni7XHD56bguUJItWm8rz7Fl2poTDH2puaIO6b87Fuqbp3Rq60Ulb8Asz
 zINyChFSqycBpN8ZkZPgcQMpdrvbInuqHAXaiXz7cRIlwPrnoBN+BvQCVaWqPXQ9G1ONk6A
 Hd2KFNVOQmgLayHNQKMrw==
UI-OutboundReport: notjunk:1;M01:P0:Nb9duxJRLj0=;z2fMnwlDmoKWqlWBCn5EjxsOSJ5
 pE9n7hHSojnsgDNhSz+b71E88SKV0V7NNabJ/c7yQLve4u6nlaR3SE+Z7LQyW0JtAOZFNKeZH
 tVaTc4LR2d4+C0bE/gGqdiW2dP1iDW7Kuw0JQTyYvmb3kb/ojSqIzbpb//gTQrrcR35cYIs1A
 WBUWjo5c+RivpU/5WGpdHvAh8o8a6kw90GNWcv/TdV3vwDH88mX5jrpEefZ1t4chArWchsfcV
 zbMm2bUU3pH8k0MDFLWktPnD4mkgQdwfx4ywr/6EKj8OGpK9qRkV5Oyupo2T7y809QYKxqnyT
 V91IIEdBEGuFL09F/3lLqYTFz4J+vWbzEHa5iPXI4GioMc2rHT9kNbE0e53IjBJ2hv6qLVhqR
 iPAiTX+6iB12O+MHfP5mIYI5mPnb8GOJm/qBBMp6VRwgiK3Xo7lBkfglhCwChUKrKI0LxpONN
 iFTJmrRAweMJnmVfVlEBK7N6dxT2HVTEryUec4MwjB9RmyYVh438O/Z6SWhH7Xm+HB+oD67Vp
 hYaV0dzvi4mtIaw1rrsKAQfcr/7MCzI+OZCwgjuZYPYPsdoiWiuA6n27WrtTgMLoHyeuXSdUU
 plhCuHyuVMCzVXfIISI0obwj1xIBKXcbYMErdTItvAUhiH9MFnPyw0V/28zeEVV3+7eQGoQd5
 FEOi4rAblPY8vFc93aQxmO/hNeL6/WR0jjblATZBlc14kQ4R7zE9uieNFAMa76YLfmsLFU2+2
 wn0cFnGaxg62XEACn/Dn2lTsU3UAaq2QA+igCkmJnPZJU/mrMJdSJhPki8txd5S+DgvS6f1zz
 NRl5QL2FC6eqEldrKdIsM5lRh+gMlPETYRSn8xsqF+eu+vM6JvLjZljo6U4MNXfD3/+jsyPQj
 Y7N1eNYnx1tZI+jRcbTXaHE4iN5rkgGDOWykRsS67rq4Ifr7ZAGswpDIzHlTz6WW9EqZZp5uA
 MT/DR6/aDBdcOs8Ahw86dZijMWE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.02.23 um 19:55 schrieb Junio C Hamano:
> Derrick Stolee <derrickstolee@github.com> writes:
>
>>>> -	int base_path_len =3D tree_path->len;
>>>> +	size_t base_path_len =3D tree_path->len;
>>>> ...
>>>>  				strbuf_setlen(tree_path, base_path_len);
>>>> -				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
>>>> +				strbuf_grow(tree_path, entry.pathlen + 1);
>>>>  				strbuf_add(tree_path, entry.path, entry.pathlen);
>>>> ...
>>>
>>> The size_t conversion is trivially correct.
>>
>> I agree, and thanks for finding and fixing this issue.
>> ...
>>> One wonders if (even for this index-related code) we really need such
>>> careful management of growth, and could instead do with:
>>>
>>> 	strbuf_setlen(tree_path, base_path_len);
>>> 	strbuf_add(tree_path, entry.path, entry.pathlen);
>>> 	strbuf_addch(tree_path, '/');
>>
>> This would be my preferred way to go here.
>
> Yup.  _setlen() is still very useful to truncate an existing
> contents in a strbuf, but we should look at each use of _grow() with
> suspicion that it might be an mistaken attempt to "optimize" where
> there is not a room for optimization.
>
> There may be cases where tight and exact allocation is desirable but
> this is not such a codepath.  tree_path will not be overly long that
> we want to avoid extra allocation for giving us slack to prepare for
> reallocation.  And tree_path is passed to recusive calls to further
> be grown, which is exactly why we would want to use ALLOW_GROW() kind
> of allocation with slack to amortize the allocation cost.

Right you are.

Ren=C3=A9
