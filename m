From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/3] read-cache: add index.version config variable
Date: Sat, 15 Feb 2014 20:23:15 +0100
Message-ID: <1392492197-7724-4-git-send-email-t.gummerer@gmail.com>
References: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 20:24:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEkqf-0006Vv-CN
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 20:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbaBOTYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 14:24:17 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:47045 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbaBOTYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 14:24:16 -0500
Received: by mail-lb0-f173.google.com with SMTP id s7so8802276lbd.32
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 11:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NeHw4n8Uvcmyx/CpDaXk7NOho3wRq/Kswgd4qHqZta0=;
        b=fADrNXpOPPG54VpqRwGniFAw3AMY6fW9Go5U76OD2OaJefCc/j2KRov4LwsORAf6QB
         hjy/VMk5dlY0pt0JD1fXPvkdsoZqLT3cp6xFkEhVD9txOPzjExu766FC3pQHeqp4Aq7i
         3wY/B98nYPtDr17tf/ULQKMNWXkQufDOwYXrojsw91+vgeD5BOfHeikQ8guEehetzE+T
         8flosuNOsDJRrDL1FF+0RAWJ86P3nSQp9DCzouP7P4JF8cP+SvD9uk/O8AWaK+tVm+fQ
         5wLnEBYwmtHIMIaBTWo1fX8u9hMZVzRfsSI5GArN1RntSJbKao41JmPngNKsI2kt/R7Q
         DIqA==
X-Received: by 10.152.219.37 with SMTP id pl5mr2918218lac.36.1392492255290;
        Sat, 15 Feb 2014 11:24:15 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id ir3sm15262167lac.9.2014.02.15.11.24.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Feb 2014 11:24:14 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.300.gb39ba80
In-Reply-To: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242201>

Add a config variable that allows setting the default index version when
initializing a new index file.  Similar to the GIT_INDEX_VERSION
environment variable this only affects new index files.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/config.txt |  4 ++++
 read-cache.c             | 27 ++++++++++++++++++++++-----
 t/t1600-index.sh         | 27 +++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1655455..033939a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1591,6 +1591,10 @@ imap::
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
index 3993e12..ca9b68c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1223,20 +1223,37 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 
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
+
 static unsigned int get_index_format_default()
 {
 	char *envversion = getenv("GIT_INDEX_VERSION");
+	unsigned int version = INDEX_FORMAT_DEFAULT;
 	if (!envversion) {
-		return INDEX_FORMAT_DEFAULT;
-	} else {
-		unsigned int version = strtol(envversion, NULL, 10);
+		git_config(index_format_config, &version);
 		if (version < INDEX_FORMAT_LB || version > INDEX_FORMAT_UB) {
-			warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
+			warning(_("index.version set, but the value is invalid.\n"
 				  "Using version %i"), INDEX_FORMAT_DEFAULT);
-			version = INDEX_FORMAT_DEFAULT;
+			return INDEX_FORMAT_DEFAULT;
 		}
 		return version;
 	}
+	version = strtol(envversion, NULL, 10);
+	if (version < INDEX_FORMAT_LB || version > INDEX_FORMAT_UB) {
+		warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
+			  "Using version %i"), INDEX_FORMAT_DEFAULT);
+		version = INDEX_FORMAT_DEFAULT;
+	}
+	return version;
 }
 
 /*
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 37fd84d..bf34985 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -21,4 +21,31 @@ test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
 	)
 '
 
+test_expect_success 'out of bounds index.version issuses warning' '
+	(
+		unset GIT_INDEX_VERSION &&
+		rm .git/index &&
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
+		rm .git/index &&
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
1.8.5.2.300.ge613be6.dirty
