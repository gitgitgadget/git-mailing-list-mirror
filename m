From: James Pickens <james.e.pickens@intel.com>
Subject: [PATCH 2/2] Add core.threadedcheckout config option
Date: Thu, 18 Dec 2008 13:56:51 -0700
Message-ID: <1229633811-3877-2-git-send-email-james.e.pickens@intel.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
 <1229633811-3877-1-git-send-email-james.e.pickens@intel.com>
Cc: James Pickens <james.e.pickens@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 21:58:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDPwp-0002HO-51
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 21:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYLRU47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 15:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbYLRU47
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 15:56:59 -0500
Received: from mga05.intel.com ([192.55.52.89]:48237 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752343AbYLRU45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 15:56:57 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 18 Dec 2008 12:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.36,245,1228118400"; 
   d="scan'208";a="415672634"
Received: from sedona.ch.intel.com ([143.182.201.200])
  by fmsmga002.fm.intel.com with ESMTP; 18 Dec 2008 12:52:14 -0800
Received: from chlr11217.ch.intel.com (chlr11217.ch.intel.com [143.182.208.217])
	by sedona.ch.intel.com (8.12.11.20060308/8.14.3/Standard MailSET/Hub) with ESMTP id mBIKusD3031755;
	Thu, 18 Dec 2008 13:56:54 -0700
Received: from chlr11217.ch.intel.com (localhost [127.0.0.1])
	by chlr11217.ch.intel.com (8.12.11.20060308/8.12.8/MailSET/client) with ESMTP id mBIKurWo003912;
	Thu, 18 Dec 2008 13:56:53 -0700
Received: (from jepicken@localhost)
	by chlr11217.ch.intel.com (8.12.11.20060308/8.12.8/MailSET/Submit) id mBIKurXC003911;
	Thu, 18 Dec 2008 13:56:53 -0700
X-Mailer: git-send-email 1.6.0.4.1116.gc5d7
In-Reply-To: <1229633811-3877-1-git-send-email-james.e.pickens@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103490>

Setting it to 'true' enables multi threaded checkout.  Default is false.
---
 Documentation/config.txt |    8 ++++++++
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    3 +++
 unpack-trees.c           |    3 +++
 5 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 21ea165..22ac76b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -422,6 +422,14 @@ relatively high IO latencies.  With this set to 'true', git will do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.
 
+core.threadedcheckout::
+	Enable parallel checkout for operations like 'git checkout'
++
+This can speed up operations like 'git clone' and 'git checkout' especially
+on filesystems like NFS that have relatively high IO latencies.  With this
+set to 'true', git will write the checked out files to disk in parallel,
+allowing overlapping IO's.
+
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/cache.h b/cache.h
index 231c06d..0777597 100644
--- a/cache.h
+++ b/cache.h
@@ -512,6 +512,7 @@ extern size_t delta_base_cache_limit;
 extern int auto_crlf;
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_threaded_checkout;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/config.c b/config.c
index 790405a..819693e 100644
--- a/config.c
+++ b/config.c
@@ -495,6 +495,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.threadedcheckout")) {
+		core_threaded_checkout = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index e278bce..2450b65 100644
--- a/environment.c
+++ b/environment.c
@@ -46,6 +46,9 @@ enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
 
+/* Parallel checkout? */
+int core_threaded_checkout = 0;
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 static char *work_tree;
diff --git a/unpack-trees.c b/unpack-trees.c
index 30b9862..635b7dc 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -165,6 +165,9 @@ static int threaded_checkout(struct index_state *index, int update, struct progr
 	struct thread_data data[MAX_PARALLEL];
 	int errs = 0;
 
+	if (!core_threaded_checkout)
+		return 0;
+
 	threads = index->cache_nr / THREAD_COST;
 	if (threads > MAX_PARALLEL)
 		threads = MAX_PARALLEL;
-- 
1.6.0.4.1116.gc5d7
