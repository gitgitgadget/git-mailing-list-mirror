From: larsxschneider@gmail.com
Subject: [PATCH v9] git-p4: Obey core.ignorecase when using P4 client specs
Date: Fri, 28 Aug 2015 14:00:34 +0200
Message-ID: <1440763234-60172-2-git-send-email-larsxschneider@gmail.com>
References: <1440763234-60172-1-git-send-email-larsxschneider@gmail.com>
Cc: git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Lars Schneider <larsxschneider@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 28 14:00:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVIKq-0004H9-AF
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 14:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbH1MAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 08:00:40 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:32931 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbbH1MAj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 08:00:39 -0400
Received: by wieo17 with SMTP id o17so13200899wie.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 05:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NKivL6Os0VnetvPsDxQlGHnF0gRMHpSZDV3kAVHEA0Y=;
        b=Sf/HTB7hdAjHPIR0XKgVWcxFbRiBOuGcLR8hG4HNHIg0wZiSI/5BCxbwqKkDksVD7S
         PTcajih25h+YtoZryhivitNp1LFvbi7f/E6u7XeKF8u3AGeiGw1/1HiL4yvNtbCYrCD5
         zZmbXzzzl7tr7dkf/UqMxJPTN12yDxAOFO+vDi4baqY81u9cuGo2/jjmvpLIP2U34ev7
         buel5kCWg5zCv3IiJpxo54xoMv/mqgXHp+xI2OdYNdQwLWki1O6Sf1sO9j3cGtWFM2DF
         rvxEemDNKky+JxBpbJ62z0eXIUQJeM/K/TNOb8d/39AT80ZaByvPGQ90m8hGBtS8TKfz
         lAKA==
X-Received: by 10.181.11.168 with SMTP id ej8mr4175889wid.83.1440763237661;
        Fri, 28 Aug 2015 05:00:37 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id lg6sm7745828wjb.10.2015.08.28.05.00.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Aug 2015 05:00:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1440763234-60172-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276717>

From: Lars Schneider <larsxschneider@gmail.com>

Perforce depot may record paths in mixed cases, e.g. "p4 files" may
show that there are these two paths:

   //depot/Path/to/file1
   //depot/pATH/to/file2

and with "p4" or "p4v", these end up in the same directory, e.g.

   //depot/Path/to/file1
   //depot/Path/to/file2

which is the desired outcome on case insensitive systems.

If git-p4 is used with client spec "//depot/Path/...", however, then
all files not matching the case in the client spec are ignored (in
the example above "//depot/pATH/to/file2").

Fix this by using the path case that appears first in lexicographical
order when core.ignorecase is set to true. This behavior is consistent
with "p4" and "p4v".

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Acked-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py                         |   7 ++
 t/t9821-git-p4-path-variations.sh | 200 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100755 t/t9821-git-p4-path-variations.sh

diff --git a/git-p4.py b/git-p4.py
index 073f87b..0093fa3 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1950,10 +1950,14 @@ class View(object):
             if "unmap" in res:
                 # it will list all of them, but only one not unmap-ped
                 continue
+            if gitConfigBool("core.ignorecase"):
+                res['depotFile'] = res['depotFile'].lower()
             self.client_spec_path_cache[res['depotFile']] = self.convert_client_path(res["clientFile"])
 
         # not found files or unmap files set to ""
         for depotFile in fileArgs:
+            if gitConfigBool("core.ignorecase"):
+                depotFile = depotFile.lower()
             if depotFile not in self.client_spec_path_cache:
                 self.client_spec_path_cache[depotFile] = ""
 
@@ -1962,6 +1966,9 @@ class View(object):
            depot file should live.  Returns "" if the file should
            not be mapped in the client."""
 
+        if gitConfigBool("core.ignorecase"):
+            depot_path = depot_path.lower()
+
         if depot_path in self.client_spec_path_cache:
             return self.client_spec_path_cache[depot_path]
 
diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
new file mode 100755
index 0000000..81e46ac
--- /dev/null
+++ b/t/t9821-git-p4-path-variations.sh
@@ -0,0 +1,200 @@
+#!/bin/sh
+
+test_description='Clone repositories with path case variations'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d with case folding enabled' '
+	start_p4d -C1
+'
+
+test_expect_success 'Create a repo with path case variations' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+
+		mkdir -p Path/to &&
+		>Path/to/File2.txt &&
+		p4 add Path/to/File2.txt &&
+		p4 submit -d "Add file2" &&
+		rm -rf Path &&
+
+		mkdir -p path/TO &&
+		>path/TO/file1.txt &&
+		p4 add path/TO/file1.txt &&
+		p4 submit -d "Add file1" &&
+		rm -rf path &&
+
+		mkdir -p path/to &&
+		>path/to/file3.txt &&
+		p4 add path/to/file3.txt &&
+		p4 submit -d "Add file3" &&
+		rm -rf path &&
+
+		mkdir -p x-outside-spec &&
+		>x-outside-spec/file4.txt &&
+		p4 add x-outside-spec/file4.txt &&
+		p4 submit -d "Add file4" &&
+		rm -rf x-outside-spec
+	)
+'
+
+test_expect_success 'Clone root' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config core.ignorecase false &&
+		git p4 clone --use-client-spec --destination="$git" //depot &&
+		# This method is used instead of "test -f" to ensure the case is
+		# checked even if the test is executed on case-insensitive file systems.
+		# All files are there as expected although the path cases look random.
+		cat >expect <<-\EOF &&
+		Path/to/File2.txt
+		path/TO/file1.txt
+		path/to/file3.txt
+		x-outside-spec/file4.txt
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone root (ignorecase)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config core.ignorecase true &&
+		git p4 clone --use-client-spec --destination="$git" //depot &&
+		# This method is used instead of "test -f" to ensure the case is
+		# checked even if the test is executed on case-insensitive file systems.
+		# All files are there as expected although the path cases look random.
+		cat >expect <<-\EOF &&
+		path/TO/File2.txt
+		path/TO/file1.txt
+		path/TO/file3.txt
+		x-outside-spec/file4.txt
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone root and ignore one file' '
+	client_view \
+		"//depot/... //client/..." \
+		"-//depot/path/TO/file1.txt //client/path/TO/file1.txt" &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config core.ignorecase false &&
+		git p4 clone --use-client-spec --destination="$git" //depot &&
+		# We ignore one file in the client spec and all path cases change from
+		# "TO" to "to"!
+		cat >expect <<-\EOF &&
+		Path/to/File2.txt
+		path/to/file3.txt
+		x-outside-spec/file4.txt
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone root and ignore one file (ignorecase)' '
+	client_view \
+		"//depot/... //client/..." \
+		"-//depot/path/TO/file1.txt //client/path/TO/file1.txt" &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config core.ignorecase true &&
+		git p4 clone --use-client-spec --destination="$git" //depot &&
+		# We ignore one file in the client spec and all path cases change from
+		# "TO" to "to"!
+		cat >expect <<-\EOF &&
+		Path/to/File2.txt
+		Path/to/file3.txt
+		x-outside-spec/file4.txt
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone path' '
+	client_view "//depot/Path/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config core.ignorecase false &&
+		git p4 clone --use-client-spec --destination="$git" //depot &&
+		cat >expect <<-\EOF &&
+		to/File2.txt
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone path (ignorecase)' '
+	client_view "//depot/Path/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config core.ignorecase true &&
+		git p4 clone --use-client-spec --destination="$git" //depot &&
+		cat >expect <<-\EOF &&
+		TO/File2.txt
+		TO/file1.txt
+		TO/file3.txt
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+# It looks like P4 determines the path case based on the first file in
+# lexicographical order. Please note the lower case "to" directory for all
+# files triggered through the addition of "File0.txt".
+test_expect_success 'Add a new file and clone path with new file (ignorecase)' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		mkdir -p Path/to &&
+		>Path/to/File0.txt &&
+		p4 add Path/to/File0.txt &&
+		p4 submit -d "Add file" &&
+		rm -rf Path
+	) &&
+
+	client_view "//depot/Path/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config core.ignorecase true &&
+		git p4 clone --use-client-spec --destination="$git" //depot &&
+		cat >expect <<-\EOF &&
+		to/File0.txt
+		to/File2.txt
+		to/file1.txt
+		to/file3.txt
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.9.5 (Apple Git-50.3)
