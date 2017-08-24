Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B229320285
	for <e@80x24.org>; Thu, 24 Aug 2017 20:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbdHXUHs (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 16:07:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64148 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751168AbdHXUHr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 16:07:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFE749DDCF;
        Thu, 24 Aug 2017 16:07:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FSEaWeIZpRCy/g40qBjq546sL+Q=; b=ftsaNI
        b7fVb/AS7aS0intZHmjWSDH0K50AUeWObpGqOPB5dvIag/GUrqbRIl/TdW4NDsUg
        ZeBTw7ThtQRYxSjNnup7roe2/QDD/ZQlOE2Kv+y9TrX2Q1CkST7DeGZcYHtb1ivZ
        wR/6dYm0EkPK//SN1Y1OCb3ttmtj6/A1w/FWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i0V2x2CeTJptbFdzf5pMno/XOqbXI1nV
        0EUJCptuc5M6CItjiCT5dckZq5DG1+2CE/uZ4OQ2IgoQUmAD9UQVCSIKyHL3J9Ht
        Bc2Q2kEYbTB5lUXSQCzmAVUwzGph8PLL4iBX8eiWvx6cW9erqgHzp0xEf3HrMs89
        pr/d37r+U50=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC30D9DDCE;
        Thu, 24 Aug 2017 16:07:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 026529DDCC;
        Thu, 24 Aug 2017 16:07:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sonny Michaud <michaud.sonny@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Add stash entry count summary to short status output
References: <c3ac0335-4f41-40d9-00ee-2a4e115bcf7a@gmail.com>
Date:   Thu, 24 Aug 2017 13:07:44 -0700
In-Reply-To: <c3ac0335-4f41-40d9-00ee-2a4e115bcf7a@gmail.com> (Sonny Michaud's
        message of "Sun, 20 Aug 2017 00:53:04 -0400")
Message-ID: <xmqqshggvien.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E524FBBC-8907-11E7-ABEB-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sonny Michaud <michaud.sonny@gmail.com> writes:

> diff --git a/wt-status.c b/wt-status.c                                         
> index 77c27c511..651bb01f0 100644                                              
> --- a/wt-status.c                                                              
> +++ b/wt-status.c                                                              
> @@ -1827,6 +1827,15 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)                                                                          
>         fputc(s->null_termination ? '\0' : '\n', s->fp);                       
>  }                                                                             
>                                                                                
> +static void wt_shortstatus_print_stash_summary(struct wt_status *s)           
> +{                                                                             
> +       int stash_count = 0;                                                   
> +                                                                              
> +       for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);     

A singleton instance of this in wt_longstatus_print_stash_summary()
thing was OK, but let's not duplicate and spread the badness.  Have
a simple there-liner helper function "static int stash_count(void);"
that does the above and returns the stash_count, and use it from
both places.

> +       if (stash_count > 0)                                                   
> +    color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## Stash entries: %d", stash_count);                                                                    

That's a funny way to indent (dedent?) a body of an if() statement.

Don't scripts that read this output (I notice that this is also
called by wt_porcelain_print() function) expect that entries that
are led by "##" are about the current branch and its tracking
information?  

This patch would break these script by adding this new line using
the same "##" leader.

