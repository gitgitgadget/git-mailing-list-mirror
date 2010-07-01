From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v5 2/4] Introduce "double conversion during merge" more gradually
Date: Thu,  1 Jul 2010 11:09:50 +0200
Message-ID: <3ae294ef30c3539da47d101bc39638e63721eb0e.1277974452.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 11:10:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUFmv-0007IR-VH
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab0GAJKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 05:10:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61087 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab0GAJKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 05:10:07 -0400
Received: by bwz1 with SMTP id 1so797024bwz.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mxXz7FN0VmaRCaUyHLd0Tu1yfLWJHeO13H2CAx3aEPc=;
        b=jZPtG7eYi4KXn19TEGb0ZbgPWQw/Op4MnKGT8gMhb3d7iMNGSWAH/SKM5z3aEvvKBt
         nRCHRwiLJMvPj5kURvoRORdhWnqD1Y3d6h7oKgNxwRs8wFpbno8l9bk+2T7jczGIWf6t
         5W/g/V6YU7M0gXpT16ZdTXpu4Ncvp/CHcbYBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vu/EyuwZ1Ooyl6PpzPTho2yUy0vJ5ZlMQ68cSqiwN98TNnA/9hxlWIu6tEKZgRHswQ
         Kzn7ONvAIVjkx/D+Q19LDyI11pkcLSVvf86bTOoIQ5LULfzE5OqImGnJw28r4ookGJad
         d2OR4WqMica3qJO0VbwoEx6QA/VeMoujFeIOQ=
Received: by 10.204.83.225 with SMTP id g33mr7354012bkl.37.1277975405692;
        Thu, 01 Jul 2010 02:10:05 -0700 (PDT)
Received: from localhost.localdomain ([62.113.137.5])
        by mx.google.com with ESMTPS id bi18sm11444654bkb.21.2010.07.01.02.10.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 02:10:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.4.g09d06
In-Reply-To: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150014>

From: Junio C Hamano <gitster@pobox.com>

This marks the recent improvement to the merge machinery that helps people
who changed their mind between CRLF/LF an opt in feature, so that we can
more easily release it early to everybody, without fear of breaking the
majority of users (read: on POSIX) that don't need it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Documentation/config.txt        |   10 ++++++++++
 Documentation/gitattributes.txt |    5 +++--
 cache.h                         |    1 +
 config.c                        |    5 +++++
 environment.c                   |    1 +
 ll-merge.c                      |    8 +++++---
 t/t6038-merge-text-auto.sh      |    1 +
 7 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 72949e7..454cbc7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -538,6 +538,16 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
 
+core.mergePrefilter::
+	Tell git that canonical representation of files in the repository
+	has changed over time (e.g. earlier commits record text files
+	with CRLF line endings, but recent ones use LF line endings).  In
+	such a repository, git can convert the data recorded in commits to
+	a canonical form before performing a merge to reduce unnecessary
+	conflicts.  For more information, see section
+	"Merging branches with differing checkin/checkout attributes" in
+	linkgit:gitattributes[5].
+
 add.ignore-errors::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 22400c1..316fac0 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -351,9 +351,10 @@ clean/smudge filter or text/eol/ident attributes, merging anything
 where the attribute is not in place would normally cause merge
 conflicts.
 
-To prevent these unnecessary merge conflicts, git runs a virtual
+To prevent these unnecessary merge conflicts, git can be told to run a virtual
 check-out and check-in of all three stages of a file when resolving a
-three-way merge.  This prevents changes caused by check-in conversion
+three-way merge by setting the `core.mergePrefilter` configuration variable.
+This prevents changes caused by check-in conversion
 from causing spurious merge conflicts when a converted file is merged
 with an unconverted file.
 
diff --git a/cache.h b/cache.h
index aa725b0..255da02 100644
--- a/cache.h
+++ b/cache.h
@@ -551,6 +551,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_merge_prefilter;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/config.c b/config.c
index cdcf583..36a0d1a 100644
--- a/config.c
+++ b/config.c
@@ -595,6 +595,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.mergeprefilter")) {
+		core_merge_prefilter = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 83d38d3..59c4515 100644
--- a/environment.c
+++ b/environment.c
@@ -53,6 +53,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int core_merge_prefilter;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/ll-merge.c b/ll-merge.c
index 28c6f54..8e59ea7 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -344,9 +344,11 @@ int ll_merge(mmbuffer_t *result_buf,
 	const struct ll_merge_driver *driver;
 	int virtual_ancestor = flag & 01;
 
-	normalize_file(ancestor, path);
-	normalize_file(ours, path);
-	normalize_file(theirs, path);
+	if (core_merge_prefilter) {
+		normalize_file(ancestor, path);
+		normalize_file(ours, path);
+		normalize_file(theirs, path);
+	}
 	if (!git_path_check_merge(path, check)) {
 		ll_driver_name = check[0].value;
 		if (check[1].value) {
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 44e6003..1f2b3a8 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -5,6 +5,7 @@ test_description='CRLF merge conflict across text=auto change'
 . ./test-lib.sh
 
 test_expect_success setup '
+	git config core.mergeprefilter true &&
 	git config core.autocrlf false &&
 	echo first line | append_cr >file &&
 	git add file &&
-- 
1.7.2.rc1.4.g09d06
