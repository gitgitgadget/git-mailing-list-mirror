From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 5/5] do not die when error in config parsing of buf
 occurs
Date: Fri, 10 May 2013 00:39:37 +0200
Message-ID: <20130509223936.GC30774@sigill.intra.peff.net>
References: <20130509154020.GA26423@book-mint>
 <20130509162102.GG3526@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 10 00:39:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZV4-0007mZ-TQ
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 00:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025Ab3EIWjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 18:39:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:42287 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170Ab3EIWjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 18:39:40 -0400
Received: (qmail 16394 invoked by uid 102); 9 May 2013 22:40:03 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 May 2013 17:40:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 May 2013 00:39:37 +0200
Content-Disposition: inline
In-Reply-To: <20130509162102.GG3526@book-mint>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223791>

On Thu, May 09, 2013 at 06:21:02PM +0200, Heiko Voigt wrote:

> diff --git a/builtin/config.c b/builtin/config.c
> index 8d01b7a..de32977 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -219,9 +219,11 @@ static int get_value(const char *key_, const char *regex_)
>  		}
>  	}
>  
> -	git_config_with_options(collect_config, &values,
> +	ret = git_config_with_options(collect_config, &values,
>  				given_config_file, given_config_blob,
>  				respect_includes);
> +	if (ret < 0)
> +		goto free_values;
>  
>  	ret = !values.nr;
>  
> @@ -231,6 +233,7 @@ static int get_value(const char *key_, const char *regex_)
>  			fwrite(buf->buf, 1, buf->len, stdout);
>  		strbuf_release(buf);
>  	}
> +free_values:
>  	free(values.items);
>  
>  free_strings:

Hmm. "values" is a strbuf_list. Don't we need to strbuf_release() its
individual members before freeing it? The writing loop directly above
your label frees each one after writing. It would probably make sense to
just split it into two loops, one for writing, and then one for
free-ing. This is not a critical performance path that we can't iterate
over the (probably handful of) entries twice.

> diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
> index fdc257e..a4929eb 100755
> --- a/t/t1307-config-blob.sh
> +++ b/t/t1307-config-blob.sh
> @@ -55,12 +55,17 @@ test_expect_success 'editing a blob is an error' '
>  test_expect_success 'parse errors in blobs are properly attributed' '
>  	cat >config <<-\EOF &&
>  	[some]
> -		value = "
> +		value = 1
> +		error = "
>  	EOF
>  	git add config &&
>  	git commit -m broken &&
>  
> -	test_must_fail git config --blob=HEAD:config some.value 2>err &&
> +	test_must_fail git config --blob=HEAD:config some.value 1>out 2>err &&
> +
> +	# Make sure there is no output of values on stdout
> +	touch out.expect &&
> +	test_cmp out.expect out &&

I'm not clear on what is being tested here. Were we outputting to stdout
before this patch (I would have thought our die() meant we did not.

-Peff
