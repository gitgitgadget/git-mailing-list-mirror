From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Is there a way to add a default `--squash` flag for all merges
 into a head?
Date: Wed, 9 Mar 2011 12:11:54 -0800 (PST)
Message-ID: <cb5f3a7a-cc84-4ec9-8d08-87436f8af044@k15g2000prk.googlegroups.com>
References: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
 <m2r5aibpsl.fsf@igel.home> <b98e837f-a0ae-4061-aa09-b4d30e3b0522@b13g2000prf.googlegroups.com>
 <7vr5ahe7jc.fsf@alter.siamese.dyndns.org> <5aad866e-38e6-4f0e-a942-97cc174651bb@o14g2000prb.googlegroups.com>
 <7v7hc8aybn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 21:12:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxPjk-0000LW-HU
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 21:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab1CIULz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 15:11:55 -0500
Received: from mail-px0-f184.google.com ([209.85.212.184]:57590 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab1CIULz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 15:11:55 -0500
X-Greylist: delayed 166370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Mar 2011 15:11:55 EST
Received: by pxi4 with SMTP id 4so126975pxi.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 12:11:54 -0800 (PST)
Received: by 10.142.231.3 with SMTP id d3mr509355wfh.39.1299701514586; Wed, 09
 Mar 2011 12:11:54 -0800 (PST)
Received: by k15g2000prk.googlegroups.com with HTTP; Wed, 9 Mar 2011 12:11:54
 -0800 (PST)
In-Reply-To: <7v7hc8aybn.fsf@alter.siamese.dyndns.org>
X-IP: 66.250.141.150
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US;
 rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168752>

On Mar 9, 1:27 pm, Junio C Hamano <gits...@pobox.com> wrote:
> Dun Peal <dunpea...@gmail.com> writes:
> That does not sound like a real world to me, though. When a fix or tweak
> is needed for codepaths introduced by these feature branches after they
> are merged to master, the cleanest thing to do is to queue the fix on top
> of the branch that needs that fix or tweak, and merge that to master.
>
> Of course, you can choose to abandon these feature branches that are
> potentially buggy and fork a fix branch from the master branch that was
> current when the bug happened to be discovered. But that would make the
> backporting bugfixes (or feature tweaks for that matter) to anything older
> a lot harder.

That's a good point if feature branches may eventually get merged into
other branches, e.g. release branches. Our case is simpler: a feature
branch that branched off master will only get merged back to master,
usually in one merge action that ends the branch. Therefore any future
fixes or updates to content that got merged like that can properly be
committed directly to master.

Of course, if we did need to merge the feature independently into
other branches, the squashed branch and any future updates to it would
have to be manually cherry-picked - an error prone process that
forgoes many amenities that Git offers for this procedure. However,
since we do not have such a need, might as well optimize for commit
graph simplicity.

We probably could find ways to deal with a ~50-level-deep commit graph
(composed of 1 master and ~49 feature branches), but if we can instead
deal with a single-level-deep one (or 2-3 levels when we introduce a
couple of long-running branches), why shouldn't we?

> > Why would John care that while implementing feature X, Jill committed
> > her half-state Y so she can go home, or made and fixed typo Z? In
> > fact, why would Jill care a day, let a lone a couple of months, after
> > X was completed and merged to master?
>
> Who is merging half-state to 'master' or merging 'master' back to the
> feature branches?  I don't think any of the above relates to the topic of
> 'merge --squash' anyway...

If Jill merged her branch X back to master with no squashing, half-
state Y which got committed in X gets merged to master as well.

Half-states like Y get committed to feature branches all the time,
since those branches are private, never get deployed in production or
even built by the continuous integration server; the feature branch is
all about developer convenience, and we're only strict about what he
merges back into master.

Of course, Jill can selectively squash with `rebase -i` X to a more
presentable form before merging it back to master. But if she's
already squashing, why not use the ultimate, simplest squash offered
by `rebase --squash`, as it happens to perfectly fit the purpose of
our short-term feature branches?

D.
