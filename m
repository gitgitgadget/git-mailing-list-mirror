From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: indicate when a detached head is checked out for a branch
Date: Fri, 18 Jul 2014 10:36:11 -0700
Message-ID: <xmqqr41imuwk.fsf@gitster.dls.corp.google.com>
References: <35dbe7e3f3e4566d775bea19d816adc44db8ed5c.1405676303.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:36:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8C5B-00030w-Ej
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 19:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966012AbaGRRgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 13:36:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54982 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966002AbaGRRgT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 13:36:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1715728C01;
	Fri, 18 Jul 2014 13:36:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WAO3BTrwtcbaZHlx/29Tjxliswk=; b=rKDIIe
	56Jf91x4XZCnafwR8lBmCfQcnoRhyeNUpn7sUL0lkkloMr2IsMNaVO2K0fRHW4Yp
	zHHzPh7VPR9SC2waHUU+VCu1P6AANxTCoWHL4/A2zshAkv49ACPvcuNaH1kQQZ6l
	pTbxMLsUeBl+ZdS01MEkzKGB5RWgiIq3OpbSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BmbfBSp/7CfvWsnq5WiOhb+MN31LYTPL
	4i4WJuJgm034LBe7kjYyl25M+9ZEJDwXe3GKCXtHUamsP42LP4odGUeFwiGNojlt
	Aauihnn58rpcBG6oEFDFd2KpIxKF2E7WMVeae9UNf8rqhVXI3A1zWDKny9Mgd0Hv
	cfSGWlfx+H8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E03928C00;
	Fri, 18 Jul 2014 13:36:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 588EB28BF1;
	Fri, 18 Jul 2014 13:36:13 -0400 (EDT)
In-Reply-To: <35dbe7e3f3e4566d775bea19d816adc44db8ed5c.1405676303.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 18 Jul 2014 11:50:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 03792F54-0EA2-11E4-9B6F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253831>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I really like the new --to feature and will convert all my "new workdir"
> checkouts to that. But that detached checkout is so easy to miss - in fact
> I noticed it only when I compared "new-workdir" to "checkout --to" for a
> test repo with one branch, to see what a converter would need to do.
>
> I'm even wondering whether we should do this DWIMmery at all, given how
> "dangerous" a detached head is for those who are not aware of it
> before gc kicks in.

As long as the amount of warning about 'detached HEAD' is about the
same between this case and a "git checkout v1.2.3" in a normal
repository, I do not think there is no additional "danger" you need
to be worried about.

But I do agree that there should not be any DWIM here.

The reason to introduce this new set of rather intrusive changes is
so that working trees can be aware of branches other working trees
have checked out.  And the whole point of wanting to have that
mutual awareness is to enable us to forbid users from mucking with
the same branch from two different places.

But Git is not in the position to dictate which alternative action
the user would want to take, when her "git checkout foo" is
prevented by this mechanism.  In one scenario, she may say "I only
wanted to take a peek" and run "git checkout foo^0" instead.  In
another, she may say "Ah, I forgot I already was doing this change
in the other one" and run "cd ../foo".  There may be other classes
of alternative actions.

Don't make it easier for the first class of scenario and make it
less useful and more dangerous for the second class, especially the
second class involve forgetful users who are likely to forget seeing
the "we've warned you that we detached without being asked" message.

Please fix it to always just error out.

> (Sorry if that dupes something on the list, can't keep up these days;
> so this is coming from a "mere user" ;-)
>
>  builtin/checkout.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index cfc6db7..38a5670 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -645,9 +645,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  				detach_advice(new->name);
>  			describe_detached_head(_("HEAD is now at"), new->commit);
>  			if (new->checkout && !*new->checkout)
> -				fprintf(stderr, _("hint: the main checkout is holding this branch\n"));
> +				fprintf(stderr, _("hint: the main checkout is holding this branch; detaching branch head instead.\n"));
>  			else if (new->checkout)
> -				fprintf(stderr, _("hint: the linked checkout %s is holding this branch\n"),
> +				fprintf(stderr, _("hint: the linked checkout %s is holding this branch; detaching branch head instead.\n"),
>  					new->checkout);
>  		}
>  	} else if (new->path) {	/* Switch branches. */
