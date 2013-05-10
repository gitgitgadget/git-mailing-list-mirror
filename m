From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Fri, 10 May 2013 10:02:51 -0700
Message-ID: <7vy5bm22f8.fsf@alter.siamese.dyndns.org>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
	<c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 10 19:03:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaqii-0006YQ-QM
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 19:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab3EJRC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 13:02:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754603Ab3EJRC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 13:02:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71D651D304;
	Fri, 10 May 2013 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=SFwm9mYGU6rzJlpDUttX0MDoj5I=; b=GqtC68iu9sa8ONYAWFrf
	ZihfoHqjMTT2GLAA4CJyDErtCV/EmSdtoO4Ft72oe3B3C9WeqKM1F5S8NnC45e91
	8tXj826u4qxoZ1OG0dQ01A8+27aUmY/p4auo4Jm+YPVaAZzJJuVPd/fycESo7E5Y
	DSdEgxZm1aWfPkgM+fRwa0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YehqP6bdnmgdnjKNkHy1pOvGKLpOjPcznGv4i+TGKB2n47
	H4+lJ7x03aZYEHT0616tRWYXM6/purYJtftYzFwkdrmnYFBQ9YgqZWT3syMq120M
	YGrUajXtV7+r2gPo3Gv2TJ25b8qEmv8PlbNwHykjN7Zi9cZdZ37IAri0e1gJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6815B1D302;
	Fri, 10 May 2013 17:02:53 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F5E71D2FF;
	Fri, 10 May 2013 17:02:52 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73ADDBF4-B993-11E2-99CD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223882>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, "diff" and "cat-file" for blobs honor "--textconv" options
> (with the former defaulting to "--textconv" and the latter to
> "--no-textconv") whereas "show" does not honor this option, even though
> it takes diff options.
>
> Make "show" on blobs behave like "diff", i.e. honor "--textconv" by
> default and "--no-textconv" when given.

Hmm...

> +static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, const char *obj_name)
>  {
> +	unsigned char sha1c[20];
> +	struct object_context obj_context;
> +	char *buf;
> +	unsigned long size;
> +
>  	fflush(stdout);
> -	return stream_blob_to_fd(1, sha1, NULL, 0);
> +	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
> +	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
> +		return stream_blob_to_fd(1, sha1, NULL, 0);

It is surprising that the necessary change is only this, but I think
it is correct ;-).  We ignore textconv when the command line did not
mention --[no-]textconv, or the command line said --no-textconv
explicitly.

This (especially the first condition) may deserve an in-code comment
for anybody who wonders where this default behaviour is implemented.

So "show" on blobs does show the raw contents by default, but the
user can explicitly ask to enable textconv with --[no-]textconv.  Is
the second paragraph in the log message still valid?

> +	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
> +		die("Not a valid object name %s", obj_name);

This looks somewhat unfortunate.

We already have sha1[]; actually we not just know sha1[] but have
the struct object for it.  How did we obtain it before we got here?

Will we always have a valid name in rev.pending.objects->name?  Will
that name convert back to the same sha1 we got in sha1[]?

I think the answers are "Yes (it is a command line argument), Yes
(that is what setup_revisions() got by feeding the name to give us
sha1[])".

I wonder if enriching rev_info->pending with the context information
might be a clean solution to avoid this redundant but unavoidable
conversion, but that is a separate and future topic, I think.

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
> @@ -526,7 +545,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  		const char *name = objects[i].name;
>  		switch (o->type) {
>  		case OBJ_BLOB:
> -			ret = show_blob_object(o->sha1, NULL);
> +			ret = show_blob_object(o->sha1, &rev, name);
>  			break;
>  		case OBJ_TAG: {
>  			struct tag *t = (struct tag *)o;
> diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
> index 3950fc9..0ebb028 100755
> --- a/t/t4030-diff-textconv.sh
> +++ b/t/t4030-diff-textconv.sh
> @@ -96,14 +96,14 @@ test_expect_success 'show blob produces binary' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'show --textconv blob produces text' '
> +test_expect_success 'show --textconv blob produces text' '
>  	git show --textconv HEAD:file >actual &&
>  	printf "0\\n1\\n" >expect &&
>  	test_cmp expect actual
>  '
>  
> -test_success 'show --no-textconv blob produces binary' '
> -	git show --textconv HEAD:file >actual &&
> +test_expect_success 'show --no-textconv blob produces binary' '
> +	git show --no-textconv HEAD:file >actual &&
>  	printf "\\0\\n\\01\\n" >expect &&
>  	test_cmp expect actual
>  '
