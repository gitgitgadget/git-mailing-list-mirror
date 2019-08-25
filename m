Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFC91F461
	for <e@80x24.org>; Sun, 25 Aug 2019 23:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfHYXeA (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 19:34:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58224 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728730AbfHYXeA (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 19:34:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 478896047B;
        Sun, 25 Aug 2019 23:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566776036;
        bh=mDk6Hqtl4z/HAyPDiCQHr+rByJ7YsZpCHPWpLuWcKOQ=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Vz9dfnGcMESl96NJE3BatQkBj0DaWL1Lu/mQ9tTraqDZC6pz4wYvCL6tVRWTGtG/k
         zOcaWiX+BwnaMPyf9hEP/eu6Pebnh0AnR6bg+FsjXnDxu7r+dvNqCsceKFiXL6+CL7
         h8ucCXwstSw9NPeoeRq3Qlcgl9b72RN2jk2j1fCHoCurFX8X+tzH41JBnEFlnnzj8x
         /NB1byZ8VwPOvMRCD52lEw/CtW368HIrmT1jiaWW2w6li+ZYX1o1XT6SGM7ssVaSie
         udnTCnUiJb1f1WbMGcxi+HUISLLiqeIRyMzksWg3MieHD13KfxtnVGfaVZaeRIWA6e
         1GpssdjVmMy+ldT5SWT1LUtgAm09YDR1Z5X7rMedfi3HoiPlqP15Xqi8BNEfhv/exx
         mbKcIMVPr7vON3gRZDCOUEQb6r0j6XoCdVaa1gSlWxqpJrvbUkekUS/NbpZvgPU1/+
         M1m5mOhgIRgICPlyG3T445MowRgehzDCDpk+EMYA2qyl3D3/vVd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 0/2] Honor .gitattributes with rebase --am
Date:   Sun, 25 Aug 2019 23:33:38 +0000
Message-Id: <20190825233340.10894-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes rebase --am honor the .gitattributes file for
subsequent patches when a patch changes it.

Note that there are two places we load attributes in ll-merge.c, but
this code only handles the one that git am uses.  The two cannot be
unified because the one in ll_merge_marker_size intentionally doesn't
load the merge attribute, since it wants to always use the recursive
strategy.  Loading it anyway causes t4017 to fail.

Changes from v4:
* Wrap lines in apply.c.
* Handle merge and conflict-marker-size attributes.
* Add tests for am and am -3 in addition to rebase.

Changes from v3:
* Check for both addition and removal of .gitattributes files.
* Switch from "test_config" to "git config".

Changes from v2:
* Rename has_path_suffix to ends_with_path_components.

Changes from v1:
* Add has_path_suffix in a separate commit.

brian m. carlson (2):
  path: add a function to check for path suffix
  am: reload .gitattributes after patching it

 apply.c           | 11 ++++++++++
 convert.c         | 11 +++++++++-
 convert.h         |  6 ++++++
 ll-merge.c        | 19 +++++++++++++----
 ll-merge.h        |  1 +
 path.c            | 39 +++++++++++++++++++++++++++--------
 path.h            |  3 +++
 t/t3400-rebase.sh | 36 ++++++++++++++++++++++++++++++++
 t/t4150-am.sh     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 164 insertions(+), 14 deletions(-)

Range-diff against v4:
1:  fa825e4b40 ! 1:  2077a0829e apply: reload .gitattributes after patching it
    @@ Metadata
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Commit message ##
    -    apply: reload .gitattributes after patching it
    +    am: reload .gitattributes after patching it
     
         When applying multiple patches with git am, or when rebasing using the
         am backend, it's possible that one of our patches has updated a
    @@ Commit message
     
         To ensure we write the correct data into the working tree, expire the
         cache after each patch that touches a path ending in ".gitattributes".
    +    Since we load these attributes in multiple separate files, we must
    +    expire them accordingly.
    +
    +    Verify that both the am and rebase code paths work correctly, including
    +    the conflict marker size with am -3.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ apply.c: static int apply_patch(struct apply_state *state,
      			*listp = patch;
      			listp = &patch->next;
     +
    -+			if ((patch->new_name && ends_with_path_components(patch->new_name, GITATTRIBUTES_FILE)) ||
    -+			    (patch->old_name && ends_with_path_components(patch->old_name, GITATTRIBUTES_FILE)))
    ++			if ((patch->new_name &&
    ++			     ends_with_path_components(patch->new_name,
    ++						       GITATTRIBUTES_FILE)) ||
    ++			    (patch->old_name &&
    ++			     ends_with_path_components(patch->old_name,
    ++						       GITATTRIBUTES_FILE)))
     +				flush_attributes = 1;
      		}
      		else {
    @@ apply.c: static int apply_patch(struct apply_state *state,
      	strbuf_release(&buf);
     
      ## convert.c ##
    +@@
    + #include "pkt-line.h"
    + #include "sub-process.h"
    + #include "utf8.h"
    ++#include "ll-merge.h"
    + 
    + /*
    +  * convert.c - convert a file when checking it out and checking it in.
     @@ convert.c: struct conv_attrs {
      	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
      };
    @@ convert.c: static void convert_attrs(const struct index_state *istate,
     +{
     +	attr_check_free(check);
     +	check = NULL;
    ++	reset_merge_attributes();
     +}
     +
      int would_convert_to_git_filter_fd(const struct index_state *istate, const char *path)
    @@ convert.h: void convert_to_git_filter_fd(const struct index_state *istate,
       *
       * Streaming conversion support
     
    + ## ll-merge.c ##
    +@@ ll-merge.c: struct ll_merge_driver {
    + 	char *cmdline;
    + };
    + 
    ++static struct attr_check *merge_attributes;
    ++static struct attr_check *load_merge_attributes(void)
    ++{
    ++	if (!merge_attributes)
    ++		merge_attributes = attr_check_initl("merge", "conflict-marker-size", NULL);
    ++	return merge_attributes;
    ++}
    ++
    ++void reset_merge_attributes(void)
    ++{
    ++	attr_check_free(merge_attributes);
    ++	merge_attributes = NULL;
    ++}
    ++
    + /*
    +  * Built-in low-levels
    +  */
    +@@ ll-merge.c: int ll_merge(mmbuffer_t *result_buf,
    + 	     struct index_state *istate,
    + 	     const struct ll_merge_options *opts)
    + {
    +-	static struct attr_check *check;
    ++	struct attr_check *check = load_merge_attributes();
    + 	static const struct ll_merge_options default_opts;
    + 	const char *ll_driver_name = NULL;
    + 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
    +@@ ll-merge.c: int ll_merge(mmbuffer_t *result_buf,
    + 		normalize_file(theirs, path, istate);
    + 	}
    + 
    +-	if (!check)
    +-		check = attr_check_initl("merge", "conflict-marker-size", NULL);
    +-
    + 	git_check_attr(istate, path, check);
    + 	ll_driver_name = check->items[0].value;
    + 	if (check->items[1].value) {
    +
    + ## ll-merge.h ##
    +@@ ll-merge.h: int ll_merge(mmbuffer_t *result_buf,
    + 	     const struct ll_merge_options *opts);
    + 
    + int ll_merge_marker_size(struct index_state *istate, const char *path);
    ++void reset_merge_attributes(void);
    + 
    + #endif
    +
      ## t/t3400-rebase.sh ##
     @@ t/t3400-rebase.sh: test_expect_success 'rebase --am and --show-current-patch' '
      	)
    @@ t/t3400-rebase.sh: test_expect_success 'rebase --am and --show-current-patch' '
      test_expect_success 'rebase--merge.sh and --show-current-patch' '
      	test_create_repo conflict-merge &&
      	(
    +
    + ## t/t4150-am.sh ##
    +@@ t/t4150-am.sh: test_expect_success 'am --quit keeps HEAD where it is' '
    + 	test_cmp expected actual
    + '
    + 
    ++test_expect_success 'am and .gitattibutes' '
    ++	test_create_repo attributes &&
    ++	(
    ++		cd attributes &&
    ++		test_commit init &&
    ++		git config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
    ++		git config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
    ++
    ++		test_commit second &&
    ++		git checkout -b test HEAD^ &&
    ++
    ++		echo "*.txt filter=test conflict-marker-size=10" >.gitattributes &&
    ++		git add .gitattributes &&
    ++		test_commit third &&
    ++
    ++		echo "This text is smudged." >a.txt &&
    ++		git add a.txt &&
    ++		test_commit fourth &&
    ++
    ++		git checkout -b removal HEAD^ &&
    ++		git rm .gitattributes &&
    ++		git add -u &&
    ++		test_commit fifth &&
    ++		git cherry-pick test &&
    ++
    ++		git checkout -b conflict third &&
    ++		echo "This text is different." >a.txt &&
    ++		git add a.txt &&
    ++		test_commit sixth &&
    ++
    ++		git checkout test &&
    ++		git format-patch --stdout master..HEAD >patches &&
    ++		git reset --hard master &&
    ++		git am patches &&
    ++		grep "smudged" a.txt &&
    ++
    ++		git checkout removal &&
    ++		git reset --hard &&
    ++		git format-patch --stdout master..HEAD >patches &&
    ++		git reset --hard master &&
    ++		git am patches &&
    ++		grep "clean" a.txt &&
    ++
    ++		git checkout conflict &&
    ++		git reset --hard &&
    ++		git format-patch --stdout master..HEAD >patches &&
    ++		git reset --hard fourth &&
    ++		test_must_fail git am -3 patches &&
    ++		grep "<<<<<<<<<<" a.txt
    ++	)
    ++'
    ++
    + test_done
