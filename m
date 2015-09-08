From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] am: match --signoff to the original scripted version
Date: Tue, 8 Sep 2015 02:25:23 -0400
Message-ID: <20150908062523.GE26331@sigill.intra.peff.net>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
 <xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:25:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZCLS-0002Nq-LZ
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 08:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbbIHGZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 02:25:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:56126 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751607AbbIHGZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 02:25:26 -0400
Received: (qmail 18533 invoked by uid 102); 8 Sep 2015 06:25:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 01:25:26 -0500
Received: (qmail 19400 invoked by uid 107); 8 Sep 2015 06:25:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 02:25:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 02:25:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277490>

On Sat, Sep 05, 2015 at 09:56:27PM -0700, Junio C Hamano wrote:

> +static void am_signoff(struct strbuf *sb)
> +{
> +	char *cp;
> +	struct strbuf mine = STRBUF_INIT;
> +
> +	/* Does it end with our own sign-off? */
> +	strbuf_addf(&mine, "\n%s%s\n",
> +		    sign_off_header,
> +		    fmt_name(getenv("GIT_COMMITTER_NAME"),
> +			     getenv("GIT_COMMITTER_EMAIL")));
> +	if (mine.len < sb->len &&
> +	    !strcmp(mine.buf, sb->buf + sb->len - mine.len))
> +		goto exit; /* no need to duplicate */

Here you insert the "\n" directly at the start of "mine", so the test
"does it contain S-o-b at the beginning of a line" does not count the
first line. Probably fine, as somebody putting a S-o-b in their subject
deserves whatever they get.

But...

> +	/* Does it have any Signed-off-by: in the text */
> +	for (cp = sb->buf;
> +	     cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
> +	     cp = strchr(cp, '\n')) {
> +		if (sb->buf == cp || cp[-1] == '\n')
> +			break;
> +	}

Here you are more careful about finding S-o-b at sb->buf.

I don't think it really matters in practice, but it's an interesting
inconsistency.

Other than that (and I do not think it is worth re-rolling for this;
just an interesting observation), the patch looks OK to me.

-Peff
