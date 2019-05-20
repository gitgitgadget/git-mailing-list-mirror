Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E701F462
	for <e@80x24.org>; Mon, 20 May 2019 18:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfETS3L (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 14:29:11 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:32884 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbfETS3L (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 May 2019 14:29:11 -0400
Received: from resomta-po-13v.sys.comcast.net ([96.114.154.237])
        by resqmta-po-09v.sys.comcast.net with ESMTP
        id SmJYhAx6eSk79Sn26hHRsl; Mon, 20 May 2019 18:29:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1558376950;
        bh=WpXUhD4uo0TMnihUuRmmePErgT9Vd+IsepdI58FPgPU=;
        h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
         Message-Id:To;
        b=I8RnscyORIRyDHy+o2m6kc1EEULWjR1Xg2x6SahIIr5MwnXBRT7HZvG7yo4AUhPgT
         im43/c9yXIXLrJpQSymLGkkuYYDAGgytd+gx+jU8+HpfIL0nGVaaVq+123sY+Igokp
         0Cxj+iU5gvvhncsraF1jR1fS5p6CWsUTqQbItsIQCa9WttyRCF1zn69/jPgF7mkCd+
         xIvL4tQtngEirRCV60LLTNjpZQamcr87bSPdeRpTIo3yCOMr7FZlQvGK5SzL71UPtj
         NMksEgEAilYmQ45erTxNNvRCwZEZW28gpM2ghnpiL99aHXnaDiVDemEG1UgExO7IqF
         r7Ii1Flv7Z9dA==
Received: from [IPv6:2620:15c:2ce:200:edad:e98f:19e5:a93] ([IPv6:2620:15c:2ce:200:edad:e98f:19e5:a93])
        by resomta-po-13v.sys.comcast.net with ESMTPA
        id Sn1dhyFv7M853Sn1ihxMBc; Mon, 20 May 2019 18:29:08 +0000
X-Xfinity-VMeta: sc=0;st=legit
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 3/3] list-objects-filter: implement composite filters
From:   Matthew DeVore <matvore@comcast.net>
In-Reply-To: <1E174CAA-BD57-400B-A83B-4AABFAFBC04B@comcast.net>
Date:   Mon, 20 May 2019 11:28:41 -0700
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDE68B7A-C621-4CA8-8039-C432ACBC4FE4@comcast.net>
References: <20190514001610.GA136746@google.com>
 <cover.1558030802.git.matvore@google.com>
 <02a8c9b017d8df056d7e90aff907d6e0b5506467.1558030802.git.matvore@google.com>
 <xmqqwoip3gp0.fsf@gitster-ct.c.googlers.com>
 <1E174CAA-BD57-400B-A83B-4AABFAFBC04B@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 2019/05/17, at 6:17, Matthew DeVore <matvore@comcast.net> wrote:
>=20
> We do have to require the combine operator (& or +) and % be encoded. =
For other operators, there are three options:
>=20
> ...
> 3. Require encoding of a couple of "reserved" characters that don't =
appear in filters now, and don't typically appear in UNIX path names. =
This would allow for expansion later. For instance, "~&%*+|(){}!\" plus =
the ASCII range [0, 0x20] and single and double quotes - do not allow =
encoding of anything else.
>=20
> 4. Same requirements as 3, but permit encoding of other arbitrary =
characters.

I tried implementing the reserved characters idea, and considering that
it was a small amount of code, I think it's worth it:

+static const char *RESERVED_NON_WS =3D "\"\\'[]{}!@#$^~*+";
+
+static int has_reserved_character(
+       struct strbuf *sub_spec, struct strbuf *errbuf)
+{
+       const char *c =3D sub_spec->buf;
+       while (*c) {
+               if (*c <=3D ' ' || *strchr(RESERVED_NON_WS, *c))
+                       goto found_reserved;
+               c++;
+       }
+
+       return 0;
+
+found_reserved:
+       if (errbuf)
+               strbuf_addf(errbuf, "must escape char in sub-spec: %c", =
*c);
+       return 1;
+}
+

