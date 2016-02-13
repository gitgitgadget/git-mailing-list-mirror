From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] config: add 'type' to config_source struct that
 identifies config type
Date: Sat, 13 Feb 2016 12:24:35 -0500
Message-ID: <20160213172435.GG30144@sigill.intra.peff.net>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
 <1455373456-64691-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 13 18:25:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUdwh-0008MO-B8
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 18:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbcBMRYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 12:24:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:41555 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750865AbcBMRYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 12:24:37 -0500
Received: (qmail 9262 invoked by uid 102); 13 Feb 2016 17:24:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 12:24:37 -0500
Received: (qmail 26991 invoked by uid 107); 13 Feb 2016 17:24:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 12:24:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2016 12:24:35 -0500
Content-Disposition: inline
In-Reply-To: <1455373456-64691-3-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286119>

On Sat, Feb 13, 2016 at 03:24:15PM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Use the config type to print more detailed error messages that inform
> the user about the origin of a config error (file, stdin, blob).

This looks OK overall. A few minor nits...

> @@ -1104,6 +1106,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
>  	top.u.buf.buf = buf;
>  	top.u.buf.len = len;
>  	top.u.buf.pos = 0;
> +	top.type = "blob";
>  	top.name = name;
>  	top.path = NULL;
>  	top.die_on_error = 0;

This function is about reading config from a memory buffer. The only reason
we do so _now_ is when reading from a blob, but I think it is laying a
trap for somebody who wants to reuse the function later.

Should git_config_from_buf() take a "type" parameter, and
git_config_from_blob_sha1() pass in "blob"?

> @@ -1066,7 +1067,8 @@ static int do_config_from_file(config_fn_t fn,
>  	struct config_source top;
>  
>  	top.u.file = f;
> -	top.name = name;
> +	top.type = path ? "file" : "stdin";
> +	top.name = name ? name : "";
>  	top.path = path;
>  	top.die_on_error = 1;
>  	top.do_fgetc = config_file_fgetc;
> @@ -1078,7 +1080,7 @@ static int do_config_from_file(config_fn_t fn,
>  
>  static int git_config_from_stdin(config_fn_t fn, void *data)
>  {
> -	return do_config_from_file(fn, "<stdin>", NULL, stdin, data);
> +	return do_config_from_file(fn, NULL, NULL, stdin, data);
>  }

Likewise here, we make assumptions in do_config_from_file() about what
the NULL path means. I think this is less likely to be a problem than
the other case, but it seems like it would be cleaner for "file" or
"stdin" to come from the caller, which knows for sure what we are doing.

Similarly, I think git_config_from_stdin() can simply pass in an empty
name rather than NULL to avoid do_config_from_file() having to fix it
up.

> +test_expect_success 'invalid stdin config' '
> +	echo "fatal: bad config line 1 in stdin " >expect &&
> +	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
> +	test_cmp expect output
> +'

The original would have been "bad config file line 1 in <stdin>"; I
think this is an improvement to drop the "file" here.

-Peff
