From: Yurii Shevtsov <ungetch@gmail.com>
Subject: [PATCH/RFC][GSoC] diff-no-index: transform "$directory $file" args to
 "$directory/$file $file"
Date: Sat, 21 Mar 2015 14:50:32 +0200
Message-ID: <CAHLaBN+x3SVL9+jDzeSEMapVd2BVrwQuVx_7ENspjbUPrium_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 13:50:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZIrd-0005VD-Pi
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 13:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbCUMuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 08:50:35 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33917 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbbCUMue (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 08:50:34 -0400
Received: by obbgg8 with SMTP id gg8so95289085obb.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=DHK8EcBtVmVab3fdy8UcdqIl7yDBAiO9mPyLGCecBqI=;
        b=qMY2Tyah9R++HQK/imbnaYtsCNeF3JsQDddJZqSC2arc9wlQlSF+nEJtf7qlb62W3e
         H1DKOSytOhz17z4QbaH+y8UYTsvENz59qfrifH4SPRGuPjjvMA3bn30gNkrxiT8yGAFs
         /kAYYwRNLk/GxZlackl21egQwNRy3kRXAS8D6q9og4wlO4poo572Q9yOdxPqixhyk0jI
         R3dce2GUprmSDxqhb3LxBP+Y3rMUEOKvPw3M5E2rFkB5Tz+yHF5WUQ/SYw7PAxdGe4J7
         38m+Z+drKPy/UI8ISVyH+eyZJ/8wmNPGmQqKap+6A4k/3MvEwz904XybZqVS+x9J4HW9
         z+Bw==
X-Received: by 10.202.87.215 with SMTP id l206mr43053813oib.84.1426942232930;
 Sat, 21 Mar 2015 05:50:32 -0700 (PDT)
Received: by 10.76.10.170 with HTTP; Sat, 21 Mar 2015 05:50:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266018>

git diff --no-index refuses to compare if args are directory and file,
instead of usual diff.

Now git diff --no-index compares args' target names and, if they are
equal, refuses to compare. If args differ, it transforms args and
diffs files, as usual diff does.
This is the least expensive way in terms of amount of new code and
also doesn't affect usual behaviour.

Changes are done in queue_diff(). Adding args transformation logic to
top-level is irrational,
because requires writing additional code to define args' types, which
is already done in
queue_diff(). The error message about file\directory conflict left as
is until further guidence.

Signed-off-by: Yurii Shevtsov <ungetch@gmail.com>
---
 diff-no-index.c |   35 +++++++++++++++++++++++++++++++++--
 1 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 265709b..9a3439a 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -97,8 +97,39 @@ static int queue_diff(struct diff_options *o,
     if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
         return -1;

-    if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
-        return error("file/directory conflict: %s, %s", name1, name2);
+    if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
+        struct strbuf path;
+        const char *dir, *file;
+        char *filename, *dirname = 0;
+        int i, ret = 0;
+
+        dir = S_ISDIR(mode1) ? name1 : name2;
+        file = (dir == name1) ? name2 : name1;
+        strbuf_init(&path, strlen(name1) + strlen(name2) + 1);
+        strbuf_addstr(&path, dir);
+        filename = strrchr(file, '/');
+        if (path.len && path.buf[path.len - 1] != '/')
+            strbuf_addch(&path, '/');
+        for (i = path.len - 2; i >= 0; i--)
+            if (path.buf[i] == '/') {
+                dirname = &path.buf[i];
+                break;
+            }
+        if (dirname == 0)
+            dirname = path.buf;
+
+        if (!strncmp(dirname, filename, strlen(filename)))
+            return error("file/directory conflict: %s, %s", name1, name2);
+
+        strbuf_addstr(&path, filename ? (filename + 1) : file);
+        if (file == name1)
+            ret = queue_diff(o, file, path.buf);
+        else
+            ret = queue_diff(o, path.buf, file);
+        strbuf_release(&path);
+
+        return ret;
+    }

     if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
         struct strbuf buffer1 = STRBUF_INIT;
--
