From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: Don't GPG sign when stashing changes
Date: Fri, 06 Nov 2015 10:56:29 -0800
Message-ID: <xmqqio5f2bz6.fsf@gitster.mtv.corp.google.com>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Cameron Currie <me@cameroncurrie.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 19:56:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZumBh-0000Yq-5P
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 19:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbbKFS4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 13:56:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284AbbKFS4c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 13:56:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A00229107;
	Fri,  6 Nov 2015 13:56:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=omOHQV390u7RGCOJaJpSWflFUEA=; b=wlDoos
	36QK612+GlycZArsBDoiuyECZcuw02h2IHrXM9GDkoJHgjhftcJJHuHJmYXZh+5f
	1A8dybjLKWzHfcsmuprmFEuJEf5+eIs1PNABVdTZsecapwBQWv0Kk3U31ozi5sTZ
	SBvjto7eX1JngHgxlAgdlK3TN73cNkZOjaSNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J8wuZEscbIwnVbsTSiKdaCCbHhvNt5HP
	PGr1+91yTTxocYR57kCtUZzNGvvTQq0L7tmtySpep/eIfq1kqxW0HNpdSEoJMvxq
	RpdW22rzXllWFoklXvDxw94WLmLSk59c24v8wa7orVwarKRhwhbH5anCWyc9e08U
	G5PosKB+XNw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51A8129105;
	Fri,  6 Nov 2015 13:56:31 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C643129104;
	Fri,  6 Nov 2015 13:56:30 -0500 (EST)
In-Reply-To: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
	(Cameron Currie's message of "Fri, 6 Nov 2015 17:32:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 178756AA-84B8-11E5-9C21-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280997>

Cameron Currie <me@cameroncurrie.net> writes:

> This is helpful for folks with commit.gpgsign = true in their .gitconfig.
> ---
>  git-stash.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I have to wonder if the right fix is to change "git commit-tree" to
ignore that configuration variable?  After all, the plumbing
commands are about stability of the interface, not convenience, and
it feels wrong for them to be affected by end-user configurations.

Patching git-stash.sh does not help other scripts (either in-tree or
third-party) that use commit-tree; they will also be broken by
over-eager users who set commit.gpgsign configuration.

>
> diff --git a/git-stash.sh b/git-stash.sh
> index c7c65e2..fcf01b9 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -85,7 +85,7 @@ create_stash () {
>  	# state of the index
>  	i_tree=$(git write-tree) &&
>  	i_commit=$(printf 'index on %s\n' "$msg" |
> -		git commit-tree $i_tree -p $b_commit) ||
> +		git commit-tree --no-gpg-sign $i_tree -p $b_commit) ||
>  		die "$(gettext "Cannot save the current index state")"
>  
>  	if test -n "$untracked"
> @@ -99,7 +99,7 @@ create_stash () {
>  				rm -f "$TMPindex" &&
>  				git update-index -z --add --remove --stdin &&
>  				u_tree=$(git write-tree) &&
> -				printf 'untracked files on %s\n' "$msg" | git commit-tree $u_tree  &&
> +				printf 'untracked files on %s\n' "$msg" | git commit-tree --no-gpg-sign $u_tree  &&
>  				rm -f "$TMPindex"
>  		) ) || die "Cannot save the untracked files"
>  
> @@ -153,7 +153,7 @@ create_stash () {
>  		stash_msg=$(printf 'On %s: %s' "$branch" "$stash_msg")
>  	fi
>  	w_commit=$(printf '%s\n' "$stash_msg" |
> -	git commit-tree $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
> +	git commit-tree --no-gpg-sign $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
>  	die "$(gettext "Cannot record working tree state")"
>  }
>  
>
> --
> https://github.com/git/git/pull/186
