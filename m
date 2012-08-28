From: Jeff King <peff@peff.net>
Subject: Re: I think git show is broken
Date: Tue, 28 Aug 2012 18:45:50 -0400
Message-ID: <20120828224550.GA21940@sigill.intra.peff.net>
References: <503D022B.6070001@redlion.net>
 <503D046B.7090606@redlion.net>
 <20120828212934.GA396@sigill.intra.peff.net>
 <7v4nnmzlsl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthew Caron <Matt.Caron@redlion.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 00:46:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6UYM-0005qG-D7
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 00:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab2H1Wpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 18:45:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41256 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422Ab2H1Wpy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 18:45:54 -0400
Received: (qmail 26695 invoked by uid 107); 28 Aug 2012 22:46:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Aug 2012 18:46:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Aug 2012 18:45:50 -0400
Content-Disposition: inline
In-Reply-To: <7v4nnmzlsl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204457>

On Tue, Aug 28, 2012 at 03:36:26PM -0700, Junio C Hamano wrote:

> > As a result, the flag would have no effect in "git log -p
> > --quiet" or "git show --quiet".  Fix it by setting the
> > format flag before the call to setup_revisions.
> 
> This also means that
> 
> 	git show --name-status --quiet
> 
> will start erroring out, if I am not recalling what diff_setup_done()
> does.  Which pretty much means "--quiet" given to the "log" family
> is truly a synonym to "-s", as the error condition that triggers is
> exactly the same for this:
> 
> 	git show --name-status -s
> 
> which is fine, I think.

Yes, I noticed that. I think it is fine for "--quiet" to be a true
synonym for "-s" here.

Though I am puzzled why we would error out on "--name-status -s" but not
"--patch -s". What is the difference between "--name-status" and
"--patch" here? Shouldn't "-s" override all formatting options?

And one final thing I noticed that is probably not worth the trouble to
fix: the position of "-s" is independent of its effect. Normally options
which override each other would be position dependent, so:

  git log --relative-date --date=local

and

  git log --date=local --relative-date

would both throw away the first option and let the latter take effect.
But doing:

  git log --patch -s

and

  git log -s --patch

will always have "-s" take over. I don't think it's a huge deal, and
fixing it would be a pain. We'd have to take NO_OUTPUT out of the
bit-field and make it a special option, and fix any callers who try to
be clever about recognizing NO_OUTPUT as a specifically-given option.
And then for "--quiet", we'd have to handle it at its proper spot on the
command-line, which would mean converting log's parse-options invocation
to be step-wise. Probably not worth it for a minor bit of consistency
that nobody has actually complained about.

-Peff
