From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: find orig_head unambiguously
Date: Tue, 23 Apr 2013 16:31:27 -0700
Message-ID: <7vobd4hlio.fsf@alter.siamese.dyndns.org>
References: <1366757474-29149-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 01:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUmgR-0003Z0-SY
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 01:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527Ab3DWXbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 19:31:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47723 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107Ab3DWXba (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 19:31:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC9A01912D;
	Tue, 23 Apr 2013 23:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FKLxIwDJrFb0+aVhihW7wvInytI=; b=jrrKSL
	LqBP3peZAncGCk+O6KCzUgseGpzal3LQ0qdl246Dbnmco/vLV0kLpB/XxAEZ1pGE
	HamiySWLEP9Ajt1DeJgAKWyyURTXU05HJT+/zipW1mdKWYLjzTTtTBT8JO0Eii24
	JCGOp5Djgr6jerqM6t4YvnpP648K+PGxsf7Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jPLyOK44KPj5RXGPwRRhrPDFs8s71ndm
	IdH+n4AViRJPZgFMCDsMCw95cm+z/DPI8FM7lEYv3FFhQE2+dy/YSXpWzBmGv8aQ
	VfxT6fyYAk4h3Jdjo243W1lqhL7k5Cnq9boz5PWMph6t12Qr4XIUlWZBAj0mbsA2
	NT7I9tUPLm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C45C11912C;
	Tue, 23 Apr 2013 23:31:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 278F91912A;
	Tue, 23 Apr 2013 23:31:29 +0000 (UTC)
In-Reply-To: <1366757474-29149-1-git-send-email-hordp@cisco.com> (Phil Hord's
	message of "Tue, 23 Apr 2013 18:51:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC6F1E1E-AC6D-11E2-9D5C-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222219>

Phil Hord <hordp@cisco.com> writes:

> When we 'git rebase $upstream', git uses 'rev-parse --verify
> $current_branch' to find ORIG_HEAD.  But if $current_branch
> is ambiguous, 'rev-parse --verify' emits a warning and returns
> a SHA1 anyway.  When the wrong ambiguous choice is used,
> git-rebase fails non-gracefully:  it emits a warning about
> failing to lock $current_branch, an error about being unable to
> checkout $current_branch again, and it might even decide the
> rebase is a fast-forward when it is not.
>
> In the 'rebase $upstream' case, we already know the unambiguous
> spelling of $current_branch is "HEAD".  Fix git-rebase to find
> $orig_head unambiguously.

Well explained; $current_branch that never appears as a variable in
the section of the code in question made me scratch my head while
reading it, though.

Will queue; thanks.

> Add a test in t3400-rebase.sh which creates an ambiguous branch
> name and rebases it implicitly with 'git rebase $other'.
>
> Signed-off-by: Phil Hord <hordp@cisco.com>
> ---
>  git-rebase.sh     | 2 +-
>  t/t3400-rebase.sh | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index b2f1c76..2c692c3 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -473,7 +473,7 @@ case "$#" in
>  		head_name="detached HEAD"
>  		branch_name=HEAD ;# detached
>  	fi
> -	orig_head=$(git rev-parse --verify "${branch_name}^0") || exit
> +	orig_head=$(git rev-parse --verify HEAD) || exit
>  	;;
>  *)
>  	die "BUG: unexpected number of arguments left to parse"
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index f6cc102..b58fa1a 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -101,7 +101,14 @@ test_expect_success 'HEAD was detached during rebase' '
>  	test $(git rev-parse HEAD@{1}) != $(git rev-parse my-topic-branch@{1})
>  '
>  
> +test_expect_success 'rebase from ambiguous branch name' '
> +	git checkout -b topic side &&
> +	git rebase master
> +'
> +
>  test_expect_success 'rebase after merge master' '
> +	git checkout --detach refs/tags/topic &&
> +	git branch -D topic &&
>  	git reset --hard topic &&
>  	git merge master &&
>  	git rebase master &&
