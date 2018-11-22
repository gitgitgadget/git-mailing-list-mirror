Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229131F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 04:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404269AbeKVP0b (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 10:26:31 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35296 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392064AbeKVP0a (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Nov 2018 10:26:30 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAM4mke1025743;
        Wed, 21 Nov 2018 20:48:46 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2ntgrrwtgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 21 Nov 2018 20:48:46 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 21 Nov 2018 23:48:44 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 21 Nov 2018 23:48:44 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id B044B21768AD;
        Wed, 21 Nov 2018 20:48:43 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <Johannes.Schindelin@gmx.de>,
        <predatoramigo@gmail.com>, <phillip.wood@talktalk.net>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/7] Reimplement rebase --merge via interactive machinery
Date:   Wed, 21 Nov 2018 20:48:34 -0800
Message-ID: <20181122044841.20993-1-newren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.7.g58371d377a
In-Reply-To: <20181108060158.27145-1-newren@gmail.com>
References: <20181108060158.27145-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811220045
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Important: Patch 1 fixes a (minor) regression in 2.20 relative to
2.19...but it also modifies a translated string.  I'm not sure what the
right step we want to take there is.  If you want me to submit it
separately and also resubmit the rest of this series to depend on the
separated first patch, let me know.]

This series continues the work of making rebase more self-consistent
by removing inconsistencies between different backends.  In
particular, this series focuses on making the merge machinery behave
like the interactive machinery (though two differences between the am
and interactive backends are also fixed along the way), and ultimately
removes the merge backend in favor of reimplementing the relevant
options on top of the interactive machinery.

Differences since v2 (full range-diff below):
  - Addressed feedback from both Phillip and Dscho
  - Added five new patches; the biggest change is still the final patch
    but it should be a little easier to review now.
  - Added a patch fixing a very recent regression in the incompatible
    options error message
  - Documented and fixed the inconsistency in how different rebase backends
    handle --skip relative to the post-rewrite hook
  - Added a patch defining the linearization order and enforcing it,
    getting rid of an age-old TODO
  - Added a patch which took a slightly confusing diff hunk from the
    previous final patch, and give it its own commit message explaining
    why the drop from a triply-nested if block to a doubly-nested
    if-block still keeps all necessary checks in place.
  - Rebased to latest master

Elijah Newren (7):
  rebase: fix incompatible options error message
  t5407: add a test demonstrating how interactive handles --skip
    differently
  am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
  git-rebase, sequencer: extend --quiet option for the interactive
    machinery
  git-legacy-rebase: simplify unnecessary triply-nested if
  rebase: define linearization ordering and enforce it
  rebase: Implement --merge via the interactive machinery

 .gitignore                        |   1 -
 Documentation/git-rebase.txt      |  17 +---
 Makefile                          |   1 -
 builtin/am.c                      |   9 ++
 builtin/rebase.c                  |  24 ++---
 git-legacy-rebase.sh              |  57 +++++------
 git-rebase--am.sh                 |   2 +-
 git-rebase--common.sh             |   2 +-
 git-rebase--merge.sh              | 164 ------------------------------
 sequencer.c                       |  23 +++--
 sequencer.h                       |   1 +
 t/t3406-rebase-message.sh         |   7 +-
 t/t3420-rebase-autostash.sh       |  78 ++------------
 t/t3421-rebase-topology-linear.sh |  10 +-
 t/t3425-rebase-topology-merges.sh |  15 ++-
 t/t5407-post-rewrite-hook.sh      |  34 +++++++
 t/t9903-bash-prompt.sh            |   2 +-
 17 files changed, 114 insertions(+), 333 deletions(-)
 delete mode 100644 git-rebase--merge.sh

-:  ---------- > 1:  2f4bdd1980 rebase: fix incompatible options error message
-:  ---------- > 2:  cc33a8ccc1 t5407: add a test demonstrating how interactive handles --skip differently
-:  ---------- > 3:  f5838ef763 am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
1:  bf0acd9b27 ! 4:  50dc863d9f git-rebase, sequencer: extend --quiet option for the interactive machinery
    @@ -13,7 +13,7 @@
         git-rebase--interactive was already somewhat quieter than
         git-rebase--merge and git-rebase--am, possibly because cherry-pick has
         just traditionally been quieter.  As such, we only drop a few
    -    informational messages -- "Rebasing (n/m)" and "Succesfully rebased..."
    +    informational messages -- "Rebasing (n/m)" and "Successfully rebased..."
     
         Also, for simplicity, remove the differences in how quiet and verbose
         options were recorded.  Having one be signalled by the presence of a
-:  ---------- > 5:  35cf552f27 git-legacy-rebase: simplify unnecessary triply-nested if
-:  ---------- > 6:  2a3d8ff1c1 rebase: define linearization ordering and enforce it
2:  cd0ccab680 ! 7:  58371d377a rebase: Implement --merge via git-rebase--interactive
    @@ -1,35 +1,37 @@
     Author: Elijah Newren <newren@gmail.com>
     
    -    rebase: Implement --merge via git-rebase--interactive
    +    rebase: Implement --merge via the interactive machinery
     
    -    Interactive rebases are implemented in terms of cherry-pick rather than
    -    the merge-recursive builtin, but cherry-pick also calls into the recursive
    -    merge machinery by default and can accept special merge strategies and/or
    -    special strategy options.  As such, there really is not any need for
    -    having both git-rebase--merge and git-rebase--interactive anymore.
    +    As part of an ongoing effort to make rebase have more uniform behavior,
    +    modify the merge backend to behave like the interactive one, by
    +    re-implementing it on top of the latter.
     
    -    Delete git-rebase--merge.sh and have the --merge option be implemented
    -    by the now built-in interactive machinery.
    +    Interactive rebases are implemented in terms of cherry-pick rather than
    +    the merge-recursive builtin, but cherry-pick also calls into the
    +    recursive merge machinery by default and can accept special merge
    +    strategies and/or special strategy options.  As such, there really is
    +    not any need for having both git-rebase--merge and
    +    git-rebase--interactive anymore.  Delete git-rebase--merge.sh and
    +    instead implement it in builtin/rebase.c.
     
    -    Note that this change fixes a few known test failures (see t3421).
    +    This results in a few deliberate but small user-visible changes:
    +      * The progress output is modified (see t3406 and t3420 for examples)
    +      * A few known test failures are now fixed (see t3421)
    +      * bash-prompt during a rebase --merge is now REBASE-i instead of
    +        REBASE-m.  Reason: The prompt is a reflection of the backend in use;
    +        this allows users to report an issue to the git mailing list with
    +        the appropriate backend information, and allows advanced users to
    +        know where to search for relevant control files.  (see t9903)
     
         testcase modification notes:
           t3406: --interactive and --merge had slightly different progress output
    -             while running; adjust a test to match
    +             while running; adjust a test to match the new expectation
           t3420: these test precise output while running, but rebase--am,
                  rebase--merge, and rebase--interactive all were built on very
                  different commands (am, merge-recursive, cherry-pick), so the
                  tests expected different output for each type.  Now we expect
                  --merge and --interactive to have the same output.
           t3421: --interactive fixes some bugs in --merge!  Wahoo!
    -      t3425: topology linearization was inconsistent across flavors of rebase,
    -             as already noted in a TODO comment in the testcase.  This was not
    -             considered a bug before, so getting a different linearization due
    -             to switching out backends should not be considered a bug now.
    -      t5407: different rebase types varied slightly in how many times checkout
    -             or commit or equivalents were called based on a quick comparison
    -             of this tests and previous ones which covered different rebase
    -             flavors.  I think this is just attributable to this difference.
           t9903: --merge uses the interactive backend so the prompt expected is
                  now REBASE-i.
     
    @@ -133,13 +135,24 @@
      		}
      	}
      
    -+	if (options.type == REBASE_MERGE) {
    ++	if (options.type == REBASE_MERGE)
     +		imply_interactive(&options, "--merge");
    -+	}
     +
      	if (options.root && !options.onto_name)
      		imply_interactive(&options, "--root without --onto");
      
    +@@
    + 
    + 		if (is_interactive(&options) && i >= 0)
    + 			die(_("error: cannot combine am options "
    +-			      "with interactive options"));
    +-		if (options.type == REBASE_MERGE && i >= 0)
    +-			die(_("error: cannot combine am options "
    +-			      "with merge options "));
    ++			      "with either interactive or merge options"));
    + 	}
    + 
    + 	if (options.signoff) {
     
      diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
      --- a/git-legacy-rebase.sh
    @@ -187,30 +200,18 @@
      else
      	type=am
     @@
    - 	git_format_patch_opt="$git_format_patch_opt --progress"
    - fi
    - 
    --if test -n "$git_am_opt"; then
    --	incompatible_opts=$(echo " $git_am_opt " | \
    --			    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
    + 		    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
    + if test -n "$incompatible_opts"
    + then
     -	if test -n "$interactive_rebase"
    -+incompatible_opts=$(echo " $git_am_opt " | \
    -+		    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
    -+if test -n "$incompatible_opts"
    -+then
    +-	then
    +-		die "$(gettext "error: cannot combine am options with interactive options")"
    +-	fi
    +-	if test -n "$do_merge"
     +	if test -n "$actually_interactive" || test "$do_merge"
      	then
    --		if test -n "$incompatible_opts"
    --		then
    --			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
    --		fi
    --	fi
    --	if test -n "$do_merge"; then
    --		if test -n "$incompatible_opts"
    --		then
    --			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
    --		fi
    -+		die "$(gettext "error: cannot combine am options ($incompatible_opts) with either interactive or merge options")"
    +-		die "$(gettext "error: cannot combine am options with merge options")"
    ++		die "$(gettext "error: cannot combine am options with either interactive or merge options")"
      	fi
      fi
      
    @@ -229,11 +230,11 @@
      
     +if test -z "$actually_interactive" && test "$mb" = "$orig_head"
     +then
    -+	# If the $onto is a proper descendant of the tip of the branch, then
    -+	# we just fast-forwarded.
     +	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
     +	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
     +		git checkout -q "$onto^0" || die "could not detach HEAD"
    ++	# If the $onto is a proper descendant of the tip of the branch, then
    ++	# we just fast-forwarded.
     +	git update-ref ORIG_HEAD $orig_head
     +	move_to_original_branch
     +	finish_rebase
    @@ -389,6 +390,8 @@
     -skip)
     -	read_state
     -	git rerere clear
    +-	cmt="$(cat "$state_dir/cmt.$msgnum")"
    +-	echo "$cmt $(git rev-parse HEAD^0)" >> "$state_dir/rewritten"
     -	msgnum=$(($msgnum + 1))
     -	while test "$msgnum" -le "$end"
     -	do
    @@ -409,7 +412,7 @@
     -rm -f "$(git rev-parse --git-path REBASE_HEAD)"
     -
     -msgnum=0
    --for cmt in $(git rev-list --reverse --no-merges "$revisions")
    +-for cmt in $(git rev-list --topo-order --reverse --no-merges "$revisions")
     -do
     -	msgnum=$(($msgnum + 1))
     -	echo "$cmt" > "$state_dir/cmt.$msgnum"
    @@ -571,7 +574,7 @@
     -test_run_rebase failure -m
     +test_run_rebase success -m
      test_run_rebase success -i
    - test_run_rebase success -p
    + test_have_prereq !REBASE_P || test_run_rebase success -p
      
     @@
      	"
    @@ -580,7 +583,7 @@
     -test_run_rebase failure -m
     +test_run_rebase success -m
      test_run_rebase success -i
    - test_run_rebase success -p
    + test_have_prereq !REBASE_P || test_run_rebase success -p
      
     @@
      	"
    @@ -589,7 +592,7 @@
     -test_run_rebase failure -m
     +test_run_rebase success -m
      test_run_rebase success -i
    - test_run_rebase success -p
    + test_have_prereq !REBASE_P || test_run_rebase success -p
      
     @@
      	"
    @@ -598,7 +601,7 @@
     -test_run_rebase failure -m
     +test_run_rebase success -m
      test_run_rebase success -i
    - test_run_rebase success -p
    + test_have_prereq !REBASE_P || test_run_rebase success -p
      
     @@
      	"
    @@ -607,52 +610,9 @@
     -test_run_rebase failure -m
     +test_run_rebase success -m
      test_run_rebase success -i
    - test_run_rebase failure -p
    + test_have_prereq !REBASE_P || test_run_rebase failure -p
      
     
    - diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
    - --- a/t/t3425-rebase-topology-merges.sh
    - +++ b/t/t3425-rebase-topology-merges.sh
    -@@
    - }
    - #TODO: make order consistent across all flavors of rebase
    - test_run_rebase success 'e n o' ''
    --test_run_rebase success 'e n o' -m
    -+test_run_rebase success 'n o e' -m
    - test_run_rebase success 'n o e' -i
    - 
    - test_run_rebase () {
    -@@
    - }
    - #TODO: make order consistent across all flavors of rebase
    - test_run_rebase success 'd e n o' ''
    --test_run_rebase success 'd e n o' -m
    -+test_run_rebase success 'd n o e' -m
    - test_run_rebase success 'd n o e' -i
    - 
    - test_run_rebase () {
    -@@
    - }
    - #TODO: make order consistent across all flavors of rebase
    - test_run_rebase success 'd e n o' ''
    --test_run_rebase success 'd e n o' -m
    -+test_run_rebase success 'd n o e' -m
    - test_run_rebase success 'd n o e' -i
    - 
    - test_expect_success "rebase -p is no-op in non-linear history" "
    -
    - diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
    - --- a/t/t5407-post-rewrite-hook.sh
    - +++ b/t/t5407-post-rewrite-hook.sh
    -@@
    - 	git rebase --continue &&
    - 	echo rebase >expected.args &&
    - 	cat >expected.data <<-EOF &&
    -+	$(git rev-parse C) $(git rev-parse HEAD^)
    - 	$(git rev-parse D) $(git rev-parse HEAD)
    - 	EOF
    - 	verify_hook_input
    -
      diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
      --- a/t/t9903-bash-prompt.sh
      +++ b/t/t9903-bash-prompt.sh

-- 
2.20.0.rc1.7.g58371d377a
