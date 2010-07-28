From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] require_work_tree: Look for top-level instead of
 is-inside-work-tree
Date: Wed, 28 Jul 2010 16:00:21 -0700
Message-ID: <7v4ofjw6t6.fsf@alter.siamese.dyndns.org>
References: <1280335624-90132-1-git-send-email-tor.arne.vestbo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <tor.arne.vestbo@nokia.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 01:00:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeFc7-00012d-1g
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 01:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638Ab0G1XAe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 19:00:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774Ab0G1XAd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 19:00:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A7314C9B40;
	Wed, 28 Jul 2010 19:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZvL5g/dEWV04
	4qONiHNpT9VLqjY=; b=vObDKJrDgH1sBLB5mpwj5oASkcOlhLvDU27evhEXs7Lb
	SVsb7ruLHqOGws6CP2V3HT4rFIoLm+hvUZSwJtEQ5Isf6Bk/fPNrf44EBH8JkFmJ
	/9AYJqECIF1HFQ8j6M0kIff6Kq4xYkiwLQaDfYN6zlME5edsNdkLm2Qu1Nl5nlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eQQsep
	96R/OVfAjBVkjC49lhHnnBzNlhVYrGwuEikQ9zmYV+prKnDg2aRIxLQK8VVwrgey
	we+bja9Vjn24Sbr/WUSZ+93swJE8RSvTIhd66VJZoBQ7hqHzB+XTF7ya3f+76aHy
	J8YyEFIDTdoE0gtHU1hakW0aOn67YDsK6tGxY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C5555C9B3E;
	Wed, 28 Jul 2010 19:00:27 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DFDBC9B3A; Wed, 28 Jul
 2010 19:00:22 -0400 (EDT)
In-Reply-To: <1280335624-90132-1-git-send-email-tor.arne.vestbo@nokia.com>
 ("Tor Arne =?utf-8?Q?Vestb=C3=B8=22's?= message of "Wed\, 28 Jul 2010
 18\:47\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E9D0213A-9A9B-11DF-8499-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152126>

Tor Arne Vestb=C3=B8 <tor.arne.vestbo@nokia.com> writes:

> The documentation describes require_work_tree as guarding against
> bare repositories, and that's also the way it's used from porcelain
> such as git-rebase. When implemented using --is-inside-work-tree
> the samantics change, causing git-rebase to fail if run from outside
> GIT_WORK_TREE, even if GIT_WORK_TREE is valid.
>
> Signed-off-by: Tor Arne Vestb=C3=B8 <tor.arne.vestbo@nokia.com>
> ---

The "requirement" is that we _have_ work tree somewhere that we can
cd-to-toplevel to if we wanted to, not that we _are_ already in the wor=
k
tree.  I can buy that rationale.

However, I notice that "git bisect", "git mergetool" and "git submodule=
"
do not seem to do cd_to_topleve immediately after require_work_tree.  T=
he
last one has cd_to_toplevel in later parts of the codepath, presumably =
so
that it can collect paths relative to the subdirectory in the work tree=
=2E
I wonder if all of them actually need to be run from inside a work tree=
?
Don't they need a separate "git rev-parse --is-inside-work-tree || die"
check after require_work_tree (or perhaps cd_to_toplevel) if we apply t=
his
patch?

"git rebase--interactive" also lacks cd_to_toplevel but that is done by
the calling "git rebase" and I think that one is Ok.

>  git-sh-setup.sh     |    2 +-
>  t/t1501-worktree.sh |    9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 6131670..f8e4428 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -141,7 +141,7 @@ cd_to_toplevel () {
>  }
> =20
>  require_work_tree () {
> -	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" =3D true =
||
> +	test -n "$(git rev-parse --show-toplevel 2>/dev/null)" ||
>  	die "fatal: $0 cannot be used without a working tree."
>  }
> =20
> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index bd8b607..45b09e7 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -114,6 +114,15 @@ test_expect_success 'repo finds its work tree fr=
om work tree, too' '
>  	 test sub/dir/tracked =3D "$(git ls-files)")
>  '
> =20
> +test_expect_success 'require_work_tree finds work tree' '
> +	(cd repo.git/work &&
> +	. "$(git --exec-path)"/git-sh-setup &&
> +	cd .. &&
> +	require_work_tree &&
> +	cd .. &&
> +	require_work_tree)
> +'
> +
>  test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TRE=
E' '
>  	(cd repo.git/work/sub/dir &&
>  	GIT_DIR=3D../../.. GIT_WORK_TREE=3D../.. GIT_PAGER=3D \
> --=20
> 1.7.2.19.g48995
