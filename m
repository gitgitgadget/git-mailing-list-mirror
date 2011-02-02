From: Johan Herland <johan@herland.net>
Subject: [1.8.0] Provide proper remote ref namespaces
Date: Wed, 02 Feb 2011 03:21:59 +0100
Message-ID: <201102020322.00171.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
 <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 02 03:22:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkSMQ-0000zE-CB
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 03:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393Ab1BBCWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 21:22:05 -0500
Received: from smtp.getmail.no ([84.208.15.66]:45309 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104Ab1BBCWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 21:22:04 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LFY00DG8X8P3X60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Feb 2011 03:22:02 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id CF75F1EA55C2_D48BFC9B	for <git@vger.kernel.org>; Wed,
 02 Feb 2011 02:22:01 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1589B1EA2900_D48BFC9F	for <git@vger.kernel.org>; Wed,
 02 Feb 2011 02:22:01 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LFY00BEUX8OLC00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Feb 2011 03:22:01 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165885>

On Wednesday 02 February 2011, Sverre Rabbelier wrote:
> On Tue, Feb 1, 2011 at 19:14, Jeff King <peff@peff.net> wrote:
> > i.e., make refs/remotes/* an actual mirror of selected parts of the
> > remote's refs/ hierarchy. And then figure out sane rules for merging
> > those namespaces into the ref lookup procedure.
> 
> Jeff, Nguy, are either of you interested in writing up a new/modifying
> this proposal to be about namespacing everything?

Here's my go at phrasing this in a proposal format. Feel free to revise and 
resend:


Proposal:

Currently, git stores remote refs in the local repo by default as follows:

  Remote repo    ->   Local repo
  ---------------------------------------------------------
  HEAD                refs/remotes/$remote/HEAD  (implicit)
  refs/heads/*        refs/remotes/$remote/*
  refs/tags/*         refs/tags/*                (implicit, autofollow)
  refs/replace/*      (TBD)
  refs/notes/*        (TBD)

Several users report that they are confused by the difference in how heads 
and tags are mapped, and by the implicit mappings that are not mentioned in 
the configured refspecs. Also, as users want to share ever more different 
types of refs (replace refs and notes refs have been discussed recently), 
the existing ref mappings (aka. refspecs) do not suggest a natural/intuitive 
mapping for the new ref types.

Instead, we should change the default ref mappings into the following:

  Remote repo    ->   Local repo
  --------------------------------------------------
  HEAD                refs/remotes/$remote/HEAD
  refs/heads/*        refs/remotes/$remote/heads/*
  refs/tags/*         refs/remotes/$remote/tags/*
  refs/replace/*      refs/remotes/$remote/replace/*
  refs/notes/*        refs/remotes/$remote/notes/*

In short, we make refs/remotes/$remote/* an actual mirror of selected parts 
of the remote's refs/* hierarchy. This provides consistent namespaces for 
remote refs that naturally allows adding new ref types in the future.

This change obviously affects our ref-handling code:

- Remote tags are now stored separate from local tags. When looking up a 
shorthand tag name (e.g. v1.7.4), we should consult local tags 
(refs/tags/v1.7.4) before remote tags (refs/remotes/*/tags/v1.7.4 [1]). See 
[2] for more details.

- Remote heads have moved into refs/remotes/$remote/heads/*, hence 
invalidating shorthand remote head names, like "origin/master". We should 
change the lookup code, so that a shorthand ref of the form "$remote/$head" 
where "$remote" happens to match a configured remote is eventually expanded 
into lookup for "refs/remotes/$remote/heads/$head" [3].

- We might want to generalize the handling of "$remote/$head" into allowing 
shorthands like "$remote/$tag", "$remote/$replace" and "$remote/$note" as 
well (provided, of course, that they match unambiguously).

- All fetch refspecs should be given explicitly.

Sub-proposal: While we are changing the default refspecs, we should also 
consider whether we want to keep the auto-following behavior that Git 
currently does for tags (don't fetch tags that refer to objects not 
otherwise fetched by another refspec). If we simply make an explicit 
"+refs/tags/*:refs/remotes/$remote/tags/*" refspec, we will lose the auto-
following behavior. If we do want to keep the auto-following behavior, we 
could for example add a "~" prefix to the refspec to trigger auto-following 
behavior (i.e. this refspec only applies to refs that happen to point at 
objects fetched by way of a different refspec). See 
http://thread.gmane.org/gmane.comp.version-control.git/160503/focus=160795 
for more details.


Risks:

Existing scripts/programs may make assumptions about the layout of remote 
refs without consulting the configured refspecs. However, such 
scripts/programs may also break today when non-default refspecs are used.

When remotes have conflicting tags (same tag name points to different 
objects), and the tag name does not exist locally (in refs/tags/*), looking 
up the shorthand tag name will result in an "ambiguous ref" error (instead 
of silently adopting whichever tag was fetched first). Although many 
consider this an improvement on the current behavior, there may be scenarios 
where this causes problems in external scripts/programs.

Existing scripts/programs that assume and depend on the current implicit 
refspecs (or the tag auto-following behavior), might encounter problems when 
we drop these in favor of explicit refspecs.


Migration plan:

The main part of this proposal is simply changing the default refspecs. As 
such, the proposal can be simulated in current Git versions by setting up 
custom refspecs according to the above table of ref mappings.

In v1.8.0, we should default to the new default refspecs when creating new 
remotes. However, existing remotes (created pre-v1.8.0) must continue to 
work as before, so we cannot simply remove the implicit refspecs (or tag 
auto-following). Instead we need to make sure that the implicit refspecs is 
NOT applied to the new-style remotes. Identifying new-style vs. old-style 
remotes can be done by looking at the refspec itself (old-style: 
"refs/remotes/$remote/*", new-style: "refs/remotes/$remote/heads/*"), or 
(worst case) by introducing a config variable specifying the desired 
behavior (defaulting to old-style).

When adding the new rules for looking up shorthand refs (described above), 
we should carefully verify that these won't cause regressions when applied 
to old-style refspecs in existing repos.

In a later major version we can consider removing the (by then ancient) 
implicit refspecs, and any other outdated compatibility measures code in our 
ref lookup code.


Have fun! :)

...Johan


[1]: The "refs/remotes/*/tags/v1.7.4" is not hardcoded, but rather the 
(default) result of mapping "refs/tags/v1.7.4" through each remote's 
refspecs as defined in the config.

[2]: When looking up a shorthand tag name (e.g. v1.7.4): If a local tag 
(refs/tags/v1.7.4) is found, then we have an unambiguous match. If no local 
tag is found, we look up the tag name in all configured remotes (using the 
method described in [1]). If the tag name exists in one or more remotes, and 
those remotes all agree on its ultimate object name (after applying e.g. 
^{commit} or whatever is appropriate in the context of the lookup), then we 
also have an unambiguous match. However, if the tag name exists in multiple 
remotes, and they do NOT all agree on its ultimate object name, then the 
shorthand tag name is ambiguous and the lookup fails. The user can always 
resolve this ambiguity by creating a local tag (refs/tags/v1.7.4) pointing 
to the desired object.

[3]: As in [1], the "refs/remotes/$remote/heads/$head" is not hardcoded, but 
rather the result of mapping "refs/heads/$head" through the refspecs for 
$remote as defined in the config.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
