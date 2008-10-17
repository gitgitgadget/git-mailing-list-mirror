From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: "checkout --track -b" broken? (with suggested fix)
Date: Fri, 17 Oct 2008 11:47:11 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810171113340.19665@iabervon.org>
References: <7vej2fohfr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 17:49:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqrZL-0002cA-NH
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 17:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbYJQPrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 11:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbYJQPrO
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 11:47:14 -0400
Received: from iabervon.org ([66.92.72.58]:56545 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbYJQPrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 11:47:13 -0400
Received: (qmail 890 invoked by uid 1000); 17 Oct 2008 15:47:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Oct 2008 15:47:11 -0000
In-Reply-To: <7vej2fohfr.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98485>

On Thu, 16 Oct 2008, Junio C Hamano wrote:

> Sorry for bringing up a potentially old issue, but I do not think the test
> added by 9ed36cf (branch: optionally setup branch.*.merge from upstream
> local branches, 2008-02-19) is correct.  It does this:
> 
>     test_expect_success \
>         'checkout w/--track from non-branch HEAD fails' '
>         git checkout -b delete-me master &&
>         rm .git/refs/heads/delete-me &&
>         test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
>         test_must_fail git checkout --track -b track'
> 
> It creates branch 'delete-me' at the tip of 'master' to check it out, and
> then it manually deletes the branch.  It expects "checkout --track -b track"
> to fail because the current branch is broken and there is no way to set up
> a tracking information for the new branch.
> 
> But I think this is bogus.  The checkout fails not because of lack of
> trackability (due to broken current _branch_), but because there is no
> current _commit_ to branch from.
>
> 	Jay CC'ed because 9ed36cf is his; Daniel CC'ed as branch.c was
> 	originally his.
>
> Here is an attempt to fix the test, which then revealed that the feature
> the commit introduced is broken in the tip of 'maint'.  Back when 9ed36cf
> was written, test_must_fail was unavailable, and test_expect_failure meant
> something different, so transplanting this on top of that old commit won't
> reveal the breakage, but I strongly suspect that the feature was broken
> from the very beginning.
> 
> The patch to branch.c is a quick fix for this issue.  The resulting code
> passes all the tests, but I am not very proud of hardcoding the "HEAD" in
> the code.  There must be a better way to do this.

I agree with the change to the test. I think it would be better to 
hard-code "refs/heads/" instead of "HEAD", and I feel like we must have a 
"is this ref name a branch?" function, if only because someone could stick 
"refs/tags/foo" in HEAD, and we should still say it's not something you 
could track, despite it being something different from "HEAD".

>  branch.c      |    4 +++-
>  t/t7201-co.sh |   11 +++++------
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git c/branch.c w/branch.c
> index b1e59f2..6a75057 100644
> --- c/branch.c
> +++ w/branch.c
> @@ -129,7 +129,9 @@ void create_branch(const char *head,
>  			die("Cannot setup tracking information; starting point is not a branch.");
>  		break;
>  	case 1:
> -		/* Unique completion -- good */
> +		/* Unique completion -- good, only if it is a real ref */
> +		if (track == BRANCH_TRACK_EXPLICIT && !strcmp(real_ref, "HEAD"))
> +			die("Cannot setup tracking information; starting point is not a branch.");
>  		break;
>  	default:
>  		die("Ambiguous object name: '%s'.", start_name);
> diff --git c/t/t7201-co.sh w/t/t7201-co.sh
> index fbec70d..da1fbf8 100755
> --- c/t/t7201-co.sh
> +++ w/t/t7201-co.sh
> @@ -330,12 +330,11 @@ test_expect_success \
>      test "$(git config branch.track2.merge)"
>      git config branch.autosetupmerge false'
>  
> -test_expect_success \
> -    'checkout w/--track from non-branch HEAD fails' '
> -    git checkout -b delete-me master &&
> -    rm .git/refs/heads/delete-me &&
> -    test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
> -    test_must_fail git checkout --track -b track'
> +test_expect_success 'checkout w/--track from non-branch HEAD fails' '
> +    git checkout master^0 &&
> +    test_must_fail git symbolic-ref HEAD &&
> +    test_must_fail git checkout --track -b track
> +'
>  
>  test_expect_success 'checkout an unmerged path should fail' '
>  	rm -f .git/index &&
> 
