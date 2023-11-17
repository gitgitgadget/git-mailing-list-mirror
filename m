Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 495 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Nov 2023 12:33:35 PST
Received: from mail.zombino.com (c3.zombino.com [91.107.222.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69459D4D
	for <git@vger.kernel.org>; Fri, 17 Nov 2023 12:33:34 -0800 (PST)
Received: from debian.desktop.box (port-92-195-213-20.dynamic.as20676.net [92.195.213.20])
	by mail.zombino.com (Postfix) with ESMTPS id E48B781895;
	Fri, 17 Nov 2023 20:25:17 +0000 (UTC)
Received: by debian.desktop.box (Postfix, from userid 1000)
	id 9ABC56019B; Fri, 17 Nov 2023 21:25:17 +0100 (CET)
From: Adam Majer <adamm@zombino.com>
To: git@vger.kernel.org
Cc: Adam Majer <adamm@zombino.com>
Subject: [PATCH] setup: recognize bare repositories with packed-refs
Date: Fri, 17 Nov 2023 21:25:13 +0100
Message-ID: <20231117202513.20604-1-adamm@zombino.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a garbage collected bare git repository is added to another git
repository, the refs/ subdirectory is empty.  In case-cases when such a
repository is added into another repository directly, it no longer is
detected as a valid. Git doesn't preserve empty paths so refs/
subdirectory is not present in parent git.  Simply creating an empty
refs/ subdirectory fixes this problem.

Looking more carefully, there are two backends to handle various refs in
git -- the files backend that uses refs/ subdirectory and the
packed-refs backend that uses packed-refs file. If references are not
found in refs/ subdirectory (or directory doesn't exist), the
packed-refs directory will be consulted. Garbage collected repository
will have all its references in packed-refs file.

To allow the use-case when packed-refs is the only source of refs and
refs/ subdirectory is simply not present, augment 'is_git_directory()'
setup function to look for packed-refs file as an alternative to refs/
subdirectory.

Signed-off-by: Adam Majer <adamm@zombino.com>
---
 setup.c       | 10 +++++++---
 t/t6500-gc.sh |  8 ++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index fc592dc6dd..2a6dda6ae9 100644
--- a/setup.c
+++ b/setup.c
@@ -348,7 +348,7 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
  *
  *  - either an objects/ directory _or_ the proper
  *    GIT_OBJECT_DIRECTORY environment variable
- *  - a refs/ directory
+ *  - a refs/ directory or packed-refs file
  *  - either a HEAD symlink or a HEAD file that is formatted as
  *    a proper "ref:", or a regular file HEAD that has a properly
  *    formatted sha1 object name.
@@ -384,8 +384,12 @@ int is_git_directory(const char *suspect)
 
 	strbuf_setlen(&path, len);
 	strbuf_addstr(&path, "/refs");
-	if (access(path.buf, X_OK))
-		goto done;
+	if (access(path.buf, X_OK)) {
+		strbuf_setlen(&path, len);
+		strbuf_addstr(&path, "/packed-refs");
+		if (access(path.buf, R_OK))
+			goto done;
+	}
 
 	ret = 1;
 done:
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 18fe1c25e6..e81eb7d2ab 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -214,6 +214,14 @@ test_expect_success 'gc.repackFilter launches repack with a filter' '
 	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
 '
 
+test_expect_success 'remove empty refs/ subdirectory' '
+	git -C bare.git cat-file -e 60dd8ad7d8ed49005c18b7ce9f5b7a45c28df814 &&
+	test_dir_is_empty bare.git/refs/heads &&
+	test_dir_is_empty bare.git/refs/tags &&
+	rm -r bare.git/refs &&
+	GIT_DIR="$PWD"/bare.git git -C bare.git cat-file -e 60dd8ad7d8ed49005c18b7ce9f5b7a45c28df814
+'
+
 test_expect_success 'gc.repackFilterTo store filtered out objects' '
 	test_when_finished "rm -rf bare.git filtered.git" &&
 
-- 
2.42.0

