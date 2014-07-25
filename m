From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/3] config --global --edit: create a template file if needed
Date: Fri, 25 Jul 2014 10:36:57 -0700
Message-ID: <xmqqioml732e.fsf@gitster.dls.corp.google.com>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 19:37:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjQh-0003jz-P2
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935044AbaGYRhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:37:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56577 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934791AbaGYRhG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:37:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF1FF2AA6C;
	Fri, 25 Jul 2014 13:37:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lJEsaxdsJpGOsqK+M0aXqitNSxM=; b=kekkf8
	jN8d8OHr6ap18EJGUX68QVNOl66pZ/lCBlZRYBU3Lz6zMsomS+SLpewdSZ0yUm9f
	p2ueaTRHge9L54Yd32LW5Sv7G8w3MhqEf5ctWrkTPTu9Utn/Epz1Vwq8rMCZ7wT0
	o1aZwUfOH/extyv8Z/FywEp3Bqi9UWIA7kPzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ApMsMick5RoQrkwEOm0dNUscVBFykMp1
	8/RdoPMGsfrbsoFK6UjSw7JUZ/EZlrTi3Vf91dDIB04Fr7dqbrhpm2oayL29CRX5
	BomW2WqfZwCojRWO+kzsEvFdVrOjFoou0OdcxNgUr6a2q6ok4pY8dnQ9Cl0HjMTs
	dGYPA+tf5NI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D52BF2AA6B;
	Fri, 25 Jul 2014 13:37:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BD6832AA62;
	Fri, 25 Jul 2014 13:36:59 -0400 (EDT)
In-Reply-To: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Fri, 25 Jul 2014 15:44:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4807AECC-1422-11E4-BD4A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254240>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> When the user has no ~/.gitconfig file, git config --global --edit used
> to launch an editor on an nonexistant file name.
>
> Instead, create a file with a default content before launching the
> editor. The template contains only commented-out entries, to save a few
> keystrokes for the user. If the values are guessed properly, the user
> will only have to uncomment the entries.
>
> Advanced users teaching newbies can create a minimalistic configuration
> faster for newbies. Beginners reading a tutorial advising to run "git
> config --global --edit" as a first step will be slightly more guided for
> their first contact with Git.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

Probably a good idea; I do not think of any possible interactions we
have to worry about with the configuration file init-db creates with
possible templating.

Do we use "user-wide" as a phrase to refer to these?  It sounds
somewhat funny to call anything specific to $frotz "$frotz-wide", at
least to me.

Surely, /etc/gitconfig is called "site-wide".  But .git/config is
per-project (or project-specific), and I would always have thought
that ~/.gitconfig was "per-user".

>  builtin/config.c | 30 +++++++++++++++++++++++++++---
>  cache.h          |  1 +
>  ident.c          |  2 +-
>  3 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index fcd8474..3821697 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -445,6 +445,20 @@ static int get_urlmatch(const char *var, const char *url)
>  	return 0;
>  }
>  
> +static char *default_user_config()

static char *default_user_config(void)

> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	strbuf_addf(&buf,
> +		    _("# This is Git's user-wide configuration file.\n"
> +		      "[core]\n"
> +		      "# Please, adapt and uncomment the following lines:\n"

tangent: is it a French tradition to always have comma after please?
