Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6491F855
	for <e@80x24.org>; Mon,  1 Aug 2016 22:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbcHAWAa (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 18:00:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49884 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbcHAWA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 18:00:29 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111231F855;
	Mon,  1 Aug 2016 21:49:45 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH 0/1 v2] add PAGER_ENV to build
Date:	Mon,  1 Aug 2016 21:49:36 +0000
Message-Id: <20160801214937.4752-1-e@80x24.org>
In-Reply-To: <20160801010557.22191-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Changes from v1:

* dropped stringify macro in favor for quoting in Makefile
  (diff below)
  I'm not sure I like this change, and might be inclined to
  go in the opposite direction of using the stringify macro
  more widely to simplify the Makefile; but that is a separate
  topic.

* dropped 2/2, I don't have a good rationale for it, either,
  other than "it seemed easy" after 1/2 :>

The following changes since commit f8f7adce9fc50a11a764d57815602dcb818d1816:

  Sync with maint (2016-07-28 14:21:18 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git pager-env-v2

for you to fetch changes up to d3aed319c9abac006060bc81e865c93ff8363066:

  pager: move pager-specific setup into the build (2016-08-01 21:46:25 +0000)

----------------------------------------------------------------
Junio C Hamano (1):
      pager: move pager-specific setup into the build

 Makefile         | 20 +++++++++++++++++++-
 config.mak.uname |  1 +
 git-sh-setup.sh  |  8 +++++---
 pager.c          | 29 +++++++++++++++++++++++++----
 4 files changed, 50 insertions(+), 8 deletions(-)

interdiff from 1/1 v1:

diff --git a/Makefile b/Makefile
index fe469a6..0b36b5e 100644
--- a/Makefile
+++ b/Makefile
@@ -1591,7 +1591,6 @@ PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
-PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
 
 # We must filter out any object files from $(GITLIBS),
 # as it is typically used like:
@@ -1604,7 +1603,7 @@ PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
 LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
-	$(COMPAT_CFLAGS) -DPAGER_ENV='$(PAGER_ENV_SQ)'
+	$(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
 
 # Quote for C
@@ -1642,6 +1641,10 @@ ifdef DEFAULT_HELP_FORMAT
 BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
 endif
 
+PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
+PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
+BASIC_CFLAGS += -DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
+
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
diff --git a/pager.c b/pager.c
index 2f2cadc..cd1ac54 100644
--- a/pager.c
+++ b/pager.c
@@ -63,12 +63,9 @@ const char *git_pager(int stdout_is_tty)
 	return pager;
 }
 
-#define stringify_(x) #x
-#define stringify(x) stringify_(x)
-
 static void setup_pager_env(struct argv_array *env)
 {
-	const char *pager_env = stringify(PAGER_ENV);
+	const char *pager_env = PAGER_ENV;
 
 	while (*pager_env) {
 		struct strbuf buf = STRBUF_INIT;
-- 
EW
