Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F1A202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 02:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933885AbdKBCSp (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 22:18:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53464 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751988AbdKBCSo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 22:18:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B23AAAB777;
        Wed,  1 Nov 2017 22:18:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=32+gjtRlHvwH
        GYzprVtvElkum7Y=; b=x7CyNDfK6oLYzbhQWYTUHlf0G7+8iOJaQxKa0n8MSviy
        g+XMcnF5ytMlZReoejbBC/bdSJyyQ2a4mGwHHQizlr7bBH00UFrHetU1R+czVL6y
        LqjlOWIB7EssIWZH1D6mR+xBcEGQu2x7u7Qv1ZZN6yXjdQO/gF8/XtQUWoqxLCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=C8NfVp
        cDaIoJmriOAJ4g9Zc3seYOebO2a9DxykDTpooK/HVCXzoBSNOyOPbYpmTlp9HWbv
        jWZtMdb0ytilVIOZnyHQ4UbqHyTnf3JBENrlTIsfgSK1ykBT/vDiGJmzbxjDRa1N
        ErRGhHhSlFuQFzt+K5ShFcg69e2xheDDJA1c4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9C19AB776;
        Wed,  1 Nov 2017 22:18:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BF43AB775;
        Wed,  1 Nov 2017 22:18:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] imap-send: handle NULL return of next_arg()
References: <2d466b78-77fc-fa2c-c5e1-7b8737a00958@web.de>
Date:   Thu, 02 Nov 2017 11:18:42 +0900
In-Reply-To: <2d466b78-77fc-fa2c-c5e1-7b8737a00958@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 1 Nov 2017 18:03:20 +0100")
Message-ID: <xmqqefphs9rx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25F3ED7C-BF74-11E7-9DDB-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> @@ -807,6 +816,8 @@ static int get_cmd_result(struct imap_store *ctx, s=
truct imap_cmd *tcmd)
>  			if (cmdp->cb.cont || cmdp->cb.data)
>  				imap->literal_pending =3D 0;
>  			arg =3D next_arg(&cmd);
> +			if (!arg)
> +				arg =3D "";

This is being cute and needs reading of the post-context a bit.

         arg =3D next_arg(&cmd);
+        if (!arg)
+                arg =3D "";
         if (!strcmp("OK", arg))
                 resp =3D DRV_OK;
         else {
                 if (!strcmp("NO", arg))
                         resp =3D RESP_NO;
                 else /*if (!strcmp("BAD", arg))*/
                         resp =3D RESP_BAD;
                 fprintf(stderr, "IMAP command '%s' returned response (%s=
) - %s\n",
                         !starts_with(cmdp->cmd, "LOGIN") ?
                                         cmdp->cmd : "LOGIN <user> <pass>=
",
                                         arg, cmd ? cmd : "");
         }
         if ((resp2 =3D parse_response_code(ctx, &cmdp->cb, cmd)) > resp)
                 resp =3D resp2;


Because the existing code does not explicitly check for "BAD", we
get RESP_BAD, which is what we want in the end, and the error
message we give has "returned response (%s)" which is filled with
this empty string.

I notice that when this change matters, i.e. we hit a premature end,
next_arg() that yielded NULL would have cleared cmd.  That is OK for
the fprintf() we see above, but wouldn't it hit parse_response_code()
that is shared between good and bad cases?  The function starts like
so:

    static int parse_response_code(struct imap_store *ctx, struct imap_cm=
d_cb *cb,
                                   char *s)
    {
            struct imap *imap =3D ctx->imap;
            char *arg, *p;

            if (*s !=3D '[')
                    return RESP_OK;		/* no response code */

so we will get an immediate NULL dereference, it appears.

The fixes in other hunks looked OK (and not cute).

