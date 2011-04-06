From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: support values longer than 1024 bytes
Date: Wed, 6 Apr 2011 11:35:09 -0400
Message-ID: <20110406153509.GA1864@sigill.intra.peff.net>
References: <1302046203-4408-1-git-send-email-kusmabite@gmail.com>
 <20110406005223.GA10374@sigill.intra.peff.net>
 <BANLkTim0N0kM+OX5Tztz-Kh+eRRsNixX0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jwa@urbancode.com, drew.northup@maine.edu
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:35:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7UlN-0001fc-5o
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 17:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125Ab1DFPfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 11:35:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55437
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117Ab1DFPfN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 11:35:13 -0400
Received: (qmail 5647 invoked by uid 107); 6 Apr 2011 15:35:59 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 11:35:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 11:35:09 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTim0N0kM+OX5Tztz-Kh+eRRsNixX0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170982>

On Wed, Apr 06, 2011 at 11:10:42AM +0200, Erik Faye-Lund wrote:

> > But for the other, one of the invariants of strbuf is that the string is
> > always NUL-terminated. So I would expect strbuf_init to properly
> > NUL-terminate after growing based on the hint.
> 
> I agree. An unterminated yet non-NULL return from strbuf_detach is
> just dangerous behavior. Something like this should probably be
> applied:
> 
> ---8<---
> diff --git a/strbuf.c b/strbuf.c
> index 77444a9..538035a 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -24,14 +24,16 @@ int suffixcmp(const char *str, const char *suffix)
>   * buf is non NULL and ->buf is NUL terminated even for a freshly
>   * initialized strbuf.
>   */
> -char strbuf_slopbuf[1];
> +char strbuf_slopbuf[1] = { '\0' };

This hunk is redundant. slopbuf will already be initialized to 0.

>  void strbuf_init(struct strbuf *sb, size_t hint)
>  {
>  	sb->alloc = sb->len = 0;
>  	sb->buf = strbuf_slopbuf;
> -	if (hint)
> +	if (hint) {
>  		strbuf_grow(sb, hint);
> +		sb->buf[0] = '\0';
> +	}
>  }

But this one is the right fix.

> that. But this brings a new issue: leaving potentially huge blocks of
> memory (especially since this patch is about long lines) allocated
> inside a function can be a bit nasty. But it's probably not a big deal

Yeah. It's just one block, though, and in the normal case it is probably
only about 80 characters. So it is more efficient than what's there now. :)

Somebody could have some gigantic value, though, and yes, we'll grow to
the biggest one and never free that memory. You could also have
parse_value take a strbuf parameter to output into, and then free it
after config reading is done.

> In other words: I think you're right, it's a much better approach.
> Less allocations, less penalty on the start-up time for every little
> git-command.

I doubt the efficiency increase is measurable. We end up xstrdup'ing
quite a few of the values in the config callbacks anyway. I would do
whatever seems most natural for reading/writing the code.

> > I do wonder, though, if we could be reusing the unquote_c_style()
> > function in quote.c. They are obviously similar, but I haven't checked
> > if there is more going on in the config code.
> 
> Hmm, this is an interesting suggestion. It would be a part of a bigger
> change though: unquote_c_style requires it's input to be in memory,
> while parse_value uses a function called get_next_char to feed the
> parser. So we'd either have to read the entire file into memory, or
> find some way to read the file line-by-line while handling \n-escaping
> correctly.
> 
> It also seems like there's differences in what kind of escaping and
> normalization the two functions handle; unquote_c_style handles more
> escaped character sequences, while parse_value normalize all
> non-escaped space-characters ('\t' et. al) into SP. This might not be
> such a big problem in reality.

This was just a random thought that I had, and I didn't investigate it
how hard it would be.  If it turns out to be too much trouble, just
forget it.

-Peff
