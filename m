Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8658220248
	for <e@80x24.org>; Fri,  1 Mar 2019 17:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbfCARez (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 12:34:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58174 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbfCARey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 12:34:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D20F54318E;
        Fri,  1 Mar 2019 12:34:49 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=s5OiqYGadRfohMobNne7+ejV/
        20=; b=ZiIKNElTpAPSSV74HdTLTpwYynSD4zh/Pa24ifIBfIG6ufraXTnRoZV8z
        CDmLuBahLJJhnd3dS/flzbKO2T35yw901F5MaEF3GR1oxW8g11D/tJSRec0RdO2S
        7zr6VpROEfLn0rGrTW8gQ+kyO+LBT54X/Lqk20hJrk9BvsqMAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=KfKKXeEgy+O2arlGnXz
        oFPyu3IIhAVAsCuZ3c/QQqEfxk4knZpv1bTvh/W4yYRf20fUk03fl2cFls37RsWQ
        /HV/R02I3l8ZFPlkWhF1v+UuXe5eTCs7zyZnjsdrUf1fTaVz1bzJcPk2wwM81g03
        88TwuuBiCKq4YvJ3qZrT28cw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC2FE4318D;
        Fri,  1 Mar 2019 12:34:49 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 784744318B;
        Fri,  1 Mar 2019 12:34:46 -0500 (EST)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
Date:   Fri,  1 Mar 2019 12:34:40 -0500
Message-Id: <20190301173443.16429-1-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228230506.GA20625@sigill.intra.peff.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 4ECA5A68-3C48-11E9-AA74-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> I can reproduce your problem, though the test you included passes for m=
e
> even with the current tip of master.

Oh, hrm.  I think the issue is that completion.commands needs to be
set in the global (or system-wide) config, via test_config_global
rather than the local repo config which test_config sets.

In hindsight, that seems obvious.  But it's probably worth noting
that where completion.commands is documented, for anyone who might
spend a few cycles trying to configure it on a per-repo basis before
realizing it doesn't work.

> I suspect this is the problem:
>=20
> diff --git a/help.c b/help.c
> index 520c9080e8..026f881715 100644
> --- a/help.c
> +++ b/help.c
> @@ -393,8 +393,8 @@ void list_cmds_by_config(struct string_list *list)
>  		const char *p =3D strchrnul(cmd_list, ' ');
> =20
>  		strbuf_add(&sb, cmd_list, p - cmd_list);
> -		if (*cmd_list =3D=3D '-')
> -			string_list_remove(list, cmd_list + 1, 0);
> +		if (sb.buf[0] =3D=3D '-')
> +			string_list_remove(list, sb.buf + 1, 0);
>  		else
>  			string_list_insert(list, sb.buf);
>  		strbuf_release(&sb);
>=20
> though I can't help but wonder if the whole thing would be simpler usin=
g
> string_list_split().

That does indeed fix things (as does SZEDER's similar version, which
arrived only a few seconds later).  Thanks to both of you for the
very quick replies!

I'll leave it to those who know better to follow up with a change to
use string_list_split().

Here's a first stab at improving the docs and fixing the bug.

Jeff King (1):
  completion: fix multiple command removals

Todd Zullinger (2):
  doc: note config file restrictions for completion.commands
  t9902: test multiple removals via completion.commands

 Documentation/config/completion.txt | 3 ++-
 Documentation/git.txt               | 3 ++-
 help.c                              | 4 ++--
 t/t9902-completion.sh               | 8 ++++++++
 4 files changed, 14 insertions(+), 4 deletions(-)

Published-as: https://github.com/tmzullinger/git/releases/tag/completion.=
commands-v1

--=20
Todd
