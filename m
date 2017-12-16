Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7691F406
	for <e@80x24.org>; Sat, 16 Dec 2017 18:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757206AbdLPSda (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 13:33:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52838 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757203AbdLPSd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 13:33:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80549C94AC;
        Sat, 16 Dec 2017 13:33:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=AiGPNgedw0N+SFUAeg+NSWNX+X4=; b=XJ3X65HuxkPkgGTf/l4V
        x6K+oqGW/3W6kct1XfshnN4XVjD9mjw9yggxODCC/OoBHPwPM5WSVEEX/fDitXem
        LAUwZ1HH8Fct+CCWd6++9EGKu1loAhVNJsu6or3sv41ENayNLVtCwIfcChTHsDPP
        uQPS+OaYSEHLWLbZ8ITy7KM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=YR5vxNdTKAvN1POYLnW9eQPYvZKSXE+xRg9akPAv8jHPMx
        EdOg5uPsUlJwGNZSovBFniFcyzOIrkZ/ERqo+swsRD+mxZT4LvZruriA3NrFgJ1u
        EJoWS2YD+qVevfoBgOVvwSMKyfyzJesIU8UyHHri8SWJ6pk9G0v1OsG4dvWPo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75F96C94AB;
        Sat, 16 Dec 2017 13:33:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E606BC94AA;
        Sat, 16 Dec 2017 13:33:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Reid Price <reid.price@gmail.com>, git@vger.kernel.org
Subject: Re: Apparent bug in 'git stash push <subdir>' loses untracked files
References: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
        <20171213230547.GC24597@hank>
Date:   Sat, 16 Dec 2017 10:33:21 -0800
Message-ID: <xmqq4loqplou.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98C89F94-E28F-11E7-81A6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Maybe the best solution would be to introduce 'git reset --hard --
> <pathspec>', or maybe someone who knows shell programming a little
> better than me has an idea? 
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 1114005ce2..01bf74015e 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -322,10 +322,15 @@ push_stash () {
>  
>                 if test $# != 0
>                 then
> +                       git ls-files -z >"$(git rev-parse --git-dir)"/stash-to-remove
>                         git reset -q -- "$@"
>                         git ls-files -z --modified -- "$@" |
>                         git checkout-index -z --force --stdin
> -                       git clean --force -q -d -- "$@"
> +                       while read -r -d '' to_delete
> +                       do
> +                               git clean --force -q -d -- "$to_delete"
> +                       done <"$(git rev-parse --git-dir)"/stash-to-remove
> +                       rm "$(git rev-parse --git-dir)"/stash-to-remove
>                 else
>                         git reset --hard -q
>                 fi

Hmph.  I personally did not care (nor use) pathspec limited stash
creation, so I admit that I do not offhand know what this code
(before or after the above fix) is trying to do, even though it has
been in our tree for some time X-<.  But judging from the fact that
the other side is a mere "git reset --hard" (for the whole tree), I
guess for each and every path in the index and/or in the HEAD that
match pathspec "$@", you are trying to

 - remove it from the index if it is not in HEAD;

 - add it to the index if it is not in the index but is in HEAD; or

 - reset the index to the version in HEAD if it is in the index.

and then match the working tree version to that of the index?

I am not convinced that "git reset --hard -- <pathspec>" is a good
UI [*1*] but I agree that a low level facility that does these would
be quite helpful to implement the then-clause of the above.

But I suspect that you do not have to do shell "logic" nor low-level
plumbing update in this case.  Would the attached work?

[Footnote]

*1* Primarily because "git reset [<tree-ish>] -- <pathspec>" that
    already exists is not a good UI.  The remainder of "git reset"
    is about repointing the HEAD, and the various operation modes
    are there to adjust the index and the working tree to the
    updated HEAD depending on why the user wants to repoint the HEAD
    in the first place.  On the other hand, the pathspec limited
    "reset" is all about affecting the index without moving the HEAD
    and operation modes, if --hard is also taught not to reject
    pathspec, will become "do we do index-only or do we do both?"

    But updating the index and the working tree is what "git
    checkout [<tree-ish>] -- <pathspec>" is for, and the "git reset
    [<tree-ish>] -- <pathspec>" should have been "checkout --cached
    [<tree-ish>] -- <pathspec>" (and the "reset --hard" equivalent
    should be the "default" for checkout).

    There is a small glitch in the current behaviour of "checkout --
    <pathspec>" to complicate the above vision, but assuming that it
    is surmountable, and if we were going to update the UI for
    consistency along the above line, then I do not mind making "git
    checkout" solely for "checking out paths" and adding a different
    subcommannd to "checking out a branch to work on".

    "reset.<commit>" is about resetting the HEAD and "reset
    [<tree-ish>] -- <pathspec>" is about resetting the index, which
    is the same duality some people complain about "git checkout"
    that is both about checking out the paths and checking out a
    branch to work on.  Adding more mode(s) to "git reset" that
    makes the command not about repointing the HEAD is piling more
    on top.

    The "small glitch" is that "checkout <tree-ish> -- <pathspec>"
    is defined as an overlay operation---take the current index (and
    the working tree), then for each (path, contents) in <tree-ish>
    that match the <pathspec>, add it in if path does not exist in
    the current index, or replace if path does.  If we have a path
    in the index that match <pathspec>, and that path does not exist
    in <tree-ish>, "checkout <tree-ish> -- <pathspec>" does not
    remove that path from the index.

    So even the index+working tree mode (which is how "reset --hard"
    would want to work) may need to take a new option.  Between two
    modes of "checkout <tree-ish> -- <pathspec>" that allows
    deletion, "--index" would be the one that works on both the
    index and the working tree, and "--cached" would be the one that
    works only on the index (this follows gitcli convention that is
    used by existing commands), and the current "overlay" mode will
    stay to be the default, at least until we know that the "--index"
    mode should become the default and decide to transition.




---

 git-stash.sh     |  5 ++---
 t/t3903-stash.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1114005ce2..a979bfb665 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -322,10 +322,9 @@ push_stash () {
 
 		if test $# != 0
 		then
-			git reset -q -- "$@"
-			git ls-files -z --modified -- "$@" |
+			git ls-files -z -- "$@" |
 			git checkout-index -z --force --stdin
-			git clean --force -q -d -- "$@"
+			git diff-index -p HEAD -- "$@" | git apply --index -R
 		else
 			git reset --hard -q
 		fi
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 39c7f2ebd7..6952a031b2 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1064,4 +1064,20 @@ test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
 	test foo,bar = $(cat foo),$(cat bar)
 '
 
+test_expect_success 'stash -- <subdir> leaves untracked files in subdir intact' '
+	git reset &&
+	>subdir/untracked &&
+	>subdir/tracked1 &&
+	>subdir/tracked2 &&
+	git add subdir/tracked* &&
+	git stash -- subdir/ &&
+	test_path_is_missing subdir/tracked1 &&
+	test_path_is_missing subdir/tracked2 &&
+	test_path_is_file subdir/untracked &&
+	git stash pop &&
+	test_path_is_file subdir/tracked1 &&
+	test_path_is_file subdir/tracked2 &&
+	test_path_is_file subdir/untracked
+'
+
 test_done
