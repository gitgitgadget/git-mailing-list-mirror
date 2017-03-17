Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB9920951
	for <e@80x24.org>; Fri, 17 Mar 2017 18:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbdCQSRT (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 14:17:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62217 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751047AbdCQSRT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 14:17:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D58475CC2;
        Fri, 17 Mar 2017 14:17:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mf2AsiAYuYUst7kiFlI4cDTCoEk=; b=LBrW4c
        JKsKqXEfKbMzFux2RuwfenU+ds/ITlM8EyF2shVDdtvGsaOWFV/noLK0nzgf1//K
        oe1W5kO/z7H9dgOHLdyQylSrfKh1qDuMkoudA/MqV6vKEiqN+khyvFLG0TiyacRI
        yVJsIIWo62zRIk6uJr4MTPWwmV56QLZNR9LXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RlM+WpyQFDHFgbsol/PuRvmOTlUw+K7k
        Jzs4BtlrKr57Ipb+OT/om9pK38U0qHINpYA0bmd0xkGcpN8r0SqHHGfmFJl72iuS
        CZb588TsD5/FOtIZ2cDOMIse3JpS4SUSrkXMH77iGfaRje6mhCMKmrNYwnIcNfSv
        4enRSsJP5UQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85B2F75CC1;
        Fri, 17 Mar 2017 14:17:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EBA0375CC0;
        Fri, 17 Mar 2017 14:17:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH 1/2] describe: localize debug output fully
References: <105f48ad2ae1aa9c88ce6088e6b304294bec0835.1489763302.git.git@drmicha.warpmail.net>
Date:   Fri, 17 Mar 2017 11:17:10 -0700
In-Reply-To: <105f48ad2ae1aa9c88ce6088e6b304294bec0835.1489763302.git.git@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Fri, 17 Mar 2017 16:12:32 +0100")
Message-ID: <xmqqpohf7opl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0D9A810-0B3D-11E7-BC23-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git describe --debug localizes all debug messages but not the terms
> head, lightweight, annotated that it outputs for the candidates.
> Localize them, too.
>
> Also, increase the width of that field to create room for the translated
> terms.

If you worry about something not fitting within 11, there is no
guarantee that 15 is enough.  Wouldn't it be saner to make that
_("%-11s %8d %s\n") localizable, too?

Alternatively,

	if (debug) {
		static int label_width = -1;
		if (label_width < 0) {
			int i;
			for (i = 0; i < ARRAY_SIZE(prio_names); i++)
				... do a one-time width measurement
                                ... to set label_width
		}
		fprintf(stderr, "%-.*s %8d %s\n", 
		                label_width, _(prio_names[t->name->prio]),
				...);
	...

or something like that, perhaps?

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Ralf: this is just the context for the following l10-de patch
>
>  builtin/describe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 76c18059bf..1a760c16f9 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -49,7 +49,7 @@ struct commit_name {
>  };
>  
>  static const char *prio_names[] = {
> -	"head", "lightweight", "annotated",
> +	N_("head"), N_("lightweight"), N_("annotated"),
>  };
>  
>  static int commit_name_cmp(const struct commit_name *cn1,
> @@ -396,8 +396,8 @@ static void describe(const char *arg, int last_one)
>  	if (debug) {
>  		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
>  			struct possible_tag *t = &all_matches[cur_match];
> -			fprintf(stderr, " %-11s %8d %s\n",
> -				prio_names[t->name->prio],
> +			fprintf(stderr, " %-15s %8d %s\n",
> +				_(prio_names[t->name->prio]),
>  				t->depth, t->name->path);
>  		}
>  		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
