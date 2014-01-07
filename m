From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] format-patch: introduce branch.*.forkedFrom
Date: Tue, 7 Jan 2014 16:16:45 -0500
Message-ID: <20140107211645.GC28102@sigill.intra.peff.net>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
 <CALkWK0=g5-9r05vTkys8Tk7iv7PqPZJvMvkYsAOnN_F90Mtgxg@mail.gmail.com>
 <20140107204035.GA27932@sigill.intra.peff.net>
 <CALkWK0mGPhU-8vVg+xY-MGWNstxoXSU9MGQiNzyFN+-Q6Bw28A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:17:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0e1P-00008o-5V
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbaAGVQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:16:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:56704 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753896AbaAGVQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:16:47 -0500
Received: (qmail 24851 invoked by uid 102); 7 Jan 2014 21:16:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 15:16:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 16:16:45 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0mGPhU-8vVg+xY-MGWNstxoXSU9MGQiNzyFN+-Q6Bw28A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240156>

On Wed, Jan 08, 2014 at 02:32:10AM +0530, Ramkumar Ramachandra wrote:

> > we should leave @{upstream} as (1), and add a new option to represent
> > (2). Not the other way around.
> 
> I have a local branch 'forkedfrom' that has two "sources": 'master'
> and 'ram/forkedfrom'. 'ram/forkedfrom' isn't a "dumb" publish-point:
> the relationship information I get between 'forkedfrom' and
> 'ram/forkedfrom' is very useful; it's what helps me tell how my
> re-roll is doing with respect to the original series; I'd often want
> to cherry-pick commits/ messages from my original series to prepare
> the re-roll, so interaction with this source is quite high. On the
> other hand, the relationship information I get between 'forkedfrom'
> and 'master' is practically useless: 'forkedfrom' is always ahead of
> 'master', and a divergence indicates that I need to rebase; I'll never
> really need to interact with this source.

Thanks for a concrete example.

I definitely respect the desire to reuse the existing tooling we have
for @{u}. At the same time, I think you are warping the meaning of
@{u} somewhat. It is _not_ your upstream here, but rather another
version of the branch that has useful changes in it. That might be
splitting hairs a bit, but I think you will find that the differences
leak through in inconvenient spots (like format-patch, where you really
_do_ want to default to the true upstream).

If we add "@{publish}" (and "@{pu}"), then it becomes very convenient to
refer to the ram/ version of your branch. That seems like an obvious
first step to me. We don't have to add new config, because
"branch.*.pushremote" already handles this.

Now you can do "git rebase @{pu}" which is nice, but not _quite_ as nice
as "git rebase", which defaults to "@{u}". That first step might be
enough, and I'd hold off there and try it out for a few days or weeks
first. But if you find in your workflow that you are having to specify
"@{pu}" a lot, then maybe it is worth adding an option to default rebase
to "@{pu}" instead of "@{u}".

You end up in the same place ("git rebase" without options does what you
want), but I think the underlying data more accurately represents what
is going on (and there is no need to teach "format-patch" anything
special).

-Peff
