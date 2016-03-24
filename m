From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH/RFC] builtin/tag.c: move PGP verification inside builtin.
Date: Thu, 24 Mar 2016 17:51:05 -0400
Message-ID: <20160324215104.GC8830@LykOS>
References: <1458855560-28519-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 22:51:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajD9u-0006AJ-SX
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbcCXVvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:51:10 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36565 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbcCXVvI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:51:08 -0400
Received: by mail-qg0-f50.google.com with SMTP id u110so49429798qge.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IImC0AE6i+DwRkvX5jdb+zHHLXZTIJOUmdhfjp10dbA=;
        b=VDiB3hc/umcOozvZCYOcCaiQ9/MZobFPSFIrr3ovZbOB/dKbCo/Bfs9Pih383txtrV
         gQ24713NCbkXnxnbxCk+McPfb0ayYw8p3mt5Zbk6O8amUPzzFOwChcHPJ2yuGyN4Ngta
         YzDSbpxWq6EkPlSjwjbSs+eZeeWh/bHkoKEfJ1N03m1oCUC6sCABl2DiTtJxjnQyE8zC
         zDQZ59KClbbHin0AkzKU9pbic2HEuXc7EZB2xG/vBqq1wWcoklH2Xi2TVlGNuQUENOaC
         NgVoLq9xDwChQ0rHB0S6b5p8pljU4pcnIBd6FJ3Dz2ah1ootQVJ8EX4HXOi+D1lomfIj
         3F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IImC0AE6i+DwRkvX5jdb+zHHLXZTIJOUmdhfjp10dbA=;
        b=a/PWtti1RdCiwdB5zxA/YT5ptYJBL1yzqWPTZRkD7kCAfZOlyPWeCqaGdAhx/Vxvo6
         XCOcIG00h+Iv0Fo2OOT6xXPgMA6xJy1j80aBNAFICLrdNZX1JcOhJc0+iZExZAX5yG8P
         MgkfLHK77NCyFT6s51CP8wLcDmfBQ+bXfTJAmDCyltDAzs5X812PX/0v8GnL41ZVghY9
         qI/TRWKpvv2Hr4AKalySch65IV49pcvYN9Idj+tSTD/m1c33WAqs6z294IcHKXwboceG
         zVvOxsPlChx9nwfLKRibYu94sUo4YFBNeMbuUa0FinQmEjtO57jUoBRmjPLwZBlPvk4O
         YJ1A==
X-Gm-Message-State: AD7BkJJHeJuk1fur5bV1HowOPAAgsxXXY0XRNZHYh+y6nbZqA2uR9nf/01F2Hmb9Ucqg8jDM
X-Received: by 10.140.18.163 with SMTP id 32mr13398960qgf.11.1458856267257;
        Thu, 24 Mar 2016 14:51:07 -0700 (PDT)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-11.NATPOOL.NYU.EDU. [216.165.95.0])
        by smtp.gmail.com with ESMTPSA id h64sm4063700qgh.39.2016.03.24.14.51.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 14:51:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1458855560-28519-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289807>

Hi Jeff.

Sorry for the delay with this, I got caught up with coursework.

This is my first stab at this, in the dumbest/simplest way imaginable. I
don't like that there is no code reuse (the run_gpg_verify function is
repeated here and in the plumbing command). I would appreciate pointers
on what would be the best way to avoid this.

I also spent quite some time figuring out what you meant with

> Do note the trickery with SIGPIPE in verify-tag, though. We probably
> need to do the same here (in fact, I wonder if that should be pushed
> down into the code that calls gpg).
I don't see any explicit SIGPIPE trickery here. Any pointers?

Thanks!
-Santiago.


On Thu, Mar 24, 2016 at 05:39:20PM -0400, santiago@nyu.edu wrote:
> From: Santiago Torres <torresariass@gmail.com>
> 
> The verify tag function is just a thin wrapper around the verify-tag
> command. We can avoid one fork call by doing the verification instide
> the tag builtin instead.
> 
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  builtin/tag.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 1705c94..be5d7c7 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -30,6 +30,27 @@ static const char * const git_tag_usage[] = {
>  
>  static unsigned int colopts;
>  
> +static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
> +{
> +	struct signature_check sigc;
> +	int len;
> +	int ret;
> +
> +	memset(&sigc, 0, sizeof(sigc));
> +
> +	len = parse_signature(buf, size);
> +
> +	if (size == len) {
> +		write_in_full(1, buf, len);
> +	}
> +
> +	ret = check_signature(buf, len, buf + len, size - len, &sigc);
> +	print_signature_buffer(&sigc, flags);
> +
> +	signature_check_clear(&sigc);
> +	return ret;
> +}
> +
>  static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
>  {
>  	struct ref_array array;
> @@ -104,13 +125,24 @@ static int delete_tag(const char *name, const char *ref,
>  static int verify_tag(const char *name, const char *ref,
>  				const unsigned char *sha1)
>  {
> -	const char *argv_verify_tag[] = {"verify-tag",
> -					"-v", "SHA1_HEX", NULL};
> -	argv_verify_tag[2] = sha1_to_hex(sha1);
>  
> -	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
> -		return error(_("could not verify the tag '%s'"), name);
> -	return 0;
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
>  }
>  
>  static int do_sign(struct strbuf *buffer)
> -- 
> 2.7.3
> 
