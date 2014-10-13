From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: add an option for writing to a temporary directory
Date: Mon, 13 Oct 2014 12:18:36 -0700
Message-ID: <xmqqoatf3hir.fsf@gitster.dls.corp.google.com>
References: <1413047085-12398-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 21:18:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdl8l-0002t1-G2
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 21:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbaJMTSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 15:18:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751304AbaJMTSj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 15:18:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1B4315C72;
	Mon, 13 Oct 2014 15:18:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+PWRDaHbUBPBvguialYsTvCTsZU=; b=SMyroY
	oP9KvcP6m/seiRjlNqOrjrMx91NxtljLy3Piy8EX6zXc+8LjyemyGSZ8QWYtKi3+
	r9fNSeMbcpCCpWjDlfgmkcSYXKbs/5glcBJ5HWN1zkI199p1uWUa2T2XQS7jJaQe
	4RJnjdvaCUd86ygK2bVcbFQP2dfjZ0AkqyRSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v2dAGUCt6tRnZ6lCgYSU79bx1K5SXjjC
	TVRKF7ytn0OHdqXlG2UJ/BR+X5kcB/bCmE+BeUUP4Lm9TL/V2FwuJtRvzHfk/H2J
	2eWWu4t8pXFsGRgl3yNDMYIjCOOeAe1NNnJGhkbd8eVMrDE8DtE3w/0TZv0kq9GG
	FFAczwMAQow=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 979DA15C70;
	Mon, 13 Oct 2014 15:18:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E7AD15C6F;
	Mon, 13 Oct 2014 15:18:38 -0400 (EDT)
In-Reply-To: <1413047085-12398-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sat, 11 Oct 2014 10:04:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BBF99A00-530D-11E4-9780-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Teach mergetool to write files in a temporary directory when
> 'mergetool.writeToTemp' is true.
>
> This is helpful for tools such as Eclipse which cannot cope with
> multiple copies of the same file in the worktree.
>
> Suggested-by: Charles Bailey <charles@hashpling.org>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This patch is dependent on my previous mergetool patches:
> "use more conservative temporary..." and the subsequent --tool-help
> series.

I can understand why it depends on the "foo_BACKUP_1234.c" change,
but why does it need to depend on the other one?

>
>  Documentation/config.txt |  6 ++++++
>  git-mergetool.sh         | 35 +++++++++++++++++++++++++++++++----
>  2 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 04a1e2f..be6cf35 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1768,6 +1768,12 @@ mergetool.keepTemporaries::
>  	preserved, otherwise they will be removed after the tool has
>  	exited. Defaults to `false`.
>  
> +mergetool.writeToTemp::
> +	Git writes temporary 'BASE', 'LOCAL', and 'REMOTE' versions of
> +	conflicting files in the worktree by default.  Git will attempt
> +	to use a temporary directory for these files when set `true`.
> +	Defaults to `false`.
> +
>  mergetool.prompt::
>  	Prompt before each invocation of the merge resolution program.
>  
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 10782b8..2b788c5 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -37,6 +37,19 @@ base_present () {
>  	test -n "$base_mode"
>  }
>  
> +mergetool_tmpdir_init () {
> +	if test "$(git config --bool mergetool.writeToTemp)" != true
> +	then
> +		MERGETOOL_TMPDIR=.
> +		return 0
> +	fi
> +	if MERGETOOL_TMPDIR=$(mktemp -d -t "git-mergetool-XXXXXX" 2>/dev/null)
> +	then
> +		return 0
> +	fi
> +	die "error: mktemp is needed when 'mergetool.writeToTemp' is true"
> +}
> +
>  cleanup_temp_files () {
>  	if test "$1" = --save-backup
>  	then
> @@ -46,6 +59,10 @@ cleanup_temp_files () {
>  	else
>  		rm -f -- "$LOCAL" "$REMOTE" "$BASE" "$BACKUP"
>  	fi
> +	if test "$MERGETOOL_TMPDIR" != "."
> +	then
> +		rmdir "$MERGETOOL_TMPDIR"
> +	fi
>  }
>  
>  describe_file () {
> @@ -235,10 +252,20 @@ merge_file () {
>  		BASE=$MERGED
>  		ext=
>  	fi
> -	BACKUP="./${BASE}_BACKUP_$$$ext"
> -	LOCAL="./${BASE}_LOCAL_$$$ext"
> -	REMOTE="./${BASE}_REMOTE_$$$ext"
> -	BASE="./${BASE}_BASE_$$$ext"
> +
> +	mergetool_tmpdir_init
> +
> +	if test "$MERGETOOL_TMPDIR" != "."
> +	then
> +		# If we're using a temporary directory then write to the
> +		# top-level of that directory.
> +		BASE=${BASE##*/}
> +	fi
> +
> +	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
> +	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
> +	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
> +	BASE="$MERGETOOL_TMPDIR/${BASE}_BASE_$$$ext"
>  
>  	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
>  	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
