From: Ammon Riley <ammon.riley@gmail.com>
Subject: [PATCH] Add a post-tag hook
Date: Fri, 17 Apr 2009 15:15:46 -0700
Message-ID: <cd3664ac0904171515u1e2fce41ubd34f60ec43fcafd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 00:17:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuwN9-0008N3-11
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbZDQWPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 18:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbZDQWPs
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:15:48 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:50399 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbZDQWPr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:15:47 -0400
Received: by yx-out-2324.google.com with SMTP id 3so235511yxj.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=4GxWuGDIDY0KD+EcKvNCqHmNnM8u20+zGUmU9Ok88Zw=;
        b=tcopNpf4TyHZl5CsE8iu12EvO4Z/AsEmWxjNpPdX6Lg0Y8VNxAht2vyVH3mRg4/ZQr
         KL31gRQDhTjnbZzkDQNejske9BA9ioYBOXgH47vD3mITvBeUK4XHK6hw6C9PFfIo7JwO
         V/sgCIDRAca3Z5uMR9/JHvZh/MiTIBBxPCHl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=WqJXyMb8/QoIf3CxGVpdIh/6Btlau3zumbc73VniZP+KCC6nVZSA9h++Zs/PrNPJuw
         SKRADQR0mrjYhmMZ2EVJKKCVLWh5Tx/V1+IIQahz3NorAjVAasPqTU2f491XNZcT4fVA
         nT/nXAjinIswGNU/REQNxJ6+AWWKNbEqwqGdk=
Received: by 10.100.47.10 with SMTP id u10mr4145895anu.122.1240006546341; Fri, 
	17 Apr 2009 15:15:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116792>

Add a post-tag hook, to allow notifications when a tag is created.
The hook is given the name of the newly created tag.

Signed-off-by: Ammon Riley <ammon.riley@gmail.com>
---
 Documentation/git-tag.txt        |    4 ++++
 Documentation/githooks.txt       |    9 +++++++++
 builtin-tag.c                    |    2 ++
 t/t3800-tag-hook.sh              |   32 ++++++++++++++++++++++++++++++++
 templates/hooks--post-tag.sample |    8 ++++++++
 5 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100755 t/t3800-tag-hook.sh
 create mode 100755 templates/hooks--post-tag.sample

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index fa73321..3fcb3d4 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -248,6 +248,10 @@ An example follows.
 $ GIT_COMMITTER_DATE="2006-10-02 10:31" git tag -s v1.0.1
 ------------

+HOOKS
+-----
+This command can run the `post-tag` hook. See linkgit:githooks[5]
+for more information.

 Author
 ------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1c73673..4512f18 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -314,6 +314,15 @@ This hook is invoked by 'git-gc --auto'. It takes
no parameter, and
 exiting with non-zero status from this script causes the 'git-gc --auto'
 to abort.

+post-tag
+--------
+
+This hook is invoked by 'git-tag'.  It takes one parameter, the name
+of the tag, and is invoked after a tag is made.
+
+This hook is meant primarily for notification, and cannot affect
+the outcome of 'git-tag'.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin-tag.c b/builtin-tag.c
index 01e7374..e4509ba 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -482,6 +482,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (write_ref_sha1(lock, object, NULL) < 0)
 		die("%s: cannot update the ref", ref);

+	run_hook(NULL, "post-tag", tag, NULL);
+
 	strbuf_release(&buf);
 	return 0;
 }
diff --git a/t/t3800-tag-hook.sh b/t/t3800-tag-hook.sh
new file mode 100755
index 0000000..68c5877
--- /dev/null
+++ b/t/t3800-tag-hook.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='git tag with its hook
+
+This test creates a post-tag hook and tests it.'
+
+. ./test-lib.sh
+
+TAG_FILE="$(pwd)/output"
+export TAG_FILE
+
+test_expect_success 'Setting up post-tag hook' '
+    mkdir -p .git/hooks &&
+    echo >.git/hooks/post-tag "#!/bin/sh
+    echo -n \$@ > \"\${TAG_FILE}\"
+    echo Post commit hook was called." &&
+    chmod +x .git/hooks/post-tag
+'
+
+test_expect_success 'post-tag hook gets correct input' '
+    test \! -e "${TAG_FILE}" &&
+    echo initial >file &&
+    git add file &&
+    git commit -m initial &&
+    git tag mytag &&
+    test -r "${TAG_FILE}" &&
+    test "z$(cat "${TAG_FILE}")" = zmytag
+'
+
+rm -rf "${TAG_FILE}"
+
+test_done
diff --git a/templates/hooks--post-tag.sample b/templates/hooks--post-tag.sample
new file mode 100755
index 0000000..5f6a3d3
--- /dev/null
+++ b/templates/hooks--post-tag.sample
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# An example hook script that is called after a successful
+# tag is made.
+#
+# To enable this hook, rename this file to "post-tag".
+
+: Nothing
-- 
1.5.4.3
