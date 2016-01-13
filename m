From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH v5] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Tue, 12 Jan 2016 21:27:36 -0600
Message-ID: <87y4bunopj.fsf@waller.obbligato.org>
References: <CAPig+cSfkz=SNOn+8yP-QN8gJ0ej1wo3HW+y3NO+QvUCOP=+8A@mail.gmail.com>
	<1449695853-24929-1-git-send-email-davidw@realtimegenomics.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Ware <davidw@realtimegenomics.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 04:28:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJC6i-00059O-LC
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 04:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbcAMD1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 22:27:45 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:58487 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751626AbcAMD1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 22:27:43 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aJC7D-0001hY-Iz; Tue, 12 Jan 2016 21:28:56 -0600
In-Reply-To: <1449695853-24929-1-git-send-email-davidw@realtimegenomics.com>
	(Dave Ware's message of "Thu, 10 Dec 2015 10:17:33 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Dave Ware <davidw@realtimegenomics.com> writes: [ I am sorry
    I took so long to respond. This one slipped by me. Thank you for tracking
    this problem down and fixing it! ] > diff --git a/contrib/subtree/git-subtree.sh
    b/contrib/subtree/git-subtree.sh > index 9f06571..ebf99d9 100755 > --- a/contrib/subtree/git-subtree.sh
    > +++ b/contrib/subtree/git-subtree.sh > @@ -479,8 +479,16 @@ copy_or_skip()
    > p="$p -p $parent" > fi > done > - > - if [ -n "$identical" ]; then > +
   > + copycommit= > + if [ -n "$identical" ] && [ -n "$nonidentical" ]; then
     
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283874>

Dave Ware <davidw@realtimegenomics.com> writes:

[ I am sorry I took so long to respond.  This one slipped by me.  Thank
  you for tracking this problem down and fixing it!  ]

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 9f06571..ebf99d9 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -479,8 +479,16 @@ copy_or_skip()
>  			p="$p -p $parent"
>  		fi
>  	done
> -	
> -	if [ -n "$identical" ]; then
> +
> +	copycommit=
> +	if [ -n "$identical" ] && [ -n "$nonidentical" ]; then
> +		extras=$(git rev-list --count $identical..$nonidentical)
> +		if [ "$extras" -ne 0 ]; then
> +			# we need to preserve history along the other branch
> +			copycommit=1
> +		fi
> +	fi
> +	if [ -n "$identical" ] && [ -z "$copycommit" ]; then
>  		echo $identical
>  	else
>  		copy_commit $rev $tree "$p" || exit $?

I don't see anything objectionable here.  I am just learning the split
code myself.  :)

However, when I apply this against master, the test doesn't actually
pass and a gitk --all shows the merge commit still missing.  At least if
I understand the problem correctly.  Can you verify whether it works for
you?

> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 9051982..4fe4820 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -468,4 +468,56 @@ test_expect_success 'verify one file change per commit' '
>  	))
>  '
>  
> +test_expect_success 'subtree descendant check' '
> +	mkdir git_subtree_split_check &&
> +	(
> +		cd git_subtree_split_check &&
> +		git init &&

This shouldn't be necessary.  If you look at the other tests in
t7900-subtree.sh, they all start with:

  next_test
  test_expect_success '<blah>' '
  subtree_test_create_repo "$subtree_test_count"

The "subtree_test_create_repo" takes care of creating a subdirectory and
initializing a repository.  Perhaps you didn't (or still don't) have the
test script rewrite patch that got merged a month or so ago.  If not,
please update to it and reformulate your test to follow the established
convention.  It helps *a lot* when debugging regressions.

> +		mkdir folder &&
> +
> +		echo a >folder/a &&
> +		git add . &&
> +		git commit -m "first commit" &&

You can use "test_create_commit" to do these "generate commit"
operations.  It's on my TODO list to update the subtree tests to use
more of the standard test infrastructure.  For now, just go ahead and
use what the other tests use.

> +		git branch noop_branch &&
[...]
> +		git checkout noop_branch &&
> +		echo moreText >anotherText.txt &&
> +		git add . &&
> +		git commit -m "irrelevant" &&

This is unfortunate naming.  Why is the branch a no-op and why is the
commit irrelevant?  Does the test test the same thing without them?  I
not they should have different names.  If so, why are these needed in
the test?

> +		git checkout master &&
> +		git merge -m "second merge" noop_branch &&
> +
> +		git subtree split --prefix folder/ --branch subtree_tip master &&
> +		git subtree split --prefix folder/ --branch subtree_branch branch &&
> +		git push . subtree_tip:subtree_branch

I understand the problem was discovered because of an inability to push
and it probably makes sense to test that since that's what exposed the
bug.  However, I wonder if there are some additional checks that should
be done.  What do you expect subtree_tip and subtree_branch to look like
and how do you expect them to relate to each other?  Should
subtree_branch be an ancestor of subtree_tip?  If so we should
explicitly test that.

Again, thanks for your work on this!  I think I actually may have hit
this bug in my own work but I couldn't be sure I hadn't done something
wrong.  The sequence of commands and splits is eerily similar to
something I tried a while back.  I'm *very* glad you were able to track
it down!

                          -David
