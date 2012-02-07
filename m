From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -e: ignore dirty submodules
Date: Mon, 06 Feb 2012 21:50:41 -0800
Message-ID: <7vaa4v42fi.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1202070504340.24259@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 07 06:50:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rudx4-0008EM-4a
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 06:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab2BGFup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 00:50:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860Ab2BGFuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 00:50:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C62A36E69;
	Tue,  7 Feb 2012 00:50:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VHAlgeQD8fFa37V7gmWkHoLzWxg=; b=q1BCsJ
	gCD0PGdERVtYTi32yO9GnRJZ5+5antoNs2FsBjAcINMPEqPiTpSDD65UoWEhx9cB
	jx8oXLMJ1WyE+B2Bua+/S5WP6NPWDuwDoEA7OuUBBBzIb6tN1c6keIjHf5C90BoJ
	T2PQ3HU0CEeEFqJDL7i9ez8tVtYoGNUmG2oGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qWkTzQRhx+nEPWuhaRp2kufIJHShHlZx
	XnkTFt1pNZy35bPBT3yyFiVR4fRI3mBH8kOtBM4sqwfI4lk5fCzIUkERCo1i/yCG
	CG4nmOMoRAdqvC0b/u0oifJT/QkhtJ8TSaDuIJm14Tmjks6PJIcohK74einZxVBw
	EUO5Umn02ug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC5F86E68;
	Tue,  7 Feb 2012 00:50:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DC936E67; Tue,  7 Feb 2012
 00:50:43 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1202070504340.24259@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Tue, 7 Feb 2012 05:05:48 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC364BE4-514F-11E1-980D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190142>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> We cannot add untracked/modified files in submodules anyway.

I can see the updated code would not break "git apply" that will be run on
this output, but the above cannot be the whole story. It is unclear to me
what it is trying to achieve (in other words, "this patch does not break
the system" is not the whole purpose of the patch).

When a submodule is updated and is dirty, we would get:

    diff --git a/submodule b/submodule
    @@ -1,+1 @@
    -Subproject commit XXXX...
    +Subproject commit YYYY...-dirty

and leaving this diff in the edited patch adds YYYY... for submodule, even
though "-dirty" suffix is there.  So it is not fixing "the user tries to
update but fails because we do not filter dirty submodules" bug, or somesuch.
Besides, showing -dirty may be a good reminder that submodule has further
changes on top of what is going to be committed in this case.

When a submodule is only dirty, we would see:

    diff --git a/submodule b/submodule
    @@ -1,+1 @@
    -Subproject commit XXXX...
    +Subproject commit XXXX...-dirty

and leaving this diff in the edited patch keeps the submodule at XXXX...,
again without failing, so it is not fixing "the user gets unnecessary
error message" bug, or somesuch.  In this case, leaving this diff will be
a no-op so it is wasteful and distracting to the user who edits the patch.

Is that what this patch is about?  "For a submodule that is unchanged but
is dirty, submodule diff whose difference is only the '-dirty' suffix is
given but the user cannot update the index with such a diff anyway, so it
is a waste of space", or something like that?

That is the best guess I arrived at, but I suspect that it cannot be it,
as that discards the "-dirty" clue from the output when the submodule path
does have difference, as we saw in the earlier example. So there must be
something I am missing.

So I am out of ideas guessing what this patch is trying to achieve.  The
commit log shouldn't force the readers of the history to _guess_ like the
above.

>  builtin/add.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 1c42900..b79336d 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -280,6 +280,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
>  
>  	argc = setup_revisions(argc, argv, &rev, NULL);
>  	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
> +	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
>  	out = open(file, O_CREAT | O_WRONLY, 0644);
>  	if (out < 0)
>  		die (_("Could not open '%s' for writing."), file);
