From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] perf: make the tests work in worktrees
Date: Tue, 10 May 2016 13:28:17 -0700
Message-ID: <xmqq7ff1ody6.fsf@gitster.mtv.corp.google.com>
References: <cover.1462894344.git.johannes.schindelin@gmx.de>
	<63972edcda32c3c927e956f2e96d5b61843d64f2.1462894344.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 22:28:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0EGY-0007Rf-HH
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 22:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbcEJU2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 16:28:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751049AbcEJU2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 16:28:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C0CD919A48;
	Tue, 10 May 2016 16:28:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GoHsgM3AJuGozc3eFp9x2hG0rqs=; b=PsnEfJ
	24lZtk2a3ZcQMyH8ahKxVSY802JWwmXUaIAALw37IHgICqZDaAazaUH5mols/AOQ
	drC9D0XPoR0CvsZeSF853bnCOH+mL7EyRoGvGj2NsRWBrqPhf7ti2c+qDxlBdmPG
	7mI/fP2c+R4Zz0BvciBCQ5pd7dMQTy3iue2MY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GPb0LNGkgEiE9FvGe7nra+mNEpM8Yxeu
	REGxWIfioHwN87QDOutlRLnYR420lA1iwqK8v+5DpZRbwEKs4IaGD5sKGJGj/svt
	ZkOJExXKubx7Hyn+WBEWBTDZD3SEOZMeRC0JKqW6Av3uwy248YL1QjSdsAxanB8l
	n3XxSxAxqJs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B73D319A47;
	Tue, 10 May 2016 16:28:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37DE219A46;
	Tue, 10 May 2016 16:28:19 -0400 (EDT)
In-Reply-To: <63972edcda32c3c927e956f2e96d5b61843d64f2.1462894344.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 10 May 2016 17:42:00 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BBA20E5C-16ED-11E6-AEE7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294185>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch makes perf-lib.sh more robust so that it can run correctly
> even inside a worktree. For example, it assumed that $GIT_DIR/objects is
> the objects directory (which is not the case for worktrees) and it used
> the commondir file verbatim, even if it contained a relative path.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/perf/perf-lib.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index e9020d0..e5682f7 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -80,22 +80,22 @@ test_perf_create_repo_from () {
>  	error "bug in the test script: not 2 parameters to test-create-repo"
>  	repo="$1"
>  	source="$2"
> -	source_git=$source/$(cd "$source" && git rev-parse --git-dir)
> +	source_git="$(cd "$source" && git rev-parse --git-dir)"
> +	objects_dir="$(git rev-parse --git-path objects)"

I do not quite understand this change.  Whose object_dir is this
looking into?  The original wanted to peek into $source/.git/objects/
which may have been wrong when $source is borrowing from some other
repository, but the new invocation of rev-parse --git-path objects
is done inside what repository?  It does not seem to pay any attention
to $source and the change below just copies from there into $repo.

Confused.

>  	mkdir -p "$repo/.git"
>  	(
> -		cd "$repo/.git" &&
> -		{ cp -Rl "$source_git/objects" . 2>/dev/null ||
> -			cp -R "$source_git/objects" .; } &&
> +		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
> +			cp -R "$objects_dir" "$repo/.git/"; } &&
>  		for stuff in "$source_git"/*; do
>  			case "$stuff" in
> -				*/objects|*/hooks|*/config)
> +				*/objects|*/hooks|*/config|*/commondir)
>  					;;
>  				*)
> -					cp -R "$stuff" . || exit 1
> +					cp -R "$stuff" "$repo/.git/" || exit 1
>  					;;
>  			esac
>  		done &&
> -		cd .. &&
> +		cd "$repo" &&
>  		git init -q &&
>  		if test_have_prereq MINGW
>  		then
