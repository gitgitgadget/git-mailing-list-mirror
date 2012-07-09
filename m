From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] test: git-stash conflict sets up rerere
Date: Sun, 08 Jul 2012 19:37:32 -0700
Message-ID: <7v8vetmzgz.fsf@alter.siamese.dyndns.org>
References: <CABURp0oXhZ5ysm4b3Z=7o+2TB+3wFdMjj4oEwxafApjD4c7ozA@mail.gmail.com>
 <1341693962-17090-1-git-send-email-hordp@cisco.com>
 <1341693962-17090-2-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 04:37:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So3r3-0005Vu-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 04:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab2GIChg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 22:37:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab2GIChf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 22:37:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8BE190FC;
	Sun,  8 Jul 2012 22:37:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6UfkCWMqeohni80e9rhzstlvblY=; b=Js0eDH
	eGwK9D40EjA1WPiel9w7LtoQ8N5yxlMm1ZSTri0ewQx34kEaTgh47+6AFR7Is7LR
	j/Xr5BJmr/pGlaSRGaiYw4uVsfYXlviTTqanqaa2ME5qTtz9oRRNoYtvGdtkTLvr
	ggQsIiYRQUodGkFBQzo9PE1Apst86YdQWrLQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gh7vHeroUM88jbaOfYn3ygl3Sp3fTeyr
	0iTSAEfDQ+hNHzbhFZKPdsn1Sl3yGkK+PcXLD208E9VC+y38mozvP+6kfr9vFOwr
	ycvvJFO4FryiFl1Pa5JZr1uUbtRS5zKfIZan5TC6f6OHJ1ADNDlbIouDk1B8HgTg
	JcN5A+ed+bA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF1F390FB;
	Sun,  8 Jul 2012 22:37:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 135E290F8; Sun,  8 Jul 2012
 22:37:33 -0400 (EDT)
In-Reply-To: <1341693962-17090-2-git-send-email-hordp@cisco.com> (Phil Hord's
 message of "Sat, 7 Jul 2012 16:46:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09CE6308-C96F-11E1-923C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201190>

Phil Hord <hordp@cisco.com> writes:

> Add a failing test to confirm a conflicted stash apply invokes
> rerere to record the conflicts and resolve the the files it can.

OK.

> In this failing state, mergetool may be confused by a left-over
> state from previous rerere activity.

It is unclear to me what relevance this has to this patch.  Does it
have this sequence:

    "previous rerere activity" (whatever that is)
    test_must_fail git stash apply &&
    git mergetool

and demonstrate that "git mergetool" fails because there is a wrong
rerere state in the repository after "git stash apply" returns?

Or perhaps you are relying on the state that is left by the previous
test piece?

> Also, the next test expected us to finish up with a reset, which
> is impossible to do if we fail (as we must) and it's an
> unreasonable expectation anyway.  Begin the next test with a reset
> of his own instead.

Yes, it is always a good discipline to start a new test piece from a
known state.

> @@ -193,7 +203,37 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
>      git reset --hard
>  '
>  
> +test_expect_failure 'conflicted stash sets up rerere'  '
> +    git config rerere.enabled true &&
> +    git checkout stash1 &&
> +    echo "Conflicting stash content" >file11 &&
> +    git stash &&
> +    
> +    git checkout --detach stash2 &&
> +    test_must_fail git stash apply &&
> +    
> +    test -e .git/MERGE_RR &&
> +    test -n "$(git ls-files -u)" &&
> +    conflicts="$(git rerere remaining)" &&

Checking that the index is conflicted with "ls-files -u" and asking
the public API "git rerere remaining" to see what paths rerere
thinks it did not touch, like you do in the second and third lines,
are very sensible, but it is probably not a good idea for this test
to check implementation details with "test -f .git/MERGE_RR".

> +    test "$conflicts" = "file11" &&
> +    output="$(git mergetool --no-prompt)" &&
> +    test "$output" != "No files need merging" &&
> +
> +    git commit -am "save the stash resolution" &&
> +
> +    git reset --hard stash2 &&
> +    test_must_fail git stash apply &&
> +
> +    test -e .git/MERGE_RR &&
> +    test -n "$(git ls-files -u)" &&
> +    conflicts="$(git rerere remaining)" &&

Likewise.

> +    test -z "$conflicts" &&
> +    output="$(git mergetool --no-prompt)" &&
> +    test "$output" = "No files need merging"
> +'
> +
>  test_expect_success 'mergetool takes partial path' '
> +    git reset --hard
>      git config rerere.enabled false &&
>      git checkout -b test12 branch1 &&
>      git submodule update -N &&
