From: Jeff King <peff@peff.net>
Subject: Re: Proposal: sharing .git/config
Date: Mon, 18 Mar 2013 07:48:05 -0400
Message-ID: <20130318114805.GB14789@sigill.intra.peff.net>
References: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
 <CACsJy8Ch70gZMkT7ScY3R-FNQU4QjtUe8UhoGRzE27cH9mu0HA@mail.gmail.com>
 <20130219153600.GA5338@sigill.intra.peff.net>
 <CALkWK0kZiYmbh-dSr-c2mzK2Mzhf3iZ_T3hFNuR57F0b5tptGw@mail.gmail.com>
 <20130312085342.GA11340@sigill.intra.peff.net>
 <CALkWK0nWXCO_EXfx69m8XbrFe=ABBodPdFbSrS9v3VqgfbnQ+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 12:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHYYQ-0008Im-8e
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 12:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab3CRLsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 07:48:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55936 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab3CRLsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 07:48:09 -0400
Received: (qmail 15759 invoked by uid 107); 18 Mar 2013 11:49:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 07:49:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 07:48:05 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nWXCO_EXfx69m8XbrFe=ABBodPdFbSrS9v3VqgfbnQ+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218404>

On Mon, Mar 18, 2013 at 02:30:23PM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > I don't think you can avoid the 3-step problem and retain the safety in
> > the general case.  Forgetting implementation details for a minute, you
> > have either a 1-step system:
> >
> >   1. Fetch and start using config from the remote.
> >
> > which is subject to fetching and executing malicious config, or:
> >
> >   1. Fetch config from remote.
> >   2. Inspect it.
> >   3. Integrate it into the current config.
> 
> I don't understand your emphasis on step 2.  Isn't the configuration
> written by me?  Why would it be malicious?

Maybe I am misunderstanding the use case, but when people talk about
share config, they are often talking about pushing project-wide config
out to developers. So the config is not necessarily written by you, but
by somebody who had write access to the upstream repository.

The obvious counterpoint is that people usually run "make" right after
fetching, so they are trusting what they fetched already. And the
counter-counterpoint is that yes, that's true, but at least with the
"make" case they can use git to inspect the differences before running
them. You may be able to tell that this is not the first time this
discussion has happened. :)

Personally, I do not think it is the end of the world for people to opt
into the "automatically fetch and respect config" method for certain
repositories (and that's why I wrote include.ref support a while ago).
It's a security tradeoff that the user may want to make. But I also
respect the argument that we should not be endorsing risky behavior by
advertising such a feature (especially when the risk is quite subtle, as
many users may not realize that git config can execute arbitrary code).

> I've just started thinking about how to design something that will
> allow us to share configuration elegantly [1].  Essentially, the
> metadata repository will consist of *.layout files, one for each
> repository to clone, containing the .git/config to write after cloning
> that repository.  So, a git.layout might look like:
> 
> [layout]
> 	directory = git
> [remote "origin"]
> 	url = git://github.com/git/git
> [remote "ram"]
> 	url = git@github.com:artagnon/git
> [remote "junio"]
> 	url = git://github.com/gitster/git
> 
> As you can see the [layout] is a special section which will tell our
> fetcher where to place the repository.  Everything else is meant to be
> inserted into the repository's .git/config.  However, I can foresee a
> problem in scaling: when I ask a specific directory like a/b/c to be
> populated (equivalent of repo sync `a/b/c`), it'll have to parse the
> layout.directory variable of all the .layout files, and this can be
> slow.  So, maybe we should have a special _manifest.layout listing all
> the paths?
> 
> Further, I see this as a way to work with projects that would
> otherwise require nested submodules like the Android project.  What do
> you think?

Yeah, reading your layout description, this is less about git config in
particular, and more about managing hierarchies of repos. Which I think
is a fine thing to do, and is a sensible place to put config management
(since you are probably executing arbitrary code as part of the layout
tool anyway). But I don't have a real opinion on the design of such a
tool. I have used repo only once or twice to deal with Android. For my
own menagerie of small repos, I have a hacky custom tool that is mostly
about deciding when there are items to be committed, pushed, or fetched
in each repo; I never found the need to handle git config at all.

-Peff
