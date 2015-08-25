From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/6] builtin/am: make sure state files are text
Date: Tue, 25 Aug 2015 12:47:01 -0400
Message-ID: <20150825164701.GA10060@sigill.intra.peff.net>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
 <1440449890-29490-1-git-send-email-gitster@pobox.com>
 <1440449890-29490-3-git-send-email-gitster@pobox.com>
 <20150824235547.GB13261@sigill.intra.peff.net>
 <xmqqtwrn1gu6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 18:47:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUHNO-0005DM-Ux
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 18:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbbHYQrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 12:47:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:49844 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751400AbbHYQrE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 12:47:04 -0400
Received: (qmail 8153 invoked by uid 102); 25 Aug 2015 16:47:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 11:47:03 -0500
Received: (qmail 5243 invoked by uid 107); 25 Aug 2015 16:47:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 12:47:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2015 12:47:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwrn1gu6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276537>

On Tue, Aug 25, 2015 at 09:19:13AM -0700, Junio C Hamano wrote:

> As to "flags exposed to callers" vs "with and without gently", when
> we change the system to allow new modes of operations (e.g. somebody
> wants to write a binary file, or allocate more flag bits for their
> special case), I'd expect that we'd add a more general and verbose
> "write_file_with_options(path, flags, fmt, ...)"), gain experience
> with that function, and then possibly introduce canned thin wrappers
> (e.g. write_binary_file() that is a synonym to passing BINARY but
> not GENTLY) if the new thing proves widely useful, just like I left
> write_file() and write_file_gently() in as fairly common things to
> do.

Yeah, that works. It is a bit of a gamble to me. If we never add a lot
more options, the end result is much nicer (callers do not deal with the
flag option at all). But if we do, we end up with the mess that
get_sha1_with_* and add_pending_object() got into.

One can always refactor later, too.  In that sense, the BINARY flag is
not useful (nobody uses it, and we do not plan to do so). We could just
make write_file_v unconditionally complete lines[1].

But I'm OK with what you posted, as well. I think this interface is not
worth spending a lot of time micro-nit-picking.

-Peff

[1] In fact, I'd be surprised if this function works well for non-text
    data anyway, as it relies on printf-style formatting. You cannot use
    it to write a string with embedded NULs, for example.

    If we wanted to support that case, we would probably break out:

        int write_buf_to_file(const char *filename,
	                      const char *buf, size_t len);

    as a thin wrapper for open/write_in_full/close. And then write_to_file()
    would format into a strbuf, complete a newline, and pass the result
    to it.
