From: Jeff King <peff@peff.net>
Subject: Re: Proposal: sharing .git/config
Date: Tue, 12 Mar 2013 04:53:42 -0400
Message-ID: <20130312085342.GA11340@sigill.intra.peff.net>
References: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
 <CACsJy8Ch70gZMkT7ScY3R-FNQU4QjtUe8UhoGRzE27cH9mu0HA@mail.gmail.com>
 <20130219153600.GA5338@sigill.intra.peff.net>
 <CALkWK0kZiYmbh-dSr-c2mzK2Mzhf3iZ_T3hFNuR57F0b5tptGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 09:54:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFKyQ-0001LS-5h
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 09:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3CLIxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 04:53:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49418 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754725Ab3CLIxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 04:53:50 -0400
Received: (qmail 24686 invoked by uid 107); 12 Mar 2013 08:55:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 04:55:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 04:53:42 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0kZiYmbh-dSr-c2mzK2Mzhf3iZ_T3hFNuR57F0b5tptGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217938>

On Tue, Mar 12, 2013 at 01:01:08AM +0530, Ramkumar Ramachandra wrote:

> > But it was pointed out that you could also just do:
> >
> >   $ git config include.ref upstream-config
> >   $ git show origin/config ;# make sure it looks reasonable
> >   $ git show origin/config >.git/upstream-config
> >
> > and so forth. There are some ways that a pure ref can be more
> > convenient (e.g., if you are carrying local changes on top of the
> > upstream config and want to merge), but ultimately, you can replicate
> > any include.ref workflow with include.path by adding a "deploy" step
> > where you copy the file into $GIT_DIR.
> 
> This seems to be unnecessarily complex and inelegant.  Maybe this
> functionality is best managed as a separate git repository: `repo`
> from depot_tools uses a manifest repository containing all the project
> metadata.  Maybe we can extend it/ write an more general version?

I don't think you can avoid the 3-step problem and retain the safety in
the general case.  Forgetting implementation details for a minute, you
have either a 1-step system:

  1. Fetch and start using config from the remote.

which is subject to fetching and executing malicious config, or:

  1. Fetch config from remote.
  2. Inspect it.
  3. Integrate it into the current config.

We can automate the sequence to remove as much friction as possible, but
fundamentally step 2 requires some effort from the user.  Moving the
config to a separate repo does not get rid of those steps.  The user
either does not look at the config before using it, in which case we are
no better than the 1-step scenario, or they do, in which case they are
replicating the 3-step scenario.

The other alternative is to automate step 2. The simplest way would be
to have a whitelist of "ok to share" config, that would not include
things like diff.external that can run arbitrary code. I don't know
whether that would make the system too limited for what people want to
do. Do we have a concrete example of what config people would like to
share in this manner?

-Peff
