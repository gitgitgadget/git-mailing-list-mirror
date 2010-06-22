From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Do not decode url protocol.
Date: Tue, 22 Jun 2010 18:46:04 -0400
Message-ID: <20100622224603.GA27423@coredump.intra.peff.net>
References: <4C211A39.2080207@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Jun 23 00:46:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORCET-0001oW-Dv
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 00:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790Ab0FVWqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 18:46:10 -0400
Received: from peff.net ([208.65.91.99]:53642 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab0FVWqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 18:46:08 -0400
Received: (qmail 9111 invoked by uid 107); 22 Jun 2010 22:46:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 22 Jun 2010 18:46:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jun 2010 18:46:04 -0400
Content-Disposition: inline
In-Reply-To: <4C211A39.2080207@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149496>

On Tue, Jun 22, 2010 at 10:16:57PM +0200, Pascal Obry wrote:

> When using the protocol git+ssh:// for example we do not want to
> decode the '+' as a space. The url decoding must take place only
> for the server name and parameters.
> 
> This fixes a regression introduced in 9d2e942.

Sorry, this is completely my fault. I obviously didn't test with
git+ssh. I looked at adding a new test case, but I don't think there's
an easy way. The only way to trigger it is by using "git+ssh" or
"ssh+git"; any other protocol (real or fake) will be handled by a custom
protocol handler and won't execute this broken code at all.

The patch looks reasonable (and I agree with all of Matthieu's comments
thus far). With respect to the "what if there is no slash" issue
discussed earlier, I prefer to be a bit defensive about possible inputs
in library-ish functions like this. But:

> +
> +       /* Skip protocol if present. */
> +       if (with_protocol) {
> +         first_slash = strchr(*query, '/');
> +
> +         while (q < first_slash)
> +               strbuf_addch(&out, *q++);
> +       }
> +

I think this actually works OK, given that "q < first_slash" will be
false if first_slash is NULL, assuming NULL is all-bytes-zero or some
low number (which is not guaranteed by the standard, but is a pretty
practical assumption these days).

However, you could make things a little more efficient by handing the
whole thing to strbuf at once:

  if (with_protocol) {
          const char *first_slash = strchr(q, '/');
          if (first_slash) {
                  strbuf_add(&out, q, first_slash - q);
                  q = first_slash;
          }
  }

which of course needs first_slash to be checked explicitly.  Not that
the efficiency probably matters in practice.

-Peff
