From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] tag: use pgp_verify_function in tag -v call
Date: Sun, 3 Apr 2016 00:56:00 -0400
Message-ID: <20160403045600.GD1519@sigill.intra.peff.net>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-5-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Sun Apr 03 06:56:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ama5Q-0005O2-FX
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 06:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbcDCE4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 00:56:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:43250 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751186AbcDCE4D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 00:56:03 -0400
Received: (qmail 31058 invoked by uid 102); 3 Apr 2016 04:56:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 00:56:02 -0400
Received: (qmail 9202 invoked by uid 107); 3 Apr 2016 04:56:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 00:56:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Apr 2016 00:56:00 -0400
Content-Disposition: inline
In-Reply-To: <1459638975-17705-5-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290628>

On Sat, Apr 02, 2016 at 07:16:15PM -0400, santiago@nyu.edu wrote:

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 1705c94..3dffdff 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -65,9 +65,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
>  }
>  
>  typedef int (*each_tag_name_fn)(const char *name, const char *ref,
> -				const unsigned char *sha1);
> +				const unsigned char *sha1, unsigned flags);

I'm not sure it's a good idea to add a flags field here; most of the
callbacks don't use it, and as you probably noticed, it makes the patch
a lot noisier. It does let you directly use pgp_verify_tag like this:

>  	if (cmdmode == 'v')
> -		return for_each_tag_name(argv, verify_tag);
> +		return for_each_tag_name(argv, pgp_verify_tag,
> +				GPG_VERIFY_VERBOSE);

but I think that is coupling too closely. What happens later when the
public, multi-file pgp_verify_tag function changes its interface? Or we
want to change our interface here, and it no longer matches
pgp_verify_tag? The results ripple a lot further than they should.

I think you probably want to keep a simple adapter callback in this
file, like:

  int verify_tag(const char *name, const char *ref, const unsigned char *sha1)
  {
	return pgp_verify_tag(name, GPG_VERIFY_VERBOSE));
  }

> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index f776778..8abc357 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -30,6 +30,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  {
>  	int i = 1, verbose = 0, had_error = 0;
>  	unsigned flags = 0;
> +	unsigned char sha1[20];
> +	const char *name;
>  	const struct option verify_tag_options[] = {
>  		OPT__VERBOSE(&verbose, N_("print tag contents")),
>  		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
> @@ -46,8 +48,16 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  	if (verbose)
>  		flags |= GPG_VERIFY_VERBOSE;
>  
> -	while (i < argc)
> -		if (pgp_verify_tag(argv[i++], flags))
> +	while (i < argc) {
> +		name = argv[i++];
> +		if (get_sha1(name, sha1)) {
> +			error("tag '%s' not found.", name);
>  			had_error = 1;
> +		}
> +
> +		if (pgp_verify_tag(name, NULL, sha1, flags))
> +			had_error = 1;
> +
> +	}

So this is a good example of the rippling I mentioned earlier.

As a side note, it might actually be an improvement for pgp_verify_tag
to take a sha1 (so that git-tag is sure that it is verifying the same
object that it is printing), but that refactoring should probably come
separately, I think.

-Peff
