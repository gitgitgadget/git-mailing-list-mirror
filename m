From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Thu, 26 Jan 2012 17:51:40 -0500
Message-ID: <20120126225140.GB12855@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126073752.GA30474@sigill.intra.peff.net>
 <7vipjy2nbi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 26 23:51:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqYAY-0007w7-KX
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 23:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab2AZWvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 17:51:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46043
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487Ab2AZWvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 17:51:44 -0500
Received: (qmail 30385 invoked by uid 107); 26 Jan 2012 22:58:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 17:58:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 17:51:40 -0500
Content-Disposition: inline
In-Reply-To: <7vipjy2nbi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189170>

On Thu, Jan 26, 2012 at 12:58:25PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Include directives are turned on for regular git config
> > parsing (i.e., when you call git_config()), as well as for
> > lookups via the "git config" program. They are not turned on
> > in other cases, including:
> >
> >   1. Parsing of other config-like files, like .gitmodules.
> >      There isn't a real need, and I'd rather be conservative
> >      and avoid unnecessary incompatibility or confusion.
> 
> This is a good design decision, I think, but I am not sure where this "we
> do not let gitmodules to honor inclusion" is implemented in this patch. I
> would have expected a patch to "git-submodule.sh" that adds --no-includes
> where it invokes "git config"?

My goal was to leave git_config_from_file untouched, so that the code in
submodule.c:gitmodules_config would work without modification. And that
works, obviously.

However, I didn't think about the fact that git-submodule.sh would be
calling git-config separately, and that is accidentally changed by my
patch.  Even if we changed git-submodule to use "git config
--no-includes" that would break any third-party scripts that use "git
config" to read git-like files.

But it would be nice for callers doing "git config foo.bar" to get the
includes by default. So maybe the right rule is:

  1. In C:
     a. git_config() respects includes automatically.
     b. other callers do not do so automatically (e.g., gitmodules via
        submodule.c).

    (i.e., what is implemented by this patch)

  2. Callers of git-config:
     a. respect includes for lookup that checks all of the "normal"
        config spots in sequence: .git/config, ~/.gitconfig, and
        /etc/gitconfig. These are the shell equivalent of calling
        git_config().

     b. when we are looking in a specific file (via GIT_CONFIG or "git
        config -f"), do not respect includes (but allow --includes if
        the caller chooses). This specific file may be something like
        .gitmodules. Or perhaps somebody is saying "no, I really just
        want to know what is in _this_ file, not what the config
        ecosystem tells me in general".

And then because of 1a and 2a, most programs should Just Work without
any changes, but because of 1b and 2b, any special uses will have to
decide manually whether they would want to allow includes.

Does that make sense?

> > +Includes
> > +~~~~~~~~
> > +
> > +You can include one config file from another by setting the special
> > +`include.path` variable to the name of the file to be included. The
> > +included file is expanded immediately, as if its contents had been
> > +found at the location of the include directive.
> 
> I cannot offer better wording, but the first reaction I had to this was
> "Eh, if I include a file A that includes another file B, to which config
> file the '[include] path = B' directive found in file A relative to?"
> 
> Logically it should be relative to A, and I think your implementation
> makes it so, but the above "as if its contents had been found at..."
> sounds as if it should be the same as writing '[include] path = B' in the
> original config file that included A.

Yes, it is relative to A. Anything else would be insane (because it
would mean "A" has to care about who is including it).

I had a similar thought while writing it, but hoped the sentence after
(that you snipped) would make it clear. But I see the "as if..." can be
ambiguous (because it's only mostly "as if"). I started trying to write
something like "with the exception of further includes, which..." but I
think that is just getting more confusing.

How about:

  The included file is processed immediately, before any other
  directives from the surrounding file.

What I wanted to make clear there is the ordering, which sometimes
matters.

> By the way, I was a bit surprised that you did not have to add the source
> stacking to git_config_from_file().
> 
> It was added in 924aaf3 (config.c: Make git_config() work correctly when
> called recursively, 2011-06-16) to address the situation where
> git_config() ends up calling git_config() recursively.

Yeah. I remembered discussing that patch with Ramsay a few months ago,
and I was pleased that it just worked in this case.

> My gut feeling is that logically that issue shouldn't be limited to
> configuration that is coming from file, which in turn makes me suspect
> that the source stacking may be better in one level higher than
> git_config_from_file() so that the ones coming from parameters could
> also be treated as a different kind of source to read configuration
> from.

I do factor it out in the second patch. I also considered how
git_config_from_parameters doesn't share the same source marking. But it
follows a completely different code-path, as its syntax is totally
different. So there's really not much point in adding to the config_file
stack (if you had another source that could be included from a file, you
would want to mention it in the stack. But the command-line parameters
must always be the "root" of the stack, so it's sufficient to simply
have a NULL stack to mark that).

> But in practice, including from the command line (i.e. -c include.path=...)
> is somewhat crazy and we probably would not want to support it, so...

Actually, I made sure it works, and it's in the tests. It even complains
if you use a relative path (I thought about using $PWD, but that is too
insane, as git changes the working directory behind the scenes).

The one use I think is to bundle a bunch of related config options, and
then turn them on selectively. So you _could_ do:

  cat >>~/.bashrc <<-\EOF
  FOO_OPTIONS="-c foo.one=1 -c foo.two=2"
  EOF
  # without FOO
  git blah
  # with FOO
  git $FOO_OPTIONS blah

but with this patch, you can do:

  cat >~/.gitconfig.foo <<-\EOF
  [foo]
  one = 1
  two = 2
  EOF
  git -c include.path=$HOME/.gitconfig.foo blah

which to my mind is a little more natural. I don't personally plan on
using it, but it was easy to implement (in fact, I'd have to write to
disallow it, since the include magic is in the callback handler).

-Peff
