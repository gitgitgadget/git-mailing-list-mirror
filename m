From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFD/PATCH] submodule doc: describe where we can configure them
Date: Wed, 4 May 2016 17:01:44 +0200
Message-ID: <20160504150143.GA8575@sandbox>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
 <20160503235652.GA395@google.com>
 <CAGZ79kb4GNZi93JpsPKUb7ScmePqDC1Xp+WZTGD7hfPUn9tWaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 17:46:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axz01-0000Ku-24
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 17:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbcEDPpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 11:45:47 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:48036 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbcEDPpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 11:45:45 -0400
X-Greylist: delayed 2636 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 May 2016 11:45:45 EDT
Received: from [84.141.121.223] (helo=sandbox)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1axyJ8-0007bq-04; Wed, 04 May 2016 17:01:46 +0200
Content-Disposition: inline
In-Reply-To: <CAGZ79kb4GNZi93JpsPKUb7ScmePqDC1Xp+WZTGD7hfPUn9tWaQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293551>

On Tue, May 03, 2016 at 05:59:58PM -0700, Stefan Beller wrote:
> On Tue, May 3, 2016 at 4:56 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Stefan Beller wrote:
> >
> >> This is similar to the gitignore document, but doesn't mirror
> >> the current situation. It is rather meant to start a discussion for
> >> the right approach for mirroring repositories with submodules.
> >
> > Ooh.
> 
> Thanks for writing such a detailed answer. :)

BTW, here is a pointer to the discussion (and what I wrote down) about
this from back in 2014:

https://github.com/jlehmann/git-submod-enhancements/wiki/Ideas#special-ref-overriding-gitmodules-values

> > To fix this, we could allow additional .gitmodules settings to be put
> > in another ref (perhaps something like "refs/repository/config" to allow
> > sharing additional repository-specific configuration in other files
> > within the same tree --- e.g., branch descriptions).  The semantics:
> >
> > * If there is a gitmodules file in refs/repository/config in the
> >   repository I clone, then the submodule settings from it are stored
> >   locally somewhere that overrides .gitmodules.  Perhaps
> >   .git/info/<remotename>/gitmodules?
> >
> > * Later fetches from the remote would also update this gitmodules
> >   file.
> >
> > * Settings from this gitmodules file can be overridden locally
> >   using 'git config' until an explicit "git submodule sync" to
> >   override the local configuration.
> >
> > What do you think?
> >
> > If two different remotes provide conflicting values for a setting
> > in their gitmodules files, git would error out and ask the user
> > to intervene with a tie-breaking "git config" setting.
> 
> Let's look at an example with C mirroring from B, who mirrors from A.
> 
> The user who clones the superproject from C may want to obtain submodules
> from either C or B or A. All this can be configured in
> the refs/repository/config value of C, but in case it is not configured in C,
> it may fall back to the same branch from B. When and how would B get
> that branch?

I think B has to setup that branch on its own when it starts to mirror
A and uses different submodule urls or other configs.

Jonathan you suggested to copy the content from a remote to
.git/info/<remotename>/gitmodules locally. How would one get it to the
remote side? It seems to me as if we would need to implement additional
infrastructure to do this. Would it not be simpler if we just kept it on
a ref on the local side as well? We already have the infrastructure to
read those values from a ref. We only would need to add something to
write them. Then a simple push, which could be aliased in form of a
git-submodule subcommand, suffices to get the values to the remote.

That also solves issues when people clone from their working copy.

I would like to think a little bit further about the conflict situation
when two remotes are providing values. Configuring this looks to me like
a nightmare for users. Maybe there is some sort of elegant solution?
E.g. like we use the values from remote A during a fetch from A, the
ones from B during a fetch from B and no values from a special ref in
case there is no remote operation involved. Since the main goal is to
support forking of submodules isn't there always a remote operation
involved?

My suggested scheme above does not solve the currently quite typical use
case where you might 'git fetch' without submodules first and then do
the submodule fetches during a 'git submodule update'. On the other hand
in the 'ideal future world' where submodules behave like "normal files" the
fetch will be done during the superproject fetch so in that case we
could solve such conflicts.

The main thing which we could keep in mind is that we only allow certain
values in such special refs. E.g. only the ones needed to support the
fork workflow. BTW, do we actually need to change other values than the
URL? Addtionally we ignore other values that are more related to the
overall project structure. E.g. like submodule.<name>.ignore.

Ok after writing this it really feels like special casing a lot. I would
not really call it elegant. At the same time limiting these special refs
to one special use case (forking) might help us to keep the user
interface[1] simpler and conflict free in the long run. Not sure. What
do you think?

Cheers Heiko

[1] Which is not the simplest already.
