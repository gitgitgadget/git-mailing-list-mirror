From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/2] rebase: omit patch-identical commits with
 --fork-point
Date: Wed, 16 Jul 2014 22:27:55 +0100
Message-ID: <20140716212755.GD2322@serenity.lan>
References: <xmqqmwcatgza.fsf@gitster.dls.corp.google.com>
 <47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405538598.git.john@keeping.me.uk>
 <374b26180807c67f7bd152ce5a2f52e34397e3a6.1405538598.git.john@keeping.me.uk>
 <xmqqa989rqx3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ted Felix <ted@tedfelix.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:38:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Wtj-00046l-Px
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 23:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbaGPVh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 17:37:56 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:58118 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbaGPVhw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 17:37:52 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jul 2014 17:37:52 EDT
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E43B5606538;
	Wed, 16 Jul 2014 22:28:02 +0100 (BST)
X-Quarantine-ID: <iq3VD1E5AdCH>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iq3VD1E5AdCH; Wed, 16 Jul 2014 22:28:02 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id D15246064A5;
	Wed, 16 Jul 2014 22:27:57 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqa989rqx3.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253691>

On Wed, Jul 16, 2014 at 01:26:32PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > When the `--fork-point` argument was added to `git rebase`, we changed
> > the value of $upstream to be the fork point instead of the point from
> > which we want to rebase.  When $orig_head..$upstream is empty this does
> > not change the behaviour, but when there are new changes in the upstream
> > we are no longer checking if any of them are patch-identical with
> > changes in $upstream..$orig_head.
> >
> > Fix this by introducing a new variable to hold the fork point and using
> > this to restrict the range as an extra (negative) revision argument so
> > that the set of desired revisions becomes (in fork-point mode):
> >
> > 	git rev-list --cherry-pick --right-only \
> > 		$upstream...$orig_head ^$fork_point
> >
> > This allows us to correctly handle the scenario where we have the
> > following topology:
> >
> > 	    C --- D --- E  <- dev
> > 	   /
> > 	  B  <- master@{1}
> > 	 /
> > 	o --- B' --- C* --- D*  <- master
> >
> > where:
> > - B' is a fixed-up version of B that is not patch-identical with B;
> > - C* and D* are patch-identical to C and D respectively and conflict
> >   textually if applied in the wrong order;
> > - E depends textually on D.
> >
> > The correct result of `git rebase master dev` is that B is identified as
> > the fork-point of dev and master, so that C, D, E are the commits that
> > need to be replayed onto master; but C and D are patch-identical with C*
> > and D* and so can be dropped, so that the end result is:
> >
> > 	o --- B' --- C* --- D* --- E  <- dev
> >
> > If the fork-point is not identified, then picking B onto a branch
> > containing B' results in a conflict and if the patch-identical commits
> > are not correctly identified then picking C onto a branch containing D
> > (or equivalently D*) results in a conflict.
> >
> > This change allows us to handle both of these cases, where previously we
> > either identified the fork-point (with `--fork-point`) but not the
> > patch-identical commits *or* (with `--no-fork-point`) identified the
> > patch-identical commits but not the fact that master had been rewritten.
> >
> > Reported-by: Ted Felix <ted@tedfelix.com>
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >
> > Change from v1:
> >     - add a test case
> 
> > diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> > index 80e0a95..47b5682 100755
> > --- a/t/t3400-rebase.sh
> > +++ b/t/t3400-rebase.sh
> > @@ -169,6 +169,29 @@ test_expect_success 'default to common base in @{upstream}s reflog if no upstrea
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'cherry-picked commits and fork-point work together' '
> > +	git checkout default-base &&
> > +	echo Amended >A &&
> > +	git commit -a --no-edit --amend &&
> > +	test_commit B B &&
> > +	test_commit new_B B "New B" &&
> > +	test_commit C C &&
> > +	git checkout default &&
> > +	git reset --hard default-base@{4} &&
> > +	test_commit D D &&
> > +	git cherry-pick -2 default-base^ &&
> > +	test_commit final_B B "Final B" &&
> > +	git rebase &&
> 
> mental note: this rebases default (i.e. the current branch) on
> default-base; it depends on branch.default.{remote,merge} being set
> by the previous test piece.
> 
> > +	echo Amended >expect &&
> > +	test_cmp A expect &&
> > +	echo "Final B" >expect &&
> > +	test_cmp B expect &&
> > +	echo C >expect &&
> > +	test_cmp C expect &&
> > +	echo D >expect &&
> > +	test_cmp D expect
> > +'
> 
> Thanks.  Do these labels on the commits have any relation to the
> topology illustrated in the log message?

No, I didn't consider the log message when adding the test; it simply
uses the next letters that are unused in the test repository.

> It looks like the above produces this:
> 
>       a'---D---B'--new_B'---final_B (default)
>      /
>     o----a---B---new_B---C (default-base)
>                           \
>                            D''---final_B''
> 
> where 'a' is "Modify A." from the original set-up and B and new_B
> are the cherry-picks to be filtered out during the rebase.  Am I
> reading the test correctly?

Yes, that's right.  The idea is to make sure that we skip the
cherry-picked commits, which requires two commits that will conflict if
we try to apply the first on top of the second and to make sure that we
don't lose the new commit on the upstream (C).

> >  test_expect_success 'rebase -q is quiet' '
> >  	git checkout -b quiet topic &&
> >  	git rebase -q master >output.out 2>&1 &&
