Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773F7C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 22:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376599AbiDCWoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376592AbiDCWoN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 18:44:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7A5387A0
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 15:42:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1079811D8AC;
        Sun,  3 Apr 2022 18:42:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XhrrbkTafo/aFeShghujk9CWHcoeqLTdyRmw6v
        iusUU=; b=HaFb1mFC9QJGyVoJWMz1tWIb7cNplMW7Z08V7W+RJjo3mLCsggqLvV
        YbydQE5/ucyccG3/0dahpsya6tsZFHSM1pn9bKrPCZNZvedlKd1AePkYwU9/kwmL
        cZ9fSQFrRFigdQHy4plgPHoo9JZiz84KQa5wojsXYVEmoTz/7CCQs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0818511D8AB;
        Sun,  3 Apr 2022 18:42:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 682B811D8AA;
        Sun,  3 Apr 2022 18:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     whydoubt@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] blame: report correct number of lines in progress when
 using ranges
References: <20220403165038.52803-1-eantoranz@gmail.com>
Date:   Sun, 03 Apr 2022 15:42:16 -0700
In-Reply-To: <20220403165038.52803-1-eantoranz@gmail.com> (Edmundo Carmona
        Antoranz's message of "Sun, 3 Apr 2022 18:50:38 +0200")
Message-ID: <xmqq5ynpu6uv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 508FE530-B39F-11EC-B238-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> When using ranges, use their sizes as the limit for progress
> instead of the size of the full file.
>
> Before:
> $ git blame --progress builtin/blame.c > /dev/null
> Blaming lines: 100% (1210/1210), done.
> $ git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
> Blaming lines:  10% (122/1210), done.
> $
>
> After:
> $ ./git blame --progress builtin/blame.c > /dev/null
> Blaming lines: 100% (1210/1210), done.
> $ ./git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
> Blaming lines: 100% (122/122), done.
> $
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
>  builtin/blame.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Wow.  I am reasonably sure that this was broken since the
introduction of the progress meter to "git blame".  Thanks for
finding and fixing.

Can we have a test, too, or is that too cumbersome to add for some
reason?

Thanks.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 8d15b68afc..e33372c56b 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -898,6 +898,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	unsigned int range_i;
>  	long anchor;
>  	const int hexsz = the_hash_algo->hexsz;
> +	long num_lines = 0;
>  
>  	setup_default_color_by_age();
>  	git_config(git_blame_config, &output_option);
> @@ -1129,7 +1130,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	for (range_i = ranges.nr; range_i > 0; --range_i) {
>  		const struct range *r = &ranges.ranges[range_i - 1];
>  		ent = blame_entry_prepend(ent, r->start, r->end, o);
> +		num_lines += (r->end - r->start);
>  	}
> +	if (!num_lines)
> +		num_lines = sb.num_lines;
>  
>  	o->suspects = ent;
>  	prio_queue_put(&sb.commits, o->commit);
> @@ -1158,7 +1162,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	sb.found_guilty_entry = &found_guilty_entry;
>  	sb.found_guilty_entry_data = &pi;
>  	if (show_progress)
> -		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
> +		pi.progress = start_delayed_progress(_("Blaming lines"), num_lines);
>  
>  	assign_blame(&sb, opt);
