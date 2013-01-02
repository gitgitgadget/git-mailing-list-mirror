From: Jeff King <peff@peff.net>
Subject: Re: Test failures with python versions when building git 1.8.1
Date: Wed, 2 Jan 2013 01:53:45 -0500
Message-ID: <20130102065345.GA8685@sigill.intra.peff.net>
References: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com>
 <7va9ss5fhq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dan McGee <dan@archlinux.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 07:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqIDI-000446-DD
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 07:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916Ab3ABGxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 01:53:49 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41147 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3ABGxs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 01:53:48 -0500
Received: (qmail 27600 invoked by uid 107); 2 Jan 2013 06:54:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jan 2013 01:54:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jan 2013 01:53:45 -0500
Content-Disposition: inline
In-Reply-To: <7va9ss5fhq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212493>

On Tue, Jan 01, 2013 at 09:19:13PM -0800, Junio C Hamano wrote:

> Dan McGee <dan@archlinux.org> writes:
> 
> > A test case snuck in this release that assumes /usr/bin/python is
> > python2 and causes test failures. Unlike all other tests and code
> > depending on python, this one does not respect PYTHON_PATH, which we
> > explicitly set when building git on Arch Linux due to python2 vs
> > python3 differences.
> 
> I had an impression that you are not supposed to run our scripts
> with python3 yet (no python scripts have been checked for python3
> compatibility), even though some people have expressed interests in
> doing so.
> 
> Eric?

Yeah, but the worrying thing to me is that we are not respecting
PYTHON_PATH. So even if Arch does everything right, it is getting
punished just for having python3 on the system at all.

I think we need to either:

  1. Build contrib/svn-fe/svnrdump_sim.py into svnrdump using our normal
     build procedure, which handles $PYTHON_PATH (right now we seem to
     just symlink[1] it into place as svnrdump during the test script
     run).

  2. Create svnrdump as a shell script in the test suite to do something
     like[2]:

       $PYTHON_PATH "$TEST_DIRECTORY"/../contrib/svn-fe/svnrdump_sim.py

-Peff

[1] This symlink is doubly wrong, because any use of symbolic links
    in the test scripts needs to depend on the SYMLINKS prereq, and this
    does not.

[2] In both the current code and what I showed above, the test scripts
    depend on things in contrib/. This is probably a bad idea in
    general, as the quality of what goes into contrib is not as closely
    watched (especially with respect to things like portability).
    Certainly I would not have known to look more carefully at a patch
    to contrib/svn-fe for breakage to the test suite.

    FWIW, we also have this situation with t9902 (bash completion),
    though the dependency is a little more obvious there. It might be
    worth promoting bash completion out of contrib (or alternatively,
    demoting t9902 into contrib/completion/, possibly with a feature to
    make it easier to run tests out of contrib).
