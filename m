From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] add t3420-rebase-topology
Date: Tue, 18 Sep 2012 09:53:23 +0200
Message-ID: <50582873.603@viscovery.net>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:53:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDscn-00081B-12
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 09:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547Ab2IRHxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 03:53:32 -0400
Received: from lilzmailso03.liwest.at ([212.33.55.24]:2881 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932098Ab2IRHxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 03:53:30 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TDscW-00038R-Ns; Tue, 18 Sep 2012 09:53:25 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4977C1660F;
	Tue, 18 Sep 2012 09:53:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205806>

Am 9/18/2012 8:31, schrieb Martin von Zweigbergk:
> Add more test cases to check that the topology after a rebase is as
> expected. Conflicts are not considered, but patch-equivalence is.
> ---
> 
> Tests pass and fail as indicated by the suffix
> (_success/_failure). Your input especially appreciated on whether you
> agree with the intent of the test cases. For example, do you agree
> that 'rebase --onto does not re-apply patches in onto' is desirable?
> And if you do, then do you also agree that 'rebase --root --onto
> ignores patch in onto' is desirable? How about 'rebase --root is not a
> no-op'? One might think that --force would be necessary, but on the
> other hand, if that was the case, the only point (AFAICT) of "git
> rebase --root <branch>" without --force would be to linearize history,
> so I instead made the test case confirm that --root without --onto
> effectively behaves as if --force was also passed.
> 
> Feedback on the structure/setup and style is of course also
> appreciated.
> 
>  t/t3420-rebase-topology.sh | 348 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 348 insertions(+)
>  create mode 100755 t/t3420-rebase-topology.sh
> 
> diff --git a/t/t3420-rebase-topology.sh b/t/t3420-rebase-topology.sh
> new file mode 100755
> index 0000000..024a2b4
> --- /dev/null
> +++ b/t/t3420-rebase-topology.sh
> @@ -0,0 +1,348 @@
> +#!/bin/sh
> +
> +test_description='effect of rebase on topology'
> +. ./test-lib.sh
> +
> +
> +#       q---C---r
> +#      /
> +# a---b---c---d!--e---p
> +#      \
> +#       f---g!--h
> +#        \
> +#         j-------E---k
> +#          \       \
> +#           n---H---w
> +#
> +# x---y---B
> +#
> +#
> +# ! = empty
> +# uppercase = cherry-picked
> +# p = reverted e
> +#
> +# TODO:
> +# prune graph to what's needed
> +
> +empty () {

Is it "is_empty" or "make_empty"/"empty_commit"?

> +	git commit --allow-empty -m $1 &&
> +	git tag $1
> +}

Obviously the latter.

> +
> +cherry_pick () {
> +	git cherry-pick -n $1 &&
> +	git commit -m $2 &&
> +	git tag $2
> +}
> +
> +revert () {
> +	git revert -n $1 &&
> +	git commit -m $2 &&
> +	git tag $2
> +}
> +
> +
> +test_expect_success 'setup' '
> +	test_commit a &&
> +	test_commit b &&
> +	test_commit c &&
> +	empty d &&
> +	test_commit e &&
> +	revert e p &&
> +	git checkout b &&
> +	test_commit f &&
> +	empty g &&
> +	test_commit h &&
> +	git checkout f &&
> +	test_commit j &&
> +	cherry_pick e E &&
> +	test_commit k &&
> +	git checkout j &&
> +	test_commit n &&
> +	cherry_pick h H &&
> +	git merge -m w E &&
> +	git tag w &&
> +	git checkout b &&
> +	test_commit q &&
> +	cherry_pick c C &&
> +	test_commit r &&
> +	git checkout --orphan disjoint &&
> +	git rm -rf . &&
> +	test_commit x &&
> +	test_commit y &&
> +	cherry_pick b B
> +'
> +
> +reset () {
> +	git rebase --abort
> +	git reset --hard
> +}

The 'rebase --abort' can fail, but there is no && chain. Good. Using this
function instead of the individual commands in the tests does not break
the && chain there. Good.

These following three functions should be and can be consistent with the
order of their arguments: expected actual.

> +test_range () {
> +	test "$(git log --reverse --topo-order --format=%s "$1" | xargs)" = "$2"

	expected=$1
	set -- $(git log --reverse --topo-order --format=%s "$2")
	test "expected" = "$*"

> +}
> +
> +test_revisions () {
> +	expected="$1"
> +	shift
> +	test "$(git log --format=%s --no-walk=unsorted "$@" | xargs)" = "$expected"

	set -- $(git log --format=%s --no-walk=unsorted "$@")
	test "expected" = "$*"

> +}
> +
> +same_revision () {
> +	test "$(git rev-parse $1)" = "$(git rev-parse $2)"
> +}

'test_same_revision'?

> +
> +# the following 5 (?) tests copy t3400 tests, but check the history rather than status code and/or stdout
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' c j &&
> +	same_revision HEAD~2 c &&
> +	test_range c.. "f j"
> +'
> +}
> +test_expect_success 'simple rebase' "$(run)"
> +test_expect_success 'simple rebase -m' "$(run -m)"
> +test_expect_success 'simple rebase -i' "$(run -i)"
> +test_expect_success 'simple rebase -p' "$(run -p)"

Since here and in the following tests the test cases and test descriptions
vary in the same way, wouldn't it make sense to factor the description out
as well?

test_run_rebase () {
	test_expect_success "simple rebase $*" "
		reset &&
		git rebase $* c j &&
		same_revision HEAD~2 c &&
		test_range c.. 'f j'
	"
}

test_run_rebase ''
test_run_rebase -m
test_run_rebase -i
test_run_rebase -p

(Watch your quoting, though.)

Oh, I see: some tests expect failure. How about:

test_run_rebase () {
	result=$1
	shift
	test_expect_$result "simple rebase $*" "..."
}
test_run_rebase success ''
etc.

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' b j &&
> +	same_revision HEAD j
> +'
> +}
> +test_expect_success 'rebase is no-op if upstream is an ancestor' "$(run)"
> +test_expect_success 'rebase -m is no-op if upstream is an ancestor' "$(run -m)"
> +test_expect_success 'rebase -i is no-op if upstream is an ancestor' "$(run -i)"
> +test_expect_success 'rebase -p is no-op if upstream is an ancestor' "$(run -p)"

OK.

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' --force b j &&
> +	! same_revision HEAD j &&
> +	test_range b.. "f j"
> +'
> +}
> +test_expect_success 'rebase --force' "$(run)"
> +test_expect_success 'rebase -m --force' "$(run -m)"
> +test_expect_success 'rebase -i --force' "$(run -i)"
> +test_expect_failure 'rebase -p --force' "$(run -p)"

Do you mean "rebase --force rewrites even if upstream is an ancestor"?
That would make sense.

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' j b &&
> +	same_revision HEAD j
> +'
> +}
> +test_expect_success 'rebase fast-forwards if an ancestor of upstream' "$(run)"
> +test_expect_success 'rebase -m fast-forwards if an ancestor of upstream' "$(run -m)"
> +test_expect_success 'rebase -i fast-forwards if an ancestor of upstream' "$(run -i)"
> +test_expect_success 'rebase -p fast-forwards if an ancestor of upstream' "$(run -p)"

OK.

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' p k &&
> +	test_range p.. "f j k"
> +'
> +}
> +test_expect_success 'rebase ignores patch in upstream' "$(run)"
> +test_expect_failure 'rebase -m ignores patch in upstream' "$(run -m)"
> +test_expect_success 'rebase -i ignores patch in upstream' "$(run -i)"
> +test_expect_success 'rebase -p ignores patch in upstream' "$(run -p)"

"drops" instead of "ignores"? OK.

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' c h &&
> +	test_range c.. "f h"
> +'
> +}
> +test_expect_success 'rebase ignores empty commit' "$(run)"
> +test_expect_success 'rebase -m ignores empty commit' "$(run -m)"
> +test_expect_success 'rebase -i ignores empty commit' "$(run -i)"
> +test_expect_success 'rebase -p ignores empty commit' "$(run -p)"

"drops" instead of "ignores"? OK.

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' --keep-empty c h &&
> +	test_range c.. "f g h"
> +'
> +}
> +test_expect_success 'rebase --keep-empty' "$(run)"
> +test_expect_failure 'rebase -m --keep-empty' "$(run -m)"
> +test_expect_success 'rebase -i --keep-empty' "$(run -i)"
> +test_expect_failure 'rebase -p --keep-empty' "$(run -p)"

OK.

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' --keep-empty p h &&
> +	test_range p.. "f g h"
> +'
> +}
> +test_expect_success 'rebase --keep-empty keeps empty even if already in upstream' "$(run)"
> +test_expect_failure 'rebase -m --keep-empty keeps empty even if already in upstream' "$(run -m)"
> +test_expect_failure 'rebase -i --keep-empty keeps empty even if already in upstream' "$(run -i)"
> +test_expect_failure 'rebase -p --keep-empty keeps empty even if already in upstream' "$(run -p)"

"is in upstream" is decided by the patch text. If an empty commit is
already in upstream, this adds another one with the same or a different
commit message and authorship information. Dubious, but since it is
opt-in, it should be OK.

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' E w &&
> +	test_range E.. "n H"
> +'
> +}
> +test_expect_success 'rebase after merge' "$(run)"
> +test_expect_success 'rebase -m after merge' "$(run -m)"
> +test_expect_success 'rebase -i after merge' "$(run -i)"

OK.

> +
> +test_expect_success 'rebase -p is no-op in history with merges' '
> +	reset &&
> +	git rebase -p j w &&
> +	same_revision HEAD w
> +'
> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' j w &&
> +	test_range j.. "E n H" || test_range j.. "n H E"
> +'

Chaining tests with || is dangerous: you do not know whether the first
failed because the condition is not satisfied or because of some other
failure.

Why is this needed in the first place? Shouldn't the history be
deterministic, provided that the commit timestamps are all distinct?

> +}
> +test_expect_success 'rebase of history with merges is linearized' "$(run)"
> +test_expect_success 'rebase -m of history with merges is linearized' "$(run -m)"
> +test_expect_success 'rebase -i of history with merges is linearized' "$(run -i)"

OK.

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' --onto p h k &&
> +	test_range p.. "j k"
> +'
> +}
> +test_expect_failure 'rebase --onto does not re-apply patches in onto' "$(run)"
> +test_expect_failure 'rebase -m --onto does not re-apply patches in onto' "$(run -m)"
> +test_expect_failure 'rebase -i --onto does not re-apply patches in onto' "$(run -i)"
> +test_expect_failure 'rebase -p --onto does not re-apply patches in onto' "$(run -p)"

Makes sense.

> +
> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' --onto f d r &&
> +	test_range f.. "q C r"
> +'
> +}
> +test_expect_failure 'rebase --onto does not lose patches in upstream' "$(run)"
> +test_expect_success 'rebase -m --onto does not lose patches in upstream' "$(run -m)"
> +test_expect_failure 'rebase -i --onto does not lose patches in upstream' "$(run -i)"
> +test_expect_failure 'rebase -p --onto does not lose patches in upstream' "$(run -p)"

Makes sense.

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' --root c &&
> +	! same_revision HEAD c &&
> +	test_range c "a b c"
> +'
> +}
> +test_expect_success 'rebase --root is not a no-op' "$(run)"
> +test_expect_success 'rebase -m --root is not a no-op' "$(run -m)"
> +test_expect_success 'rebase -i --root is not a no-op' "$(run -i)"
> +test_expect_success 'rebase -p --root is not a no-op' "$(run -p)"

Why? Is it more like "--root implies --force"?

> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' --root --onto e y &&
> +	test_range e.. "x y"
> +'
> +}
> +test_expect_success 'rebase --root --onto' "$(run)"
> +test_expect_failure 'rebase -m --root --onto' "$(run -m)"
> +test_expect_success 'rebase -i --root --onto' "$(run -i)"
> +test_expect_success 'rebase -p --root --onto' "$(run -p)"

Where does this rebase start? Ah, --root stands in for the "upstream"
argument, hence, y is the tip to rebase. Right? Then it makes sense.

> +
> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' --root --onto e B &&
> +	test_range e.. "x y"
> +'
> +}
> +test_expect_success 'rebase --root --onto ignores patch in onto' "$(run)"
> +test_expect_failure 'rebase -m --root --onto ignores patch in onto' "$(run -m)"
> +test_expect_success 'rebase -i --root --onto ignores patch in onto' "$(run -i)"
> +test_expect_success 'rebase -p --root --onto ignores patch in onto' "$(run -p)"

Makes sense.

> +
> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' e y &&
> +	test_range e.. "x y"
> +'
> +}
> +test_expect_success 'rebase without --root works on disjoint history' "$(run)"
> +test_expect_failure 'rebase -m without --root works on disjoint history' "$(run -m)"
> +test_expect_success 'rebase -i without --root works on disjoint history' "$(run -i)"
> +test_expect_failure 'rebase -p without --root works on disjoint history' "$(run -p)"

OK.

> +
> +
> +run () {
> +echo '
> +	reset &&
> +	git rebase '"$@"' --root --onto p k &&
> +	test_range p.. "f j k"
> +'
> +}
> +test_expect_success 'rebase --root --onto with merge-base ignores --root' "$(run)"
> +test_expect_failure 'rebase -m --root --onto with merge-base ignores --root' "$(run -m)"
> +test_expect_success 'rebase -i --root --onto with merge-base ignores --root' "$(run -i)"
> +test_expect_success 'rebase -p --root --onto with merge-base ignores --root' "$(run -p)"

Makes sense.

> +
> +test_expect_success 'rebase -p re-creates merge from upstream' '
> +	reset &&
> +	git rebase -p k w &&
> +	same_revision HEAD^ H &&
> +	same_revision HEAD^2 k
> +'

IMO, this tests the wrong thing. You have this history:

 ---j-------E---k
     \       \
      n---H---w

where E is the second parent of w. What does it mean to rebase w onto k?
IMO, it is a meaningless operation, and the outcome is irrelevant.

It would make sense to test that this history results after the upstream
at H moved forward:

 ---j-------E---k
     \       \
      n---H   \
           \   \
            z---w'

That is, w began a topic by mergeing the sidebranch E; then upstream
advanced to z, and now you rebase the topic to the new upstream.

> +
> +test_expect_success 'rebase -p re-creates internal merge' '
> +	reset &&
> +	git rebase -p c w &&
> +	test_revisions "f j n E H w" HEAD~4 HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD

You must also test for c; otherwise the test would succeed if rebase did
nothing at all.

This comment applies to all other tests as well, even the "regular" rebase
tests above. (But I noticed only when I read this test.)

> +'
> +
> +test_expect_success 'rebase -p rebuilds history around dropped commit matching upstream' '
> +	reset &&
> +	git rebase -p h w &&
> +	test_revisions "j E n w" HEAD~2 HEAD^2 HEAD^ HEAD
> +'
> +
> +test_expect_success 'rebase -p drops merge commit when one entire side is dropped' '
> +	reset &&
> +	git rebase -p p w &&
> +	test_range p.. "f j n H"
> +'
> +
> +test_expect_failure 'rebase -p --onto drops commit in <onto>' '
> +	reset &&
> +	git rebase -p --onto p f w &&
> +	test_range p.. "j n H"
> +'
> +
> +test_expect_success 'rebase -p with two paths to $from' '
> +	reset &&
> +	git rebase -p --onto c j w &&
> +	test_revisions "c n E H w" HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD
> +'

I didn't look at these remaining -p tests because I ran out of time.


After this plethora of tests, can we get rid of some or many from other
test scripts? (t34* tests are the ones that take the longest on Windows to
run.)

A nice summary of the rebase behavior. I like it.

-- Hannes
