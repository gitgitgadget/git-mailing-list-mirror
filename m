From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] shortlog: replace hand-parsing of author with pretty-printer
Date: Mon, 18 Jan 2016 19:47:54 -0800
Message-ID: <xmqqegdecjrp.fsf@gitster.mtv.corp.google.com>
References: <20160118200136.GA9514@sigill.intra.peff.net>
	<20160118200248.GC15836@sigill.intra.peff.net>
	<20160118201337.GA15943@sigill.intra.peff.net>
	<20160118230435.GA16898@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 04:48:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLNH6-0004a7-3P
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 04:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbcASDsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 22:48:03 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755875AbcASDsC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 22:48:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CBC243D3BF;
	Mon, 18 Jan 2016 22:47:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eLsEe4KT77IUUSdwHb/7ghVBS+w=; b=UPlmwA
	Osn9lLaUmTYKB/V9lkXu0j+wyNLPH5REiLjsLehzXsixnNkfoBG9/xw+z7mytpmc
	wRzfL5g457eFJzYQPp95Tqro+h2M6NsTwqsZvChdTg7uVsYh8ALswqb9EeXHl4mq
	+8kPSB9sOArpgHMVveF7cwl/S1areKbDnAEXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9k3/G8zNmxPU5T0nINIRuhLPKkmLzEe
	6WdtH5+lyMnud3dwQFqRBe4OrnlR6UJIkPa152gsCsQrhnnxvuUATsYw5rKSkeXx
	H2Infrnqz6ZrCWB34nvHMnNKUWXhMh12pwNvxzdvxRJwFDQ2VllHT5SWAJVfyu/V
	EULfmiBfZPQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3EB23D3BE;
	Mon, 18 Jan 2016 22:47:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 492D83D3BD;
	Mon, 18 Jan 2016 22:47:55 -0500 (EST)
In-Reply-To: <20160118230435.GA16898@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 18 Jan 2016 18:04:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6C51B6D6-BE5F-11E5-9530-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284344>

Jeff King <peff@peff.net> writes:

> After thinking on this, I'm in favor of removing this warning entirely.
> My reasons are given in the commit message below, which can apply on top
> of the series.  It could also be squashed in to 2/6, but given that it
> is removing the test added by cd4f09e (shortlog: ignore commits with
> missing authors, 2013-09-18), I think it's worth recording as a separate
> commit.

I agree 100% with the reasoning. Thanks for thinking things through.

>
> -- >8 --
> Subject: [PATCH] shortlog: don't warn on empty author
>
> Git tries to avoid creating a commit with an empty author
> name or email. However, commits created by older, less
> strict versions of git may still be in the history.  There's
> not much point in issuing a warning to stderr for an empty
> author. The user can't do anything about it now, and we are
> better off to simply include it in the shortlog output as an
> empty name/email, and let the caller process it however they
> see fit.
>
> Older versions of shortlog differentiated between "author
> header not present" (which complained) and "author
> name/email are blank" (which included the empty ident in the
> output).  But since switching to format_commit_message, we
> complain to stderr about either case (linux.git has a blank
> author deep in its history which triggers this).
>
> We could try to restore the older behavior (complaining only
> about the missing header), but in retrospect, there's not
> much point in differentiating these cases. A missing
> author header is bogus, but as for the "blank" case, the
> only useful behavior is to add it to the "empty name"
> collection.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/shortlog.c  |  8 --------
>  t/t4201-shortlog.sh | 16 ----------------
>  2 files changed, 24 deletions(-)
>
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index adbf1fd..e32be39 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -149,13 +149,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  	ctx.output_encoding = get_log_output_encoding();
>  
>  	format_commit_message(commit, "%an <%ae>", &author, &ctx);
> -	/* we can detect a total failure only by seeing " <>" in the output */
> -	if (author.len <= 3) {
> -		warning(_("Missing author: %s"),
> -		    oid_to_hex(&commit->object.oid));
> -		goto out;
> -	}
> -
>  	if (!log->summary) {
>  		if (log->user_format)
>  			pretty_print_commit(&ctx, commit, &oneline);
> @@ -165,7 +158,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  
>  	insert_one_record(log, author.buf, oneline.len ? oneline.buf : "<none>");
>  
> -out:
>  	strbuf_release(&author);
>  	strbuf_release(&oneline);
>  }
> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index 82b2314..f5e6367 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -178,22 +178,6 @@ test_expect_success !MINGW 'shortlog encoding' '
>  	git shortlog HEAD~2.. > out &&
>  test_cmp expect out'
>  
> -test_expect_success 'shortlog ignores commits with missing authors' '
> -	git commit --allow-empty -m normal &&
> -	git commit --allow-empty -m soon-to-be-broken &&
> -	git cat-file commit HEAD >commit.tmp &&
> -	sed "/^author/d" commit.tmp >broken.tmp &&
> -	commit=$(git hash-object -w -t commit --stdin <broken.tmp) &&
> -	git update-ref HEAD $commit &&
> -	cat >expect <<-\EOF &&
> -	A U Thor (1):
> -	      normal
> -
> -	EOF
> -	git shortlog HEAD~2.. >actual &&
> -	test_cmp expect actual
> -'
> -
>  test_expect_success 'shortlog with revision pseudo options' '
>  	git shortlog --all &&
>  	git shortlog --branches &&
