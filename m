From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: don't read index when --no-index is given
Date: Mon, 09 Dec 2013 12:30:29 -0800
Message-ID: <xmqqwqjdydga.fsf@gitster.dls.corp.google.com>
References: <1386590745-4412-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Borzenkov <snaury@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Tim Henigan <tim.henigan@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 21:30:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7TT-0001os-8f
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932941Ab3LIUaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:30:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932569Ab3LIUae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:30:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E3C95980E;
	Mon,  9 Dec 2013 15:30:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=seXQtea8q67uDQoldMKpmfM2kAY=; b=fJshEa
	1OOU9qldY7o3IPiAO7JzlCBsVbu2w8aFdyQILanhYO7Y3k3s8IzF3NSFmTNdVu51
	xUIVbzuQNSfQVD1GvZvkmsun4xG2dcrVg7sn2B6BO+lYXeDg9Btsb1viNcy/I0tt
	k+FheDpHKWLKHLvtyqHnKCDqi0cf//ymth948=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pb9xrKffauvoJJrsmzTyEknhTZ6T/xRt
	areLCoA1hE305MvCxI5b8sRJL4VzHaO5NvNGjZC/Gf4Hcz0fokNXtmym2w7VLH4M
	GtEbRnWhOn4AmYsd7E7efSAMXJ2ohhy2BQF15wYOgZj2KkKRuBsZMLC41V0VaVVo
	mcFmYUcYX1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B8895980D;
	Mon,  9 Dec 2013 15:30:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AF445980A;
	Mon,  9 Dec 2013 15:30:32 -0500 (EST)
In-Reply-To: <1386590745-4412-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Mon, 9 Dec 2013 13:05:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C057D020-6110-11E3-A5EA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239088>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> git diff --no-index ... currently reads the index, during setup, when
> calling gitmodules_config().  In the usual case this gives us some
> performance drawbacks, but it's especially annoying if there is a broken
> index file.
>
> Avoid calling the unnecessary gitmodules_config() when the --no-index
> option is given.  Also add a test to guard against similar breakages in the future.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/diff.c           | 13 +++++++++++--
>  t/t4053-diff-no-index.sh |  6 ++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index adb93a9..47c0833 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -257,7 +257,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	int blobs = 0, paths = 0;
>  	const char *path = NULL;
>  	struct blobinfo blob[2];
> -	int nongit;
> +	int nongit, no_index = 0;
>  	int result = 0;
>  
>  	/*
> @@ -282,9 +282,18 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	 *
>  	 * Other cases are errors.
>  	 */
> +	for (i = 1; i < argc; i++) {
> +		if (!strcmp(argv[i], "--"))
> +			break;
> +		if (!strcmp(argv[i], "--no-index")) {
> +			no_index = 1;
> +			break;
> +		}
> +	}

This seems to duplicate only half the logic at the beginning of
diff_no_index(), right?  E.g., running "git diff /var/tmp/[12]"
inside a working tree that is controlled by a Git repository when
/var/tmp/ is outside, we do want to behave as if the command line
were "git diff --no-index /var/tmp/[12]", but this half duplication
makes these two behave differently, no?

I think the issue you are trying to address is worth tackling, but I
wonder if a bit of preparatory refactoring is necessary to avoid the
partial duplication.

>  	prefix = setup_git_directory_gently(&nongit);
> -	gitmodules_config();
> +	if (!no_index)
> +		gitmodules_config();
>  	git_config(git_diff_ui_config, NULL);
>  
>  	init_revisions(&rev, prefix);
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 979e983..a24ae4d 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -29,4 +29,10 @@ test_expect_success 'git diff --no-index relative path outside repo' '
>  	)
>  '
>  
> +test_expect_success 'git diff --no-index with broken index' '
> +	cd repo &&
> +	echo broken >.git/index &&
> +	test_expect_code 0 git diff --no-index a ../non/git/a
> +'
> +
>  test_done
