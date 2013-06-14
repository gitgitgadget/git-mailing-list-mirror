From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase: use peel_committish() where appropriate
Date: Fri, 14 Jun 2013 09:56:57 -0700
Message-ID: <7vmwqspr52.fsf@alter.siamese.dyndns.org>
References: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
	<1371215872-9796-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 18:57:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnXJD-0000Uc-RO
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 18:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab3FNQ5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 12:57:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390Ab3FNQ5B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 12:57:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46B3D2750E;
	Fri, 14 Jun 2013 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=alpPg507dn+O7v89U7sXH6L46L0=; b=I0mUlh
	vdGXT+RP8GT1SVpeJm0CuX76BGNDMVJcmJkonF8W/k8tJ3LJNu4P0JqjbNuWdhal
	CQRvQQIBHsZ1ide2kVU0CD65SESMQStXF7zYqMXhrrIS9c68PXiKHQCDPP1dFzXX
	14i2UOoCLmfy8e2QZXTQsf0M/XXXEPwtuIuZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nPPX4fYwHHjPAcyjia997ROo15EcwKBe
	apBwIjfTKJQwWab2FnWPLz6jhEr59IrsYnlhA12KVmpq0mgygljgqsv2q+yMsaGw
	qBwwA6pKFjzkc+sxFhigmDgtZvMGanU7u97cRH5JQSe4Kn9z0IuZbhomABmIs5n7
	QL+7aaTPxMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BBF22750D;
	Fri, 14 Jun 2013 16:57:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 900C72750B;
	Fri, 14 Jun 2013 16:56:59 +0000 (UTC)
In-Reply-To: <1371215872-9796-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 14 Jun 2013 18:47:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DB1AA0A-D513-11E2-951E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227898>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The revisions specified on the command-line as <onto> and <upstream>
> arguments could be of the form :/quuxery; so, use peel_committish() to
> resolve them.  The failing tests in t/rebase and t/rebase-interactive
> now pass.

You can also specify the commit at the end of the history to be
rebased (very useful while trial runs to see where a series should
apply):

    git rebase foo ":/Add B"

This is already handled properly because it first gets turned into
an object name $orig_head and then we use it (without ^0) to update
the ORIG_HEAD.

Even after this patch, there is

	git checkout -q "$onto^0"

when detaching the HEAD to that commit.  Can that peeling be dropped
now (I am not suggesting to drop it in this patch)?

What would happen when you are given "--onto :/f...o" is somewhat
interesting, but that may be a separate topic, I think.  At that
point, it is probably in the realm of "don't do it then" ;-)

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-rebase.sh                 | 4 ++--
>  t/t3400-rebase.sh             | 2 +-
>  t/t3404-rebase-interactive.sh | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index d0c11a9..6987b9b 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -434,7 +434,7 @@ then
>  		shift
>  		;;
>  	esac
> -	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
> +	upstream=$(peel_committish "${upstream_name}") ||
>  	die "$(eval_gettext "invalid upstream \$upstream_name")"
>  	upstream_arg="$upstream_name"
>  else
> @@ -470,7 +470,7 @@ case "$onto_name" in
>  	fi
>  	;;
>  *)
> -	onto=$(git rev-parse --verify "${onto_name}^0") ||
> +	onto=$(peel_committish "$onto_name") ||
>  	die "$(eval_gettext "Does not point to a valid commit: \$onto_name")"
>  	;;
>  esac
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 81ec517..cbca71e 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -88,7 +88,7 @@ test_expect_success 'rebase fast-forward to master' '
>  	test_i18ngrep "Fast-forwarded HEAD to my-topic-branch" out
>  '
>  
> -test_expect_failure 'rebase, with <onto> and <upstream> specified as :/quuxery' '
> +test_expect_success 'rebase, with <onto> and <upstream> specified as :/quuxery' '
>  	test_when_finished "git branch -D torebase" &&
>  	git checkout -b torebase my-topic-branch^ &&
>  	upstream=$(git rev-parse ":/Add B") &&
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index eb241f5..86917d1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -947,7 +947,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> -test_expect_failure 'rebase -i, with <onto> and <upstream> specified as :/quuxery' '
> +test_expect_success 'rebase -i, with <onto> and <upstream> specified as :/quuxery' '
>  	test_when_finished "git branch -D torebase" &&
>  	git checkout -b torebase branch1 &&
>  	upstream=$(git rev-parse ":/J") &&
