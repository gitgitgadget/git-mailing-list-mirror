Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99F7E92FD6
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 23:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjJEXIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 19:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJEXF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 19:05:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C968BD59
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 16:01:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A2AD1A4D5C;
        Thu,  5 Oct 2023 19:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=HbcuMScn8tQ43LvgVqLgM+Sww6XBxoHtGJxqRR
        RHx8Y=; b=xQjfzysKpQDVWJr5lsiuwsFU4aUKTWIZxgmgetXLEYykPl7cxmPrwy
        40xWsR/RJvDBg4ojaXiGAuUHM3miRM+dxLf/T2glgEXLqeT0etM551Z2MsVv1O7e
        trY7nIR9Cxhj2M5yUSqvrKHhvCqdlS/WxKHAyIggOkclsIIV8hyJo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 109031A4D5A;
        Thu,  5 Oct 2023 19:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 139681A4D57;
        Thu,  5 Oct 2023 19:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision: clear decoration structs during
 release_revisions()
In-Reply-To: <20231005213014.GB986467@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 5 Oct 2023 17:30:14 -0400")
References: <20231005212802.GA982892@coredump.intra.peff.net>
        <20231005213014.GB986467@coredump.intra.peff.net>
Date:   Thu, 05 Oct 2023 16:00:54 -0700
Message-ID: <xmqq34yoekt5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D87FF94-63D3-11EE-8C6E-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

Wow, nested maze of callbacks make my head spin ;-) but they all
look reasonable.  Thanks.

> diff --git a/line-log.c b/line-log.c
> index 790ab73212..24a1ecb677 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1327,3 +1327,13 @@ int line_log_filter(struct rev_info *rev)
>  
>  	return 0;
>  }
> +
> +static void free_void_line_log_data(void *data)
> +{
> +	free_line_log_data(data);
> +}
> +
> +void line_log_free(struct rev_info *rev)
> +{
> +	clear_decoration(&rev->line_log_data, free_void_line_log_data);
> +}
> diff --git a/line-log.h b/line-log.h
> index adff361b1b..4291da8d79 100644
> --- a/line-log.h
> +++ b/line-log.h
> @@ -60,4 +60,6 @@ int line_log_process_ranges_arbitrary_commit(struct rev_info *rev,
>  
>  int line_log_print(struct rev_info *rev, struct commit *commit);
>  
> +void line_log_free(struct rev_info *rev);
> +
>  #endif /* LINE_LOG_H */
> diff --git a/revision.c b/revision.c
> index e789834dd1..219dc76716 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3083,6 +3083,11 @@ static void release_revisions_mailmap(struct string_list *mailmap)
>  
>  static void release_revisions_topo_walk_info(struct topo_walk_info *info);
>  
> +static void free_void_commit_list(void *list)
> +{
> +	free_commit_list(list);
> +}
> +
>  void release_revisions(struct rev_info *revs)
>  {
>  	free_commit_list(revs->commits);
> @@ -3100,6 +3105,10 @@ void release_revisions(struct rev_info *revs)
>  	diff_free(&revs->pruning);
>  	reflog_walk_info_release(revs->reflog_info);
>  	release_revisions_topo_walk_info(revs->topo_walk_info);
> +	clear_decoration(&revs->children, free_void_commit_list);
> +	clear_decoration(&revs->merge_simplification, free);
> +	clear_decoration(&revs->treesame, free);
> +	line_log_free(revs);
>  }
>  
>  static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
> diff --git a/t/t4217-log-limit.sh b/t/t4217-log-limit.sh
> index 6e01e2629c..613f0710e9 100755
> --- a/t/t4217-log-limit.sh
> +++ b/t/t4217-log-limit.sh
> @@ -2,6 +2,7 @@
>  
>  test_description='git log with filter options limiting the output'
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
>  test_expect_success 'setup test' '
