From: Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
Subject: [PATCH v2] merge-file: correctly open files when in a subdir
Date: Tue, 10 Feb 2015 21:23:55 +0100
Message-ID: <CAPHKiG7vzKbtH7=cXD-7Cta=a-iy-ViMustn98z+VEog5ep2sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:24:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLHLl-0002w8-CP
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 21:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbbBJUX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 15:23:56 -0500
Received: from mail-qg0-f67.google.com ([209.85.192.67]:50520 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbbBJUX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 15:23:56 -0500
Received: by mail-qg0-f67.google.com with SMTP id z60so6577697qgd.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=X4ZbiHDf174xRo1zEdmJVYrEVTU2P3AY0qCZ2g67qys=;
        b=cTTxOekghFgeN9LuyKR3Wc0HXbIo/Z0SUp1bIVh2QE30B14VewhRLS6Q430Oj0GUZq
         nR+JCOAzGE8cCJdNyO/VP4uqM7yVQS1DlXFhUztM8K4uoHlEoMeD7RP6rSCSirL3D4se
         QgbZlZxjRL+9fQJFwAGdu/a8onLKIdAACw9PalRSKYTH7G4RUnfQqSp2qGfbfKpbT1QI
         puRJzSFZY8XnWAhuzjgWaJZFvGhyxHHIrV6/c3me2KpAeis0nyj0tA48eA+U/mLsljRM
         /nBDyVJtpSV681QTZQU+8omR4qbv8/mZWIwWPZR1xQO02zj4sCFV9Cnp2etIlnhVIy6i
         GCwQ==
X-Received: by 10.224.68.8 with SMTP id t8mr26197749qai.72.1423599835643; Tue,
 10 Feb 2015 12:23:55 -0800 (PST)
Received: by 10.140.83.166 with HTTP; Tue, 10 Feb 2015 12:23:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263646>

run_setup_gently() is called before merge-file. This may result in changing
current working directory, which wasn't taken into account when opening a file
for writing.

Fix by prepending the passed prefix. Previous var is left so that error
messages keep refering to the file from the user's working directory
perspective.

Signed-off-by: Aleksander Boruch-Gruszecki
    <aleksander.boruchgruszecki@gmail.com>
---
 builtin/merge-file.c  | 3 ++-
 t/t6023-merge-file.sh | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 844f84f..232b768 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -90,7 +90,8 @@ int cmd_merge_file(int argc, const char **argv,
const char *prefix)

     if (ret >= 0) {
         const char *filename = argv[0];
-        FILE *f = to_stdout ? stdout : fopen(filename, "wb");
+        const char *fpath = prefix_filename(prefix, prefixlen, argv[0]);
+        FILE *f = to_stdout ? stdout : fopen(fpath, "wb");

         if (!f)
             ret = error("Could not open %s for writing", filename);
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 3758961..fdd104c 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -72,6 +72,12 @@ test_expect_success 'works in subdirectory' '
     ( cd dir && git merge-file a.txt o.txt b.txt )
 '

+mkdir -p dir/deep
+cp new1.txt orig.txt new2.txt dir/deep
+test_expect_success 'accounts for subdirectory when writing' '
+    (cd dir && git merge-file deep/new1.txt deep/orig.txt deep/new2.txt)
+'
+
 cp new1.txt test.txt
 test_expect_success "merge without conflict (--quiet)" \
     "git merge-file --quiet test.txt orig.txt new2.txt"
-- 
1.9.1
