From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/3] introduce GIT_INDEX_VERSION environment variable
Date: Sat, 15 Feb 2014 20:23:13 +0100
Message-ID: <1392492197-7724-2-git-send-email-t.gummerer@gmail.com>
References: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 20:24:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEkqX-0006N8-GV
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 20:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbaBOTYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 14:24:09 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33418 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbaBOTYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 14:24:06 -0500
Received: by mail-lb0-f176.google.com with SMTP id w7so10064137lbi.7
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 11:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z+pwpahLeqXcDWyQOeIfRzlstx/89N2B4nmeiqWoYI0=;
        b=k12oRw8FV5LkV03Nyuoa/jEgj2qG04JbtuNZ4s2iBHsFd+FO7evr0P+XMvhV719BpX
         danHU3izjiM6vwA6ZElGdBCJLOT9AvpRorqpOidCDthISMjIelLHkQB0JwwV33TsW6Q2
         lk/+kzM+Sc5uvc2L32WN63XPOBwOmHBPV6WWEGHZR7ruJlFOOlBS6dGi1/+Ti7OkMXXb
         5yysgEvfqbTjWJz3L0dhLPKO9I8R6ADswVq8YCbQrBumuI8DbuVdJJMLeHbkyUqlejJY
         1qt3iVyZIOtV5cejWcEknBA7US329eJpgof2TACT8hZQfj05Yg5jzLc3lvIDEZwG7poe
         Nfng==
X-Received: by 10.152.242.131 with SMTP id wq3mr11049692lac.12.1392492245413;
        Sat, 15 Feb 2014 11:24:05 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id g8sm15282430lae.1.2014.02.15.11.24.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Feb 2014 11:24:04 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.300.gb39ba80
In-Reply-To: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242200>

Respect a GIT_INDEX_VERSION environment variable, when a new index is
initialized.  Setting the environment variable will not cause existing
index files to be converted to another format, but will only affect
newly written index files.  This can be used to initialize repositories
with index-v4.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git.txt |  5 +++++
 read-cache.c          | 18 +++++++++++++++++-
 t/t1600-index.sh      | 24 ++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100755 t/t1600-index.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index aec3726..bc9eeea 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -712,6 +712,11 @@ Git so take care if using Cogito etc.
 	index file. If not specified, the default of `$GIT_DIR/index`
 	is used.
 
+'GIT_INDEX_VERSION'::
+	This environment variable allows the specification of an index
+	version for new repositories.  It won't affect existing index
+	files.  By default index file version 3 is used.
+
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
 	environment variable then the sha1 directories are created
diff --git a/read-cache.c b/read-cache.c
index 3f735f3..3993e12 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1223,6 +1223,22 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 
 #define INDEX_FORMAT_DEFAULT 3
 
+static unsigned int get_index_format_default()
+{
+	char *envversion = getenv("GIT_INDEX_VERSION");
+	if (!envversion) {
+		return INDEX_FORMAT_DEFAULT;
+	} else {
+		unsigned int version = strtol(envversion, NULL, 10);
+		if (version < INDEX_FORMAT_LB || version > INDEX_FORMAT_UB) {
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
@@ -1799,7 +1815,7 @@ int write_index(struct index_state *istate, int newfd)
 	}
 
 	if (!istate->version)
-		istate->version = INDEX_FORMAT_DEFAULT;
+		istate->version = get_index_format_default();
 
 	/* demote version 3 to version 2 when the latter suffices */
 	if (istate->version == 3 || istate->version == 2)
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
new file mode 100755
index 0000000..37fd84d
--- /dev/null
+++ b/t/t1600-index.sh
@@ -0,0 +1,24 @@
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
+test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
+	(
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
+test_done
-- 
1.8.5.2.300.ge613be6.dirty
