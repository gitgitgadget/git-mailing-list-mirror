From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 08:06:10 -0700
Message-ID: <7vli6crau5.fsf@alter.siamese.dyndns.org>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
	<1371196058-23948-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 17:06:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVZy-0004Fp-65
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab3FNPGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:06:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57892 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab3FNPGN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:06:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA2CB253BA;
	Fri, 14 Jun 2013 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=82UtU7sasGmFDEzejKUlyqiOwn0=; b=NF10n/
	chz6GvnKa+dm2xE0hJeFChIiaN9ETUczc8XpioSDhW03ShKv0rfF/b4lW3qQgB8D
	9WSsmBvO7qAOrZwR9dP6+4Ti6rKivKwcTJjRiZjz9hzipD5g2AeUgV1IVbI1NxMu
	g+DVomWbSJ6sOwYVMGUe6sjTPp9V/34MiSlNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=owl7gnA8W5GFMaY5BqQcZt3ok1QNDB2T
	z4ctmjtmdBow4HanknFsuctsS9m7lCyutxgdiY+Ei9YqCMbyBd2+bz8M4m/6b/i5
	OlqwUYwVtuDl3wWBMqRNmFooN3bynlpDxiYo5qsCQ9MHIVqHBfAZ/bY8oI/HziyG
	+ybah5r7RqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF25E253B9;
	Fri, 14 Jun 2013 15:06:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36763253B5;
	Fri, 14 Jun 2013 15:06:12 +0000 (UTC)
In-Reply-To: <1371196058-23948-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 14 Jun 2013 13:17:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F38E2A64-D503-11E2-B495-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227878>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The following bug has been observed:
>
>   $ git am  # no input file
>   ^C
>   $ git am --abort
>   Resolve operation not in progress, we are not resuming.
>
> This happens because the following test fails:
>
>   test -d "$dotest" && test -f "$dotest/last" && test -f "$dotest/next"
>
> and the codepath for an "am in-progress" is not executed.  It falls back
> to the codepath that treats this as a "fresh execution".  Before
> rr/rebase-autostash, this condition was
>
>   test -d "$dotest"
>
> It would incorrectly execute the "normal" am --abort codepath:
>
>   git read-tree --reset -u HEAD ORIG_HEAD
>   git reset ORIG_HEAD
>
> by incorrectly assuming that an am is "in progress" (i.e. ORIG_HEAD
> etc. was written during the previous execution).
>
> Notice that
>
>   $ git am
>   ^C
>
> executes nothing of significance, is equivalent to
>
>   $ mkdir .git/rebase-apply
>
> Therefore, the correct solution is to treat .git/rebase-apply as a
> "stray directory" and remove it on --abort in the fresh-execution
> codepath.
>
> While at it, tell the user to run "git am --abort" to get rid of the
> stray $dotest directory, if she attempts anything else.
>
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-am.sh     | 14 ++++++++++++++
>  t/t4150-am.sh |  6 ++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/git-am.sh b/git-am.sh
> index 1cf3d1d..37ee18b 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -506,6 +506,20 @@ then
>  	esac
>  	rm -f "$dotest/dirtyindex"
>  else
> +	# Possible stray $dotest directory
> +	if test -d "$dotest"; then
> +	case "$skip,$resolved,$abort" in
> +		,,t)
> +			rm -fr "$dotest"
> +			exit 0
> +			;;
> +		*)
> +			die "$(eval_gettext "Stray $dotest directory found.
> +Use \"git am --abort\" to remove it.")"
> +			;;
> +	esac

These two case arms are indented one level too deep (will locally
touch up).

> +	fi
> +
>  	# Make sure we are not given --skip, --resolved, nor --abort
>  	test "$skip$resolved$abort" = "" ||
>  		die "$(gettext "Resolve operation not in progress, we are not resuming.")"
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 12f6b02..6c2cc3e 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -363,6 +363,12 @@ test_expect_success 'am --skip works' '
>  	test_cmp expected another
>  '
>  
> +test_expect_success 'am --abort removes a stray directory' '
> +	mkdir .git/rebase-apply &&
> +	git am --abort &&
> +	test_path_is_missing .git/rebase-apply
> +'
> +
>  test_expect_success 'am --resolved works' '
>  	echo goodbye >expected &&
>  	rm -fr .git/rebase-apply &&
