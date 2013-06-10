From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t/checkout-last: checkout - doesn't work after rebase -i
Date: Mon, 10 Jun 2013 11:29:03 -0700
Message-ID: <7vhah5izv4.fsf@alter.siamese.dyndns.org>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
	<1370881332-9231-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:29:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6q9-0008VP-IV
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab3FJS3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:29:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316Ab3FJS3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:29:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1713927E80;
	Mon, 10 Jun 2013 18:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FFzf2Z1khBD3KpTs4kT0IDYF3EM=; b=hdlVKD
	qxYZHFs6lOXc3O3jjS/NQRBhetUjrOzuhwXIakmpSMuL46Cmvyx3BTGmiDPZpQ12
	ZH0f1Oj+y4YDYVEE3IXd16oWEDnBZ8sAcPqymDaQbFSudZerYWiTixoaWdTQY098
	X576pzGaF/wAtFsL1inm62wwcWv3Kl3Gnr2Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TibZp45Ti59xFcM188erRnKxHdQiGcoI
	wx3Q7w2fovNdA5+Uw5Bf4U1YFwECer8Bu/U71h1g+MV00MbsWzenpZOzcQqn9Rs0
	JgbkAvk0MVmtWILOkpsmo77io5f93d0TB0u9c55sqVuhOUfCHlxw9LFWIGeFZF6x
	9TlLsDiiV/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E2BE27E7F;
	Mon, 10 Jun 2013 18:29:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D2FC27E7D;
	Mon, 10 Jun 2013 18:29:05 +0000 (UTC)
In-Reply-To: <1370881332-9231-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 10 Jun 2013 21:52:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1A1B848-D1FB-11E2-A08D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227342>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The following command
>
>   $ git checkout -
>
> does not work as expected after a 'git rebase -i'.
>
> Add a failing test documenting this bug.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t2012-checkout-last.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
> index b44de9d..5729487 100755
> --- a/t/t2012-checkout-last.sh
> +++ b/t/t2012-checkout-last.sh
> @@ -116,4 +116,12 @@ test_expect_success 'master...' '
>  	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
>  '
>  
> +test_expect_failure '"checkout -" works after an interactive rebase' '
> +	git checkout master &&
> +	git checkout other &&
> +	git rebase -i master &&
> +	git checkout - &&
> +	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
> +'

Hmph, you were on "other" and then ran "rebase -i" to rebase it.
When you are done, you are on "other".  You want to go back to the
one before you checked out the branch you started your "rebase -i"
on, which is "master".

OK, the expectation makes sense to me.

These four are all valid ways to spell the "rebase -i master" step.

	git rebase -i master
        git rebase -i --onto master master
        git rebase -i master other
        git rebase -i --onto master master other

and I think it is sensible to expect

 (1) they all behave the same way; or

 (2) the first two behave the same, but the latter two explicitly
     checks out 'other' by giving the last argument.  If you are not
     on 'other' when you run the "rebase -i", "checkout -" should
     come back to the branch before 'other', i.e. the branch you
     started your "rebase -i" on.

In other words, (2) would mean:

	git checkout master &&
        git checkout -b naster &&
        git rebase -i master other &&
	# ends up on other
        test_string_equal "$(git symbolic-ref HEAD)" refs/heads/other &&
        git checkout - &&
	# we were on naster before we rebased 'other'
        test_string_equal "$(git symbolic-ref HEAD)" refs/heads/naster

It is a bit unclear what the following should expect.

	git checkout master &&
        git checkout other &&
        git rebase -i master other &&
	# ends up on other
        test_string_equal "$(git symbolic-ref HEAD)" refs/heads/other &&
        git checkout - &&
	# we are on ??? before we rebased other
        test_string_equal "$(git symbolic-ref HEAD)" refs/heads/???

One could argue that the "first checkout other and then rebase" done
by rebase becomes a no-op and the user should be aware of that
because rebase is started while on that other branch, in which case
we should come back to 'master'.  From consistency point of view,
one could instead argue that we were on 'other' before we rebased
it, in which case it may not be unreasonable for "checkout -" to
come back to 'other'.  I tend to prefer the former (i.e. go back to
'master') over the latter but not by a large margin.
