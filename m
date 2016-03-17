From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHV2 1/2] rebase -x: do not die without -i
Date: Thu, 17 Mar 2016 14:58:20 -0700
Message-ID: <xmqqd1qszs03.fsf@gitster.mtv.corp.google.com>
References: <1458251060-311-1-git-send-email-sbeller@google.com>
	<1458251060-311-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j6t@kdbg.org, johannes.schindelin@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 22:58:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agfwH-00079z-K8
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 22:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031531AbcCQV6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 17:58:32 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936950AbcCQV6X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 17:58:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DCC474D81F;
	Thu, 17 Mar 2016 17:58:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8mndA+U8k8wba9M7cCU7vCHnwwo=; b=VyJk9R
	lJpXMGNXITwNMVIdxCbt4udvbuuNDrfqMSsTfrHR1M9QzgUCr3BRO1fVsFKRix8o
	rGtHgr4A5XX/w7D8+8/vWSTWpFWsnjRLz3dq6SQn2CBR0eh2CJCZy1dXv5gLMfAC
	mX2P/l3LAFMKhevJQShyhDiB4JxovmyDr8sxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xagO8I7wSsh1XIy26Lec97dXHosgCTYF
	C29TMQ/eFh+lVJO44WyJwHfV4bIYteuxPYnplN7lWANxJdfcjS7stU5+/qbQvWfX
	6JBof6pEsFonasxy8EhLYmbjl2Zyao/zJGSabMpVSjPVT5kPQcI+lRC5oVspid0K
	9it/0gv0vbc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D38D44D81D;
	Thu, 17 Mar 2016 17:58:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 53BAF4D81C;
	Thu, 17 Mar 2016 17:58:21 -0400 (EDT)
In-Reply-To: <1458251060-311-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 17 Mar 2016 14:44:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D3D8896-EC8B-11E5-9873-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289162>

Stefan Beller <sbeller@google.com> writes:

> In the later steps of preparing a patch series I do not want to edit the
> patches any more, but just make sure the test suite passes after each
> patch. Currently I would run
>
>   EDITOR=true git rebase -i <anchor> -x "make test"
>
> In an ideal world the command would be simpler and just be
>
>   git rebase <anchor> -x "make test"
>
> to run the test for each commit I am about to send out for review.
> This patch enables the short line. As things can still break, I'd want
> to be able to fix those failures directly at the commit, so it is not
> sufficient to just use:
>
>         git rev-list old...new |
>         while read rev
>         do
>                 $command || break
>         done
>
> as it only tests and does not stop at a breakage to fix it up.

That is overly verbose.

    In the later steps of preparing a patch series I do not want to
    edit or reorder the patches any more, but just make sure the
    test suite passes after each patch and also to fix breakage
    right there if some of the steps fail.  I could run

      EDITOR=true git rebase -i <anchor> -x "make test"

    but it would be simpler if it can be spelled like so:

      git rebase <anchor> -x "make test"

says the same thing.

If you said "I want to fix breakage right there as well" upfront,
like in the above shortened example, nobody would imagine that
"rev-list | while .. do .. done" could be a viable substitute.

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

This makes the code structure for $cmd more in line with how the
"--preserve-merges" option is handled, which feels just right ;-)

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 544f9ad..c8cc03d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -876,16 +876,14 @@ test_expect_success 'rebase -ix with --autosquash' '
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
> +	git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&
> +	test_i18ngrep  "Successfully rebased and updated" actual &&
> +	test_line_count = 2 exec_output
>  '

Shouldn't this test make sure that

	GIT_EDITOR=something git rebase --exec "..." $range

does not invoke 'something', as the point of the new feature is that
you will not have to see the editor to reorder the commits?

> -
>  test_expect_success 'rebase -i --exec without <CMD>' '
>  	git reset --hard execute &&
>  	set_fake_editor &&
