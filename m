From: Jeff King <peff@peff.net>
Subject: Re: Proposal: sharing .git/config
Date: Tue, 19 Feb 2013 10:36:00 -0500
Message-ID: <20130219153600.GA5338@sigill.intra.peff.net>
References: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
 <CACsJy8Ch70gZMkT7ScY3R-FNQU4QjtUe8UhoGRzE27cH9mu0HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 16:36:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7pFD-0007Q4-Qk
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 16:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933083Ab3BSPgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 10:36:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52961 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758410Ab3BSPgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 10:36:10 -0500
Received: (qmail 32029 invoked by uid 107); 19 Feb 2013 15:37:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Feb 2013 10:37:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2013 10:36:00 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Ch70gZMkT7ScY3R-FNQU4QjtUe8UhoGRzE27cH9mu0HA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216624>

On Tue, Feb 19, 2013 at 05:34:43PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Feb 19, 2013 at 4:25 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
> > Hi,
> >
> > I have this itch where I want to share my remotes config between
> > machines.  In my fork, I should be able to specify where my upstream
> > sources are, so remotes get set up automatically when I clone.  There
> > are also other things in .git/config that would be nice to share, like
> > whether to do a --word-diff (why isn't it a configuration variable
> > yet?) on the repository.  The only problem is that I have no clue how
> > to implement this: I'm currently thinking a special remote ref?
> 
> If you check out the config file, then include.path should work. You
> could add include.ref to point to a ref, but you need to deal with the
> attached security implications. This has been proposed before (and
> turned down, I think).

Here's the patch:

  http://article.gmane.org/gmane.comp.version-control.git/189144

The basic argument against it is that you would _not_ want to do:

  $ git config include.ref origin/config

because it's unsafe (you immediately start using config fetched from the
remote, before you even get a chance to inspect it). So the recommended
way to use it is:

  $ git config include.ref config
  $ git show origin/config ;# make sure it looks reasonable
  $ git update-ref refs/config origin/config

  [time passes...]

  $ git fetch
  $ git diff config origin/config ;# inspect changes
  $ git update-ref refs/config origin/config

But it was pointed out that you could also just do:

  $ git config include.ref upstream-config
  $ git show origin/config ;# make sure it looks reasonable
  $ git show origin/config >.git/upstream-config

and so forth. There are some ways that a pure ref can be more
convenient (e.g., if you are carrying local changes on top of the
upstream config and want to merge), but ultimately, you can replicate
any include.ref workflow with include.path by adding a "deploy" step
where you copy the file into $GIT_DIR.

-Peff
