From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: submodule update --force
Date: Mon, 14 May 2012 18:52:32 +0200
Message-ID: <20120514165231.GB58058@book.hvoigt.net>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com> <CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com> <7vobpwpoyi.fsf@alter.siamese.dyndns.org> <7vk40kpnia.fsf@alter.siamese.dyndns.org> <CAHOQ7J_6+sfU6egjvVSPj-FAS6zjSUT=a057=kz_wYbogHLMMA@mail.gmail.com> <7v8vh0ozge.fsf@alter.siamese.dyndns.org> <20120510185738.GE76400@book.hvoigt.net> <CABURp0rFQ+330X8g3C2rmozQ77zxqhZhReZhaYMi1FE4uKeQtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Zager <szager@google.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 18:52:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STyVi-0006lG-1L
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 18:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab2ENQwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 12:52:35 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40229 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756377Ab2ENQwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 12:52:34 -0400
Received: (qmail 2735 invoked from network); 14 May 2012 16:52:32 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 14 May 2012 16:52:32 -0000
Content-Disposition: inline
In-Reply-To: <CABURp0rFQ+330X8g3C2rmozQ77zxqhZhReZhaYMi1FE4uKeQtA@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197786>

Hi,

On Fri, May 11, 2012 at 04:56:07PM -0400, Phil Hord wrote:
> On Thu, May 10, 2012 at 2:57 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > On Thu, May 10, 2012 at 07:58:09AM -0700, Junio C Hamano wrote:
> > > Stefan Zager <szager@google.com> writes:
> > >
> > > > ... ?To my mind, any
> > > > `git submodule` command should *always* run on the first level of
> > > > submodules. ?If you're going to specify --no-recurse, then why are you
> > > > running `git submodule` at all? ?I think 'recursion' only applies to
> > > > moving beyond the first level of submodules.
> > >
> > > Very true.
> > >
> > > Submodule folks, any opinion on the Stefan's approach?
> >
> > The distinction between first level of submodules and deeper is only
> > present in the "git submodule" subcommand and I think mainly for
> > historical reasons. I do not see a use case where this would be helpful.
> 
> Do I understand you to mean that you think the git-submodule ...
> --recursive option is archaic?  I would agree that one might expect it
> to be the default option, but I do not think it should be deprecated
> in any way.

In a way yes its archaic since I do not know why one would distinguish
between the first level of populated submodules and below. For example
if you have nested submodules and want them all be populated you need to
use

	git submodule update --init --recursive

The sequence

	git submodule init --recursive
	git submodule update --recursive

does not do the same thing but would have to be called multiple times
until you have reached the deepest level. IMO that is confusing but not
only a problem of this option.

> > To skip uninteresting submodules one can always use the
> > submodule.$name.update option set to 'none'. (I just found that its
> > documentation is in the wrong place but I will send a seperate patch
> > about that).
> >
> > In the non submodule commands we usually name this option
> > --recurse-submodules=always and have another
> > --recurse-submodules=on-demand option for the current behavior. Those
> > options would either recurse or do nothing with the submodule.  Such a
> > behavior, as pointed out, does not make sense for 'submodule update'.
> > Similar options names for 'submodule update' would probably be
> > --recurse=always and --recurse=on-demand.
> >
> > Nonetheless is force a term where the user probably wants to skip all
> > optimizations which the sha1 equality provides. So to make the current
> > behavior more consistent I would be fine with adding this change.
> >
> > One thing which might make force even more useful would be to also skip
> > the "is the sha1 available"-check for fetch that is possibly run before
> > the checkout and just always run the fetch.
> >
> > In the long term, once checkout has learned things 'submodule update' is
> > currently doing, it probably makes sense to let 'submodule update'
> > always recurse into all checked out submodules. Since then it does not
> > make sense to run 'submodule update' for much more than resetting
> > things or changing the currently registered commits anymore. So in the
> > bright new future the 'on-demand' part will probably move away from
> > 'submodule update' and as such it does not make sense to implement
> > the seperate recurse options I described above.
> >
> > What do others think?
> 
> I think there are three cases:
> 
> 1. I want to update any sha1-mismatching submodules so
>     their HEAD matches the superproject gitlink.
> 
>     git submodule update
> 
> 2. Same as (1) above, but also check out files for all
>     submodules which are not already checked out.
> 
>     git submodule update &&
>     git submodule foreach 'git checkout HEAD || :'
> 
> 3. I want to update exactly to the gitlinks in the superproject
>    and discard any local or staged changes.
> 
>     git submodule update -f
> 
> (2) above is the case Junio was trying to cover.  I cannot think of an
> elegant name for the switch for such an option, but I would be
> surprised it to find it is not the default behavior if I also
> encountered it like Stefan did.  We should try to eliminate surprises
> to help dispel the notion that submodules are unwieldy.

Yes we should eliminate surprises thats true. On the other hand there is
no way to setup submodules in the way Stefan had them by using the git
submodule command or is there? So for his use case the command sequence
you described seems to be more appropriate but I am not sure whether
that justifies a separate option for it.

> (3) is too heavy when I really only wanted (2).
> 
> I do not understand that use case that led Stefan to the predicament
> he was in where he had submodules with HEADs but with no checked out
> files.  But I do not begrudge his being there.

Yes, but currently -f is wrong in the way that when the submodules HEAD
sha1 is the same as registered in the superproject it will skip the
checkout. That is wrong when you have local uncommitted changes in the
worktree. In such a state I would expect it to throw away those local
changes and checkout HEAD. So I think Stefans patch makes sense anyway
even though it might actually be to heavy for his use case.

Cheers Heiko
