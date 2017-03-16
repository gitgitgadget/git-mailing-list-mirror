Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE1C20323
	for <e@80x24.org>; Thu, 16 Mar 2017 18:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbdCPSdm (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 14:33:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57091 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752668AbdCPSdk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 14:33:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8336E6A562;
        Thu, 16 Mar 2017 14:33:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ap+7cEHWkZKWnwlhVuhYPHCBYwM=; b=oMfl4y
        iYyyGn3BVoXon+DaFwkyz3O5AVwKwFigkdGg+9zZo6GWSGVNerzdt7Jnh9+zJRHn
        BDt+Dg6uhXJUMz2O2c68PTncDDv/B+Vh1OTJM/tK+BoaHkIY1/4l4XH92BfYudA1
        nAd4uA+eQzgnxd29MMf/Wbzx0kGGJKqGcCHWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MW0cu2h3w97pGRmkGTvVuUC+HJm7BF2W
        1x0dlOWPehCOOB3INiIWhqkTUoUB5ijsxJe2YtM9+FHY9lUAepTDg8vTLqhF5jmX
        LzKhiyqLJ56zZSkgVnXWeCOsH73xwKLeir9AWLcr3oL4uc8/R1zUo6zYcxiVA+7W
        I/Q1I0nFvSA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B6E96A560;
        Thu, 16 Mar 2017 14:33:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E02FF6A55F;
        Thu, 16 Mar 2017 14:33:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 4/5] replace snprintf with odb_pack_name()
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
        <20170316142715.zdoikgyy3difeafk@sigill.intra.peff.net>
Date:   Thu, 16 Mar 2017 11:33:36 -0700
In-Reply-To: <20170316142715.zdoikgyy3difeafk@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 16 Mar 2017 10:27:15 -0400")
Message-ID: <xmqqvar9ax6n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 121BF68A-0A77-11E7-9C60-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +	struct strbuf name = STRBUF_INIT;
>  	int err;
>  
>  	if (!from_stdin) {
> @@ -1402,14 +1402,13 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  		int keep_fd, keep_msg_len = strlen(keep_msg);
>  
>  		if (!keep_name)
> -			snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
> -				 get_object_directory(), sha1_to_hex(sha1));
> +			odb_pack_name(&name, sha1, "keep");
>  
> -		keep_fd = odb_pack_keep(keep_name ? keep_name : name);
> +		keep_fd = odb_pack_keep(keep_name ? keep_name : name.buf);
>  		if (keep_fd < 0) {
>  			if (errno != EEXIST)
>  				die_errno(_("cannot write keep file '%s'"),
> -					  keep_name ? keep_name : name);
> +					  keep_name ? keep_name : name.buf);
>  		} else {
>  			if (keep_msg_len > 0) {
>  				write_or_die(keep_fd, keep_msg, keep_msg_len);
> @@ -1417,28 +1416,22 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  			}
>  			if (close(keep_fd) != 0)
>  				die_errno(_("cannot close written keep file '%s'"),
> -					  keep_name ? keep_name : name);
> +					  keep_name ? keep_name : name.buf);
>  			report = "keep";
>  		}
>  	}


The patch as-posted is obviously with less damage to the current
code, but the above makes me wonder if it makes simpler to do

	if (keep_name)
		strbuf_addstr(&name, keep_name);
	else
		odb_pack_name(&name, sha1, "keep");

so that we can always use name.buf without having to do "?:" thing.
