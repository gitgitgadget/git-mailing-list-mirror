From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] branch: suggest how to undo a --set-upstream when
 given one branch
Date: Mon, 20 Aug 2012 11:50:19 -0700
Message-ID: <7vk3wtjt3o.fsf@alter.siamese.dyndns.org>
References: <1345470460-28734-1-git-send-email-cmn@elego.de>
 <1345470460-28734-4-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 20:50:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3X3W-0007db-UA
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 20:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab2HTSuZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 14:50:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59942 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155Ab2HTSuX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 14:50:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EE569BF1;
	Mon, 20 Aug 2012 14:50:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Hx0ZxtsghlpL
	wzC4DKEfM06X6xg=; b=CDX4x+EV2RNuKm/9cOCdy+y3tpSvjr/ZOQpsnuC74ER3
	z43zLeTFMOmS2VYUj0xZWeT6IKX9dqi8uwuIsGe8LEXrGICAjRitiZBOUSQL9m/1
	AXN/HDk5+vjnLNUzdDwGqLC8oyHboJAnlNYozu99hA30JP1WghaZrF3UlRTf7y4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=F300qa
	gui5W//AUwK+Blzon1bnRNgUaUDlS6PjJpyRHApKojDRT83PIdyjnx1rniNcjPDM
	CzdC5b2IzpmMnAbc7s+ZXL3jst0DJeS0D4+OdfQ0GSpQrxglsDZAQTq4NEeGSTL8
	fVo62UEaE67RcEfcNXA91wWoTUUbtutUgAbig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B0BD9BF0;
	Mon, 20 Aug 2012 14:50:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F5A99BEC; Mon, 20 Aug 2012
 14:50:21 -0400 (EDT)
In-Reply-To: <1345470460-28734-4-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 20 Aug 2012 15:47:40
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4D2454C-EAF7-11E1-8157-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203867>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> This interface is error prone, and a better one (--set-upstream-to)
> exists. Suggest how to fix a --set-upstream invocation in case the
> user only gives one argument, which makes it likely that he meant to
> do the opposite, like with
>
>     git branch --set-upstream origin/master
>
> when they meant one of
>
>     git branch --set-upstream origin/master master
>     git branch --set-upstream-to origin/master

In "git branch --set-upstream $A", if $A did not exist (i.e. we
ended up creating $A that is forked from the current branch), and if
refs/remotes/$A exists, I agree it is very likely that the user
wanted to set the upstream of the current branch to remotes/$A
instead.

But I am not sure about other cases.  If $A already existed, it is
equally likely that "git branch --set-upstream $A" wanted to make
the existing $A track our current branch, or make our branch track
that existing $A, isn't it?  We would end up giving unwanted advice
that is *wrong* for the user's situation 50% of the time, which does
not sound like an acceptable thing to do.

So I would really prefer to see the condition this advice is offered
limited to very specific cases (namely, only one parameter $A was
given to cause us use "HEAD" as the other branch, refs/heads/$A did
not exist and refs/remotes/$A did; there may be others but I think
this is the one we most care about) in which we know the advice is
correct with certainty.

> While we're at it, add a notice that the --set-upstream flag is
> deprecated and will be removed at some point.

This part is unquestionably good.

> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>
> ---
>
> This produces suboptimal output in case that A tracks B and we do
>
>     git checkout B
>     git branch --set-upstream A
>
> as it will suggest
>
>     git branch --set-upstream A B
>
> as a way of undoing what we just did.

The literal meaning of what the user did was to create B and then
made A that existed (and used to build upon B) to build upon B,
which is a no-op.  And undoing can be done with the same command.

Which is funny.

I am sure you will get complaint from the real users.  To avoid it,
you would need to know what the old value was (if any), and skip the
"undo" part, but I think it is probably worth it.  You already have
code to learn what the old value was anyway, so the ideal is just a
single comparison away, no?

By the way, are you assuming that what the user wanted to do was to
make B build on top of A (i.e. set branch.B.up to A) in this
example?  For that setting to make sense, perhaps B should already
be a descendant of A, shouldn't it?  If that is the case, that is
another clue you can use in your logic to decide if you want to tell
the user "you told me to make $A build on the current branch, but I
think you meant the other way around" with more confidence.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 08068f7..33641d9 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -707,6 +707,21 @@ static int edit_branch_description(const char *b=
ranch_name)
>  	return status;
>  }
> =20
> +static void print_set_upstream_warning(const char *branch, int branc=
h_existed, const char *old_upstream)
> +{
> +	fprintf(stderr, _("If you wanted to make '%s' track '%s', do this:\=
n\n"), head, branch);

I would suggest strongly against using the verb "track" here, as it
is overused and has caused confusion "is it tracking branch, remote
tracking branch, do I merge in one but fetch to update the other?".

Regardless of the verb, I think there should be a line _before_ the
above to tell the user what the command actually _did_, to make the
distinction stand out to help the user decide.

That is, tell the user "I set upstream for that other branch to the
current branch, making that other branch build on top of the current
branch.  If that was a mistake, and what you really wanted to do was
to make the current branch build on top of the other branch, here
are the things you need to do to recover".  Without saying anything
before "If that was a mistake, " part and giving "to do X, do Y"
would leave the user confused why he is being given a way to do X in
the first place, whether what he really wanted to do was X or
something else.

> +	if (branch_existed) {
> +		if (old_upstream)
> +			fprintf(stderr, _("    git branch --set-upstream %s %s\n"), old_u=
pstream, branch);
> +		else
> +			fprintf(stderr, _("    git branch --unset-upstream %s\n"), branch=
);
> +	} else {
> +		fprintf(stderr, _("    git branch -d %s\n"), branch);
> +	}
> +
> +	fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branch)=
;
> +}

And I suspect the logic to call into this function needs to be
tightened a lot.  It may even turn out that we may not need messages
when "branch_existed" is true.

>  int cmd_branch(int argc, const char **argv, const char *prefix)
>  {
>  	int delete =3D 0, rename =3D 0, force_create =3D 0, list =3D 0;
> @@ -877,10 +892,30 @@ int cmd_branch(int argc, const char **argv, con=
st char *prefix)
>  		git_config_set_multivar(buf.buf, NULL, NULL, 1);
>  		strbuf_release(&buf);
>  	} else if (argc > 0 && argc <=3D 2) {
> +		struct branch *branch =3D branch_get(argv[0]);
> +		const char *old_upstream =3D NULL;
> +		int branch_existed =3D 0;
> +
>  		if (kinds !=3D REF_LOCAL_BRANCH)
>  			die(_("-a and -r options to 'git branch' do not make sense with a=
 branch name"));
> +
> +		if (track =3D=3D BRANCH_TRACK_OVERRIDE)
> +			fprintf(stderr, _("The --set-upstream flag is deprecated and will=
 be removed. Consider using --track or --set-upstream-to\n"));
> +
> +		/*
> +		 * Save what argv[0] was pointing to so we can give
> +		 * the --set-upstream-to hint
> +		 */
> +		if (branch_has_merge_config(branch))
> +			old_upstream =3D shorten_unambiguous_ref(branch->merge[0]->dst, 0=
);
> +
> +		branch_existed =3D ref_exists(branch->refname);
>  		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
>  			      force_create, reflog, 0, quiet, track);
> +
> +		if (argc =3D=3D 1 && track =3D=3D BRANCH_TRACK_OVERRIDE)
> +			print_set_upstream_warning(argv[0], branch_existed, old_upstream)=
;
> +
