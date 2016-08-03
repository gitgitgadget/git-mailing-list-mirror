Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 986731F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbcHCVgL (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:36:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932644AbcHCVgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:36:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 892E4317E2;
	Wed,  3 Aug 2016 17:36:08 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y6O8h187f7f6RYWlMUqEitP0Gw0=; b=gE/SgB
	WpRKJgjZQcT5rItXWz4himK3tVZ9EeokyB/b6UolmPgik1pjwRpdpR4we4I16Rrb
	owSeELVaDy+RfuYWc1q7lZPVtZ2uhKfGjowe1SxYma0yz8xknUzko7Uh2IJ/tGek
	HV/ibLcP+ho5ogZDm//c0PX8gk8vSFnKswWq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GY+8lwiw5z83mR+GbwS+snNZ9lrzdRap
	n41bEtUqmCrYGXCO9vdf4kjxPepl3KuGCFH0M6pcKKuEpPzkzCyAozOAi5BL09lY
	1D2URSt8ShGj1klOTCaJgFfU3EGE6gBtczqevoF4TuZXgQYM6rcAWYUDoJrZMysm
	HYV8GmWOn2M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82A1C317E1;
	Wed,  3 Aug 2016 17:36:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B4E7317DF;
	Wed,  3 Aug 2016 17:36:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 2/8] status: cleanup API to wt_status_print
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
	<1470147137-17498-3-git-send-email-git@jeffhostetler.com>
Date:	Wed, 03 Aug 2016 14:36:05 -0700
In-Reply-To: <1470147137-17498-3-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Tue, 2 Aug 2016 10:12:11 -0400")
Message-ID: <xmqqr3a57cxm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49F31220-59C2-11E6-9B37-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Refactor the API between builtin/commit.c and wt-status.[ch].
> Hide details of the various wt_*status_print() routines inside
> wt-status.c behind a single (new) wt_status_print() routine
> and eliminate the switch statements from builtin/commit.c
>
> This will allow us to more easily add new status formats
> and isolate that within wt-status.c
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Jeff Hostetler <git@jeffhostetler.com>

Again, are these the same person?  I won't repeat this for the
remainder of the series.

> diff --git a/wt-status.h b/wt-status.h
> index 2023a3c..a859a12 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -43,6 +43,15 @@ struct wt_status_change_data {
>  	unsigned new_submodule_commits : 1;
>  };
>  
> + enum wt_status_format {
> +	STATUS_FORMAT_NONE = 0,
> +	STATUS_FORMAT_LONG,
> +	STATUS_FORMAT_SHORT,
> +	STATUS_FORMAT_PORCELAIN,
> +
> +	STATUS_FORMAT_UNSPECIFIED
> + };

Is it your editor, or is it your MUA?  This definition is indented
by one SP, which is funny.

Also throughout the series, I saw a handful of blank lines that
should be empty but are not (e.g. three tabs and nothing else on a
new line).  I've fixed them up all but I won't be sending an
interdiff just for them, so please make sure they won't resurface
when/if you reroll.

>  struct wt_status {
>  	int is_initial;
>  	char *branch;
> @@ -66,6 +75,8 @@ struct wt_status {
>  	int show_branch;
>  	int hints;
>  
> +	enum wt_status_format status_format;
> +
>  	/* These are computed during processing of the individual sections */
>  	int commitable;
>  	int workdir_dirty;
> @@ -99,6 +110,7 @@ struct wt_status_state {
>  void wt_status_truncate_message_at_cut_line(struct strbuf *);
>  void wt_status_add_cut_line(FILE *fp);
>  void wt_status_prepare(struct wt_status *s);
> +void wt_status_print(struct wt_status *s);
>  void wt_status_collect(struct wt_status *s);
>  void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
>  int wt_status_check_rebase(const struct worktree *wt,
> @@ -106,10 +118,6 @@ int wt_status_check_rebase(const struct worktree *wt,
>  int wt_status_check_bisect(const struct worktree *wt,
>  			   struct wt_status_state *state);
>  
> -void wt_longstatus_print(struct wt_status *s);
> -void wt_shortstatus_print(struct wt_status *s);
> -void wt_porcelain_print(struct wt_status *s);
> -

I think I agreed during the previous review round that shifting the
division of labor boundary between the command and wt-status.[ch]
this way, to have the latter do more printing, is a good idea, and I
still do.

Thanks.
