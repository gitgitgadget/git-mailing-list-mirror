From: Johan Herland <johan@herland.net>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 15 Jun 2011 01:45:12 +0200
Message-ID: <201106150145.12912.johan@herland.net>
References: <20110608093648.GA19038@elte.hu>
 <201106141156.56320.johan@herland.net>
 <20110614171204.GC26764@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 15 01:45:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWdIV-0005h0-Gu
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 01:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab1FNXpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 19:45:22 -0400
Received: from smtp.getmail.no ([84.208.15.66]:35253 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab1FNXpV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 19:45:21 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LMT00C190NJFV70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 15 Jun 2011 01:45:19 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 50E331EA57B3_DF7F28FB	for <git@vger.kernel.org>; Tue,
 14 Jun 2011 23:45:19 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 59E701EA2EE6_DF7F28EF	for <git@vger.kernel.org>; Tue,
 14 Jun 2011 23:45:18 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LMT005NC0NI1D00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 15 Jun 2011 01:45:18 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <20110614171204.GC26764@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175803>

On Tuesday 14 June 2011, Jeff King wrote:
> On Tue, Jun 14, 2011 at 11:56:56AM +0200, Johan Herland wrote:
> > 2. Interpreting/DWIMing refs
> > 
> > Changing the ref mappings require a revised set of rules for
> > interpreting shorthand ref names (expanding them into full ref names),
> > and handling ambiguities when they arise:
> > [...]
> > 
> > - "origin/foo" must continue to work, even if "refs/remotes/origin/foo"
> > has now become "refs/remotes/origin/heads/foo". In other words,
> > "foo/bar" where "foo" is a valid remote, must try to resolve "bar"
> > against the refspecs specified for the "foo" remote.
> 
> What happens if I ask for foo/bar/baz? Should it try to resolve:
> 
>   1. refs/remotes/foo/heads/bar/baz
> 
> or
> 
>   2. refs/remotes/foo/bar/heads/baz
> 
> or both (and if both, in which order)?

I think we want to do both, following these pseudo-bash steps (or something 
similar):

  shorthand=$1  # e.g. "foo/bar/baz"
  for remote in $(git remote)
  do
      case $shorthand in
        "$remote/"*)
          # Found matching remote
          trailer=${shorthand#$remote/}
          # Assert $remote/$trailer == $shorthand
          # DWIM $trailer into
          # - refs/heads/$trailer
          # - refs/tags/$trailer
          # etc.
          for dwimmed_ref in dwim_ref($trailer)
          do
              # Map $dwimmed_ref through refspec to get
              # remote-tracking ref, e.g. mapping
              # "refs/heads/spam" to "refs/remotes/$remote/heads/spam"
              remote_ref=map_through_refspec($dwimmed_ref, $remote)
              if test -n "$remote_ref"
              then
                  # Add $remote_ref to list of candidates
              fi
          done
          ;;
        *)
          # Non-match, ignore
          ;;
      esac
  done

  # We now have a list of (fully qualified) ref candidates
  # for $shorthand.

  # If there are zero candidates, there is no match for $shorthand.

  # If there is only one candidate, we have found an unambiguous
  # match for $shorthand.

  # If our current context demands a SHA1 object name, and all
  # candidates point to the same SHA1, there is no ambiguity.

  # Otherwise, $shorthand is ambiguous.


Using the above (pseudo)code, and assuming remotes "foo" and "foo/bar" exist 
(with remote branches "bar/baz" and "baz", respectively, and default new-
style refspecs), then the "foo/bar/baz" shorthand would resolve to the 
following two remote-tracking branches:

- refs/remotes/foo/heads/bar/baz
- refs/remotes/foo/bar/heads/baz

This would likely result in an "ambiguous shorthand" error, unless the 
current context wants a SHA1 object name, and the two remote-tracking refs 
happen to point to the same SHA1 (in which case the result is unambiguous).

(Obviously, all of the above assumes that "foo/bar/baz" does not match any 
local ref, which would take precedence over the remote-tracking refs listed 
above.)

> I don't know offhand if "git remote" and "git clone" allow slashes in
> remote names, but I don't think we forbid it if somebody configures it
> themselves (and of course, remote names aside, they are free to write
> whatever refspecs they like in the config file).

  git remote add foo/bar .

does not report any errors for me.

> > - If "refs/tags/foo" does not exist, tag name "foo" is unambiguous if
> > it exists in one or more "refs/remotes/*/tags/foo" and they all point
> > to the same SHA1.
> > 
> > - If "refs/tags/foo" does not exist, and more than one
> > "refs/remotes/*/tags/foo" exist, and they do NOT all point to the same
> > SHA1, then there is an ambiguity.
> > 
> > - The user may resolve the ambiguity by creating "refs/tags/foo"
> > pointing to the chosen SHA1 ("refs/tags/foo" takes precedence over
> > "refs/remotes/*/tags/foo").
> > 
> > - The same rules apply to heads, notes, etc.
> 
> I'm not sure we need all of these rules for anything but tags. We
> already keep remote heads in a separate namespace, and we don't
> automagically look them up. And that's OK, because the way tags and
> heads work is fundamentally different. I can peek at your remote heads,
> but if I checkout or merge, I better make a local branch that matches
> your remote one.  Whereas with tags, I don't think that is the case.
> They're really a read-only thing, and you want them to stay in the
> remotes namespace.

I don't really have any strong opinions here. As long as the rules end up 
being fairly intuitive and usable in practice, I'm quite happy to let others 
decide on the details.

FWIW, if I run "git log some_topic" and "some_topic" only exists as a 
remote-tracking ref ("refs/remotes/origin/heads/some_topic"), I do think I 
would prefer git to DWIM it, instead of simply failing with:

  fatal: bad revision: some_topic

This would be somewhat in line with the DWIMing already performed by "git 
checkout some_topic".


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
