From: Jeff King <peff@peff.net>
Subject: Re: [BUG] redundant error message
Date: Fri, 6 Dec 2013 17:13:56 -0500
Message-ID: <20131206221356.GD25620@sigill.intra.peff.net>
References: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
 <20131205191518.GB19039@sigill.intra.peff.net>
 <xmqqsiu73w6n.fsf@gitster.dls.corp.google.com>
 <20131205200306.GA13443@sigill.intra.peff.net>
 <xmqqfvq73vhw.fsf@gitster.dls.corp.google.com>
 <20131205210000.GA19617@sigill.intra.peff.net>
 <20131205212851.GA21776@sigill.intra.peff.net>
 <CACsJy8CKDiCX0G3jD6KLZ=cyvp6zf4MT6DCY0XodfD8rkQF=wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 23:14:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp3ev-0000kR-BR
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 23:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161391Ab3LFWOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 17:14:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:51873 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161112Ab3LFWN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 17:13:58 -0500
Received: (qmail 11518 invoked by uid 102); 6 Dec 2013 22:13:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 16:13:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 17:13:56 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CKDiCX0G3jD6KLZ=cyvp6zf4MT6DCY0XodfD8rkQF=wA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238959>

On Fri, Dec 06, 2013 at 08:15:52AM +0700, Duy Nguyen wrote:

> On Fri, Dec 6, 2013 at 4:28 AM, Jeff King <peff@peff.net> wrote:
> > BTW, the raw looping to find "--" made me wonder how we handle:
> >
> >   git log --grep -- HEAD
> >
> > I'd expect it to be equivalent to:
> >
> >   git log --grep=-- HEAD
> >
> > but it's not; we truncate the arguments and complain that --grep is
> > missing its argument. Which is probably good enough, given that the
> > alternative is doing a pass that understands all of the options. But it
> > does mean that the "--long-opt=arg" form is safer than the split form if
> > you are passing along an arbitrary "arg".
> 
> Maybe we could make setup_revisions() use parse_options() someday,
> which understands about arguments and dashdash.
> 
> $ ./git grep -e -- foo
> fatal: ambiguous argument 'foo': both revision and filename
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> $ ./git grep -e -- -- foo

Yes, although we use it some in handle_revision_opt, I believe. The
problem isn't inherent to parse_options or not, though. To do it
correctly, we need to either:

  1. make two passes with the code that actually understands the options
     (be it parse_options or not); the first looking for "--", and the
     second to do the actual parsing. Right now our first pass does not
     understand the options at all.

  2. store the non-option arguments (including "--"), and only resolve
     and verify them after we have gone through the whole command-line
     and know whether we hit a "--" or not.

I suspect the second option would be simpler, as neither parse-options
nor the current revision code is safe to run through twice (e.g.,
parse-options may have callbacks that add to a list, and we would need
to add some kind of "dry-run" flag).

It's something that would be nice to fix, but I don't see myself working
on it anytime soon. It's a lot of work for very little benefit.

-Peff
