From: David Michael <fedora.dm0@gmail.com>
Subject: [BUG/PATCH] setup: Copy an environment variable to avoid overwrites
Date: Fri, 4 Jan 2013 19:35:14 -0500
Message-ID: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 01:42:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrHqX-0005ls-Ul
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 01:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab3AEAm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 19:42:27 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:40489 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab3AEAm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 19:42:26 -0500
Received: by mail-vc0-f176.google.com with SMTP id fo13so17071724vcb.35
        for <git@vger.kernel.org>; Fri, 04 Jan 2013 16:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=mRpt8RQMAuXvzj52k7L24xM7goU4vAkhbNUm/9eMsqg=;
        b=flyojiJfPH4lwctQCisQ3VymkXb6gyOBw6KHxF+RgB6OjpxBL7T22mZjr4e9xcVVFu
         s9fQi4BBiyiUFLW0DvzdQN6fyoX68oKT9idubabZwI3iJJ9os9AZwLqrYbXuAdokkKMD
         /jLSOyPBOy52++vGOma7wb78TMqq3eaozrnqBn1H01DLqI/x1J+KtpJKJuSJLo1TDSrP
         R1k/OjPged5PFLIs4HZao7Fh8MxgkSK2ybgY0q3TdkGkBoeHX0wGncTp4puobYVuGfNS
         VsSJ7OeMoTxKFSwHrptkt7l2TXBloH3DjHwMpHpvd8lVOQS5zwtnX+Ow20bxYI+MjUGB
         z/qA==
Received: by 10.52.33.228 with SMTP id u4mr68163650vdi.4.1357346114687; Fri,
 04 Jan 2013 16:35:14 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Fri, 4 Jan 2013 16:35:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212657>

It is possible for this pointer of the GIT_DIR environment variable to
survive unduplicated until further getenv calls are made.  The standards
allow for subsequent calls of getenv to overwrite the string located at
its returned pointer, and this can result in broken git operations on
certain platforms.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---

I have encountered an issue with consecutive calls to getenv
overwriting earlier values.  Most notably, it prevents a plain "git
clone" from working.

Long story short: This value of GIT_DIR gets passed around setup.c
until it reaches check_repository_format_gently.  This function calls
git_config_early, which eventually runs getenv("HOME").  When it
returns back to check_repository_format_gently, the gitdir variable
contains my home directory path.  The end result is that I wind up
with ~/objects/ etc. and a failed repository clone.  (Simply adding a
bare getenv("GIT_DIR") afterwards to reset the pointer also corrects
the problem.)

Since other platforms are apparently working, yet this getenv behavior
is supported by the standards, I am left wondering if this could be a
symptom of something else being broken on my platform (z/OS).  Can
anyone more familiar with this part of git identify any condition that
obviously should not be occurring?

Thanks.

 setup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index f108c4b..64fb160 100644
--- a/setup.c
+++ b/setup.c
@@ -675,8 +675,12 @@ static const char
*setup_git_directory_gently_1(int *nongit_ok)
      * validation.
      */
     gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
-    if (gitdirenv)
-        return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
+    if (gitdirenv) {
+        gitdirenv = xstrdup(gitdirenv);
+        ret = setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
+        free(gitdirenv);
+        return ret;
+    }

     if (env_ceiling_dirs) {
         string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
--
1.7.11.7
