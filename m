From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/3] introduce GIT_INDEX_VERSION environment variable
Date: Sun, 23 Feb 2014 21:49:57 +0100
Message-ID: <1393188599-5391-2-git-send-email-t.gummerer@gmail.com>
References: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, sunshine@sunshineco.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 23 21:50:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHg0E-0007Vi-SV
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 21:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaBWUuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 15:50:05 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:41314 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbaBWUuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 15:50:04 -0500
Received: by mail-la0-f46.google.com with SMTP id b8so4650480lan.19
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 12:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o97WWnDae3KRpH01nEMoWbVYk9ibWToVWhcT8z1IVho=;
        b=KLKSfqw1iOaypIUsQzeY+S8AAIDu8bY9ZSFULeYOu5OH/z6DFt8Kz/itKPx8wHIjtZ
         okM1estQn13q2YlP9pEvy89Mms1XsjOAomKWbP/YINoLyde8BtIMLEhvwO2ckDwVAG2i
         LzoZM+y/Wi6RV50SQn+KPRi03vIexLVxD6sWaOcHZoenvPwE9idVNUsvGjhuRTmLx7kn
         /+4RiQAaBQEuuIGOUtADo/UzEwviNcWBqkFZT/lS1IdxyudEb2VaIIQEckjFvOWmiDWL
         PnVAIjHXK23hhslM3EcD8jnOLOLsSzBNWDRAEbm2bC3KwMb60PPo5QbeC1LduWHaQVVO
         HArQ==
X-Received: by 10.112.172.8 with SMTP id ay8mr9518604lbc.41.1393188600783;
        Sun, 23 Feb 2014 12:50:00 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id jf8sm16085251lbc.8.2014.02.23.12.49.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2014 12:49:59 -0800 (PST)
X-Mailer: git-send-email 1.9.0.1.ge0caaa8.dirty
In-Reply-To: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242550>

Respect a GIT_INDEX_VERSION environment variable, when a new index is
initialized.  Setting the environment variable will not cause existing
index files to be converted to another format, but will only affect
newly written index files.  This can be used to initialize repositories
with index-v4.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git.txt |  5 +++++
 read-cache.c          | 21 ++++++++++++++++++++-
 t/t1600-index.sh      | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100755 t/t1600-index.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 02bbc08..27a199c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -720,6 +720,11 @@ Git so take care if using Cogito etc.
 	index file. If not specified, the default of `$GIT_DIR/index`
 	is used.
 
+'GIT_INDEX_VERSION'::
+	This environment variable allows the specification of an index
+	version for new repositories.  It won't affect existing index
+	files.  By default index file version [23] is used.
+
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
 	environment variable then the sha1 directories are created
diff --git a/read-cache.c b/read-cache.c
index 33dd676..efc4aae 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1219,6 +1219,25 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 
 #define INDEX_FORMAT_DEFAULT 3
 
+static unsigned int get_index_format_default(void)
+{
+	char *envversion = getenv("GIT_INDEX_VERSION");
+	if (!envversion) {
+		return INDEX_FORMAT_DEFAULT;
+	} else {
+		char *endp;
+		unsigned int version = strtoul(envversion, &endp, 10);
+
+		if (*endp ||
+		    version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
+			warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
+				  "Using version %i"), INDEX_FORMAT_DEFAULT);
+			version = INDEX_FORMAT_DEFAULT;
+		}
+		return version;
+	}
+}
+
 /*
  * dev/ino/uid/gid/size are also just tracked to the low 32 bits
  * Again - this is just a (very strong in practice) heuristic that
@@ -1795,7 +1814,7 @@ int write_index(struct index_state *istate, int newfd)
 	}
 
 	if (!istate->version)
-		istate->version = INDEX_FORMAT_DEFAULT;
+		istate->version = get_index_format_default();
 
 	/* demote version 3 to version 2 when the latter suffices */
 	if (istate->version == 3 || istate->version == 2)
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
new file mode 100755
index 0000000..6195c55
--- /dev/null
+++ b/t/t1600-index.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='index file specific tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo 1 >a
+'
+
+test_expect_success 'bogus GIT_INDEX_VERSION issues warning' '
+	(
+		rm -f .git/index &&
+		GIT_INDEX_VERSION=2bogus &&
+		export GIT_INDEX_VERSION &&
+		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
+		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
+			warning: GIT_INDEX_VERSION set, but the value is invalid.
+			Using version Z
+		EOF
+		test_i18ncmp expect.err actual.err
+	)
+'
+
+test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
+	(
+		rm -f .git/index &&
+		GIT_INDEX_VERSION=1 &&
+		export GIT_INDEX_VERSION &&
+		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
+		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
+			warning: GIT_INDEX_VERSION set, but the value is invalid.
+			Using version Z
+		EOF
+		test_i18ncmp expect.err actual.err
+	)
+'
+
+test_expect_success 'no warning with bogus GIT_INDEX_VERSION and existing index' '
+	(
+		GIT_INDEX_VERSION=1 &&
+		export GIT_INDEX_VERSION &&
+		git add a 2>actual.err &&
+		>expect.err &&
+		test_i18ncmp expect.err actual.err
+	)
+'
+
+test_done
-- 
1.9.0.1.ge0caaa8.dirty
