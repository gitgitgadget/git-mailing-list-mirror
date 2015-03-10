From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Tue, 10 Mar 2015 15:09:54 -0700
Message-ID: <xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
	<1425934575-19581-1-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:10:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVSLi-00021q-Du
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbbCJWJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:09:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753293AbbCJWJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 18:09:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D8B6B3F957;
	Tue, 10 Mar 2015 18:09:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U5U3k4XDA9Pmny6uBJaiiJAAJqg=; b=pawRMK
	F4yQwmxJXd9u3dBrHpJzpMibyV+5iIfNn/OgXZmfOtjguRctc8KOCt66AqYQ79S5
	2Lqbg+nPV/2EB/vcJpLP1hJDW4Aflyz1O6e9MRNy0FWrMHGRqCZq+2sj16DlcbM/
	myAUagfMG/Cwk43V9bdBhuoCrBUuNFGoJXeGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ceL+75oAfb8To+cQP0KFW1ClQDvo6wLL
	jDWq0S4S/XK/aa5EC611mOt+tqw3UyWJ+UazraAGZjgFAD0v52mRVWotXzsk0wtv
	MyAI97NRUYLZ1+E6UXBdMsoYQHgUbuj/TC2Et443nUbOiLSA/zPMIGhsFKX+pHn/
	xu6k5hI4QZ4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CFA903F955;
	Tue, 10 Mar 2015 18:09:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4ED003F954;
	Tue, 10 Mar 2015 18:09:55 -0400 (EDT)
In-Reply-To: <1425934575-19581-1-git-send-email-me@ikke.info> (Kevin Daudt's
	message of "Mon, 9 Mar 2015 21:56:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2ECD507A-C772-11E4-AE4E-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265267>

Kevin Daudt <me@ikke.info> writes:

> rev-list --bisect is used by git bisect, but never together with
> --first-parent. Because rev-list --bisect together with --first-parent
> is not handled currently, and even leads to segfaults, refuse to use
> both options together.
>
> Suggested-by: Junio C. Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---
> Changes since v3:
>
> * Added an ifdef::git-rev-list[] guard around the warning in the
>   --first-parent section so that it only shows up in `man git-rev-list`
>   and not in `man git log`
>
> * Added the warning also to the --bisect section.

I wonder what "git log --first-parent --bisect A..B" should do,
though.

Wouldn't the rejection belong to revision.c::setup_revisions(),
where we reject combined use of (--reverse, --walk-reflogs) and
(--children, --parents), to apply this to all commands in the "log"
family that uses the revision walker machinery?

>
>  Documentation/rev-list-options.txt | 4 ++++
>  builtin/rev-list.c                 | 3 +++
>  t/t6000-rev-list-misc.sh           | 4 ++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 4ed8587..a148672 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -124,6 +124,9 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
>  	adjusting to updated upstream from time to time, and
>  	this option allows you to ignore the individual commits
>  	brought in to your history by such a merge.
> +ifdef::git-rev-list[]
> +	Cannot be combined with --bisect.
> +endif::git-rev-list[]
>  
>  --not::
>  	Reverses the meaning of the '{caret}' prefix (or lack thereof)
> @@ -567,6 +570,7 @@ would be of roughly the same length.  Finding the change which
>  introduces a regression is thus reduced to a binary search: repeatedly
>  generate and test new 'midpoint's until the commit chain is of length
>  one.
> +Cannot be combined with --first-parent.
>  
>  --bisect-vars::
>  	This calculates the same as `--bisect`, except that refs in
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ff84a82..f5da2a4 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -291,6 +291,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	if (revs.bisect)
>  		bisect_list = 1;
>  
> +	if (revs.first_parent_only && revs.bisect)
> +		die(_("--first-parent is incompattible with --bisect"));
> +
>  	if (DIFF_OPT_TST(&revs.diffopt, QUICK))
>  		info.flags |= REV_LIST_QUIET;
>  	for (i = 1 ; i < argc; i++) {
> diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> index 2602086..1f58b46 100755
> --- a/t/t6000-rev-list-misc.sh
> +++ b/t/t6000-rev-list-misc.sh
> @@ -96,4 +96,8 @@ test_expect_success 'rev-list can show index objects' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--bisect and --first-parent can not be combined' '
> +	test_must_fail git rev-list --bisect --first-parent HEAD
> +'
> +
>  test_done
