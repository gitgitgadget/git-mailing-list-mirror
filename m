From: Yurii Shevtsov <ungetch@gmail.com>
Subject: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file" DWIM better.
Date: Sun, 15 Mar 2015 17:35:27 +0200
Message-ID: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 16:35:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXAZh-0007IM-DC
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 16:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbbCOPf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 11:35:29 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33062 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbbCOPf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 11:35:28 -0400
Received: by oiba3 with SMTP id a3so4601908oib.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=At+11DF2Q1UZdHuPhmlnQFdxW2FCYUJfCEIVwHZxgJw=;
        b=NKK8SWGVFjknadwTJG7VBKzCiqRRw3z3qsAIqba1LnvssaNO6Y9Hl71X9nOE9t1g+2
         NmbAvemWxpyN5y9BRRsxMmiSDEaX81xFD04ZGK+W6iFpY1sqcUsUx1yRhiHEioWvQnPl
         pFZDE3Fkwo2e+JTmlt7Q7AkxDXFHsVh4J8Ur/2GIkH8cOGVAq6hmAzy2uY3jkValiVC1
         rbnxa+2m+PyYM/EBZ7AXgGeRA5Tzk7u/yrXdyQQPowvJbE9CiB7MP58lC9dGXBwHYHM3
         8K6azjY+oUF3oxSp6Q5fvrRgWs/5mYYQpf1Erqsi8UfomYV+ljhje5k6ipOZPzfWlXq7
         5KXw==
X-Received: by 10.202.87.215 with SMTP id l206mr19675289oib.84.1426433727756;
 Sun, 15 Mar 2015 08:35:27 -0700 (PDT)
Received: by 10.76.10.170 with HTTP; Sun, 15 Mar 2015 08:35:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265497>

Changes 'git diff --no-index $directory $file' behaviour.
Now it is transformed to 'git diff --no-index $directory/&file $file'
instead of throwing an error.

Signed-off-by: Yurii Shevtsov <ungetch <at> gmail.com>
---
 diff-no-index.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 265709b..4e71b36 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -97,8 +97,25 @@ static int queue_diff(struct diff_options *o,
        if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
                return -1;

-       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
-               return error("file/directory conflict: %s, %s", name1, name2);
+       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
+               struct strbuf dirnfile;
+               const char *dir, *file;
+               char *filename;
+               int ret = 0;
+
+               dir = S_ISDIR(mode1) ? name1 : name2;
+               file = (dir == name1) ? name2 : name1;
+               strbuf_init(&dirnfile, strlen(name1) + strlen(name2) + 2);
+               strbuf_addstr(&dirnfile, dir);
+               if (dirnfile.buf[dirnfile.len - 1] != '/')
+                       strbuf_addch(&dirnfile, '/');
+               filename = strrchr(file, '/');
+               strbuf_addstr(&dirnfile, filename ? (filename + 1) : file);
+               ret = queue_diff(o, dirnfile.buf, file);
+               strbuf_release(&dirnfile);
+
+               return ret;
+       }

        if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
                struct strbuf buffer1 = STRBUF_INIT;
--

I hope I understood task correct. I think this patch requires writing
additional tests, so that's what I'm going to do now.
