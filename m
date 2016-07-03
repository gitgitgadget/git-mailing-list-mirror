Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4540A20179
	for <e@80x24.org>; Sun,  3 Jul 2016 07:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbcGCH6j (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 03:58:39 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55397 "EHLO
	homiemail-a21.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869AbcGCH6d convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2016 03:58:33 -0400
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id E357C300080;
	Sun,  3 Jul 2016 00:58:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=novalis.org; bh=utu1x
	3mqc36npNXPBaMBq6J1hN4=; b=DHIE5SXAe4ouEaCguuwT2BoywO/vqCRIS0Y3z
	pI2yq3c076wePTX4RUvTutFDwyQ70pYjnvlk+XgSvmHk77VSKB9nqOSmFk3IbfaQ
	oem6ws1FbWVbkaafQHyjOqmb2qDOC+uGZCQSvy4hisj4ZkD9altffbRXGABwTgB7
	Jw+gYg=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id 4203F300061;
	Sun,  3 Jul 2016 00:58:32 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v14 06/21] daemonize(): set a flag before exiting the main process
Date:	Sun,  3 Jul 2016 03:57:58 -0400
Message-Id: <1467532693-20017-7-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

This allows signal handlers and atexit functions to realize this
situation and not clean up.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/gc.c | 2 +-
 cache.h      | 2 +-
 daemon.c     | 2 +-
 setup.c      | 4 +++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c583aad..37180de 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -385,7 +385,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
-			daemonized = !daemonize();
+			daemonized = !daemonize(NULL);
 		}
 	} else
 		add_repack_all_option();
diff --git a/cache.h b/cache.h
index 6cb0d02..4c1529a 100644
--- a/cache.h
+++ b/cache.h
@@ -539,7 +539,7 @@ extern int set_git_dir_init(const char *git_dir, const char *real_git_dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
 
 extern void sanitize_stdfds(void);
-extern int daemonize(void);
+extern int daemonize(int *);
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
diff --git a/daemon.c b/daemon.c
index 8d45c33..a5cf954 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1365,7 +1365,7 @@ int main(int argc, char **argv)
 		return execute();
 
 	if (detach) {
-		if (daemonize())
+		if (daemonize(NULL))
 			die("--detach not supported on this platform");
 	} else
 		sanitize_stdfds();
diff --git a/setup.c b/setup.c
index de1a2a7..9adf13f 100644
--- a/setup.c
+++ b/setup.c
@@ -1017,7 +1017,7 @@ void sanitize_stdfds(void)
 		close(fd);
 }
 
-int daemonize(void)
+int daemonize(int *daemonized)
 {
 #ifdef NO_POSIX_GOODIES
 	errno = ENOSYS;
@@ -1029,6 +1029,8 @@ int daemonize(void)
 		case -1:
 			die_errno("fork failed");
 		default:
+			if (daemonized)
+				*daemonized = 1;
 			exit(0);
 	}
 	if (setsid() == -1)
-- 
1.9.1

