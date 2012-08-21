From: Jeff King <peff@peff.net>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Tue, 21 Aug 2012 15:33:31 -0400
Message-ID: <20120821193331.GA15667@sigill.intra.peff.net>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
 <7v628dght9.fsf@alter.siamese.dyndns.org>
 <20120821015738.GA20271@sigill.intra.peff.net>
 <7vpq6kgazt.fsf@alter.siamese.dyndns.org>
 <20120821061059.GA26516@sigill.intra.peff.net>
 <20120821062219.GB26516@sigill.intra.peff.net>
 <7v1uj0fauk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 21:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3uCt-0005oK-U1
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 21:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab2HUTdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 15:33:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44051 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717Ab2HUTdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 15:33:36 -0400
Received: (qmail 2077 invoked by uid 107); 21 Aug 2012 19:33:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 15:33:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 15:33:31 -0400
Content-Disposition: inline
In-Reply-To: <7v1uj0fauk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203987>

On Tue, Aug 21, 2012 at 09:50:27AM -0700, Junio C Hamano wrote:

> > Subject: [PATCH] gitignore: report access errors of exclude files
> >
> > When we try to access gitignore files, we check for their
> > existence with a call to "access". We silently ignore
> > missing files. However, if a file is not readable, this may
> > be a configuration error; let's warn the user.
> >
> > For $GIT_DIR/info/excludes or core.excludesfile, we can just
> > use access_or_warn. However, for per-directory files we
> > actually try to open them, so we must add a custom warning.
> 
> There are a couple of users of add_excludes_from_file() that is
> outside the per-directory walking in ls-files and unpack-trees; I
> think both are OK with this change, but the one in ls-files may want
> to issue a warning or even an error upon ENOENT.
> 
> Not a regression with this patch; just something we may want to do
> while we are in the vicinity.

The two I see are:

  1. unpack-trees:verify_absent

     This looks like it is reading info/sparse-checkout. But I think it
     is OK for that file to be missing, no?

  2. ls-files:option_parse_exclude_from

      This handles --exclude-from. I would expect most callers to be
      converted to --exclude-standard these days, but originally callers
      did something like:

        git ls-files \
          --exclude-from=$GIT_DIR/info/exclude \
          --exclude-per-directory=.gitignore \
          ...

       While it would be friendlier to a user calling ls-files to warn
       about a missing entry in the first case (since they explicitly
       typed it, they presumably expect it to work). But for a script
       calling the ls-files plumbing, that --exclude-from has always
       meant "if it's there, use it, but otherwise, don't worry".

       Probably no such callers exist anymore, but complaining would be
       a regression for them.

-Peff
