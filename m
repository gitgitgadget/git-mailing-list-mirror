From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Colorize commit decorations
Date: Thu, 17 Jun 2010 13:22:50 -0700
Message-ID: <7vtyp11k9x.fsf@alter.siamese.dyndns.org>
References: <1276791344-25550-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 22:23:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPLcC-0001uJ-9M
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 22:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933294Ab0FQUXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 16:23:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933243Ab0FQUW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 16:22:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E533BBCB7A;
	Thu, 17 Jun 2010 16:22:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZzPRYHvxeBnYwoxpQxkv3xX5Fqc=; b=h4oltxvxZ86ErCjW9LC1lgI
	fEaYT83Xis2DhlvHiUMIERKH2D+G9VLeQgc9hx93pwy9hdV0SZ3K9p+mXDoM7L11
	iWI4oiMx488rJGxt5B7/IWrX5i4RdGMI4MM9G/3Ujcd3MsaUgcVQxmzHZI0tA25p
	8pxbgbKqHEDzatxjvG94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=H46YOMCZu87sIH9Pb8l6tzhlWUJgahgvfAuX8SetgohaSgPX6
	+W5+QL7tecrna01gnjHA83oMoJAVwYRd5hxz4G+5oOVwtnygYnhFtsbWRYy2mD0a
	xkh50hNB60NLKaFkhDPR5VJCyg4ftBoeWGofjAX2Yv0HnJKv94RDK8q8qQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC080BCB78;
	Thu, 17 Jun 2010 16:22:55 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A41E3BCB74; Thu, 17 Jun
 2010 16:22:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1CFCD94A-7A4E-11DF-AF63-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149326>

Nazri Ramliy <ayiehere@gmail.com> writes:

> Use different color for each type of refs (local, remote, tags, HEAD,
> and stash). This makes the decorations and their type stand out more
> and easier to distinguish in 'git log --decorate'.
>
> Currently all the different types of decorations are shown in the same
> color as the commit id, which is not that easy to spot.
>
> The color applied for each type of refs are customizable via
> color.log.decorate.<slot> config entry, as documented in
> Documentation/config.txt.
> ---

Sign-off?

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 95cf73c..afa4f5a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -725,6 +725,11 @@ color.interactive.<slot>::
>  	commands.  The values of these variables may be specified as
>  	in color.branch.<slot>.
>  
> +color.log.decorate.<slot>::
> +	Use customized color for 'git log --decorate' output.
> +	`<slot>` is one of `local`, `remote`, `tag`, `stash` or `head`
> +	for local refs, remote refs, tags, stash and HEAD, respectively.

Configuration variable names are either 2-level or 3-level.  There are
existing examples for <slot> (e.g. color.branch.<slot>).

> diff --git a/decorate.c b/decorate.c
> index 2f8a63e..cbef2b4 100644
> --- a/decorate.c
> +++ b/decorate.c
> @@ -5,6 +5,48 @@
>  #include "cache.h"
>  #include "object.h"
>  #include "decorate.h"
> +#include "color.h"
> ...
> +int parse_decorate_color_config(const char *var, const int ofs, const char *value) {
> +	int slot = parse_decorate_color_slot(var + ofs);
> +	if (slot < 0)
> +		return 0;
> +	if (!value)
> +		return config_error_nonbool(var);
> +	color_parse(value, var, decoration_colors[slot]);
> +	return 0;
> +}

I don't think any of the above belongs to "decorate.c", which is the
generic mechanism to annotate commits with arbitrary data.  The Porcelain
feature "log --decorate" is just one user that happens to use refname as
that "arbitrary data", and that is what you are coloring.  The code for
that is in log-tree.c, I think.

> diff --git a/decorate.h b/decorate.h
> index e732804..d593d32 100644

So is any change to this file.

> diff --git a/log-tree.c b/log-tree.c
> index d3ae969..95ebf1a 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -10,29 +10,41 @@
>  
>  struct decoration name_decoration = { "object names" };
>  
> -static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
> +static void add_name_decoration(enum decoration_type type, const char *name, struct object *obj)
>  {
> -	int plen = strlen(prefix);
>  	int nlen = strlen(name);
> -	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
> -	memcpy(res->name, prefix, plen);
> -	memcpy(res->name + plen, name, nlen + 1);
> +	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + nlen);
> +	memcpy(res->name, name, nlen + 1);
> +	res->type = type;
>  	res->next = add_decoration(&name_decoration, obj, res);
>  }

When color is not in use (e.g. output is not going to the terminal), you
would lose "tag: " prefix, wouldn't you?

Even when color _is_ in use, people may want to see familiar "tag: "
prefix in the output---I personally do not think that is necessary,
though.

>  static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
>  {
>  	struct object *obj = parse_object(sha1);
> +	enum decoration_type type = DECORATION_NONE;
>  	if (!obj)
>  		return 0;
> +
> +	if (!prefixcmp(refname, "refs/heads"))
> +		type = DECORATION_REF_LOCAL;
> +	else if (!prefixcmp(refname, "refs/remotes"))
> +		type = DECORATION_REF_REMOTE;
> +	else if (!prefixcmp(refname, "refs/tags"))
> +		type = DECORATION_TAG;
> +	else if (!prefixcmp(refname, "refs/stash"))
> +		type = DECORATION_STASH;
> +	else if (!prefixcmp(refname, "HEAD"))
> +		type = DECORATION_HEAD;

I suspect that users would expect DECORATION_HEAD to be used to highlight
the object at the tip of the current branch, but I also suspect this code
would not do so.
