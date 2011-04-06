From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: support values longer than 1024 bytes
Date: Tue, 5 Apr 2011 20:52:23 -0400
Message-ID: <20110406005223.GA10374@sigill.intra.peff.net>
References: <1302046203-4408-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jwa@urbancode.com, drew.northup@maine.edu
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 02:52:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7GzJ-00089y-Hr
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 02:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159Ab1DFAwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 20:52:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43748
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102Ab1DFAwf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 20:52:35 -0400
Received: (qmail 31353 invoked by uid 107); 6 Apr 2011 00:53:18 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Apr 2011 20:53:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Apr 2011 20:52:23 -0400
Content-Disposition: inline
In-Reply-To: <1302046203-4408-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170946>

On Wed, Apr 06, 2011 at 01:30:03AM +0200, Erik Faye-Lund wrote:

> The rather awkward return statement with strdup("") is because
> strbuf_detach returns NULL when there's nothing allocated. Even
> worse, it returns an uninitialized string if the string has been
> initialized with a non-zero 'hint'.

That seems like two bugs in the strbuf code.

I would expect strbuf_detach to _always_ return an allocated buffer,
even if it is xstrdup(""). Though the code in strbuf_detach is explicit
about returning NULL rather than slopbuf, so perhaps there is a case
where it is useful.

But for the other, one of the invariants of strbuf is that the string is
always NUL-terminated. So I would expect strbuf_init to properly
NUL-terminate after growing based on the hint.

>  static char *parse_value(void)
>  {
> -	static char value[1024];
> -	int quote = 0, comment = 0, len = 0, space = 0;
> +	struct strbuf value = STRBUF_INIT;
> +	int quote = 0, comment = 0, space = 0;

One thing you could about the strbuf_detach thing is to just use a
single static strbuf instead of the static array, and just reset its
length back to zero on each call. So:

  static struct strbuf value = STRBUF_INIT;
  ...
  strbuf_reset(&value);

> -			value[len] = 0;
> -			return value;
> +			return value.len ?
> +			    strbuf_detach(&value, NULL) :
> +			    strdup("");

Then this just becomes:

  return value.buf;

>  			default:
> +				strbuf_release(&value);
>  				return NULL;

And you can drop the release.

> @@ -226,7 +226,9 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
>  		if (!value)
>  			return -1;
>  	}
> -	return fn(name, value, data);
> +	ret = fn(name, value, data);
> +	free(value);
> +	return ret;

And drop this hunk, since callers no longer need to free.

I do wonder, though, if we could be reusing the unquote_c_style()
function in quote.c. They are obviously similar, but I haven't checked
if there is more going on in the config code.

-Peff
