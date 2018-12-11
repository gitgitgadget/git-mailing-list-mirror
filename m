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
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C6720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 16:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeLKQLz (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 11:11:55 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48376 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729586AbeLKQLx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Dec 2018 11:11:53 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBG8wKP000913;
        Tue, 11 Dec 2018 08:11:46 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2p8cpp3qxp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Dec 2018 08:11:45 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 11 Dec 2018 11:11:43 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 11 Dec 2018 11:11:43 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id EE96421E6B44;
        Tue, 11 Dec 2018 08:11:41 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <Johannes.Schindelin@gmx.de>,
        <predatoramigo@gmail.com>, <phillip.wood@talktalk.net>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 0/8] Reimplement rebase --merge via interactive machinery
Date:   Tue, 11 Dec 2018 08:11:31 -0800
Message-ID: <20181211161139.31686-1-newren@gmail.com>
X-Mailer: git-send-email 2.20.0.8.g5de428d695
In-Reply-To: <20181122044841.20993-1-newren@gmail.com>
References: <20181122044841.20993-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110146
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series continues the work of making rebase more self-consistent
by removing inconsistencies between different backends.  In
particular, this series focuses on making the merge machinery behave
like the interactive machinery (though a few differences between the am
and interactive backends are also fixed along the way), and ultimately
removes the merge backend in favor of reimplementing the relevant
options on top of the interactive machinery.

Differences since v3 (full range-diff below):
  - Fixed the redundant "fatal: error:" error message prefixes, as pointed
    out by Duy
  - Rebased on 2.20.0

Elijah Newren (8):
  rebase: make builtin and legacy script error messages the same
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
 builtin/rebase.c                  |  30 ++----
 git-legacy-rebase.sh              |  65 ++++++------
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
 17 files changed, 121 insertions(+), 340 deletions(-)
 delete mode 100644 git-rebase--merge.sh

Range-diff:
-:  ---------- > 1:  2e8b1bcb8b rebase: make builtin and legacy script error messages the same
1:  2f4bdd1980 ! 2:  eba87828c6 rebase: fix incompatible options error message
    @@ -9,12 +9,12 @@
         understood by separate backends were used:
     
         $ git rebase --keep --ignore-whitespace
    -    fatal: error: cannot combine interactive options (--interactive, --exec,
    +    fatal: cannot combine interactive options (--interactive, --exec,
         --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with
         am options (.git/rebase-apply/applying)
     
         $ git rebase --merge --ignore-whitespace
    -    fatal: error: cannot combine merge options (--merge, --strategy,
    +    fatal: cannot combine merge options (--merge, --strategy,
         --strategy-option) with am options (.git/rebase-apply/applying)
     
         Note that in both cases, the list of "am options" is
    @@ -33,18 +33,17 @@
      				break;
      
      		if (is_interactive(&options) && i >= 0)
    --			die(_("error: cannot combine interactive options "
    +-			die(_("cannot combine interactive options "
     -			      "(--interactive, --exec, --rebase-merges, "
     -			      "--preserve-merges, --keep-empty, --root + "
     -			      "--onto) with am options (%s)"), buf.buf);
    -+			die(_("error: cannot combine am options "
    ++			die(_("cannot combine am options "
     +			      "with interactive options"));
      		if (options.type == REBASE_MERGE && i >= 0)
    --			die(_("error: cannot combine merge options (--merge, "
    +-			die(_("cannot combine merge options (--merge, "
     -			      "--strategy, --strategy-option) with am options "
     -			      "(%s)"), buf.buf);
    -+			die(_("error: cannot combine am options "
    -+			      "with merge options "));
    ++			die(_("cannot combine am options with merge options "));
      	}
      
      	if (options.signoff) {
    @@ -56,15 +55,15 @@
      	then
      		if test -n "$incompatible_opts"
      		then
    --			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
    -+			die "$(gettext "error: cannot combine am options with interactive options")"
    +-			die "$(gettext "fatal: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
    ++			die "$(gettext "fatal: cannot combine am options with interactive options")"
      		fi
      	fi
      	if test -n "$do_merge"; then
      		if test -n "$incompatible_opts"
      		then
    --			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
    -+			die "$(gettext "error: cannot combine am options with merge options")"
    +-			die "$(gettext "fatal: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
    ++			die "$(gettext "fatal: cannot combine am options with merge options")"
      		fi
      	fi
      fi
2:  cc33a8ccc1 = 3:  15d929edb2 t5407: add a test demonstrating how interactive handles --skip differently
3:  f5838ef763 = 4:  c9d6d5141e am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
4:  50dc863d9f = 5:  0b19ad8e2d git-rebase, sequencer: extend --quiet option for the interactive machinery
5:  35cf552f27 ! 6:  5ded8654ec git-legacy-rebase: simplify unnecessary triply-nested if
    @@ -18,7 +18,7 @@
         moving the innermost conditional to the outside, allowing us to remove
         the test on git_am_opt entirely and giving us the following form:
     
    -    if incomptable_opts:
    +    if incompatible_opts:
           if interactive:
             show_error_about_interactive_and_am_incompatibilities
           if rebase-merge:
    @@ -44,18 +44,18 @@
      	then
     -		if test -n "$incompatible_opts"
     -		then
    --			die "$(gettext "error: cannot combine am options with interactive options")"
    +-			die "$(gettext "fatal: cannot combine am options with interactive options")"
     -		fi
    -+		die "$(gettext "error: cannot combine am options with interactive options")"
    ++		die "$(gettext "fatal: cannot combine am options with interactive options")"
      	fi
     -	if test -n "$do_merge"; then
     -		if test -n "$incompatible_opts"
     -		then
    --			die "$(gettext "error: cannot combine am options with merge options")"
    +-			die "$(gettext "fatal: cannot combine am options with merge options")"
     -		fi
     +	if test -n "$do_merge"
     +	then
    -+		die "$(gettext "error: cannot combine am options with merge options")"
    ++		die "$(gettext "fatal: cannot combine am options with merge options")"
      	fi
      fi
      
6:  2a3d8ff1c1 = 7:  bb8e5a4527 rebase: define linearization ordering and enforce it
7:  58371d377a ! 8:  5de428d695 rebase: Implement --merge via the interactive machinery
    @@ -142,14 +142,15 @@
      		imply_interactive(&options, "--root without --onto");
      
     @@
    + 				break;
      
      		if (is_interactive(&options) && i >= 0)
    - 			die(_("error: cannot combine am options "
    +-			die(_("cannot combine am options "
     -			      "with interactive options"));
     -		if (options.type == REBASE_MERGE && i >= 0)
    --			die(_("error: cannot combine am options "
    --			      "with merge options "));
    -+			      "with either interactive or merge options"));
    +-			die(_("cannot combine am options with merge options "));
    ++			die(_("cannot combine am options with either "
    ++			      "interactive or merge options"));
      	}
      
      	if (options.signoff) {
    @@ -205,13 +206,13 @@
      then
     -	if test -n "$interactive_rebase"
     -	then
    --		die "$(gettext "error: cannot combine am options with interactive options")"
    +-		die "$(gettext "fatal: cannot combine am options with interactive options")"
     -	fi
     -	if test -n "$do_merge"
     +	if test -n "$actually_interactive" || test "$do_merge"
      	then
    --		die "$(gettext "error: cannot combine am options with merge options")"
    -+		die "$(gettext "error: cannot combine am options with either interactive or merge options")"
    +-		die "$(gettext "fatal: cannot combine am options with merge options")"
    ++		die "$(gettext "fatal: cannot combine am options with either interactive or merge options")"
      	fi
      fi
      
    @@ -225,7 +226,7 @@
      	# linear history?
      	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
     @@
    - 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
    + 	GIT_PAGER='' git diff --stat --summary "$mb_tree" "$onto"
      fi
      
     +if test -z "$actually_interactive" && test "$mb" = "$orig_head"
-- 
2.20.0.8.g5de428d695

