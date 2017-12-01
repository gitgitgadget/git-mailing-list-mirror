Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD8120C11
	for <e@80x24.org>; Fri,  1 Dec 2017 02:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdLACcr (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 21:32:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62072 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751790AbdLACcp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 21:32:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A74A6B19A3;
        Thu, 30 Nov 2017 21:32:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Qr7o
        rWD9apnictms/LznWin6J9Y=; b=sHDjetlGbZBSc6biIiyC96rUB6GvQ15fP1rI
        S7HjMyvkWWiG4XWlPUOuBXI6kuOxC5dsDB4JGu3BusVAouBEFhuC6iuIaTDO5Dg5
        MUZGbGYeumFWXEsiLyUoYuTpID8ySWEQPoIgrc1Y0PvopjQ+j/gGbbz0Mj/FGNdd
        NNYOkAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        Q0mazRpreWJZ4udWnwCBmYDH9lgm+X3GylZb4BzMp7zevrt6BXNSw2CqiSJMbMmH
        UgZn/uUpnnaFmg0ocZBWMsKj29h/GwyS+FuNahNRYNaxfx2QaUfsM99pN271A9Rf
        p3kuS0JXxzj807LNs6YmP52RvJU/y0MrenqXWT67kho=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A04DBB19A2;
        Thu, 30 Nov 2017 21:32:44 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12A6CB1999;
        Thu, 30 Nov 2017 21:32:43 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>
Subject: [PATCH 2/2] t/lib-git-svn.sh: improve svnserve tests with parallel make test
Date:   Thu, 30 Nov 2017 21:32:39 -0500
Message-Id: <20171201023239.26153-3-tmz@pobox.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171201023239.26153-1-tmz@pobox.com>
References: <20171201023239.26153-1-tmz@pobox.com>
X-Pobox-Relay-ID: E93318EE-D63F-11E7-A230-8EF31968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, setting SVNSERVE_PORT enabled several tests which require a
local svnserve daemon to be run (in t9113 & t9126).  The tests share the
setup of the local svnserve via `start_svnserve()`.  The function uses
the svnserve option `--listen-once` which causes svnserve to accept one
connection on the port, serve it, and exit.  When running the tests in
parallel this fails if one test tries to start svnserve while the other
is still running.

Use the test number as the svnserve port (similar to httpd tests) to
avoid port conflicts.  Set GIT_TEST_SVNSERVE to any value other than
'false' or 'auto' to enable these tests.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-git-svn.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 84366b2624..4c1f81f167 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -110,14 +110,16 @@ EOF
 }
 
 require_svnserve () {
-	if test -z "$SVNSERVE_PORT"
+	test_tristate GIT_TEST_SVNSERVE
+	if ! test "$GIT_TEST_SVNSERVE" = true
 	then
-		skip_all='skipping svnserve test. (set $SVNSERVE_PORT to enable)'
+		skip_all='skipping svnserve test. (set $GIT_TEST_SVNSERVE to enable)'
 		test_done
 	fi
 }
 
 start_svnserve () {
+	SVNSERVE_PORT=${SVNSERVE_PORT-${this_test#t}}
 	svnserve --listen-port $SVNSERVE_PORT \
 		 --root "$rawsvnrepo" \
 		 --listen-once \
-- 
2.15.1

