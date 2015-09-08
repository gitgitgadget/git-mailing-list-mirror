From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] am: match --signoff to the original scripted version
Date: Tue, 8 Sep 2015 02:18:37 -0400
Message-ID: <20150908061836.GD26331@sigill.intra.peff.net>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
 <xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
 <CACRoPnTUzeF=RUVv_0+2Ej422Vh-NH+KpYaKH0VKNmGbuVQ_8g@mail.gmail.com>
 <xmqqd1xvbgw3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:18:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZCF4-00041X-DC
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 08:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbbIHGSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 02:18:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:56118 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751464AbbIHGSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 02:18:39 -0400
Received: (qmail 18082 invoked by uid 102); 8 Sep 2015 06:18:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 01:18:39 -0500
Received: (qmail 19348 invoked by uid 107); 8 Sep 2015 06:18:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 02:18:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 02:18:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd1xvbgw3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277489>

On Sun, Sep 06, 2015 at 10:24:12AM -0700, Junio C Hamano wrote:

> >> +       /* Does it end with our own sign-off? */
> >> +       strbuf_addf(&mine, "\n%s%s\n",
> >> +                   sign_off_header,
> >> +                   fmt_name(getenv("GIT_COMMITTER_NAME"),
> >> +                            getenv("GIT_COMMITTER_EMAIL")));
> >
> > Maybe use git_committer_info() here?
> 
> Perhaps, but I wanted to make sure I am doing the same thing as the
> codepath of sequencer.c::append_signoff(), which the original ended
> up calling.  git_committer_info() does way more than that, no?

Not really.  I think git_committer_info(IDENT_STRICT | IDENT_NO_DATE)
runs the exact same code, with one exception: we would also set the
ident_explicitly_given variables. But nobody in builtin/am.c calls
committer_ident_sufficiently_given(). And if they did, I think the
change would be an improvement.

> >> +       if (mine.len < sb->len &&
> >> +           !strcmp(mine.buf, sb->buf + sb->len - mine.len))
> >
> > Perhaps use ends_with()?
> 
> This caller already _knows_ how long the sb->buf string is; it is
> pointless to have ends_with() run strlen() on it.

That actually goes double. We know sb.len. The ends_with() function is
built around strip_suffix(), which both operate on strings.  But we do
not have ends_with_mem() built around strip_suffix_mem().

But we also know mine.len. Even strip_suffix_mem() assumes the suffix
itself is a string. So what you really want is:

  int strip_suffix_mem_mem(const char *buf, size_t *len,
                           const char *suffix, size_t suffix_len);

and then you can trivially build the existing strip_suffix_mem() around
it, build strip_suffix() around that, and then build ends_with(),
ends_with_mem() and ends_with_mem_mem() around those. And don't forget
strbuf_ends_with(), strbuf_ends_with_mem(), and strbuf_ends_with_strbuf()

:) I am only half tongue in cheek. The proliferation of names is tedious
(and not appropriate for an -rc regression fix), but I do think the
resulting code is a lot more obvious as:

  if (strbuf_ends_with_strbuf(&sb, &mine))
      ...

or even:

  if (ends_with_mem_mem(sb->buf, sb->len, mine.buf, mine.len))
      ...

Of course given that this is run only once per program, and that these
_are_ in fact strings, we can probably not bother to optimize it and
just accept:

  if (ends_with(sb->buf, mine.buf))
      ...

But if you want to go all-out on optimization, I think you can replace
your strcmp with memcmp:

  if (mine.len < sb->len &&
      !memcmp(mine.buf, sb->buf + sb->len - mine.len, mine.len))

(assuming that memcmp is in fact faster than strcmp).

-Peff
