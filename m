From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Fri, 19 Feb 2016 15:08:53 -0800
Message-ID: <xmqq37sob8my.fsf@gitster.mtv.corp.google.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	<1455772670-21142-26-git-send-email-dturner@twopensource.com>
	<20160218085023.GA30049@lanh>
	<1455922186.7528.97.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	git mailing list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 00:09:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWuAb-0006VG-96
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 00:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1428816AbcBSXI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 18:08:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1428813AbcBSXI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 18:08:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 283A1449FC;
	Fri, 19 Feb 2016 18:08:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k2CW3fO7L8tYbf6cDpEqBnuWv0o=; b=KHDz+z
	lM2xDhcaTerlXdEaK75rFM7k2U0420oE3WXi6LmbyxbChkqj4E3aqkNr1lO4mpYc
	vsU9l1H01phOF9OZzqpUfOk3DlAwUyMdLSIBYXRtJaqTlaDgKa9tbGbbskwn1LCt
	mUJ9ZZ8lOE538ONOaf/Ng+WyeovxS+/khBm2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TFMEd9jXck/MwjJaLkmtL9JD94XLv6o8
	RbSHESsfhn9UazvXX1rTiOmhsuR0GYyp0vvYvO7HfjzZ0uMzwXWA2653xc7OO/8U
	NjnDJkcFn13TE0HvmUn9uRVwqBh6lNuC+34P515ZjBFk3CXPEBDQsvXO/GoQqYhr
	nnDwCeimsoY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 201A1449FA;
	Fri, 19 Feb 2016 18:08:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 91DC6449F9;
	Fri, 19 Feb 2016 18:08:54 -0500 (EST)
In-Reply-To: <1455922186.7528.97.camel@twopensource.com> (David Turner's
	message of "Fri, 19 Feb 2016 17:49:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BF4D71C4-D75D-11E5-851A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286759>

David Turner <dturner@twopensource.com> writes:

> Something like the following?
>
> commit aad6b84fd1869f6e1cf6ed15bcece0c2f6429e9d
> Author: David Turner <dturner@twopensource.com>
> Date:   Thu Feb 18 17:09:29 2016 -0500
>
>     refs: break out some functions from resolve_ref_1
>     
>     A bunch of resolve_ref_1 is not backend-specific, so we can
>     break it out into separate internal functions that other
>     backends can use.
>     
>     Signed-off-by: David Turner <dturner@twopensource.com>
> 
> diff --git a/refs.c b/refs.c
> index c9fa34d..680c2a5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1221,6 +1221,66 @@ int for_each_rawref(each_ref_fn fn, void
> *cb_data)
>  			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
>  }
>  
> +int parse_simple_ref(const char *buf, unsigned char *sha1, unsigned
> int *flags, int bad_name)
> +{
> +	/*
> +	 * Please note that FETCH_HEAD has a second
> +	 * line containing other data.
> +	 */

This comment is not quite correct; the reason why the latter half of
this condition is more convoluted than just !buf[40] is not because
FETCH_HEAD has a second line, but it has an additional info at the
tail on the first line.

Also the caller is expected to have already checked for "ref:"
prefix to decide not to call this.

> +	if (get_sha1_hex(buf, sha1) ||
> +	    (buf[40] != '\0' && !isspace(buf[40]))) {

> +/*
> + * Parse a refname out of the contents of a symref into a provided
> + * strbuf.  Return a pointer to the strbuf's contents.
> + */
> +char *parse_symref_data(const char *buf, struct strbuf *sb_refname)
> +{
> +	buf += 4;
> +	while (isspace(*buf))
> +		buf++;

This is expecting to be called by somebody who read "ref:..."  into
buf and the caller must decide by checking the "ref:" prefix before
calling into this function.

> ...  I'm not sure I like it, because it breaks out these weird
> tiny functions that take a lot of arguments.  But maybe it's worth
> it?  What do you think?

I wasn't Cc'ed but if you ask me, I do not think I can say I like
it, either.  Somehow it smells that the responsibility of inspecting
data and doing different things based on normal vs symbolic ref is
split between the caller and the callees at a wrong level.  The
caller also is responsible to rtrim the line before calling the
latter function if I am reading the code correctly, which smells
inconsistent given that an equivalent ltrim() is done by the "skip
the leading spaces" loop inside.
