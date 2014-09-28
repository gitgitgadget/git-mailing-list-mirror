From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: [PATCH] init - Honour the global core.filemode setting
Date: Sat, 27 Sep 2014 17:37:34 -0700
Message-ID: <CAE1pOi0zhnUNNdHsrq+4H_6LiFnr-qoY-owrcJquy6dyG+Mk4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 28 02:38:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY2Uz-00061J-UO
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 02:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbaI1Ah4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2014 20:37:56 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:47666 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaI1Ahz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 20:37:55 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so7561700qaq.10
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 17:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=I4Uw8K4PC2pwy1uxRI9gRaguruZmP6gYliLVqyT8wXk=;
        b=xpAeYyFRD8rPUBebFfjt3rXxANcCGBx9LKtsbCuoji2PEOii+5HWA3fs/lXgvEzyTo
         4Mqbs1fpANhxwn38u109NrfaQBcHvJwi5T62TR/K1OhT7chPMr5m6qkPJKyRhP5Iwop6
         /ncAABAWHUSECVd4ZgqZvsOE3yFbY6cznsUNMPYd4f4jxpEF63Mrj6QofyRw3aPJarwl
         NXw8tIRolUjq1YcxTpz/6d1wy17wQ9IhNA5JXw4rpSjNxzfi3CxO8w44Hn3vKwrKwFmw
         wFuJMg3hGH/DNX8j8Zdclpz7ui5GbGR8N0xZiTNzv8vJ+XPQjiRVceC2wYniriuA9saW
         qXQA==
X-Received: by 10.140.38.231 with SMTP id t94mr47815779qgt.3.1411864674732;
 Sat, 27 Sep 2014 17:37:54 -0700 (PDT)
Received: by 10.140.19.85 with HTTP; Sat, 27 Sep 2014 17:37:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257558>

If "~/.gitconfig" contains a "core.filemode" entry then "git init"
should honour that setting.

Signed-off-by: Hilco Wijbenga <hilco.wijbenga@gmail.com>
---
This bit me at work where I have to work with Windows. Git on Cygwin
and the Eclipse Git plugin do not agree on file attributes so I had
set "filemode = false" in ~/.gitconfig.

A few weeks later, I did a "git init" and, some time later yet, I
noticed the strange behaviour of Cygwin/Eclipse again. This was very
surprising because things had been working well until then. It took
quite a bit of research before I realized that "git init" always sets
"filemode". I think "filemode" should only be set if not set already
in the global config (similar to log_all_ref_updates).

The usual caveat applies: this is my first patch. Having said that,
please feel free to be pedantic and strict. It's a small patch so I
would imagine that fixing any problems should not take long (assuming
it is acceptable at all, of course). I'd like to know I did it right.
:-)

AFAICT, all tests passed. Should a separate test be added for this change?

(I used "git format-patch" and "git imap-send" to send this patch to
the ML but looking below I still do not see tabs? In fact, I do not
see any indentation.)
 builtin/init-db.c | 19 +++++++++++--------
 environment.c     |  2 +-
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 56f85e2..19cdc58 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -248,15 +248,18 @@ static int create_default_files(const char *template_path)
  path[len] = 0;
  strcpy(path + len, "config");

- /* Check filemode trustability */
- filemode = TEST_FILEMODE;
- if (TEST_FILEMODE && !lstat(path, &st1)) {
- struct stat st2;
- filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
- !lstat(path, &st2) &&
- st1.st_mode != st2.st_mode);
+ /* Do not override the global filemode setting. */
+ if (trust_executable_bit == -1) {
+ /* Check filemode trustability */
+ filemode = TEST_FILEMODE;
+ if (TEST_FILEMODE && !lstat(path, &st1)) {
+ struct stat st2;
+ filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
+ !lstat(path, &st2) &&
+ st1.st_mode != st2.st_mode);
+ }
+ git_config_set("core.filemode", filemode ? "true" : "false");
  }
- git_config_set("core.filemode", filemode ? "true" : "false");

  if (is_bare_repository())
  git_config_set("core.bare", "true");
diff --git a/environment.c b/environment.c
index 565f652..875a498 100644
--- a/environment.c
+++ b/environment.c
@@ -12,7 +12,7 @@
 #include "fmt-merge-msg.h"
 #include "commit.h"

-int trust_executable_bit = 1;
+int trust_executable_bit = -1;
 int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
-- 
2.1.1.dirty
