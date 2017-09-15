Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FEC20A27
	for <e@80x24.org>; Fri, 15 Sep 2017 11:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdIOLu0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 07:50:26 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:12777 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdIOLu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 07:50:26 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dsp8Y-0003Y2-DQ; Fri, 15 Sep 2017 13:50:22 +0200
Date:   Fri, 15 Sep 2017 13:50:21 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2] add test for bug in git-mv for recursive submodules
Message-ID: <20170915115021.GB76244@book.hvoigt.net>
References: <20170817103413.GA52233@book.hvoigt.net>
 <CAGZ79kZhUO95oSEzARqXi3+dm5Ow5Jwm-O1adowh0nkbqHdhMw@mail.gmail.com>
 <20170818160603.GA69414@book.hvoigt.net>
 <CAGZ79kYNLo_3PfLTOE5wusTs6wgFXZLVH+qNZ-ovxGguhinHLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYNLo_3PfLTOE5wusTs6wgFXZLVH+qNZ-ovxGguhinHLg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git-mv with a submodule it will detect that and update the
paths for its configurations (.gitmodules, worktree and gitfile). This
does not work for recursive submodules where a user renames the root
submodule.

We discovered this fact when working on on-demand fetch for renamed
submodules. Lets add a test to document.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Fri, Aug 18, 2017 at 12:04:03PM -0700, Stefan Beller wrote:
> > I just copied the shortcut that they were adding themselfes as submodule
> > in 'setup submodule'. The whole setup of submodules in this test is like
> > this. This way we already had a nested submodule structure which I could
> > just add.
> >
> > I agree that this is unrealistic so I can change that in the test I am
> > adding. But from what I have seen, this shortcut is taken in quite some
> > places when dealing with submodules.
> 
> Please do not make it worse.
> Once upon a time (late '16 IIRC) I had a series floating on the
> list removing all occurrences, but there were issues with the
> series and it did not land.

Took a little while but here is a more clean patch creating individual
submodules for the nesting.

Cheers Heiko

 t/t7001-mv.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index e365d1ff77..cbc5fb37fe 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -491,4 +491,29 @@ test_expect_success 'moving a submodule in nested directories' '
 	test_cmp actual expect
 '
 
+test_expect_failure 'moving nested submodules' '
+	git commit -am "cleanup commit" &&
+	mkdir sub_nested_nested &&
+	(cd sub_nested_nested &&
+		touch nested_level2 &&
+		git init &&
+		git add . &&
+		git commit -m "nested level 2"
+	) &&
+	mkdir sub_nested &&
+	(cd sub_nested &&
+		touch nested_level1 &&
+		git init &&
+		git add . &&
+		git commit -m "nested level 1"
+		git submodule add ../sub_nested_nested &&
+		git commit -m "add nested level 2"
+	) &&
+	git submodule add ./sub_nested nested_move &&
+	git commit -m "add nested_move" &&
+	git submodule update --init --recursive &&
+	git mv nested_move sub_nested_moved &&
+	git status
+'
+
 test_done
-- 
2.14.1.145.gb3622a4

