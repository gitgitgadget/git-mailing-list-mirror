From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 06/10] fast-export: add new --refspec option
Date: Fri, 8 Nov 2013 16:06:53 -0800
Message-ID: <20131109000653.GB22906@sigill.intra.peff.net>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
 <1383212197-14259-6-git-send-email-felipe.contreras@gmail.com>
 <xmqq61sd70vw.fsf@gitster.dls.corp.google.com>
 <CAMP44s246M5DaeX80tqzfjRWnbE4vKh-vp_tLW-qAQUFFPsP0Q@mail.gmail.com>
 <xmqq38n98cud.fsf@gitster.dls.corp.google.com>
 <20131106221427.GB13258@sigill.intra.peff.net>
 <xmqqwqkimpas.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 01:07:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vew54-0005OH-Qc
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 01:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757954Ab3KIAG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 19:06:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:35832 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751087Ab3KIAGz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 19:06:55 -0500
Received: (qmail 26904 invoked by uid 102); 9 Nov 2013 00:06:55 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Nov 2013 18:06:55 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Nov 2013 16:06:53 -0800
Content-Disposition: inline
In-Reply-To: <xmqqwqkimpas.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237475>

On Fri, Nov 08, 2013 at 03:44:43PM -0800, Junio C Hamano wrote:

> > The "^origin" is not a refspec, and finding the refspec in the
> > dot-expression would involve parsing it into two components. I think you
> > can come up with a workable system by parsing the arguments as revision
> > specifiers and then applying some rules. E.g....
> 
> I was thinking about this a bit more today.  It is more or less
> trivial to actually teach the setup_revisions() infrastructure to
> optionally allow A:B to mean "We want a revision A, but with an
> extra twist", and leave that "extra twist" information in the
> rev_cmdline machinery.  After all, rev_cmdline was introduced for
> doing exactly this kind of thing.

I had wondered at first whether it would be a problem to be
syntactically ambiguous with <ref>:<path>. But I don't think so. Doing:

   git fast-export HEAD:Documentation

does not produce any output currently. And the fast-import stream cannot
actually represent trees outside of commits. Something like:

  git fast-export HEAD:Makefile

could produce a blob entry, but it currently does nothing. So I don't
think it's a big deal, as nobody is clamoring for the feature. And
certainly "git push" suffers from the same problem, and you can work
around it with:

  git push $(git rev-parse HEAD:Makefile):refs/tag/makefile-blob

> Earlier I said that all the existing transport commands take refspec
> as proper operands, not a value to a dashed-option, but I can imagine
> that we may in the future want to update "git push" in a way similar
> to what Felipe did to "git fast-export" so that it allows something
> like this:
> 
>     $ git push mothership \
>     > --refspec refs/heads/*:refs/remotes/satellite/* master
> 
> which would mean "I am pushing out 'master', but anything I push out
> to the mothership from my refs/heads/ hierarchy should be used to
> update the refs/remotes/satellite/ hierarchy over there".  The same
> thing can be done in the reverse direction for "git fetch".

Yes, though I would expect the "--refspec" bit would end up in config
(else why would you not just apply it directly to master). And you would
want to be able to override it, like:

  git push mothership \
    --refspec refs/heads/*:refs/remotes/satellite/* master:refs/other/master

So I think even with such wildcard magic, you'd still want refspecs,
both for "push" and for "fast-export".

> But such a wildcard refspec cannot be supported naturally by
> extending the setup_revisions(); what the wildcarded refspec expands
> to will depend on what other things are on the command line (in this
> case, 'master').  So I stopped there (I'll attach a toy patch at the
> end, but I'll discard it once I send this message out).

Yes, I think applying such a refspec would be the duty of whoever
expands "master" into "master:master". And that is not a job for
setup_revisions, which should be dealing mostly with the syntax and
telling us "I got just 'master'" or "I got 'master:foo'". The
interpretation is up to the caller.

> If we were to go that route, however, I would be strongly against
> calling that option --refspec; perhaps calling it --refmap would
> avoid confusion.

Agreed.

-Peff
