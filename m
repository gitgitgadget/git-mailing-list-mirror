From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] pretty: prepare notes message at a centralized place
Date: Thu, 18 Oct 2012 03:49:21 -0400
Message-ID: <20121018074921.GC9999@sigill.intra.peff.net>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
 <1350539128-21577-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 09:49:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOkrH-0007id-Py
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 09:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102Ab2JRHtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 03:49:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37553 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980Ab2JRHtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 03:49:24 -0400
Received: (qmail 2742 invoked by uid 107); 18 Oct 2012 07:50:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 03:50:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 03:49:21 -0400
Content-Disposition: inline
In-Reply-To: <1350539128-21577-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207976>

On Wed, Oct 17, 2012 at 10:45:25PM -0700, Junio C Hamano wrote:

> +	if (opt->show_notes) {
> +		int raw;
> +		struct strbuf notebuf = STRBUF_INIT;
> +
> +		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
> +		format_display_notes(commit->object.sha1, &notebuf,
> +				     get_log_output_encoding(), raw);
> +		ctx.notes_message = notebuf.len
> +			? strbuf_detach(&notebuf, NULL)
> +			: xcalloc(1, 1);
> +	}

This last line seems like it is caused by a bug in the strbuf API.
Detaching an empty string will sometimes get you NULL and sometimes not.
For example, this:

  struct strbuf foo = STRBUF_INIT;
  strbuf_detach(&foo, NULL);

will return NULL. But this:

  struct strbuf foo = STRBUF_INIT;
  strbuf_addstr(&foo, "bar");
  strbuf_reset(&foo);
  strbuf_detach(&foo, NULL);

will get you a zero-length string. Which just seems insane to me. The
whole point of strbuf_detach is that you do not have to care about the
internal representation. It should probably always return a newly
allocated zero-length string.

Looking through a few uses of strbuf_detach, it looks like callers
assume they will always get a pointer from strbuf_detach, and we are
saved by implementation details. For example, sha1_file_to_archive might
have an empty file, but the fact that strbuf_attach always allocates a
byte means that the detach will never return NULL. Similarly,
argv_array_pushf would never want to turn an empty string into an
accidental NULL; it is saved by the fact that strbuf_vaddf will always
preemptively allocate 64 bytes.

It's possible that switching it would create bugs elsewhere (there are
over 100 uses of strbuf_detach, so maybe somebody really does want this
NULL behavior), but I tend to think it is just as likely to be fixing
undiscovered bugs.

-Peff
