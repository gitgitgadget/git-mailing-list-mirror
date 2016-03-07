From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] grep: turn off gitlink detection for --no-index
Date: Sun, 06 Mar 2016 17:29:01 -0800
Message-ID: <xmqqk2lfrs82.fsf@gitster.mtv.corp.google.com>
References: <20160305220829.GA31316@sigill.intra.peff.net>
	<20160305221551.GE31508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 07 02:29:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acjyx-0008JI-AK
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 02:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbcCGB3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 20:29:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751896AbcCGB3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 20:29:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 045DC4A6D2;
	Sun,  6 Mar 2016 20:29:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g7nh86rjbjhTaqkGac0RAZS+LG8=; b=xkdlJo
	tkQ9njiKhoGQGQcvfqZdequAO9vEq8SIpBaOU+5bBA03iF9CpiIXOb5/l/VnaqQ5
	fTnxhE+c0YapStl8RLVjJ7hmeUfpIZN31mG6i8f0gIymdFEbTLDdRLdGegqZsZzn
	jInG1fT4aR4lWObxAeMfvbXsj6fKKPlvHb7QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WMpy1csMN5cvhhPrSnov/jD2cAfATJzx
	4XcCdC/KUZ3Zg7gEHErpR3USIPDfWFMxdrhMnISxjiNseEF7pfj+EFI2Hhst0NBF
	TceyT2zNuq7UNHka/PjHRiA08JE5WgAMQcpvwbuEu2Bv3g4+jKCotf8P7UB6WFi/
	AE1loYz7KrA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE72D4A6D1;
	Sun,  6 Mar 2016 20:29:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6C8474A6D0;
	Sun,  6 Mar 2016 20:29:02 -0500 (EST)
In-Reply-To: <20160305221551.GE31508@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 5 Mar 2016 17:15:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F960E280-E403-11E5-939C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288377>

Jeff King <peff@peff.net> writes:

> If we are running "git grep --no-index" outside of a git
> repository, we behave roughly like "grep -r", examining all
> files in the current directory and its subdirectories.
> However, because we use fill_directory() to do the
> recursion, it will skip over any directories which look like
> sub-repositories.
>
> For a normal git operation (like "git grep" in a repository)
> this makes sense; we do not want to cross the boundary out
> of our current repository into a submodule. But for
> "--no-index" without a repository, we should look at all
> files, including embedded repositories.
>
> There is one exception, though: we probably should _not_
> descend into ".git" directories. Doing so is inefficient and
> unlikely to turn up useful hits.
>
> This patch drops our use of dir.c's gitlink-detection, but
> we do still avoid ".git". That makes us more like tools such
> as "ack" or "ag", which also know to avoid cruft in .git.
>
> As a bonus, this also drops our usage of the ref code
> when we are outside of a repository, making the transition
> to pluggable ref backends cleaner.
>
> Based-on-a-patch-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I hope the reasoning above makes sense. My ulterior motive is the
> "bonus", but I really think the new behavior is what people would expect
> (i.e., that "git grep --no-index" is basically a replacement for "ack",
> etc).

I agree with --no-index part, but the caller of grep_directory() is
"either no-index, or untracked".  I am not sure if the latter wants
this new behaviour.

>
>  builtin/grep.c  |  1 +
>  t/t7810-grep.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index aa7435f..0636cd7 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -528,6 +528,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
>  	int i, hit = 0;
>  
>  	memset(&dir, 0, sizeof(dir));
> +	dir.flags |= DIR_NO_GITLINKS;
>  	if (exc_std)
>  		setup_standard_excludes(&dir);
>  
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index b540944..1e72971 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -905,6 +905,33 @@ test_expect_success 'inside git repository but with --no-index' '
>  	)
>  '
>  
> +test_expect_success 'grep --no-index descends into repos, but not .git' '
> +	rm -fr non &&
> +	mkdir -p non/git &&
> +	(
> +		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd non/git &&
> +
> +		echo magic >file &&
> +		git init repo &&
> +		(
> +			cd repo &&
> +			echo magic >file &&
> +			git add file &&
> +			git commit -m foo &&
> +			echo magic >.git/file
> +		) &&
> +
> +		cat >expect <<-\EOF &&
> +		file
> +		repo/file
> +		EOF
> +		git grep -l --no-index magic >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'setup double-dash tests' '
>  cat >double-dash <<EOF &&
>  --
