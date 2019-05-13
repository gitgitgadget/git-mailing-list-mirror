Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A601F461
	for <e@80x24.org>; Mon, 13 May 2019 02:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfEMCoZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 22:44:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59885 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfEMCoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 May 2019 22:44:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 614A114DBF7;
        Sun, 12 May 2019 22:44:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FPFOZsasL4CyLXJRRziwRwW4p78=; b=Pv/cns
        fjQNMM1vtuXBpnhmNAH4u9E1PaFrcRV3oRIQx83iDQgV0CLCjgIDzqdIbEBPdaHj
        KePfO75HADWTvNSxN8+oi487AIemxekNVLlQwSX7VKIOqq8lYEaHS628x231Yk2l
        nDktvHDmXqSMUdrtlDrxqfLULJ5YYhivmV/yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yL+HePlhYYIqQSNlb/Bf9n4w0dvMkfyn
        FSMxCyhgvSDZ3O3MAGq+u5hsV2pkFOGwUF+IzbB54kM0Ov43n2ofn635Sc9invVz
        j7xwsFgid55Gvdsx0yMo1Qhsb8ZpGqErVIbcUFk9hIeWlsDt/R26aq5eR8mGXluD
        NX4qmIVeE9M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59B2814DBF6;
        Sun, 12 May 2019 22:44:23 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDC0B14DBF5;
        Sun, 12 May 2019 22:44:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3 2/2] format-patch: teach format.notes config option
References: <cover.1557327652.git.liu.denton@gmail.com>
        <cover.1557513353.git.liu.denton@gmail.com>
        <df864c4adf4dcab5f959007f87b1c4d0eafecb52.1557513353.git.liu.denton@gmail.com>
Date:   Mon, 13 May 2019 11:44:21 +0900
In-Reply-To: <df864c4adf4dcab5f959007f87b1c4d0eafecb52.1557513353.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 10 May 2019 14:37:05 -0400")
Message-ID: <xmqqimufdqey.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03B69180-7529-11E9-8F64-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> @@ -864,6 +866,20 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  			from = NULL;
>  		return 0;
>  	}
> +	if (!strcmp(var, "format.notes")) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		rev->show_notes = 1;
> +		if (!strcmp(value, "standard")) {
> +			rev->notes_opt.use_default_notes = 1;
> +		} else {
> +			strbuf_addstr(&buf, value);
> +			expand_notes_ref(&buf);
> +			string_list_append(&rev->notes_opt.extra_notes_refs,
> +					strbuf_detach(&buf, NULL));
> +		}
> +		return 0;
> +	}

Unlike the command line option parser, this does not seem to touch
rev->show_notes_given at all.  Intended?  I am wondering how well
this implementation meshes with what 66b2ed09 ("Fix "log" family not
to be too agressive about showing notes", 2010-01-20) wanted to do,
which 894a9d33 ("Support showing notes from more than one notes
tree", 2010-03-12) later extended.

> +test_expect_success 'format-patch notes output control' '
> +	git notes add -m "notes config message" HEAD &&
> +	test_when_finished git notes remove HEAD &&
> +
> +	git format-patch -1 --stdout >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes >out &&
> +	grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes --notes >out &&
> +	grep "notes config message" out &&
> +
> +	test_config format.notes standard &&

I think we tend to spell these things "default".

Alternatively, the format.notes configuration can be "bool or text",
and make the variable set to 'true' mean "show notes, using the
default ref".

> +	git format-patch -1 --stdout >out &&
> +	grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes >out &&
> +	grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes --notes >out &&
> +	grep "notes config message" out
> +'

OK.

> +test_expect_success 'format-patch with multiple notes refs' '
> +	git notes --ref note1 add -m "this is note 1" HEAD &&
> +	test_when_finished git notes --ref note1 remove HEAD &&
> +	git notes --ref note2 add -m "this is note 2" HEAD &&
> +	test_when_finished git notes --ref note2 remove HEAD &&
> + ...
> +	git format-patch -1 --stdout --notes=note1 --notes=note2 >out &&
> +	grep "this is note 1" out &&
> +	grep "this is note 2" out &&

Do we promise the order in which these two lines appear in the output?

> +	test_config format.notes note1 &&
> +	git format-patch -1 --stdout >out &&
> +	grep "this is note 1" out &&
> +	! grep "this is note 2" out &&
> +	git format-patch -1 --stdout --no-notes >out &&
> +	! grep "this is note 1" out &&
> +	! grep "this is note 2" out &&
> +	git format-patch -1 --stdout --notes=note2 >out &&
> +	grep "this is note 1" out &&
> +	grep "this is note 2" out &&

So format.notes say note1 but the command line explicitly asks it
wants note from note2, but the command still gives from note1
anyway.

> +	git format-patch -1 --stdout --no-notes --notes=note2 >out &&
> +	! grep "this is note 1" out &&
> +	grep "this is note 2" out &&

And there is a way to work it around, i.e. clear everything
configured with --no-notes and then name the one you want from the
command line.

I am not sure if the above is consistent with how our options and
configurations interact in general.  Shouldn't the --notes=note2
alone in the earlier example cancel format.notes=note1 configured?

> +	git config --add format.notes note2 &&
> +	git format-patch -1 --stdout >out &&
> +	grep "this is note 1" out &&
> +	grep "this is note 2" out &&
> +	git format-patch -1 --stdout --no-notes >out &&
> +	! grep "this is note 1" out &&
> +	! grep "this is note 2" out
> +'
> +
>  echo "fatal: --name-only does not make sense" > expect.name-only
>  echo "fatal: --name-status does not make sense" > expect.name-status
>  echo "fatal: --check does not make sense" > expect.check
