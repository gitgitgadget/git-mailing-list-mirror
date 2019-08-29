Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789541F461
	for <e@80x24.org>; Thu, 29 Aug 2019 22:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfH2WqT (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 18:46:19 -0400
Received: from smtp123.ord1d.emailsrvr.com ([184.106.54.123]:35486 "EHLO
        smtp123.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728749AbfH2WqT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Aug 2019 18:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1567118300;
        bh=SWjQ5b8JutVPiwHd9KmLqAVpd4x7J9NFb2o5FhlmmwY=;
        h=From:To:Subject:Date:From;
        b=DFFncFucCaQ9AGCQbyboX9vVFheWRRFeG+o/KFMbgINjKWzgaqu3/NH7F/iAvpJZ5
         NdAhktALMMWEOunsZ8iX2Ic8cuz/0hnHeguk6PtK7ogY1W3D/O9lUKp8iPuXfv53sk
         Ts6b+mynjB8LOxbNfocsY3K+nG6MoR39dAV4UVI8=
X-Auth-ID: jon@jonsimons.org
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id B34A8A0252;
        Thu, 29 Aug 2019 18:38:19 -0400 (EDT)
X-Sender-Id: jon@jonsimons.org
Received: from localhost.localdomain (c-73-223-68-105.hsd1.ca.comcast.net [73.223.68.105])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 29 Aug 2019 18:38:20 -0400
From:   Jon Simons <jon@jonsimons.org>
To:     jon@jonsimons.org, git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sunshine@sunshineco.com,
        stolee@gmail.com
Subject: [PATCH v2 1/2] list-objects-filter: only parse sparse OID when 'have_git_dir'
Date:   Thu, 29 Aug 2019 18:38:10 -0400
Message-Id: <20190829223811.12072-2-jon@jonsimons.org>
X-Mailer: git-send-email 2.23.0.37.g745f681289.dirty
In-Reply-To: <20190829223811.12072-1-jon@jonsimons.org>
References: <20190829223811.12072-1-jon@jonsimons.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in partial cloning with sparse filters by ensuring to check
for 'have_git_dir' before attempting to resolve the sparse filter OID.

Otherwise the client will trigger:

    BUG: refs.c:1851: attempting to get main_ref_store outside of repository

when attempting to git clone with a sparse filter.

Note that this fix is the minimal one which avoids the BUG and allows
for the clone to complete successfully:

There is an open question as to whether there should be any attempt
to resolve the OID provided by the client in this context, as a filter
for the clone to be used on the remote side.  For cases where local
and remote OID resolutions differ, resolving on the client side could
be considered a bug.  For now, the minimal approach here is used to
unblock further testing for partial clones with sparse filters, while
a more invasive fix could make sense to pursue as a future direction.

t5616 is updated to demonstrate the change.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 list-objects-filter-options.c |  3 ++-
 t/t5616-partial-clone.sh      | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 1cb20c659c..aaba312edb 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -71,7 +71,8 @@ static int gently_parse_list_objects_filter(
 		 * command, but DO NOT complain if we don't have the blob or
 		 * ref locally.
 		 */
-		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
+		if (have_git_dir() &&
+		    !get_oid_with_context(the_repository, v0, GET_OID_BLOB,
 					  &sparse_oid, &oc))
 			filter_options->sparse_oid_value = oiddup(&sparse_oid);
 		filter_options->choice = LOFC_SPARSE_OID;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 565254558f..0c6f365bf2 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -241,6 +241,27 @@ test_expect_success 'fetch what is specified on CLI even if already promised' '
 	! grep "?$(cat blob)" missing_after
 '
 
+test_expect_success 'setup src repo for sparse filter' '
+	git init sparse-src &&
+	git -C sparse-src config --local uploadpack.allowfilter 1 &&
+	git -C sparse-src config --local uploadpack.allowanysha1inwant 1 &&
+	for n in 1 2 3 4
+	do
+		test_commit -C sparse-src "this-is-file-$n" file.$n.txt || return 1
+	done &&
+	test_write_lines /file1.txt /file3.txt >sparse-src/odd-files &&
+	test_write_lines /file2.txt /file4.txt >sparse-src/even-files &&
+	test_write_lines /* >sparse-src/all-files &&
+	git -C sparse-src add odd-files even-files all-files &&
+	git -C sparse-src commit -m "some sparse checkout files"
+'
+
+test_expect_success 'partial clone with sparse filter succeeds' '
+	git clone --no-local --no-checkout --filter=sparse:oid=master:all-files sparse-src pc-all &&
+	git clone --no-local --no-checkout --filter=sparse:oid=master:even-files sparse-src pc-even &&
+	git clone --no-local --no-checkout --filter=sparse:oid=master:odd-files sparse-src pc-odd
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.23.0.37.g745f681289.dirty

