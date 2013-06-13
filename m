From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t/checkout-last: checkout - doesn't work after rebase
Date: Thu, 13 Jun 2013 10:46:45 -0700
Message-ID: <7vfvwlvr7e.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:46:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBbp-0000K7-NT
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758851Ab3FMRqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 13:46:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758359Ab3FMRqr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 13:46:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52D1B27A41;
	Thu, 13 Jun 2013 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kOmhzccoCnyCxyJkLgxpvAmFr+4=; b=UdOHCA
	Oahze6UDi7qtBi80aLtQ3fUYfyHAJs3np2yuKDmsKH2PNCrpG6Yj6jSnW8zFKkjW
	Wr3WwyAO+gx6OeBPQdzI5OHTcRScySsiF6tEeH3lyAbXeCZ9QG3CwTwtTu2pRUSe
	FobZ2Q1SMHBDkLvr+5pgoF6Q5wFYZhusME9hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bdVZ+5k4BkibvZne+aDmF779TD0rPe0z
	1mbBfr24grkwkCYK0tFOyiXU19GcWRAeGxxGjx+RBGaoHZwfIJxTxlrF6LdKhvC4
	SjFaeJyWhsr7vlY4UQo95QWcHHtVqnm8uJ4TdTBRYs/FMKlhGYXgyJHQELr+EY6p
	IUGrg/7kjaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 485D727A3F;
	Thu, 13 Jun 2013 17:46:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A84B127A3E;
	Thu, 13 Jun 2013 17:46:46 +0000 (UTC)
In-Reply-To: <1371130349-30651-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 13 Jun 2013 19:02:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37BAF298-D451-11E2-9CB5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227755>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The following command
>
>   $ git checkout -
>
> does not work as expected after a rebase.  Every kind of rebase must
> behave in the exactly same way: for the purposes of checkout -, the
> rebase event should be inconsequential.
>
> Add two failing tests documenting this bug: one for a normal rebase, and
> another for an interactive rebase.

Why two?

After the discussion, I would have expected to see the two argument
form:

	git rebase [-i] master other
        
started on the 'other' branch and also started on a branch that is
not 'master' or 'other', also be tested to specify the desired
behaviour in these cases.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t2012-checkout-last.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
> index b44de9d..ae6d319 100755
> --- a/t/t2012-checkout-last.sh
> +++ b/t/t2012-checkout-last.sh
> @@ -116,4 +116,20 @@ test_expect_success 'master...' '
>  	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
>  '
>  
> +test_expect_failure '"checkout -" works after a rebase' '
> +	git checkout master &&
> +	git checkout other &&
> +	git rebase master &&
> +	git checkout - &&
> +	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
> +'
> +
> +test_expect_failure '"checkout -" works after an interactive rebase' '
> +	git checkout master &&
> +	git checkout other &&
> +	git rebase -i master &&
> +	git checkout - &&
> +	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
> +'
> +
>  test_done
