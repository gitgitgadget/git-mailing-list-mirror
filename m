From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 03/11] t5403: avoid doing "git add foo/bar" where
 foo/.git exists
Date: Tue, 25 Oct 2011 12:19:26 -0700
Message-ID: <7vd3dk516p.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 21:19:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RImX9-0006sT-G6
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 21:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab1JYTTa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 15:19:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab1JYTTa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 15:19:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C5185D77;
	Tue, 25 Oct 2011 15:19:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QDQYI8cfXq+Z
	fz+Vl7wnfn6d86Y=; b=FKh0XD6kbhsUsz0ObDZkHxPASfo0H/YE0tnEnEzkXQ+g
	Hhn/1qlehyhh6MyygrMGNWlRYsYNlIYZzAiI/qZQdgri72CywAvdakxFndDH5CZ3
	hOMcsqUC8WikQqGX30yKukuptZeE0W9lQMAYC+5u9R0P34/d7btjT/60ryQKAxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=voNAPs
	8cAUVTmpbg+ifpPXPxHmWqBCH48mkoNtR3aLkvrc9ritKwYUmX1TB4s6s4r07NjX
	nBQHsNQqwgWwaDOGz51cmxwQhHNxdP+Gd49irGD7RBIXAef+NnPjIheNP0WYYApn
	yNWYvXFUKO2dwWZhL0bN1OYsIW7ZRDnoxbW7E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E38325D76;
	Tue, 25 Oct 2011 15:19:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 020E95D75; Tue, 25 Oct 2011
 15:19:27 -0400 (EDT)
In-Reply-To: <1319438176-7304-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 24 Oct
 2011 17:36:08 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41EC93F0-FF3E-11E0-815F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184231>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> In this case, "foo" is considered a submodule and bar, if added,
> belongs to foo/.git. "git add" should only allow "git add foo" in thi=
s
> case, but it passes somehow.

I do not think the above description is correct.

The test:

 - populates the current directory;
 - makes a clone in ./clone2;
 - creates a file clone2/b;
 - runs "git add clone2/b" with GIT_DIR set to clone2/.git, without
   setting GIT_WORK_TREE nor having core.worktree in clone2/.git/config=
=2E

The last step should add a path "clone2/b" to $GIT_DIR/index (which is
clone2/.git/index in this case).  The clone2 is not a submodule to the =
top
level repository in this case, but even if it were, that would not chan=
ge
the definition of what the command should do when GIT_DIR is set withou=
t
GIT_WORK_TREE nor core.worktree in $GIT_DIR/config.

Running (cd clone2 && git add b) is a _more natural_ thing to do, and i=
t
will result in a path "b" added to the clone2 repository, so that the
result is more useful if you are going to chdir to the repository and k=
eep
working on it.  But that does not mean the existing test is incorrect. =
It
does not just pass somehow but the test passes by design.

I did not check if later tests look at the contents of commit "new2" to
make sure it contains "clone2/b", but if they do this change should bre=
ak
such tests.

So I am puzzled by this change; what is this trying to achieve?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  t/t5403-post-checkout-hook.sh |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-ho=
ok.sh
> index 1753ef2..3b3e2c1 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -16,10 +16,13 @@ test_expect_success setup '
>  	git update-ref refs/heads/master $commit0 &&
>  	git clone ./. clone1 &&
>  	git clone ./. clone2 &&
> -	GIT_DIR=3Dclone2/.git git branch new2 &&
> -	echo Data for commit1. >clone2/b &&
> -	GIT_DIR=3Dclone2/.git git add clone2/b &&
> -	GIT_DIR=3Dclone2/.git git commit -m new2
> +	(
> +		cd clone2 &&
> +		git branch new2 &&
> +		echo Data for commit1. >b &&
> +		git add b &&
> +		git commit -m new2
> +	)
>  '
> =20
>  for clone in 1 2; do
> @@ -48,7 +51,7 @@ test_expect_success 'post-checkout runs as expected=
 ' '
>  '
> =20
>  test_expect_success 'post-checkout args are correct with git checkou=
t -b ' '
> -	GIT_DIR=3Dclone1/.git git checkout -b new1 &&
> +	( cd clone1 && git checkout -b new1 ) &&
>  	old=3D$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
>  	new=3D$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
>  	flag=3D$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
> @@ -56,7 +59,7 @@ test_expect_success 'post-checkout args are correct=
 with git checkout -b ' '
>  '
> =20
>  test_expect_success 'post-checkout receives the right args with HEAD=
 changed ' '
> -	GIT_DIR=3Dclone2/.git git checkout new2 &&
> +	( cd clone2 && git checkout new2 ) &&
>  	old=3D$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
>  	new=3D$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
>  	flag=3D$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
> @@ -64,7 +67,7 @@ test_expect_success 'post-checkout receives the rig=
ht args with HEAD changed ' '
>  '
> =20
>  test_expect_success 'post-checkout receives the right args when not =
switching branches ' '
> -	GIT_DIR=3Dclone2/.git git checkout master b &&
> +	( cd clone2 && git checkout master b ) &&
>  	old=3D$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
>  	new=3D$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
>  	flag=3D$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
