From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/5] Fix 'url.*.insteadOf' for submodule URLs
Date: Mon, 04 Aug 2008 09:52:10 +0200
Message-ID: <200808040952.10472.johan@herland.net>
References: <200808040057.00221.johan@herland.net>
 <200808040147.16797.johan@herland.net>
 <7vwsix5y9w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 10:06:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPv4h-00062j-Ce
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 10:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbYHDIEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 04:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbYHDIEP
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 04:04:15 -0400
Received: from smtp.getmail.no ([84.208.20.33]:56809 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbYHDIEN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 04:04:13 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K5200E35H30PC00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 10:04:12 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5200BSOGIYA530@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 09:52:10 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5200F6BGIYRP20@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 09:52:10 +0200 (CEST)
In-reply-to: <7vwsix5y9w.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91324>

On Monday 04 August 2008, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > 1. Consistency: Other git commands in the supermodule does _not_
> > require the URL rewriting rule to reside in the global config. Why
> > should 'git submodule' be different.
>
> When it comes to "submodules", I do not think such consistency argument
> makes much sense.  "git submodule" command crosses module boundary,
> normal commands don't.  They are naturally different and they should be.
>
> Your kind of consistency means breaking the separation between module
> boundary, doesn't it?

To a certain degree, yes, but (1) only for this specific config rule 
(url.*.insteadOf), and (2) only at the specific point in time when the 
submodule is cloned. This means that after the submodule is cloned, it is 
indeed not affected by the super-repo's config. E.g. you can change the 
origin URL of the submodule back to the original (un-rewritten) URL in the 
submodule's config, and the super-repo will not try to rewrite it at again.

I believe that the module boundary should not be crossed in general. But 
this patch only "crosses" that boundary before it really exists (i.e. 
before the submodule has been cloned into the super-repo). The event of 
introducing a submodule into a super-repo, is AFAICS the _only_ event where 
I would consider to cross the module boundary (and then only for a good 
reason).

> Having said that...
>
> > 2. I believe there are valid use cases for adding URL rewriting rules
> > to the repo config instead of the global config. You may want to check
> > out Fred's version of project X (including submodules), without making
> > your other clones of project X start cloning/fetching from Fred.
>
> I think you are referring to the example given in an earlier thread to
> peek what your neighbor did between you two, without affecting other
> people.

Correct.

> Personally I think it is partly showing the shortcoming of the current
> "git submodule" that minimally supports the workflow to follow what the
> canonical repository does, and partly showing that it is an abuse of that
> interface to rewrite config file to temporarily switch to peek somewhere
> else in such a workflow.

Indeed. However, the development of submodules usability seems so slow that 
even though this use case is an ugly workaround, it's one I thought we'd 
have to live with for some time... [1]

> Let's step back and think what we would do if there is no submodule
> involved.  That is, you usually follow origin, but you temporarily want
> to peek at what Fred did.  How would you do this?
>
> 	$ git fetch $fred $branch_fred_wants_you_to_review
> 	$ git checkout FETCH_HEAD ;# this detaches HEAD.
>
> And you take a look around.  Perhaps you like the change and decide to
> merge that to your branch.  Perhaps you create your own branch on top of
> that state, build a few fix-up commits, and give the result back to Fred.
>
> Shouldn't peeking what Fred did in the whole submodule hierarchy be
> essentially the same thing?  That is,
>
> 	$ git submodule for-each-submodule sh -c '
> 		git fetch "$fred/$1" $branch_fred_wants_you_to_review &&
> 		git checkout FETCH_HEAD
> 	' -
>
> where "for-each-submodule" would iterate over the submodules in the
> current superproject that you are interested in (that is, you actually
> have corresponding repositories there), and runs any given command with
> the path to the submodule in that directory.
>
> Hmm?

Yes, having such functionality in 'git submodule' would be wonderful. 
However, implementations of such functionality have been slow in coming, 
and apparently hard to implement without being workflow-agnostic (if I 
remember correctly).

In light of improvements to 'git submodule', feel free to disregard my patch 
series (although I still find 'git config --rewrite-url' useful for 
dry-testing my 'url.*.insteadOf' rules...).


Thanks for providing constructive feedback.


Have fun!

...Johan


[1]: Maybe 'git submodule' would improve more quickly if we ate our own 
dogfood, i.e. if we included submodules (e.g. gitk and git-gui) in git.git?

-- 
Johan Herland, <johan@herland.net>
www.herland.net
