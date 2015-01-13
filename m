From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame.c: fix garbled error message
Date: Mon, 12 Jan 2015 20:54:27 -0500
Message-ID: <20150113015427.GA5497@peff.net>
References: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
 <xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
 <xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
 <20150112231231.GA4023@peff.net>
 <xmqqzj9n4k11.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:55:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAqhX-00047z-U3
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 02:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbbAMBy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 20:54:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:33588 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751650AbbAMBy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 20:54:28 -0500
Received: (qmail 19006 invoked by uid 102); 13 Jan 2015 01:54:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 19:54:28 -0600
Received: (qmail 22638 invoked by uid 107); 13 Jan 2015 01:54:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 20:54:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 20:54:27 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzj9n4k11.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262315>

On Mon, Jan 12, 2015 at 04:11:06PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As an aside, I have often been tempted to have xstrdup silently
> > propagate a NULL. It would have been the right thing to do here, but
> > maybe there are cases where the segfault is preferable for catching a
> > mistake early (otherwise you might store the NULL and then segfault much
> > later).
> 
> Great minds think alike.  The sentence after "but maybe ..." was
> what I had in mind as a response in anticipation that somebody might
> suggest that; a separate xstrdup_or_null() might be fine, but I'd
> rather not to have xstrdup() that is _too_ magical.

Yeah. Of course, it is not _that_ many more characters to do a ternary
conditional. I guess the main benefit is that you do not have to repeat
the name of the variable (which lets you reuse a function result
directly, avoiding an explicit temporary).

Here's my attempt. Some cases are a little nicer, but overall, it does
not feel significantly more readable to me. I dunno. I could go either
way. I stuck Lukas's patch on top (modified to use xstrdup_or_null), if
we do want to go that route. Otherwise it needs the ?: treatment.

  [1/5]: git-compat-util: add xstrdup_or_null helper
  [2/5]: builtin/apply.c: use xstrdup_or_null instead of null_strdup
  [3/5]: builtin/commit.c: use xstrdup_or_null instead of envdup
  [4/5]: use xstrdup_or_null to replace ternary conditionals
  [5/5]: blame.c: fix garbled error message
