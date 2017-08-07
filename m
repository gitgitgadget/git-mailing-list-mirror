Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC9D2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdHGT4A convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 7 Aug 2017 15:56:00 -0400
Received: from 8.mo176.mail-out.ovh.net ([46.105.58.67]:58032 "EHLO
        8.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdHGT4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:56:00 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 3759C6AFF7;
        Mon,  7 Aug 2017 21:55:58 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 7 Aug
 2017 21:55:57 +0200
Subject: Re: [PATCH 1/4] imap-send: add wrapper to get server credentials if
 needed
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
References: <9687e182-1e23-f84d-3fad-83fdf15dba4c@morey-chaisemartin.com>
 <CAN0heSoA_Xm+14V49hjJBMT7PS_ge0wyhmuvKiw-MHD99rApYQ@mail.gmail.com>
 <fdd74c52-7d9a-b12e-2e1f-524479201701@morey-chaisemartin.com>
 <CAN0heSqVmrFwP7LdjDJmH0JivoCc+DhGtUiTSBs=8nTppzG79A@mail.gmail.com>
 <20170807194257.jrdmpvoseauz37uc@sigill.intra.peff.net>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Message-ID: <a4761418-0464-baa1-b415-836f33503eb8@morey-chaisemartin.com>
Date:   Mon, 7 Aug 2017 21:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <20170807194257.jrdmpvoseauz37uc@sigill.intra.peff.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: CAS1.indiv2.local (172.16.1.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 14253329874879965149
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkedugddugeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 07/08/2017 à 21:42, Jeff King a écrit :
> On Mon, Aug 07, 2017 at 07:18:32PM +0200, Martin Ågren wrote:
>
>>>> "cred.username" is checked further down, but now it will always be NULL,
>>>> no?
>>> You're right I missed this.
>>> Not sure if this is needed though.
>>> From what I understand this means the username/password are store for the next access to credential. but in the current state, there is only one.
>>> Maybe the credential_approved can be dropped ?
>> I'm no credentials-expert, but api-credentials.txt says this:
>>
>> "Credential helpers are programs executed by Git to fetch or save
>> credentials from and to long-term storage (where "long-term" is simply
>> longer than a single Git process; e.g., credentials may be stored
>> in-memory for a few minutes, or indefinitely on disk)."
>>
>> So the calls to approve/reject probably do matter in some scenarios.
> Right, this is important. credential_fill() may actually prompt the
> user, and we'd want to then pass along that credential for storage. Or
> the user may have changed their password, and the credential_reject() is
> the only thing that prevents us from trying an out-dated password over
> and over.
>
>> The current code is a bit non-obvious as we just discovered since it
>> duplicates the strings (for good reasons, I believe) and then still
>> refers to the originals (also for good reasons, I believe). I suppose
>> your new function could be called like
>>
>> server_fill_credential(&cred, srvc);
>>
>> That should limit the impact of the change, but I'm not sure it's a
>> brilliant interface. Just my 2c.
> That would work. I'm also tempted to say that imap_server_conf could
> just store the "struct credential" inside it. We could even potentially
> drop its parallel user/pass fields to minimize confusion.
>
> Once upon a time imap-send was a fork of another program, which is why
> most of its code isn't well-integrated with Git. But I think at this
> point there's very little chance of merging changes back and forth
> between the two.
>
> On the other hand, if we're hoping to get rid of this code in favor of
> the curl-based approach, then it's not worth spending time on
> cosmetic refactoring, as long as it still behaves correctly in the
> interim.
>
> -Peff

Looking at the code, it seems the tunnel mode always uses the legacy imap approach.
This would have to be ported to curl and stabilized before dropping the legacy code.
In the meantime, it might be worth doing a bit of cleanup.
And as I said in patch 4, I have a current IMAP account where it works without curl but not with curl (for unknown reason yet).
Meaning legacy needs to stay for a while. But switching to curl as default to get out all the bugs (hence this slightly broken patch series)

I think it would make sense to get patch 1 (fixed), 2 and 4 in to really test out the curl implementation and take some time to prepare another serie with code cleanups: dropping imap_server_conf parameters, storing cred therem etc.)

Nicolas



