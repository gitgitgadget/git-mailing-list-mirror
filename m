From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] wt-status: Show ignored files in untracked dirs
Date: Wed, 26 Dec 2012 22:48:59 -0500
Message-ID: <20121227034859.GA20817@sigill.intra.peff.net>
References: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
 <1356528674-2730-1-git-send-email-apelisse@gmail.com>
 <7vip7omd8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 04:49:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To4TC-0003Aj-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 04:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab2L0DtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 22:49:03 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36851 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab2L0DtC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 22:49:02 -0500
Received: (qmail 9469 invoked by uid 107); 27 Dec 2012 03:50:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Dec 2012 22:50:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Dec 2012 22:48:59 -0500
Content-Disposition: inline
In-Reply-To: <7vip7omd8c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212190>

On Wed, Dec 26, 2012 at 06:37:55PM -0800, Junio C Hamano wrote:

> Antoine Pelisse <apelisse@gmail.com> writes:
> 
> > When looking for ignored files, we do not recurse into untracked
> > directory, and simply consider the directory ignored status.
> 
> When asked to show ignored ones, instead of listing all ignored
> files in such a directory, we just say "everything in this directory
> is ignored"?
> 
> That sounds like a more desirable behaviour, than listing everything
> there, at least to me, but perhaps I am missing something.

I do not use this feature myself, but I would think that it should
respect the same DIR_SHOW_OTHER_DIRECTORIES flag (or a parallel flag)
that we already hook into "--untracked={all,normal}".

IOW, given:

  git init
  mkdir untracked ignored
  >untracked/file
  >ignored/file
  echo ignored >.git/info/exclude

I would expect:

  $ git status --short --ignored --untracked=normal
  ?? untracked/
  !! ignored/

  $ git status --short --ignored --untracked=all
  ?? untracked/file
  !! ignored/file

I do not know if anybody cares about the distinction, but optionally we
could give --ignored its own selector, like:

  $ git status --short --ignored=all --untracked=normal
  ?? untracked/
  !! ignored/file

where obviously it would default to "none" (whereas untracked defaults
to "normal"). But the behavior with Antoine's patch is:

  $ git status --short --ignored --untracked=normal
  ?? untracked/
  !! ignored

  $ git status --short --ignored --untracked=all
  ?? untracked/file
  !! ignored

which seems wrong to me for two reasons:

  1. It does not recurse for ignored but untracked entries. Neither does
     the current code, but I think it should.

  2. It loses the trailing slash from the ignored directory in both
     cases (which is printed by the current code).

-Peff
