From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] rebase: decouple --exec from --interactive
Date: Fri, 18 Mar 2016 14:33:09 -0700
Message-ID: <xmqqh9g3pj3e.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1qszs03.fsf@gitster.mtv.corp.google.com>
	<1458336377-28296-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:33:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah21I-000895-VA
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 22:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbcCRVdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 17:33:14 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754752AbcCRVdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 17:33:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 004094E9A5;
	Fri, 18 Mar 2016 17:33:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UnEoxDHM5XzBSYLeHk7quOYC5z4=; b=uMow2W
	TGkLGAgN5yleBvQVfao5PT7slVy5Keee8+kHQV4QwpyCrYvE4rXRq5xmdbvSe0cd
	w5TDC+3DSn469BbyyeAI6AmFbo7FTfcT+tWIF3iL+cLsm+QOqh2p/GkW6YMBlpLP
	M7dcBmKZ78bAKcp2+P+tHxY7QrwgbsItrMWvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R9B60TgbKGus2mY7fnZdj9viu9XnUdki
	QnepsITYycwWNOR2omdOvDmUkLTTscxYcPGqYM7CRWzDwJee4tkrclBuT2TfQ8sz
	Lic8QXiDqxKjUqx7pCAUDtiVcBrMdjKEKSjh2uy2NsqMdMmbwFowVxJjK5jDhHX6
	L7ROmfyMPd0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA7624E9A4;
	Fri, 18 Mar 2016 17:33:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6A5A54E9A3;
	Fri, 18 Mar 2016 17:33:10 -0400 (EDT)
In-Reply-To: <1458336377-28296-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 18 Mar 2016 14:26:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 031454C8-ED51-11E5-840D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289253>

Stefan Beller <sbeller@google.com> writes:

> In the later steps of preparing a patch series I do not want to
> edit or reorder the patches any more, but just make sure the
> test suite passes after each patch and also to fix breakage
> right there if some of the steps fail.  I could run
>
>     EDITOR=true git rebase -i <anchor> -x "make test"
>
> but it would be simpler if it can be spelled like so:
>
>     git rebase <anchor> -x "make test"
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>   Thanks Junio, Johannes for review!
>  
>  * Reworded the commit message (took your suggestion)
>  
>  * Diff to v2 in t3404:
>         test_expect_success 'rebase --exec works without -i ' '
>                 git reset --hard execute &&
>                 rm -rf exec_output &&
>         -	git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&
>         +	EDITOR="echo >invoked_editor" git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&

Hmph.  If you add "-i" to the command line, do you see the
'invoked_editor' file created?

I ask this because I thought we override GIT_EDITOR, which has
higher precedence than EDITOR, in the test-lib framework.

>                 test_i18ngrep  "Successfully rebased and updated" actual &&
>         -	test_line_count = 2 exec_output
>         +	test_line_count = 2 exec_output &&
>         +	test_path_is_missing invoked_editor
>         '
>   * I just resend this patch instead of the whole series, so do not expect a
>     [PATCHv3 2/2] nor cover letter 0/2
>         
>
>  Documentation/git-rebase.txt  |  6 +++---
>  git-rebase.sh                 |  7 +------
>  t/t3404-rebase-interactive.sh | 13 ++++++-------
>  3 files changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 6ed610a..0387b40 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -391,9 +391,6 @@ idea unless you know what you are doing (see BUGS below).
>  	final history. <cmd> will be interpreted as one or more shell
>  	commands.
>  +
> -This option can only be used with the `--interactive` option
> -(see INTERACTIVE MODE below).
> -+
>  You may execute several commands by either using one instance of `--exec`
>  with several commands:
>  +
> @@ -406,6 +403,9 @@ or by giving more than one `--exec`:
>  If `--autosquash` is used, "exec" lines will not be appended for
>  the intermediate commits, and will only appear at the end of each
>  squash/fixup series.
> ++
> +This uses the `--interactive` machinery internally, but it can be run
> +without an explicit `--interactive`.
>  
>  --root::
>  	Rebase all commits reachable from <branch>, instead of
> diff --git a/git-rebase.sh b/git-rebase.sh
> index cf60c43..0bf41ee 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -248,6 +248,7 @@ do
>  		;;
>  	--exec=*)
>  		cmd="${cmd}exec ${1#--exec=}${LF}"
> +		test -z "$interactive_rebase" && interactive_rebase=implied
>  		;;
>  	--interactive)
>  		interactive_rebase=explicit
> @@ -348,12 +349,6 @@ do
>  done
>  test $# -gt 2 && usage
>  
> -if test -n "$cmd" &&
> -   test "$interactive_rebase" != explicit
> -then
> -	die "$(gettext "The --exec option must be used with the --interactive option")"
> -fi
> -
>  if test -n "$action"
>  then
>  	test -z "$in_progress" && die "$(gettext "No rebase in progress?")"
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 544f9ad..21b1f95 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -876,16 +876,15 @@ test_expect_success 'rebase -ix with --autosquash' '
>  	test_cmp expected actual
>  '
>  
> -
> -test_expect_success 'rebase --exec without -i shows error message' '
> +test_expect_success 'rebase --exec works without -i ' '
>  	git reset --hard execute &&
> -	set_fake_editor &&
> -	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
> -	echo "The --exec option must be used with the --interactive option" >expected &&
> -	test_i18ncmp expected actual
> +	rm -rf exec_output &&
> +	EDITOR="echo >invoked_editor" git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&
> +	test_i18ngrep  "Successfully rebased and updated" actual &&
> +	test_line_count = 2 exec_output &&
> +	test_path_is_missing invoked_editor
>  '
>  
> -
>  test_expect_success 'rebase -i --exec without <CMD>' '
>  	git reset --hard execute &&
>  	set_fake_editor &&
