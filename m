From: Johan Herland <johan@herland.net>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Tue, 14 Jun 2011 11:56:56 +0200
Message-ID: <201106141156.56320.johan@herland.net>
References: <20110608093648.GA19038@elte.hu>
 <BANLkTiku_qvn73cUDBT=OxY-3jR3raoOhg@mail.gmail.com>
 <BANLkTimtxESnZ23tRBYYVN1paUmNOhdPyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Ingo Molnar <mingo@elte.hu>, Jeff King <peff@peff.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>, git@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 11:57:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWQMx-0007km-Cr
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 11:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab1FNJ5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 05:57:01 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53458 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755586Ab1FNJ47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 05:56:59 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LMR00GRIYAXA7D0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 14 Jun 2011 11:56:57 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8A9B61EA57CD_DF73069B	for <git@vger.kernel.org>; Tue,
 14 Jun 2011 09:56:57 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id EFF971EA2B82_DF73068F	for <git@vger.kernel.org>; Tue,
 14 Jun 2011 09:56:56 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LMR00KZIYAWWM20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 14 Jun 2011 11:56:56 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <BANLkTimtxESnZ23tRBYYVN1paUmNOhdPyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175755>

On Wednesday 08 June 2011, Nguyen Thai Ngoc Duy wrote:
> 2011/6/8 Sverre Rabbelier <srabbelier@gmail.com>:
> > Heya,
> > 
> > [+Peff, Duy, who seemed interested in this]
> > 
> > On Wed, Jun 8, 2011 at 14:52, Ingo Molnar <mingo@elte.hu> wrote:
> >> So it would be nice to have more separation for remotes - right now
> >> they do not sit still in their sandboxes! :-)
> > 
> > Sounds like the "tags should go in their own namespaces in git 1.8.0"
> > [0] discussion? :)
> > 
> > [0]
> > http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=16
> > 5837
> 
> A lengthy thread. Does anybody remember the outcome? Was Johan's
> proposal OK and only waiting to be implemented, or is there still
> unanswered questions?

(Sorry for the late answer. Unfortunately, I don't have much Git time these 
days...)

Browsing that thread, it seems my proposal was largely OK. AFAICS there are 
no major technical problems with moving to the following ref mapping:

  Remote repo    ->   Local repo
  --------------------------------------------------
  refs/heads/*        refs/remotes/$remote/heads/*
  refs/tags/*         refs/remotes/$remote/tags/*
  refs/replace/*      refs/remotes/$remote/replace/*
  refs/notes/*        refs/remotes/$remote/notes/*

There was a fair amount of discussion around whether we really _want_ to put 
all refs (especially tags) in separate per-remote namespaces, and it seems 
(both from that thread, and from later threads, like this one) that we _do_ 
want per-remote namespaces for all refs.

That said, there are a couple of outstanding questions/challenges before 
this can be implemented:


1. How to deal with tag auto-following

The tag auto-follow behavior currently depends on the implicit 
"refs/tags/*:refs/tags/*" refspec, and the "refs/tags/" prefix is presently 
hardcoded both at the local and remote end. If we want to support auto-
follow behavior in the new ref mappings (e.g. specified with a "~" prefix: 
"~+refs/tags/*:refs/remotes/$remote/tags/*"), we must change code both on 
the local and remote side. In order to get optimal behavior we will probably 
also need to make some protocol changes.

On the other hand, it is not clear how useful tag auto-following really is. 
Quoting Peff from the earlier thread ( 
http://thread.gmane.org/gmane.comp.version-control.git/160503/focus=160726 
): "Now you could argue that auto-follow is not worth the effort. It is 
somewhat confusing, and I can't think of a time when it ever actually 
reduced the set of objects I was fetching (as opposed to just fetching all 
tags). But maybe others have use cases where it matters."

Or, quoting Junio further down in the thread ( 
http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=166694 
): "Also if you give tags a totally separate namespace, I don't see much 
reason to still give it the "auto-follow" semantics.  It is far simpler to 
explain if you just fetch all of them and be done with it, no?"

So far nobody have stood up to defend the current auto-following behavior as 
a necessary feature.


2. Interpreting/DWIMing refs

Changing the ref mappings require a revised set of rules for interpreting 
shorthand ref names (expanding them into full ref names), and handling 
ambiguities when they arise:

- "foo" should still be usable for "refs/heads/foo", "refs/tags/foo", etc.

- "origin/foo" must continue to work, even if "refs/remotes/origin/foo" has 
now become "refs/remotes/origin/heads/foo". In other words, "foo/bar" where 
"foo" is a valid remote, must try to resolve "bar" against the refspecs 
specified for the "foo" remote.

- For tag name "foo": "refs/tags/foo" (if exists) is unambiguous.

- If "refs/tags/foo" does not exist, tag name "foo" is unambiguous if it 
exists in one or more "refs/remotes/*/tags/foo" and they all point to the 
same SHA1.

- If "refs/tags/foo" does not exist, and more than one 
"refs/remotes/*/tags/foo" exist, and they do NOT all point to the same SHA1, 
then there is an ambiguity.

- The user may resolve the ambiguity by creating "refs/tags/foo" pointing to 
the chosen SHA1 ("refs/tags/foo" takes precedence over 
"refs/remotes/*/tags/foo").

- The same rules apply to heads, notes, etc.

- Extra care must be taken across different "types" of refs, depending on 
the context. I.e. in some situations we might want to prefer 
"refs/remotes/origin/heads/foo" to "refs/remotes/otherremote/tags/foo", or 
the other way around (or flag the ambiguity and abort).


3. Migration path

We need both styles of ref mappings ("traditional", with the implicit and 
auto-following tag refspec, and "new-style", where all refspecs are 
explicit) to work side-by-side in the same repo (i.e. having one remote use 
traditional refspecs, while another uses new-style). At first, we will 
probably still default to the traditional refspecs when creating a new 
remote, but over time we should migrate to new-style refspecs, before 
finally deprecating the traditional refspecs. I'm not sure if traditional 
vs. new-style can be reliably autodetected from the refspecs themselves, or 
if we need an explicit per-remote config variable to discern between the 
two.


I think all of the above problems are solvable.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
