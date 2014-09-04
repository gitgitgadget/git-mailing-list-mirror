From: Bostjan Skufca <bostjan@a2o.si>
Subject: Re: Configurable filename for what is now .gitignore
Date: Thu, 4 Sep 2014 22:33:27 +0200
Message-ID: <CAEp_DRD5u+Vtr8MiFfbLsBtfkuW-EEXRPM9ro1htk7r-8mPYYQ@mail.gmail.com>
References: <CAEp_DRDCQqkwL1N-PemLtOvPEv-xfBW4MatAOomwi+my9QeK8g@mail.gmail.com>
	<20140830054312.GA28512@google.com>
	<CAEp_DRATLprK9LZg45dn5LY=3C8cLM1BNg4rmi0XxJmdPhDGBw@mail.gmail.com>
	<CAEp_DRBM6cexcoBrYmEktZXh4WMzE-tYwCi80-THCNwJqthQ=g@mail.gmail.com>
	<CACsJy8CwSD9Ux+vT9UQUPLFnXoGMn-fvraML+Sj79_et3wJ8WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 22:33:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdiq-0001vn-Va
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbaIDUdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:33:32 -0400
Received: from portkey.s.itsis.si ([78.47.12.76]:60409 "EHLO
	portkey.s.itsis.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbaIDUdb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:33:31 -0400
Received: from undisclosed (undisclosed [127.0.0.254]) (Authenticated sender: undisclosed) by portkey.s.itsis.si (Postfix) with ESMTPSA id 58F5E80061
	for <git@vger.kernel.org>; Thu,  4 Sep 2014 20:33:29 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.98.4 at portkey
Received: by mail-ie0-f178.google.com with SMTP id at1so12525295iec.37
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 13:33:27 -0700 (PDT)
X-Received: by 10.43.70.66 with SMTP id yf2mr9163471icb.36.1409862807479; Thu,
 04 Sep 2014 13:33:27 -0700 (PDT)
Received: by 10.50.73.233 with HTTP; Thu, 4 Sep 2014 13:33:27 -0700 (PDT)
In-Reply-To: <CACsJy8CwSD9Ux+vT9UQUPLFnXoGMn-fvraML+Sj79_et3wJ8WA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256481>

I see, tnx for the pointer.

Would inclusion of this patch be viable option then?


Patch below, it is possible to look at it here to:

Patch: https://github.com/teonsystems/git/commit/27449825ff4d7bb3eecb5a3e32692aaf1ab1a026
Branch: https://github.com/teonsystems/git/commits/feature/configurable-gitignore-filename



commit 27449825ff4d7bb3eecb5a3e32692aaf1ab1a026
Author: Bostjan Skufca <bostjan@a2o.si>
Date:   Thu Sep 4 20:20:30 2014 +0000

    .gitignore: make '.gitignore' filename configurable

    When using git with detached work tree and .git directory,
    it is currently impossible to use multiple git repositories
    with the same workdir, as .gitignore is always parsed.

    This feature keeps the original '.gitignore' file as default
    at almost no performance penalty, and enables reconfiguring
    git to use alternate filename when obtaining per-dir exclusion
    patterns.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c55c22a..1c63b13 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -507,6 +507,17 @@ be delta compressed, but larger binary media
files won't be.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.

+core.excludesperdirfilename::
+ By default, Git checks for presence of .gitignore files to read
+ exclude patterns from. This option enables the customization of
+ per-dir exclude patterns filename that is by default called
+ '.gitignore', to arbitrary filename.
++
+This setting is not implicitly distributed when transferring
+changes between repository clones. In order to achieve identical
+behaviour in all repository clones, each repository clone must
+set this option to the same value.
+
 core.excludesfile::
  In addition to '.gitignore' (per-directory) and
  '.git/info/exclude', Git looks into this file for patterns
diff --git a/cache.h b/cache.h
index 4d5b76c..ff952b4 100644
--- a/cache.h
+++ b/cache.h
@@ -392,6 +392,7 @@ static inline enum object_type
object_type(unsigned int mode)
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
+#define GITIGNORE_FILE ".gitignore"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
@@ -1423,6 +1424,7 @@ extern int check_pager_config(const char *cmd);

 extern const char *editor_program;
 extern const char *askpass_program;
+extern const char *excludes_per_dir_filename;
 extern const char *excludes_file;

 /* base85 */
diff --git a/config.c b/config.c
index a191328..da80556 100644
--- a/config.c
+++ b/config.c
@@ -847,6 +847,9 @@ static int git_default_core_config(const char
*var, const char *value)
  if (!strcmp(var, "core.askpass"))
  return git_config_string(&askpass_program, var, value);

+ if (!strcmp(var, "core.excludesperdirfilename"))
+ return git_config_string(&excludes_per_dir_filename, var, value);
+
  if (!strcmp(var, "core.excludesfile"))
  return git_config_pathname(&excludes_file, var, value);

diff --git a/dir.c b/dir.c
index bd274a7..8b429c3 100644
--- a/dir.c
+++ b/dir.c
@@ -1624,7 +1624,12 @@ void setup_standard_excludes(struct dir_struct *dir)
  const char *path;
  char *xdg_path;

- dir->exclude_per_dir = ".gitignore";
+ if (excludes_per_dir_filename) {
+ dir->exclude_per_dir = excludes_per_dir_filename;
+ } else {
+ dir->exclude_per_dir = GITIGNORE_FILE;
+ }
+
  path = git_path("info/exclude");
  if (!excludes_file) {
  home_config_paths(NULL, &xdg_path, "ignore");
diff --git a/environment.c b/environment.c
index 565f652..0d48ef9 100644
--- a/environment.c
+++ b/environment.c
@@ -43,6 +43,7 @@ const char *pager_program;
 int pager_use_color = 1;
 const char *editor_program;
 const char *askpass_program;
+const char *excludes_per_dir_filename;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
diff --git a/t/t7515-status-changed-gitignore-filename.sh
b/t/t7515-status-changed-gitignore-filename.sh
new file mode 100755
index 0000000..ed7de42
--- /dev/null
+++ b/t/t7515-status-changed-gitignore-filename.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='status with changed default .gitignore filename'
+. ./test-lib.sh
+
+
+#
+# Check if only single file is in 'untracked' state: file2
+# file1 is excluded by ignore pattern in .gitignore (default)
+#
+test_expect_success 'status with default .gitignore filename' '
+ mkdir repo-default &&
+ (cd repo-default && git init &&
+ echo "/file1" > .gitignore  &&
+ git add .gitignore &&
+ touch file1 &&
+ touch file2 &&
+ COUNT_UNTRACKED=`git status | grep -P "^\t" | grep -P -v "^\tnew
file:" | grep -c .` &&
+ if [ "$COUNT_UNTRACKED" == "1" ]; then
+  true
+ else
+  false
+ fi
+ )
+'
+
+
+#
+# Check if only single file is in 'untracked' state: file2
+# file1 is excluded by ignore pattern in .gitexclude (modified
default ignore filename)
+#
+test_expect_success 'status with .gitignore filename reconfigured to
.gitexclude' '
+ mkdir repo-modified &&
+ (cd repo-modified && git init &&
+ git config --add core.excludesperdirfilename .gitexclude &&
+ echo "/file1" > .gitexclude  &&
+ git add .gitexclude &&
+ touch file1 &&
+ touch file2 &&
+ COUNT_UNTRACKED=`git status | grep -P "^\t" | grep -P -v "^\tnew
file:" | grep -c .` &&
+ if [ "$COUNT_UNTRACKED" == "1" ]; then
+  true
+ else
+  false
+ fi
+ )
+'
+
+
+#
+# Check if .gitignore is ignored when default exclude filename is changed
+# file1 is excluded by ignore pattern in .gitexclude (modified
default ignore filename)
+#
+test_expect_success 'ignore .gitignore when reconfigured to use .gitexclude' '
+ mkdir repo-modified-failure &&
+ (cd repo-modified-failure && git init &&
+ git config --add core.excludesperdirfilename .gitexclude &&
+ echo "/file1" > .gitignore  &&
+ git add .gitignore &&
+ touch file1 &&
+ touch file2 &&
+ COUNT_UNTRACKED=`git status | grep -P "^\t" | grep -P -v "^\tnew
file:" | grep -c .` &&
+ if [ "$COUNT_UNTRACKED" == "2" ]; then
+  true
+ else
+  false
+ fi
+ )
+'
+
+
+test_done


b.


On 2 September 2014 01:33, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Sep 2, 2014 at 3:30 AM, Bostjan Skufca <bostjan@a2o.si> wrote:
>> There is currently no way to transfer/share repository configuration
>> between clones.
>
> See http://article.gmane.org/gmane.comp.version-control.git/216624
> --
> Duy
