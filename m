Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B929820954
	for <e@80x24.org>; Sun, 26 Nov 2017 02:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbdKZCQB (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 21:16:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:51526 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbdKZCQA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 21:16:00 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McVGq-1eaRrR0cZk-00HdY7; Sun, 26
 Nov 2017 03:15:57 +0100
Date:   Sun, 26 Nov 2017 03:15:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org
Subject: Bug in pathspec handling (in conjunction with submodules)
Message-ID: <alpine.DEB.2.21.1.1711260210060.6482@virtualbox>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rXzOTeZ14wfvrPRx1F/pQYgaMO77jY2x6QZ49L+RxdyI5L00zun
 AJju7XD9lGsyv0MCuha3ZVTL4A+/+IpNy/pnjrobI+k0pPNEei8vO3a+hzkx/o4ztOvC2P5
 84NS4K0D3tV8+TtC27CpfTbZgludPlYuWubsdewDq+sPaqNjdgCo5BOMj1slj3Nf52eQ+bE
 CP6Doecm2D68A7Cc+Ej5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1sNhLu/7HS8=:nwHTpaaPqr0XflAC/0eWPz
 E+wUUf1ejTGdEfRhvnTczJN8hh0uQIpHb1Xd41mUsRR5ZsjBzpvYmfxNQPcOASy+6v/MegmEv
 5odeWBABmJZNdMdSQuKy1Q0Q5pbEugA3v4UEldDJXGjhN85xOJ3tYPXyIAzfWDK2nu8LpwEt7
 P/sue3aKLhcpLYLbP7g4JGtu38Kl0VzDzAWhaIJI34hYLPEjEo7oTy0IOwZCM/MucsmE3MOs2
 8OrinHd+Vsbzfu4QT+GLD0w+RUOla7oEzoCLv3ilPmCwSTQZJ4Da5oh/iJAsURc8xNmEvqk2e
 kuOVElLKPSsRHaNjJPALVIlGXHQfcXU9PyxuXFhUS2iyfufrGv8gUY0hFGmfbMRQ/nBVRlvdw
 PGCq2vt3SWtt3dd2WYr/2FkpednSHMrLANVEhDvtbUQoMCYipJ4VoJsjdsaAfeUbIGbmZ90Ir
 yybAoES5u1JA0+nhqJgXU73OLC3s/oBtRHJJ4WnuDaE9aCq59P2YQcEujJWtQZBQEM5dA09oW
 FFhnt+qHloHyf6OS+AcjRcKlQY7Al6PogbFS6C/Ua8vSlJZUJOa0AD63nXxpp3P4n/DTeISXl
 zB+F6XBn6DlAXV+KVRaZJXCN+a8lm1AvQcE5SM9Q1HL1t6EqEqhiMLY/4JjRviFAQAFu2tNgD
 vsbv27bdBtVm9SgaqPBc3IQ51InBO3HujbtTln0Kd25Ts+5amhRCW421bnwNWW4fB5Ucr7n5R
 XOvub/GQjuIwGFk9ncV3F3ZzqqYrfO0oE0zqFugpjD21QTuFt0QuREzKQ8Sy+NA0ff6wvp13g
 v31gpwymdIrmR/dkmDH6dQvm3ne/hdTBDOwV3FL1XY0qKl95V8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy & Brandon,

in 74ed43711fd (grep: enable recurse-submodules to work on <tree> objects,
2016-12-16), the do_match() function in tree-walk.c was changed so that it
can recurse across submodule boundaries.

However, there is a bug, and I *think* there may be two bugs actually. Or
even three.

First of all, here is an MCVE that I distilled from
https://github.com/git-for-windows/git/issues/1371:

	git init repo
	cd repo

	git init submodule
	git -C submodule commit -m initial --allow-empty

	touch "[bracket]"
	git add "[bracket]"
	git commit -m bracket
	git add submodule
	git commit -m submodule

	git rev-list HEAD -- "[bracket]"

Nothing fancy, just adding a file with brackets in the name, then a
submodule, then showing the commit history filtered by the funny file
name.

However, the log prints *both* commits. Clearly the submodule commit
should *not* be shown.

Now, how does this all happen?

Since the pathspec contains brackets, parse_pathspec() marks it as
containing wildcards and sets nowildcard_len to 0.

Now, note that [bracket] *is* a wildcard expression: it should only match
a single character that is one of  a, b, c, e, k, r or t.

I think this is the first bug: `git rev-list` should not even match the
commit that adds the file [bracket] because its file name does not match
that expression. From where I sit, it would appear that f1a2ddbbc2d
(tree_entry_interesting(): optimize wildcard matching when base is
matched, 2010-12-15) simply added the fnmatch() code without disabling the
literal match_entry() code when the pathspec contains a pattern.

But it does not stop there: there is *another* bug which causes the
pattern to somehow match the submodule. I *guess* the idea of
https://github.com/git/git/commit/74ed43711#diff-7a08243175f2cae66aedf53f7dce3bdfR1015
was to allow a pattern like *.c to match files in a submodule, but the
pattern [bracket] should not match any file in submodule/. I think that
that code needs to be a little bit more careful to try to match the
submodule's name against the pattern (it seems to interpret nowildcard_len
== 0 to mean that the wildcard is `*`).

However, the commit introducing that code wanted to teach *grep* (not
*rev-list*) a new trick, and it relies on the `recursive` flag of the
pathspec to be set.

And now it gets really interesting. Or confusing, depending on your mental
condition. This recursive flag of the pathspec is set in
ll_diff_tree_paths() (yep, changing the flag in the passed-in opt
structure... which I found a bit... unexpected, given the function name, I
would have been less surprised if that function only diff'ed the trees and
used the options without changing the options). That flag-change was
introduced in
https://github.com/git/git/commit/bc96cc87dbb2#diff-15203e8cd8ee9191113894de9d97a8a6R149
which is another patch that changed the tree diff machinery to accommodate
`git grep` (but maybe not really paying a lot of attention to the fact
that the same machinery is called repeatedly by the revision machinery,
too).

I am really confused by this code mainly due to the fact that the term
"recursive" is pretty ambiguous in that context: does it refer to
directories/tree objects, or to submodules? I guess it is used for both
when there should be two flags so that rev-list can recurse over tree
objects but not submodules (unless told to do so).

The problem, of course, is that `git rev-list HEAD -- '[bracket]'` never
recurses into the submodule. And therefore, the promised "more accurate
matching [...] in the submodule" is never performed. And the commit adding
the submodule is never pruned.

Since I am not really familiar with all that tree diff code (and as a
general rule to protect my mental health, I try my best to stay away from
submodules, too), but you two are, may I ask you gentle people to have a
closer look to fix those bugs?

Thanks,
Dscho
