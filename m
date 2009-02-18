From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Is there a way to exclude user-specified files or directories
 from  participating in merges?
Date: Wed, 18 Feb 2009 13:33:45 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngpo3hp.boq.sitaramc@sitaramc.homelinux.net>
References: <e38bce640902171649g765275a4n4e86d1d4f4aaf394@mail.gmail.com>
 <7v1vtw367w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 14:35:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmaM-0005Nx-MM
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbZBRNeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbZBRNeF
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:34:05 -0500
Received: from main.gmane.org ([80.91.229.2]:37942 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbZBRNeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:34:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LZmYn-00027k-I4
	for git@vger.kernel.org; Wed, 18 Feb 2009 13:33:57 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 13:33:57 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 13:33:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110538>

On 2009-02-18, Junio C Hamano <gitster@pobox.com> wrote:
> And stick to the following two rules:
>
>  - You make edits to common files only on the common branch.
>  - You merge from common to deployment, never the other way.
>
> So at work, you would have a checkout of your work "deployment branch",
> and find needs to change things.  It is Ok to edit both work.sh and
> generic.sh (without being able to edit both, it would be hard to verify if
> the changes would work together) at this time, but don't commit the result
> in the work branch.
>
> Save the changes to work.sh away (e.g. "git diff work.sh >P.diff" and then
> "git checkout HEAD work.sh"), switch to the common branch, and commit the
> changes to the generic file.  Switch back to the deployment branch, merge
> the common branch (to pick up the changes to home.sh), reapply the changes
> specific to the deployment you saved earlier (e.g. "git apply P.diff"),
> tne commit the result.

[I did read your followup also; my question applies to both
versions of the technique]

Let me explain where I'm coming from: this is very often
needed when you maintain customer specific branches, and the
workflows in both your posts in this thread so far are too
complex for, err, me <sheepish grin> :-)

Would it not be easier to do something like this?  (I suck
at 2-d drawing, even line... but this should still be
understandable)

(W = work, T = temporary, C = common)

  - make granular commits and test etc, from W to T

        O---a---b+1---c---2---d---3
        W is pointing at commit O
        T is pointing at commit 3
        b+1 is a commit that contains both types of changes

  - use rebase -i (including split commits if needed, as
    described in 'git help rebase') to put all the changes
    that go to master before the ones that only go to work.

        O---a---b---c---d---1---2---3

  - (retest if needed)

  - cherry pick the first set of changes to common (in this
    example, a, b, c, d will become a', etc on common)

  - merge from common to work (x, y, etc are some other
    changes that went into common since the last time you
    merged)

        O---x---y---a'---b'---c'---d'
        W is now pointing at d'

  - cherry pick the stuff that remains

        O---x---y---a'---b'---c'---d'---1'---2'---3'
        W is now pointing at 3'
