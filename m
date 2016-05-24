From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION
Date: Tue, 24 May 2016 12:53:01 -0700
Message-ID: <xmqq7fej44iq.fsf@gitster.mtv.corp.google.com>
References: <1464078713-3220-1-git-send-email-ville.skytta@iki.fi>
	<xmqqshx75psw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 24 21:53:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5IOC-00039k-Ia
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 21:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbcEXTxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 15:53:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932525AbcEXTxE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 15:53:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CB691EFCA;
	Tue, 24 May 2016 15:53:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Be0WMd5z6wMJtZew9ADgvaFJvE0=; b=qIyEd5
	Zpr/FCOUZDn248Vg5ZRmSvBkgbrdU7lngRH9dIUzW90FyxDGo3rr0idIiQTBsYpn
	8qpfygytyYkRelrRkpyyErnCv184cm0FviWXA6amIrxe+cnXjFC7c/I8b7CRYhHD
	t54noEKn/jBWn6HEHatt/1LUaxO2PjZNg+Buk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nYT3mE+T8OAsHng+q8kunlPmLehx75aj
	JlVCHnxkl2XOSkECLXreC1H0TdYL0EZs6yXzKNab+iktW5YnUb8JFNHTEFJLI6/f
	iOQv+nkej55ZyzpBWyridS30ICFyv2p9Ody8nQu7RQ+M7OhtrRN1/C5u6azd+zHd
	zmt5ga95RwA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 626891EFC9;
	Tue, 24 May 2016 15:53:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2BB51EFC6;
	Tue, 24 May 2016 15:53:02 -0400 (EDT)
In-Reply-To: <xmqqshx75psw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 24 May 2016 10:27:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1FF77850-21E9-11E6-8B49-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295529>

Junio C Hamano <gitster@pobox.com> writes:

> Others, I am not sure how seriously we would want to support those
> who use "set -u"; the damage to test-lib.sh so far (see below) does
> not look _too_ bad, but the reason why I have "set -u" after
> including lib-bash.sh is because it will trigger a lot more errors
> while lib-bash and test-lib do their preparation.

Ehh, this didn't come out very well as I hoped, primarily because my
thinking behind it was muddy X-<.

I do want to see us keep supporting those who "set -u" in their
interactive shell environment, and we should strive to make sure
that the "prompt" and the "completion", which are part of their
interactive shell experience, work well with "set -u".

It does not mean "cd t && sh t$anything.sh" must be "set -u" clean
at all (this is where my thinking was muddy); it is sufficient if we
can successfully run t9903 (prompt) with "set -u" before the script
includes "git-prompt".  We do not have to be able to insert "set -u"
at the beginning of test-lib.sh and cleanly run other tests.

Having said that, some parts of "minimum" change shown in my "how
about this" patch would probably be worth doing anyway.  They make
sure that:

 (1) variables the test framework uses will always be initialized
     properly, without getting affected a stray environment variable
     the user may have.  E.g. "trace".

 (2) environment variables the test framework may accept to change
     the behaviour, e.g. GIT_SKIP_TESTS, are clearly documented by
     using the idiom "set to an empty string if not set".

So in that sense, even though we may not add "set -u" at the
beginning of test-lib.sh in the production code, doing so may be a
good developer aid to catch other variables the attached patch did
not catch and complete the above two points.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0055ebb..36ca13e 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -186,6 +186,9 @@ test "x$TERM" != "xdumb" && (
>  	) &&
>  	color=t
>  
> +HARNESS_ACTIVE= quiet= verbose_only= run_list= trace=
> +: ${GIT_SKIP_TESTS=}
> +
>  while test "$#" -ne 0
>  do
>  	case "$1" in
> @@ -585,7 +588,7 @@ test_eval_ () {
>  
>  test_run_ () {
>  	test_cleanup=:
> -	expecting_failure=$2
> +	expecting_failure=${2-}
>  
>  	if test "${GIT_TEST_CHAIN_LINT:-1}" != 0; then
>  		# turn off tracing for this test-eval, as it simply creates
> @@ -750,6 +753,8 @@ test_done () {
>  	esac
>  }
>  
> +GIT_VALGRIND=
> +
>  if test -n "$valgrind"
>  then
>  	make_symlink () {
> @@ -902,6 +907,7 @@ fi
>  # in subprocesses like git equals our $PWD (for pathname comparisons).
>  cd -P "$TRASH_DIRECTORY" || exit 1
>  
> +skip_all=
>  this_test=${0##*/}
>  this_test=${this_test%%-*}
>  if match_pattern_list "$this_test" $GIT_SKIP_TESTS
