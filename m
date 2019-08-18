Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680C11F461
	for <e@80x24.org>; Sun, 18 Aug 2019 18:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfHRSoS (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 14:44:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57704 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbfHRSoS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 14:44:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 55EBF605B2;
        Sun, 18 Aug 2019 18:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566153854;
        bh=xgjAHBnlym6SfgjOPfg8THsx5UR+WtCZnPzszIypj7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gs6mDpvUoPtdangqoI0PuXCPU6mmY4BbCBT5oSKw2yOq1aih7N1OyJbHomg0p59V7
         8SDuZLfvhEi+fdqoKpMJi1h9OcFyf192hDtelMGSG6MXer8uYgdfC6Rf50mNF5g648
         vc9LBiZiplHg3AwWtIrrM+1KWIa6PzjyJKI6jlrWdiV5/h7dXxoHVZHXDkQIZsM6rK
         4RwXN5soPjX3HCFWK4u1DUvVL1gClykesVWAXhAj0o1hsabtoh9DaqdbN4t31bPOef
         NBX+SVaWDbG68qwevzFWLgw7RNGYE8fmrVuGM/iWpbMy/1ySFNaBGLuKFQX52s9db4
         Pf4JX/eK4lwtsJdlwx5xnBdziNXW1/uHR7YmqehJgD/64GFFixgk9syEHQyVwkF3jk
         kIZ6uF32r95Cc2cBARlB2BLuhM+YBmgxs5LM+dLxXZ2EeAfkb7SjIt5RND9l0P974b
         pCFBh/0Uw9qIpq3PY8yOwWPr5rl6a5pCbPOnd6nnluj53Dqav9O
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/2]  Honor .gitattributes with rebase --am
Date:   Sun, 18 Aug 2019 18:44:01 +0000
Message-Id: <20190818184403.861907-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190809100217.427178-1-sandals@crustytoothpaste.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes rebase --am honor the .gitattributes file for
subsequent patches when a patch changes it.

Changes from v3:
* Check for both addition and removal of .gitattributes files.
* Switch from "test_config" to "git config".

Changes from v2:
* Rename has_path_suffix to ends_with_path_components.

Changes from v1:
* Add has_path_suffix in a separate commit.

brian m. carlson (2):
  path: add a function to check for path suffix
  apply: reload .gitattributes after patching it

 apply.c           |  7 +++++++
 convert.c         |  9 ++++++++-
 convert.h         |  6 ++++++
 path.c            | 39 ++++++++++++++++++++++++++++++---------
 path.h            |  3 +++
 t/t3400-rebase.sh | 36 ++++++++++++++++++++++++++++++++++++
 6 files changed, 90 insertions(+), 10 deletions(-)

Range-diff against v3:
1:  5f4402b38d ! 1:  fa825e4b40 apply: reload .gitattributes after patching it
    @@ apply.c: static int apply_patch(struct apply_state *state,
      			*listp = patch;
      			listp = &patch->next;
     +
    -+			if (!flush_attributes && patch->new_name &&
    -+			    ends_with_path_components(patch->new_name, GITATTRIBUTES_FILE))
    ++			if ((patch->new_name && ends_with_path_components(patch->new_name, GITATTRIBUTES_FILE)) ||
    ++			    (patch->old_name && ends_with_path_components(patch->old_name, GITATTRIBUTES_FILE)))
     +				flush_attributes = 1;
      		}
      		else {
    @@ t/t3400-rebase.sh: test_expect_success 'rebase --am and --show-current-patch' '
     +	(
     +		cd attributes &&
     +		test_commit init &&
    -+		test_config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
    -+		test_config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
    ++		git config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
    ++		git config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
     +
     +		test_commit second &&
     +		git checkout -b test HEAD^ &&
    @@ t/t3400-rebase.sh: test_expect_success 'rebase --am and --show-current-patch' '
     +		echo "This text is smudged." >a.txt &&
     +		git add a.txt &&
     +		test_commit fourth &&
    ++
    ++		git checkout -b removal HEAD^ &&
    ++		git rm .gitattributes &&
    ++		git add -u &&
    ++		test_commit fifth &&
    ++		git cherry-pick test &&
    ++
    ++		git checkout test &&
     +		git rebase master &&
    -+		grep "smudged" a.txt
    ++		grep "smudged" a.txt &&
    ++
    ++		git checkout removal &&
    ++		git reset --hard &&
    ++		git rebase master &&
    ++		grep "clean" a.txt
     +	)
     +'
     +
