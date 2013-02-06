From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Wed, 06 Feb 2013 08:53:52 -0800
Message-ID: <7vmwvhmli7.fsf@alter.siamese.dyndns.org>
References: <20130205201106.GA29248@sigill.intra.peff.net>
 <cover.1360162813.git.git@drmicha.warpmail.net>
 <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:54:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U38GI-0001K5-Ai
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 17:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab3BFQxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 11:53:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929Ab3BFQxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 11:53:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21445C00E;
	Wed,  6 Feb 2013 11:53:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kDgRCxeWznW/Et1UCwY3xi8hnWg=; b=ljKlR5
	Qbk1fLfyyvPFV59F3413CaZtlMjFWx7+9aBe3/wowHgl3jdxp06U+5bnlK2409nH
	gJcPkgoO3zeVuLeKDF14kz6BkRk4vlwwD+BekwxSrQDZyIS/DBzug3JK0v+cz0vj
	j30NmHQW9NeqHU2YuuJRZBwHoY+e0V1bTkYW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BaA/WkvtVOSDie0AOIxlL0fH52/wyiIY
	433mTXFIeLk+fiTpUvaLwYfnS2LkGxNU+HcZE34TDKnoeNmIhiM0pAd/HncMHdzu
	fS+zOGppFGHeGm2L9SY/Tp040jTbJMbJGkRyYZLKPd/plFxhy84tts7El9lwrAZK
	+ivSePwfk4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14F23C00B;
	Wed,  6 Feb 2013 11:53:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71406C004; Wed,  6 Feb 2013
 11:53:53 -0500 (EST)
In-Reply-To: <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed, 6 Feb 2013 16:08:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9E10DA2-707D-11E2-AB48-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215599>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, "diff" and "cat-file" for blobs obey "--textconv" options
> (with the former defaulting to "--textconv" and the latter to
> "--no-textconv") whereas "show" does not obey this option, even though
> it takes diff options.
>
> Make "show" on blobs behave like "diff", i.e. obey "--textconv" by
> default and "--no-textconv" when given.

What does "log -p" do currently, and what should it do?  Does/should
it also use --textconv?

The --textconv is a natural extension of what --ext-diff provides us,
so I think it should trigger the same way as how --ext-diff triggers.

We apply "--ext-diff" for "diff" by default but not for "log -p" and
"show"; I suspect this may have been for a good reason but I do not
recall the discussion that led to the current behaviour offhand.

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/log.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 8f0b2e8..f83870d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -402,10 +402,28 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
>  	strbuf_release(&out);
>  }
>  
> -static int show_blob_object(const unsigned char *sha1, struct rev_info *rev)
> +static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, const char *obj_name)
>  {
> +	unsigned char sha1c[20];
> +	struct object_context obj_context;
> +	char *buf;
> +	unsigned long size;
> +
>  	fflush(stdout);
> -	return stream_blob_to_fd(1, sha1, NULL, 0);
> +	if (!DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
> +		return stream_blob_to_fd(1, sha1, NULL, 0);
> +
> +	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
> +		die("Not a valid object name %s", obj_name);
> +	if (!obj_context.path[0] ||
> +	    !textconv_object(obj_context.path, obj_context.mode, sha1c, 1, &buf, &size))
> +		return stream_blob_to_fd(1, sha1, NULL, 0);
> +
> +	if (!buf)
> +		die("git show %s: bad file", obj_name);
> +
> +	write_or_die(1, buf, size);
> +	return 0;
>  }
>  
>  static int show_tag_object(const unsigned char *sha1, struct rev_info *rev)
> @@ -491,7 +509,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  		const char *name = objects[i].name;
>  		switch (o->type) {
>  		case OBJ_BLOB:
> -			ret = show_blob_object(o->sha1, NULL);
> +			ret = show_blob_object(o->sha1, &rev, name);
>  			break;
>  		case OBJ_TAG: {
>  			struct tag *t = (struct tag *)o;
