Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57EF320281
	for <e@80x24.org>; Wed,  6 Sep 2017 23:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbdIFXo7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 19:44:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64310 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750944AbdIFXo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 19:44:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 313E5A66E3;
        Wed,  6 Sep 2017 19:44:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MBR5D+dfumizQK3EMl/T4bOAtz4=; b=jUc0N1
        JvY/bx/OYQJNftN/y5C1OnVQtVR/+Y9RMLtwK6npXvHH6xQv/o+Z5PNAaRBVStzr
        oUTW8exfnTlYboIVFqv4p1spCO4wInqQQM4OaRhfqovurzpz5S07kugcIFnnO0f/
        KjFBRBRAH/tPUa2uIsM7pnv5q9963GgTv4MRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bA4whJ7QrO8EvoEI4HABJ5+kQbxa/z8R
        QIuGeC9X9NFt1WLBtOO8whfac5OC1/wnNQ9tSA5wx/HFfp9njIq1+yfWDeH61NTW
        5c8axPdrL093vFa8FEcRgv2+1wVi8pqeynkC1jtkfT4oPj4xBdjGVeEc6msE8UPo
        ZwVYAidAoBs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28CD9A66E2;
        Wed,  6 Sep 2017 19:44:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88EEEA66E1;
        Wed,  6 Sep 2017 19:44:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2] merge-recursive: change current file dir string_lists to hashmap
References: <20170906222834.77116-1-kewillf@microsoft.com>
Date:   Thu, 07 Sep 2017 08:44:56 +0900
In-Reply-To: <20170906222834.77116-1-kewillf@microsoft.com> (Kevin Willford's
        message of "Wed, 6 Sep 2017 16:28:34 -0600")
Message-ID: <xmqqmv672xzb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63EC35AA-935D-11E7-91C8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kewillf@microsoft.com> writes:

> The code was using two string_lists, one for the directories and
> one for the files.  The code never checks the lists independently
> so we should be able to only use one list.  The string_list also
> is a O(log n) for lookup and insertion.  Switching this to use a
> hashmap will give O(1) which will save some time when there are
> millions of paths that will be checked.
>
> Also cleaned up a memory leak and method where the return was not
> being used.
>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>  merge-recursive.c | 76 ++++++++++++++++++++++++++++++++++++++++---------------
>  merge-recursive.h |  3 +--
>  2 files changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1494ffdb82..ebfe01017f 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -24,6 +24,31 @@
>  #include "dir.h"
>  #include "submodule.h"
>  
> +struct path_hashmap_entry {
> +	struct hashmap_entry;

You seem to have lost the squash you privately agreed to that is
needed in order to make it compile?
