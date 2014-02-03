From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] combine-diff: move show_log_first logic/action out of paths scanning
Date: Mon, 03 Feb 2014 15:21:13 -0800
Message-ID: <xmqqr47jbx5i.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<3f729b3cac37e11e8ec74d88b4caac79f037194b.1391430523.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 04 00:21:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASpS-00009K-QZ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 00:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbaBCXVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 18:21:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbaBCXVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 18:21:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D18C969CD6;
	Mon,  3 Feb 2014 18:21:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mv6cgBYcjJPxDDfAsvcUG7XmxwU=; b=q7msHs
	goXAsJWpOj4e8V1yxmCXEslQRcCaFJGerLqc7tMmfaiXPbiwFy3HpHbSBCzEQhU6
	j6jqxtgPOqHt8lmHK/+W3hLO9exabkhsGYLm8a66kmTEglHMaaERQD5G7xj42HdN
	r5gHKe3M801tjZ+YGqQLYydaSpufVFzh6Ox0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PH/YmOg/LfU/NL6LnTJQPulXHqoqi//Z
	7tD3ltxaz/Jr3DRVGplFuxENPqtINmcmgE4geUnQV7t9+FqmgmAg2mP7/zE4Po9e
	HUyn+2N2rkyPDiiHYUPX4gqRdFGlgv6WhY2C+iQpt2kCcQ6WYdzNA8RqKmtWOB9g
	56/ajHf3luU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84ACB69CD3;
	Mon,  3 Feb 2014 18:21:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EBE569CD1;
	Mon,  3 Feb 2014 18:21:16 -0500 (EST)
In-Reply-To: <3f729b3cac37e11e8ec74d88b4caac79f037194b.1391430523.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 3 Feb 2014 16:47:19 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E16654C2-8D29-11E3-A69C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241494>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> Judging from sample outputs and tests nothing changes in diff -c output,

Yuck.

I do not think the processing done inside the loop for the first
path (i.e. i==0) before we call show_log(rev) affects what that
called show_log(rev) does, so it probably is a good readability
change.

Thanks.

> and this change will help later patches, when we'll be refactoring paths
> scanning into its own function with several variants - the
> show_log_first logic / code will stay common to all of them.
>
> NOTE: only now we have to take care to explicitly not show anything if
>     parents array is empty, as in fact there are some clients in Git code,
>     which calls diff_tree_combined() in such a way.
>
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> ---
>  combine-diff.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/combine-diff.c b/combine-diff.c
> index a03147c..272931f 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1313,6 +1313,20 @@ void diff_tree_combined(const unsigned char *sha1,
>  	struct combine_diff_path *p, *paths = NULL;
>  	int i, num_paths, needsep, show_log_first, num_parent = parents->nr;
>  
> +	/* nothing to do, if no parents */
> +	if (!num_parent)
> +		return;
> +
> +	show_log_first = !!rev->loginfo && !rev->no_commit_id;
> +	needsep = 0;
> +	if (show_log_first) {
> +		show_log(rev);
> +
> +		if (rev->verbose_header && opt->output_format)
> +			printf("%s%c", diff_line_prefix(opt),
> +			       opt->line_termination);
> +	}
> +
>  	diffopts = *opt;
>  	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
>  	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
> @@ -1321,8 +1335,6 @@ void diff_tree_combined(const unsigned char *sha1,
>  	/* tell diff_tree to emit paths in sorted (=tree) order */
>  	diffopts.orderfile = NULL;
>  
> -	show_log_first = !!rev->loginfo && !rev->no_commit_id;
> -	needsep = 0;
>  	/* find set of paths that everybody touches */
>  	for (i = 0; i < num_parent; i++) {
>  		/* show stat against the first parent even
> @@ -1338,14 +1350,6 @@ void diff_tree_combined(const unsigned char *sha1,
>  		diffcore_std(&diffopts);
>  		paths = intersect_paths(paths, i, num_parent);
>  
> -		if (show_log_first && i == 0) {
> -			show_log(rev);
> -
> -			if (rev->verbose_header && opt->output_format)
> -				printf("%s%c", diff_line_prefix(opt),
> -				       opt->line_termination);
> -		}
> -
>  		/* if showing diff, show it in requested order */
>  		if (diffopts.output_format != DIFF_FORMAT_NO_OUTPUT &&
>  		    opt->orderfile) {
