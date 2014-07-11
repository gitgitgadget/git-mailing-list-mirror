From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] tag: use skip_prefix instead of magic numbers
Date: Fri, 11 Jul 2014 15:44:13 -0700
Message-ID: <xmqqwqbj1poi.fsf@gitster.dls.corp.google.com>
References: <1405114724-23829-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:44:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5jYH-0006xx-LU
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 00:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbaGKWoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 18:44:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60226 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbaGKWoV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 18:44:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 98A6028D56;
	Fri, 11 Jul 2014 18:44:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qIgk0RYNYt6TsSfNP5pwjvT4oYE=; b=R8CvGH
	Gxge4dc69oXvygOZUZgXFknZ1X379bBgoZ+qKdrtm4NpMEqZah9jpnVEJkXxFGOD
	VCasTIetbVqegXDLLDy3URLEcPhwN5zwuC/nt422XMf2i19i/K5p4lU6EqBt3Xv+
	QjelWJn1aGXDS58vsvGSxbAwF6pZ3wVumj4bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dn5FoSgCa6um01IjQEJbJ1YO4D9a1NtI
	Ch3V+ST/15snKaTgnPnOekAGlsfcNiLH/h2hsoglroyiND0LsW6ukQBo2QGmjPGR
	mrin9KH2J0p9jjn5McFinpozRigKaP6OD/RWCTgHsUd7CbJNQVxaYfa60xzPU3K4
	dx9hfmkvYz4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EE7328D55;
	Fri, 11 Jul 2014 18:44:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7E1A028D43;
	Fri, 11 Jul 2014 18:43:59 -0400 (EDT)
In-Reply-To: <1405114724-23829-1-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Fri, 11 Jul 2014 14:38:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D945A2F8-094C-11E4-9A5B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253340>

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jeff King <peff@peff.net>
>
> Make the parsing of the --sort parameter more readable by having
> skip_prefix keep our pointer up to date.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  builtin/tag.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index ef765563388c..7ccb6f3c581b 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -524,18 +524,12 @@ static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
>  	int *sort = opt->value;
>  	int flags = 0;
>  
> -	if (*arg == '-') {
> +	if (skip_prefix(arg, "-", &arg))
>  		flags |= REVERSE_SORT;
> -		arg++;
> -	}
> -	if (starts_with(arg, "version:")) {
> +
> +	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
>  		*sort = VERCMP_SORT;
> -		arg += 8;
> -	} else if (starts_with(arg, "v:")) {
> -		*sort = VERCMP_SORT;
> -		arg += 2;
> -	} else
> -		*sort = STRCMP_SORT;
> +

By losing "*sort = STRCMP_SORT", the version after this patch would
stop clearing what is pointed by opt->value, so

	git tag --sort=v:refname --sort=refname

would no longer implement the "last one wins" semantics, no?

Am I misreading the patch?  I somehow thought Peff's original was
clearing the variable...

>  	if (strcmp(arg, "refname"))
>  		die(_("unsupported sort specification %s"), arg);
>  	*sort |= flags;
