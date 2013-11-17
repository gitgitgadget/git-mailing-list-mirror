From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] commit -v: strip diffs and submodule shortlogs from
 the commit message
Date: Sun, 17 Nov 2013 04:09:36 -0500
Message-ID: <20131117090935.GC17016@sigill.intra.peff.net>
References: <loom.20131110T222043-57@post.gmane.org>
 <528140F5.6090700@web.de>
 <loom.20131111T214646-550@post.gmane.org>
 <52814C35.6040205@web.de>
 <5281DCC5.2000209@kdbg.org>
 <5282A90A.4030900@web.de>
 <xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
 <5283C701.8090400@web.de>
 <xmqq7gccdq67.fsf@gitster.dls.corp.google.com>
 <5287F735.3030306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ari Pollak <ari@debian.org>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 17 10:10:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhyMs-0001yE-3h
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 10:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab3KQJJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 04:09:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:40742 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751969Ab3KQJJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 04:09:37 -0500
Received: (qmail 13448 invoked by uid 102); 17 Nov 2013 09:09:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Nov 2013 03:09:38 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Nov 2013 04:09:36 -0500
Content-Disposition: inline
In-Reply-To: <5287F735.3030306@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237956>


> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6ab4605..091a6e7 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1602,9 +1602,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> 
>  	/* Truncate the message just before the diff, if any. */
>  	if (verbose) {
> -		p = strstr(sb.buf, "\ndiff --git ");
> -		if (p != NULL)
> -			strbuf_setlen(&sb, p - sb.buf + 1);
> +		p = strstr(sb.buf, wt_status_diff_divider);
> +		if ((p != NULL) && (p > sb.buf) && (p[-1] == '\n'))
> +			strbuf_setlen(&sb, p - sb.buf);

I think your check for a preceding newline is too strict. If I delete
everything before the scissor line (e.g., because I am trying to abort
the commit), we should still remove the diff. With your patch, we do
not, and a commit message consisting solely of the diff.

So I think you want:

  if (p && (p == sb.buf || p[-1] == '\n'))

> +	fprintf(s->fp, _("# The diff below will be removed when keeping the previous line.\n"));

I found this hard to parse, I think because of the "keeping" (why would
I not keep it?), and because you are talking about lines above and
below. It is not as accurate to say:

  # ------------------ >8 --------------------
  # Everything below this line will be removed.

because it is technically the line above that is the cutoff. But I think
the meaning is clear, and it is simpler to parse.

I do think it would be simpler with a single line. I know handling the
i18n was a question there, but I think we should be fine as long as we
check for the exact bytes we wrote. Surely gettext can do something
like:

  magic = _("# Everything below this line will be removed");
  fprintf(fh, "%s", magic);
  ...
  p = strstr(magic);

I don't know what guarantees on string lifetime gettext gives us, but
the worst case is that we simply strdup the result.

I suppose it's possible that the translated string could have utf8 with
multiple representations, and the user's editor normalizes the text in a
different way than we wrote it when it saves the result. I don't know if
that is worth caring about or not; it seems kind of insane.

-Peff
