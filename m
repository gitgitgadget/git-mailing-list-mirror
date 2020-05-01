Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97719C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 13:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355E3208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 13:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sorrel.sh header.i=@sorrel.sh header.b="P3ReINjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbgEANk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 09:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731358AbgEANkx (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 09:40:53 -0400
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61457C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sorrel.sh;
         s=mythic-beasts-k1; h=Date:To:From:Subject;
        bh=TgMMdVSALH6dbkp+aanWpLoDzf/lS3EO+HDykT/aYYM=; b=P3ReINjm60Dq4490KqJmUXJ1+V
        jyIN1xD8rodcPLdhJpXb2qdaoUJs8k2XJsuJ5Z3IrQf6nKuEN0Ko/X3fYNiOedZTEexJwt59g/l/z
        nxwQ0BW/bNxwVpYANhZ/uc3t2ISN4EDQXwJDbj8lJEGnwtRylOw0lUYzpwaJCRogAWMokPdJyD2JJ
        fTLlnAvz8awj+IS8be67XXORMuyIfgn3rN08nu2+ED7KTkcHwoh0xwJq7af+kplPI8Dv3xqOjKvH9
        EQ7M+tS3KnTZznIDsg1+FglIuLHeur5vlcOQFp0p49wcfCAE2GdvzuHzagFJtlA0t/ZhSVCQ4eqlH
        F3zGwerQ==;
Received: from [212.56.100.202] (port=51953 helo=localhost)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <ash@sorrel.sh>)
        id 1jUVt8-0004Oq-0i; Fri, 01 May 2020 14:40:50 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>, "Boxuan Li" <liboxuan@connect.hku.hk>,
        "Alban Gruin" <alban.gruin@gmail.com>
Subject: Re: [PATCH v2] userdiff: support Markdown
From:   "Ash Holland" <ash@sorrel.sh>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Fri, 01 May 2020 12:49:54 +0100
Message-Id: <C2FDC85CN8B8.8IVFPUOV0BHA@what>
In-Reply-To: <xmqq4kt0ubgu.fsf@gitster.c.googlers.com>
X-BlackCat-Spam-Score: 39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Apr 30, 2020 at 11:31 AM BST, Junio C Hamano wrote:
> This is "possibly just a bit indented run of up to 6 hashes, either
> ending the line by itself or if some text follows, there must be a
> SP after the hashes".
>
> If I had a line that has a hash, HT and then "Hello, world", would
> everybody's markdown implementation reject it as a header, because
> the whitespace after the run of hashes is not a SP?

Good point, Pandoc at least accepts a tab as well as a space there.
(Some markdown implementations don't even require the whitespace, so any
line starting with #{1,6} would be a heading, but that runs into
problems with paragraphs containing a line starting with "#", which is
not uncommon.)

> Also, allowing only the hashes might be spec-compliant, but how
> useful would it be to see just a sequence of 4 hashes without any
> text after "@@ -100,5, +100,6 @@" in the diff output?
>
> Taking all that together, my suspicion is
>
> "^ {0,3}#{1,6}[ \t]"
>
> i.e. "possibly slightly indented run of 6 hashes, with a whitespace
> to catch the headers with real contents and nothing else" might be
> more practically useful. I dunno.

Sure, that looks plausible. I don't have a strong opinion on whether
it's more useful to be consistent (and show the last heading, even if it
doesn't contain any text) or to try as hard as possible to just show
"some text", even if it's not the last heading, but two people have now
suggested changing it, so I'll submit a v3 with your suggested pattern.
