From: Jeff King <peff@peff.net>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Mon, 6 Jan 2014 14:36:26 -0500
Message-ID: <20140106193625.GA27062@sigill.intra.peff.net>
References: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
 <20140106152742.GA26221@sigill.intra.peff.net>
 <xmqqbnzpkrvk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Burke <spraints@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 20:36:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0FyY-0002Oa-8r
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 20:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbaAFTgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 14:36:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:56049 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755839AbaAFTg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 14:36:28 -0500
Received: (qmail 13348 invoked by uid 102); 6 Jan 2014 19:36:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 13:36:27 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 14:36:26 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbnzpkrvk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240052>

On Mon, Jan 06, 2014 at 08:16:31AM -0800, Junio C Hamano wrote:

> > I was going to ask you to send your repository, but I can easily
> > reproduce here. I guess people don't run into it because it's uncommon
> > to fetch the whole refs/ namespace from a non-bare repo (and bare repos
> > do not tend to have stashes). Here's a minimal reproduction recipe:
> >
> >   git init repo &&
> >   cd repo &&
> >   echo content >foo &&
> >   git add . &&
> >   git commit -m foo &&
> >   echo more >>foo &&
> >   git stash &&
> >   git init --bare sub &&
> >   cd sub &&
> >   git fetch .. 'refs/*:refs/*'
> >
> > It looks like we are not feeding refs/stash properly to pack-objects.
> > I'll try to take a closer look later today.
> 
> I looked at this in the past and I vaguely recall that we reject it
> in the for-each-ref loop with check-ref-format saying "eh, that is a
> single-level name".
> 
> At that point I stopped digging, thinking it was a feature ;-)
> based on your exact observation about stash vs bare/non-bare.

I am fine with rejecting it with a warning, but we should not then
complain that the other side did not send us the object, since we should
not be asking for it at all. I also do not see us complaining about the
funny ref anywhere.  So there is definitely _a_ bug here. :)

I think somebody else mentioned recently that we do not handle malformed
refs consistently. I think it was:

  http://article.gmane.org/gmane.comp.version-control.git/239381

which might or might not be related.

-Peff
