From: Jeff King <peff@peff.net>
Subject: Re: [RFC] improve 'bad default revision' message for empty repo
Date: Wed, 5 Mar 2008 04:10:52 -0500
Message-ID: <20080305091051.GA18377@sigill.intra.peff.net>
References: <3f4fd2640803011140o38ba0830l7775c8528f812779@mail.gmail.com> <20080303081021.GA6578@sigill.intra.peff.net> <3f4fd2640803041351k6debe788xbf5e818951f70146@mail.gmail.com> <20080305010701.GB20007@sigill.intra.peff.net> <7v7igh51rm.fsf@gitster.siamese.dyndns.org> <20080305043319.GA9074@sigill.intra.peff.net> <7vwsoho8t4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Reece Dunn <msclrhd@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 10:11:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWpez-0004uf-TL
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 10:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074AbYCEJK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 04:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbYCEJK6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 04:10:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4864 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756096AbYCEJKz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 04:10:55 -0500
Received: (qmail 27011 invoked by uid 111); 5 Mar 2008 09:10:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 05 Mar 2008 04:10:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2008 04:10:52 -0500
Content-Disposition: inline
In-Reply-To: <7vwsoho8t4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76199>

On Wed, Mar 05, 2008 at 12:48:39AM -0800, Junio C Hamano wrote:

> The thing is, nobody uses "--default" with random crap (i.e. risk of typo
> running from the command line).  It is really about scripted use, and I can
> guarantee majority of --default argument is HEAD, and in people's custom
> scripts that are specially tailored for specific workflows, they would
> use concrete commit object names that their workflow is built around as
> convention (e.g. "alias.recent = git log --since=1.day --default master").

Well, if you are comfortable, then I have no real objection. I just
wanted to raise the point since I didn't really know how widely and in
what way --default was being used.

> We could enhance the --default mechanism to say that its argument is
> optional when it begins with a '?', and change our internal callers to
> pass the equivalent of "--default ?HEAD", and keep the traditional die()
> behaviour for non-optional defaults to catch breakages in end-user
> scripts.

Sure, that is reasonable. The syntax is a bit ugly. Maybe just set an
ignore_default_errors flag to '1', and then if --default is specified on
the commandline, set it to '0'. The behavior should be identical for all
external scripts, and we can audit the internal uses.

But given your 'master' example above, I think you would actually want
it to be treated in the same way; if master doesn't exist, it is empty.
IOW, it is the "defaultness" which makes one want to ignore errors.

> > I think a tighter rule that would accomplish the same thing is "if we
> > resolve to a ref that is yet-to-be-born, then ignore." But unfortunately
> > that information is lost deep within the bowels of get_sha1_with_mode.
> 
> Yes and no.  It is in the error path, so you can afford to redo resolving
> the symref _after_ seeing get_sha1_with_mode() fail.

True. Although considering your 'master' example above, it is not just
"symref whose target doesn't exist", but "ref does not exist". In either
case (internal HEAD or explicit --default) I think something like "ref
exists but is corrupted" is something you would expect git to note.

Hrm. Thinking about it a bit more, what should be done with a --default
like "HEAD^^"? It currently works fine, but parsing it down to "HEAD"
requires the magic of get_sha1_with_mode. I think anyone using anything
but an unadorned refname for --default is probably insane, though. Would
it be acceptable to formally disallow it?

-Peff
