From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/3] read-cache: add index.version config variable
Date: Sun, 23 Feb 2014 21:49:59 +0100
Message-ID: <1393188599-5391-4-git-send-email-t.gummerer@gmail.com>
References: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, sunshine@sunshineco.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 23 21:50:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHg0B-0007Tw-FX
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 21:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbaBWUuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 15:50:09 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:39799 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbaBWUuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 15:50:06 -0500
Received: by mail-la0-f42.google.com with SMTP id ec20so259830lab.15
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 12:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4klRVqNfRUVYVA8JkHPlqQciEFUyCfVz0cd4tqPmNeY=;
        b=JTWpZgWpKUnfGIj+8eMYD6Y4X2H7BDsArTeQoVoG5zDnSlNohClLpU2kp7FN5HhVzm
         OlYLz8XeiFLnhIVPu5Nkbm9Q0/88hXrIDD/xdLOmFNCyMr/XinAYv9ZkaA1VwpbQSROX
         tn5sS/MyVGdz5YaUqoWO1mGp/QwrHc6SnIY1MUwuDlmAIC5cIEioMi5FsFlV+IUlGeNS
         ZCqv2Jb99Ezd9JLjk3UQ9t+BHcbYglIaQsyQTt0Cy96HRnUhuFriiK1ZaXpGAoKFsrtf
         y5eMJ8IdX4Dzt59VRG++Mjuk9AX4LZ56sS+P7W/aULfaBteM7f4uz2NVk6KIOvoCuoaQ
         jVwA==
X-Received: by 10.152.19.42 with SMTP id b10mr5807526lae.84.1393188605516;
        Sun, 23 Feb 2014 12:50:05 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id o10sm22190254laj.2.2014.02.23.12.50.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2014 12:50:04 -0800 (PST)
X-Mailer: git-send-email 1.9.0.1.ge0caaa8.dirty
In-Reply-To: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242549>

Add a config variable that allows setting the default index version when
initializing a new index file.  Similar to the GIT_INDEX_VERSION
environment variable this only affects new index files.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/config.txt |  4 ++++
 read-cache.c             | 35 ++++++++++++++++++++++++++---------
 t/t1600-index.sh         | 27 +++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f4d793..98200aa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1601,6 +1601,10 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
+index.version::
+	Specify the version with which new index files should be
+	initialized.  This does not affect existing repositories.
+
 init.templatedir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
diff --git a/read-cache.c b/read-cache.c
index efc4aae..6bc9724 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1219,23 +1219,40 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 
 #define INDEX_FORMAT_DEFAULT 3
 
+static int index_format_config(const char *var, const char *value, void *cb)
+{
+	unsigned int *version = cb;
+	if (!strcmp(var, "index.version")) {
+		*version = git_config_int(var, value);
+		return 0;
+	}
+	return 1;
+}
+
 static unsigned int get_index_format_default(void)
 {
 	char *envversion = getenv("GIT_INDEX_VERSION");
-	if (!envversion) {
-		return INDEX_FORMAT_DEFAULT;
-	} else {
-		char *endp;
-		unsigned int version = strtoul(envversion, &endp, 10);
+	char *endp;
+	unsigned int version = INDEX_FORMAT_DEFAULT;
 
-		if (*endp ||
-		    version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
-			warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
+	if (!envversion) {
+		git_config(index_format_config, &version);
+		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
+			warning(_("index.version set, but the value is invalid.\n"
 				  "Using version %i"), INDEX_FORMAT_DEFAULT);
-			version = INDEX_FORMAT_DEFAULT;
+			return INDEX_FORMAT_DEFAULT;
 		}
 		return version;
 	}
+
+	version = strtoul(envversion, &endp, 10);
+	if (*endp ||
+	    version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
+		warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
+			  "Using version %i"), INDEX_FORMAT_DEFAULT);
+		version = INDEX_FORMAT_DEFAULT;
+	}
+	return version;
 }
 
 /*
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 6195c55..079d241 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -46,4 +46,31 @@ test_expect_success 'no warning with bogus GIT_INDEX_VERSION and existing index'
 	)
 '
 
+test_expect_success 'out of bounds index.version issues warning' '
+	(
+		sane_unset GIT_INDEX_VERSION &&
+		rm -f .git/index &&
+		git config --add index.version 1 &&
+		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
+		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
+			warning: index.version set, but the value is invalid.
+			Using version Z
+		EOF
+		test_i18ncmp expect.err actual.err
+	)
+'
+
+test_expect_success 'GIT_INDEX_VERSION takes precedence over config' '
+	(
+		rm -f .git/index &&
+		GIT_INDEX_VERSION=4 &&
+		export GIT_INDEX_VERSION &&
+		git config --add index.version 2 &&
+		git add a 2>&1 &&
+		echo 4 >expect &&
+		test-index-version <.git/index >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
1.9.0.1.ge0caaa8.dirty
