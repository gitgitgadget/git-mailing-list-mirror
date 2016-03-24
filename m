From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin/tag.c: move PGP verification inside builtin.
Date: Thu, 24 Mar 2016 18:10:20 -0400
Message-ID: <20160324221020.GA17805@sigill.intra.peff.net>
References: <1458855560-28519-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Santiago Torres <torresariass@gmail.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Thu Mar 24 23:10:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajDSX-0000Ot-4H
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 23:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbcCXWKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 18:10:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:37818 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750896AbcCXWKX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 18:10:23 -0400
Received: (qmail 29098 invoked by uid 102); 24 Mar 2016 22:10:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 18:10:23 -0400
Received: (qmail 18061 invoked by uid 107); 24 Mar 2016 22:10:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 18:10:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2016 18:10:20 -0400
Content-Disposition: inline
In-Reply-To: <1458855560-28519-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289811>

On Thu, Mar 24, 2016 at 05:39:20PM -0400, santiago@nyu.edu wrote:

> +static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
> +{
> +	struct signature_check sigc;
> +	int len;
> +	int ret;
> +
> +	memset(&sigc, 0, sizeof(sigc));
> +
> +	len = parse_signature(buf, size);

I know you are just copying this from the one in builtin/verify-tag.c,
but I find the use of "size" and "len" for two different purposes
confusing. Those words are synonyms, so how do the variables differ?

Perhaps "payload_size", or "signature_offset" would be a better term for
"len".

> +	if (size == len) {
> +		write_in_full(1, buf, len);
> +	}

If the two are the same, we have no signature. Should we be returning
early, and skipping check_signature() in that case?

> +	ret = check_signature(buf, len, buf + len, size - len, &sigc);
> +	print_signature_buffer(&sigc, flags);
> +
> +	signature_check_clear(&sigc);
> +	return ret;
> +}

This part looks OK.

> @@ -104,13 +125,24 @@ static int delete_tag(const char *name, const char *ref,
>  static int verify_tag(const char *name, const char *ref,
>  				const unsigned char *sha1)
>  {
> -	const char *argv_verify_tag[] = {"verify-tag",
> -					"-v", "SHA1_HEX", NULL};

So the original was passing "-v" to verify-tag. That should put
GPG_VERIFY_VERBOSE into the flags field. But later:

> +	ret = run_gpg_verify(buf, size, 0);

We don't pass any flags. Shouldn't this unconditionally pass
GPG_VERIFY_VERBOSE?

> +	enum object_type type;
> +	unsigned long size;
> +	const char* buf;
> +	int ret;
> +
> +	type = sha1_object_info(sha1, NULL);
> +	if (type != OBJ_TAG)
> +		return error("%s: cannot verify a non-tag object of type %s.",
> +				name, typename(type));
> +
> +	buf = read_sha1_file(sha1, &type, &size);
> +	if (!buf)
> +		return error("%s: unable to read file.", name);
> +
> +	ret = run_gpg_verify(buf, size, 0);
> +
> +	return ret;

All of this seems like a repetition of verify_tag() in
builtin/verify-tag.c (and ditto with run_gpg_verify()). Can we move
those functions into tag.c and just call them from both places, or is
there some difference that needs to be taken into account (and if the
latter, can we refactor them to account for the differences?).

-Peff
