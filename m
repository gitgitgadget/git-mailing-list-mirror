Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB38E1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 05:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKOFtL (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 00:49:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54171 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOFtL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 00:49:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D3DF39A50;
        Fri, 15 Nov 2019 00:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dHQc58pzxG2EBgXBh2tn0Qsks18=; b=tHDSc5
        gpBRn01qsB1FSZqBwgoG5rrKeZuZZzhIa22ZV1TYEFIPWDKKLQv4ekDefSL4+UjH
        ebontpJnki7aphqfQ+aU0NBqvybne17uumB0ejvzOpxsa2kjpXNWyR/Pn5ClkkH7
        gtb+ncyw1BTBRRm+YQ2wv0xyzXFkXlKzc5Xg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nvTYiHOVAXGWpC9tL1K8/glZeC9aXT+c
        SVGDTGL7u8DTSr32FcM95c4eYF9jAIRcBhcKgn4OGgmQ9CnTS4P8W8myh+WLR6as
        jRAZkkF+tT9Jf49llCyGbd704OB/M47dZDYyc7IKhZBkrvdNAY9mGOXFZ0q7Dd7v
        WmUOniu5mo4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3539439A4F;
        Fri, 15 Nov 2019 00:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 916C839A4E;
        Fri, 15 Nov 2019 00:49:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] rebase: prepare cmd before choosing action
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
        <20191114163549.7648-2-rybak.a.v@gmail.com>
Date:   Fri, 15 Nov 2019 14:49:07 +0900
In-Reply-To: <20191114163549.7648-2-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Thu, 14 Nov 2019 17:35:47 +0100")
Message-ID: <xmqqk1817kq4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4362678-076B-11EA-AFDC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 4a20582e72..9457912f9d 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1595,6 +1595,21 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			trace2_cmd_mode(action_names[action]);
>  	}
>  
> +	for (i = 0; i < exec.nr; i++)
> +		if (check_exec_cmd(exec.items[i].string))
> +			exit(1);
> +
> +	if (exec.nr) {
> +		int i;

This masks the outer "i" (I am assuming such a thing exists, judging
from its use in the above loop you added), but I do not see a need
for it.  With or without this masked local "i", the value of outer "i"
will be equal to exec.nr+1 after the control leaves this if block.

> +		imply_interactive(&options, "--exec");
> +
> +		strbuf_reset(&buf);
> +		for (i = 0; i < exec.nr; i++)
> +			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
> +		options.cmd = xstrdup(buf.buf);
> +	}
> +
