From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] teach ref iteration module about submodules
Date: Wed, 30 Jun 2010 13:37:24 -0700
Message-ID: <7vvd9045q3.fsf@alter.siamese.dyndns.org>
References: <cover.1277923843.git.hvoigt@hvoigt.net>
 <26d63936d5a71de6a8e8aa823a69ddda8b999e4b.1277923844.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jun 30 22:38:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU42g-0001x8-AB
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 22:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab0F3Uhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 16:37:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab0F3Uhg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 16:37:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81A90C085C;
	Wed, 30 Jun 2010 16:37:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7bWbvuV6y2U8PNQOG7BNpX+RNvY=; b=nd3C8GcEHh9QKl1DYKa69K/
	Kx8O6W/ZJkNj0m3juqPBIRaa8xTNdUiUNcKOS82R2/bx4WvkSsaI6jZR5heqFpuk
	DVjmCyQKNDqpGEAjDvhK4pkaD5/EYxwe+FoCqmtk8IG1LfIFvlanDYsW1rWo+5pV
	ZIJAtGduVRkS0it8LvSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=UbRHUoL1mK3LZqY+d57Ys2aoofQlZLBHZUtoqt+rj/GXkX/jF
	zykjckIem0jnnIAUvPcKPyKk1d+Zgx+cxyp60bD8qoQXKe+TDXcxSHWb+0m4Pdqg
	voh4VFQM5BhuI1+MOvGFr1ItbLjMSatxnXN9rGrATvaL0zQGTkwFKkeUzo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39FA9C085A;
	Wed, 30 Jun 2010 16:37:31 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2251BC0854; Wed, 30 Jun
 2010 16:37:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E32F132-8487-11DF-8318-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149993>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> +char *git_path_submodule(const char *path, const char *fmt, ...)
> +{
> +...
> +	strbuf_addch(&buf, '/');
> +
> +	strncpy(pathname, buf.buf, PATH_MAX);
> +	if (pathname[PATH_MAX-1] != '\0')
> +		return bad_path;

This may not be wrong per-se, but having strncpy() NUL-pad the remainder
of the buffer only because you want to check overlong path by inspecting
pathname[PATH_MAX-1] sounds somewhat stupid, no?  Your buf.len knows how
long the path is already at this point, doesn't it?

> @@ -322,11 +352,12 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
>  	for_each_rawref(warn_if_dangling_symref, &data);
>  }
>  
> -static struct ref_list *get_loose_refs(void)
> +static struct ref_list *get_loose_refs(const char *submodule)
>  {
> -	if (!cached_refs.did_loose) {
> -		cached_refs.loose = get_ref_dir("refs", NULL);
> +	if (!cached_refs.did_loose || cached_refs.submodule != submodule) {

Do you really mean "!=" here?  I do not see anywhere that you are
"intern"-ing (a la Lisp implementations) names of submodules to make
address comparison work as a cheap equality check.

> +		cached_refs.loose = get_ref_dir(submodule, "refs", NULL);

What happened to the old ref_list that had the refs from the toplevel
project (or the last submodule you visited) if your "did_loose" is true?
Leakage?

>  		cached_refs.did_loose = 1;
> +		cached_refs.submodule = submodule;
>  	}
>  	return cached_refs.loose;
>  }

Once you grabbed loose refs for _any_ repository, you will have did_loose
set, so the flag has now became pretty much useless.

More importantly, I wonder if you would instead want to have cached_refs
structure for each submodule separately, or at least not nuke the
cached_refs structure for the top-level project, only because you wanted
to peek into one submodule.  While your for_each_ref() is walking the refs
of top-level project, its callback may stomp on the cached_refs by asking
about submodule refs, and there is nothing in this code structure to help
catching such a bug, is there?
