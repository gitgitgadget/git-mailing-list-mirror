From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] fsck: check tag objects' headers
Date: Thu, 28 Aug 2014 14:25:16 -0700
Message-ID: <xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:25:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN7CH-00024u-Eq
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 23:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbaH1VZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 17:25:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62547 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbaH1VZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 17:25:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9163B352EE;
	Thu, 28 Aug 2014 17:25:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EWycJudc96ZBPAVh8tYfd1nArv0=; b=rTvy4U
	308rLHiHTSJqvDC1GK+ph+BMA3x1Zuc6m7qCPjXqd/9FUlEE9OjCR/o6Hlljntzy
	dyNTUki9/u/m/va1cl2noIHHu/4gudawMfsOTcoUvqNdv4C6XQZhc4BzFXSi4YyF
	2l0Rc6flXoXw+Mg9OyD8WzVUDkzSD5nkOTxc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lkRzYw0FzWN6e75uAiPG4gpWk/YO/j/8
	J2EPzugt27og+1zX5jWpbclsXtsDB/Ij77qpvjY75NfmxDG7dAWJfRiPwtGpHD8v
	Ysnk0u/ygM2RpM/CpUan4EJJoH22pGxuvmlH3fhW31yJr6ozRRAKmEg+SlfVyrh9
	5ojK/B5glcs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 07237352EC;
	Thu, 28 Aug 2014 17:25:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7AD48352E2;
	Thu, 28 Aug 2014 17:25:18 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 28 Aug 2014 16:46:55 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF26E476-2EF9-11E4-B2C4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256125>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We inspect commit objects pretty much in detail in git-fsck, but we just
> glanced over the tag objects. Let's be stricter.
>
> This work was sponsored by GitHub Inc.

Is it only this commit, or all of these patches in the series?
Does GitHub want their name sprinkled over all changes they sponsor?

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/fsck.c b/fsck.c
> index db6aaa4..d30946b 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -6,6 +6,7 @@
>  #include "commit.h"
>  #include "tag.h"
>  #include "fsck.h"
> +#include "refs.h"
>  
>  static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
>  {
> @@ -355,6 +356,90 @@ static int fsck_commit(struct commit *commit, const char *data,
>  	return ret;
>  }
>  
> +static int fsck_tag_buffer(struct tag *tag, const char *data,
> +	unsigned long size, fsck_error error_func)
> +{
> +	unsigned char commit_sha1[20];
> +	int ret = 0;
> +	const char *buffer;
> +	char *tmp = NULL, *eol;

Call it "to_free" or something; naming it 'tmp' would tempt people
who later touch this code to reuse it temporarily to hold something
unrelated (I know they will notice that mistake later, but noticing
mistake after wasting time is too late).

> +	if (data)
> +		buffer = data;
> +	else {
> +		enum object_type type;
> +
> +		buffer = tmp = read_sha1_file(tag->object.sha1, &type, &size);
> +		if (!buffer)
> +			return error_func(&tag->object, FSCK_ERROR,
> +				"cannot read tag object");
> +
> +		if (type != OBJ_TAG) {
> +			ret = error_func(&tag->object, FSCK_ERROR,
> +				"expected tag got %s",
> +			    typename(type));
> +			goto done;
> +		}
> +	}
> +
> +	if (must_have_empty_line(buffer, size, &tag->object, error_func))
> +		goto done;
> +
> +	if (!skip_prefix(buffer, "object ", &buffer)) {
> +		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'object' line");
> +		goto done;
> +	}
> +	if (get_sha1_hex(buffer, commit_sha1) || buffer[40] != '\n') {

This code is not making the mistake to assume that tagged objects
are always commits, so let's not call it commit_sha1; I'd suggest 
just calling it sha1[] (or even "tmp" or "junk", as the parsed value
is not used).

> +	*eol = '\0';
> +	if (type_from_string_gently(buffer) < 0)
> +		ret = error_func(&tag->object, FSCK_ERROR, "invalid 'type' value");
> +	*eol = '\n';
> +	if (ret)
> +		goto done;

I can see that it is reverted back to '\n' immediately after calling
type_from_string_gently(), but it is a bit unfortunate that "const
char *data" needs to be touched this way.

Since the callee is introduced in this series, perhaps it can be
made to take a counted string?

> +	if (!skip_prefix(buffer, "tag ", &buffer)) {
> +		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'tag' line");
> +		goto done;
> +	}
> +	eol = strchr(buffer, '\n');
> +	if (!eol) {
> +		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - unexpected end after 'type' line");
> +		goto done;
> +	}
> +	*eol = '\0';
> +	if (check_refname_format(buffer, REFNAME_ALLOW_ONELEVEL))
> +		ret = error_func(&tag->object, FSCK_ERROR, "invalid 'tag' name: %s", buffer);
> +	*eol = '\n';

I actually think this check is harmful.  It often matches the name
of the ref, but there is nothing inherently "refname like" in the
tag name proper.

And I think it is unnecessary.  Don't we already warn if it does not
match the name of the ref we use to point at it?  It would mean that
anything that does not conform to the check-refname-format will get
a warning one way or the other, either it is pointed at by a ref
whose name is kosher and does not match, or a ref itself has a name
that does not pass check-refname-format.

(goes and looks)

Yikes.  I assumed too much.  We do not seem to do much checking on
refs in that

    (1) After "git rev-parse HEAD >.git/refs/heads/ee..oo"
        "fsck" does not complain about the malformed ee..oo branch;

    (2) After "git tag -a foo -m foo && cp .git/refs/tags/foo .git/refs/tags/bar"
        "fsck" does not complain that refs/tags/bar talks about "foo"

But these two are something we would want to fix in a larger context
within "git fack" anyway, so my comments above still stand.

> +	if (!skip_prefix(buffer, "tagger ", &buffer)) {
> +		/* early tags do not contain 'tagger' lines; warn only */
> +		error_func(&tag->object, FSCK_WARN, "invalid format - expected 'tagger' line");

Nice.  Even nicer that this explains why people should not touch
'ret' here.

> +	}
> +	ret = fsck_ident(&buffer, &tag->object, error_func);
> +
> +done:
> +	free(tmp);
> +	return ret;
> +}
> +
>  static int fsck_tag(struct tag *tag, const char *data,
>  	unsigned long size, fsck_error error_func)
>  {
> @@ -362,7 +447,8 @@ static int fsck_tag(struct tag *tag, const char *data,
>  
>  	if (!tagged)
>  		return error_func(&tag->object, FSCK_ERROR, "could not load tagged object");
> -	return 0;
> +
> +	return fsck_tag_buffer(tag, data, size, error_func);
>  }
>  
>  int fsck_object(struct object *obj, void *data, unsigned long size,
