Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00B71FEAA
	for <e@80x24.org>; Mon, 18 Jul 2016 10:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbcGRKWL (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 06:22:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53170 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbcGRKWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 06:22:10 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1178D1FEAA;
	Mon, 18 Jul 2016 10:22:09 +0000 (UTC)
Date:	Mon, 18 Jul 2016 10:22:08 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: [PATCH] configure.ac: stronger test for pthread linkage
Message-ID: <20160718102208.GA23220@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We need to test linkage of pthread_create and pthread_join,
as pthread_mutex_* and pthread_key_* functions do not need
extra linkage under FreeBSD 10.3, leading to a false-positive
of the empty case.

Signed-off-by: Eric Wong <e@80x24.org>
---
 configure.ac | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index c279025..aa9c91d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1108,14 +1108,19 @@ GIT_CONF_SUBST([HAVE_BSD_SYSCTL])
 AC_DEFUN([PTHREADTEST_SRC], [
 AC_LANG_PROGRAM([[
 #include <pthread.h>
+static void *noop(void *ignore) { return ignore; }
 ]], [[
 	pthread_mutex_t test_mutex;
 	pthread_key_t test_key;
+	pthread_t th;
 	int retcode = 0;
+	void *ret = (void *)0;
 	retcode |= pthread_key_create(&test_key, (void *)0);
 	retcode |= pthread_mutex_init(&test_mutex,(void *)0);
 	retcode |= pthread_mutex_lock(&test_mutex);
 	retcode |= pthread_mutex_unlock(&test_mutex);
+	retcode |= pthread_create(&th, ret, noop, ret);
+	retcode |= pthread_join(th, &ret);
 	return retcode;
 ]])])
 
-- 
EW
