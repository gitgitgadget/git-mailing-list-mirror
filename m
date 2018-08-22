Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFDD1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeHVUZF (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 16:25:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:51902 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726842AbeHVUZF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 16:25:05 -0400
Received: (qmail 22167 invoked by uid 109); 22 Aug 2018 16:59:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 16:59:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1532 invoked by uid 111); 22 Aug 2018 16:59:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 12:59:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 12:59:23 -0400
Date:   Wed, 22 Aug 2018 12:59:23 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180822165923.GA14878@sigill.intra.peff.net>
References: <20180822030344.GA14684@sigill.intra.peff.net>
 <20180822053626.GB535143@genre.crustytoothpaste.net>
 <20180822060735.GA13195@sigill.intra.peff.net>
 <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
 <d1fafc75-d6e4-d363-d600-579c200aca43@gmail.com>
 <20180822151703.GB32630@sigill.intra.peff.net>
 <CACsJy8B+FN6W32ZUgetXbEJ=Ld5ZDHHhNWVz2aiZLZG1_qA+FQ@mail.gmail.com>
 <CACsJy8DifmYtDE4D58yVM7rYhfJFe8p-t9bXgMmMsw=txxmzHA@mail.gmail.com>
 <20180822162609.GA11904@sigill.intra.peff.net>
 <7ea416cf-b043-1274-e161-85a8780b8e1c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ea416cf-b043-1274-e161-85a8780b8e1c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 12:49:34PM -0400, Derrick Stolee wrote:

> > Yes, that was what I meant. We actually did switch to that hand-rolled
> > loop, but later we went back to memcmp in 0b006014c8 (hashcmp: use
> > memcmp instead of open-coded loop, 2017-08-09).
> 
> Looking at that commit, I'm surprised the old logic was just a for
> loop, instead of a word-based approach, such as the following:
> [...]
> +struct object_id_20 {
> +       uint64_t data0;
> +       uint64_t data1;
> +       uint32_t data2;
> +};
> +
>  static inline int hashcmp(const unsigned char *sha1, const unsigned char
> *sha2)
>  {
> -       return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +       if (the_hash_algo->rawsz == 20) {
> +               struct object_id_20 *obj1 = (struct object_id_20 *)sha1;
> +               struct object_id_20 *obj2 = (struct object_id_20 *)sha2;

I wonder if you're potentially running afoul of alignment requirements
here.

-Peff
