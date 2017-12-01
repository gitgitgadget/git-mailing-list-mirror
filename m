Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65CF420954
	for <e@80x24.org>; Fri,  1 Dec 2017 15:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbdLAP5A (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 10:57:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61322 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752138AbdLAP46 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 10:56:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94636C9836;
        Fri,  1 Dec 2017 10:56:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:in-reply-to
        :references; s=sasl; bh=DOkuMucElbUeQEiAeZEmoaeWt+8=; b=bthKzE7G
        pR1PvRv7+shUtjLpLPT4CxON6jzATD+gd7VNJoxXDthQ8RrUsnDGOn7qZ1NtMgUt
        wv8o9QCMIU0t4TOdzv5wICU1VJeI12JrfWUkPreS1a1DmNu0lw60A2Cnb0Gr0tgc
        0qv4W+07nPAMQ0ptxhQ2ZSoIoJAz4knj0yI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:in-reply-to
        :references; q=dns; s=sasl; b=W0iR805wfrFFgvC04Pg41ABQ4qUc6EYkwI
        Cluzd0VXzQv8p2VyGkuVfY5Viy0rDHwkRuiPbjHijgnnLdfBYCgUZnlPmjJUjcz8
        abqSJ+EZfeBnYQWvlnu8WMpuzoQ7by4ZBru3Hdb/Zq3YhPaerxUKC+B7NkNi9yha
        wHea/YAnA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C887C9835;
        Fri,  1 Dec 2017 10:56:57 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE772C9832;
        Fri,  1 Dec 2017 10:56:55 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 2/2] t/lib-git-svn.sh: improve svnserve tests with parallel make test
Date:   Fri,  1 Dec 2017 10:56:53 -0500
Message-Id: <20171201155653.29553-2-tmz@pobox.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171201155653.29553-1-tmz@pobox.com>
References: <20171201155653.29553-1-tmz@pobox.com>
In-Reply-To: <20171201153241.27071-1-tmz@pobox.com>
References: <20171201041133.GF3693@zaya.teonanacatl.net> <20171201153241.27071-1-tmz@pobox.com>
X-Pobox-Relay-ID: 422ECAFE-D6B0-11E7-96F2-575F0C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setting SVNSERVE_PORT enables several tests which require a local
svnserve daemon to be run (in t9113 & t9126).  The tests share setup of
the local svnserve via `start_svnserve()`.  The function uses svnserve's
`--listen-once` option, which causes svnserve to accept one connection
on the port, serve it, and exit.  When running the tests in parallel
this fails if one test tries to start svnserve while the other is still
running.

Use the test number as the svnserve port (similar to httpd tests) to
avoid port conflicts.  Developers can set GIT_TEST_SVNSERVE to any value
other than 'false' or 'auto' to enable these tests.

Acked-by: Eric Wong <e@80x24.org>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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

