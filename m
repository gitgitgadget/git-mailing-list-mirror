From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP PATCH 1/4] Prepare checkout_entry() for recursive checkout
 of submodules
Date: Sat, 10 Apr 2010 19:01:12 +0200
Message-ID: <4BC0AED8.1080006@web.de>
References: <4BBF9D6F.2000006@web.de> <4BBF9DC9.8030905@web.de> <7vd3y81e3s.fsf@alter.siamese.dyndns.org> <4BBFB40C.1060905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 19:01:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0e3s-0003xz-2j
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 19:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab0DJRBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 13:01:30 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45735 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab0DJRB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 13:01:28 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 172BD14D263FD;
	Sat, 10 Apr 2010 19:01:18 +0200 (CEST)
Received: from [80.128.68.165] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0e3Z-0000Fk-00; Sat, 10 Apr 2010 19:01:17 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BBFB40C.1060905@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX196ilumgnjwcHljV3eq1aJMC3jfN50J/3ST+Qe6
	Ol6ohJL/iV33DV8y1wo11W/6eSz5KFAax+rUb4UarDBzzlsqZ7
	kwXbjL61npUrs9WI99WA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144559>

Am 10.04.2010 01:11, schrieb Jens Lehmann:
> Am 09.04.2010 23:59, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>> +	strbuf_addf(&buf, "%s/.git/", path);
>>> +	if (!is_directory(buf.buf)) {
>>> +		strbuf_release(&buf);
>>> +		/* The submodule is not populated, so we can't check it out */
>>> +		return 0;
>>> +	}
>>
>> This would give you an incorrect result if .git is a file that records
>> "gitdir: overthere" (see read_gitfile_gently() in setup.c); I would expect
>> it would become a fairly important ingredient if we ever enhance the
>> submodule support to add submodule that disappears/reappears in the
>> history.
> 
> Right. This assumption is also present in add_submodule_odb() (used by
> show_submodule_summary()) and is_submodule_modified(), so i just reused
> it. This should be addressed in another patch.

What about this one:

-----------------8<---------------
Subject: [PATCH] Teach diff --submodule and status to handle .git files in submodules

The simple test for an existing .git directory gives an incorrect result
if .git is a file that records "gitdir: overthere". So for submodules that
use a .git file, "git status" and the diff family - when the "--submodule"
option is given - did assume the submodule was not populated at all when
a .git file was used, thus generating wrong output or no output at all.

This is fixed by using read_gitfile_gently() to get the correct location
of the .git directory. While at it, is_submodule_modified() was cleaned up
to use the "dir" member of "struct child_process" instead of setting the
GIT_WORK_TREE and GIT_DIR environment variables.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c                 |   33 ++++++++++++++++-----------------
 t/t4041-diff-submodule.sh   |   15 +++++++++++++++
 t/t7506-status-submodule.sh |   16 ++++++++++++++++
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/submodule.c b/submodule.c
index b3b8bc1..676d48f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,8 +12,15 @@ static int add_submodule_odb(const char *path)
 	struct strbuf objects_directory = STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
 	int ret = 0;
+	const char *git_dir;

-	strbuf_addf(&objects_directory, "%s/.git/objects/", path);
+	strbuf_addf(&objects_directory, "%s/.git", path);
+	git_dir = read_gitfile_gently(objects_directory.buf);
+	if (git_dir) {
+		strbuf_reset(&objects_directory);
+		strbuf_addstr(&objects_directory, git_dir);
+	}
+	strbuf_addstr(&objects_directory, "/objects/");
 	if (!is_directory(objects_directory.buf)) {
 		ret = -1;
 		goto done;
@@ -132,7 +139,6 @@ void show_submodule_summary(FILE *f, const char *path,

 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
-	int i;
 	ssize_t len;
 	struct child_process cp;
 	const char *argv[] = {
@@ -141,16 +147,16 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		NULL,
 		NULL,
 	};
-	const char *env[LOCAL_REPO_ENV_SIZE + 3];
 	struct strbuf buf = STRBUF_INIT;
 	unsigned dirty_submodule = 0;
 	const char *line, *next_line;
+	const char *git_dir;

-	for (i = 0; i < LOCAL_REPO_ENV_SIZE; i++)
-		env[i] = local_repo_env[i];
-
-	strbuf_addf(&buf, "%s/.git/", path);
-	if (!is_directory(buf.buf)) {
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile_gently(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+	if (!is_directory(git_dir)) {
 		strbuf_release(&buf);
 		/* The submodule is not checked out, so it is not modified */
 		return 0;
@@ -158,21 +164,16 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	}
 	strbuf_reset(&buf);

-	strbuf_addf(&buf, "GIT_WORK_TREE=%s", path);
-	env[i++] = strbuf_detach(&buf, NULL);
-	strbuf_addf(&buf, "GIT_DIR=%s/.git", path);
-	env[i++] = strbuf_detach(&buf, NULL);
-	env[i] = NULL;
-
 	if (ignore_untracked)
 		argv[2] = "-uno";

 	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
-	cp.env = env;
+	cp.env = local_repo_env;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
+	cp.dir = path;
 	if (start_command(&cp))
 		die("Could not run git status --porcelain");

@@ -201,8 +202,6 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	if (finish_command(&cp))
 		die("git status --porcelain failed");

-	for (i = LOCAL_REPO_ENV_SIZE; env[i]; i++)
-		free((char *)env[i]);
 	strbuf_release(&buf);
 	return dirty_submodule;
 }
diff --git a/t/t4041-diff-submodule.sh b/t/t4041-diff-submodule.sh
index 11b1997..019acb9 100755
--- a/t/t4041-diff-submodule.sh
+++ b/t/t4041-diff-submodule.sh
@@ -329,4 +329,19 @@ index 0000000..$head7
 EOF
 "

+test_expect_success 'setup .git file for sm2' '
+	(cd sm2 &&
+	 REAL="$(pwd)/../.real" &&
+	 mv .git "$REAL"
+	 echo "gitdir: $REAL" >.git)
+'
+
+test_expect_success 'diff --submodule with .git file' '
+	git diff --submodule HEAD^ >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6...0000000 (submodule deleted)
+Submodule sm2 0000000...$head7 (new submodule)
+EOF
+'
+
 test_done
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index aeec1f6..3d4f85d 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -157,6 +157,22 @@ test_expect_success 'status with added and untracked file in modified submodule
 	EOF
 '

+test_expect_success 'setup .git file for sub' '
+	(cd sub &&
+	 rm -f new-file
+	 REAL="$(pwd)/../.real" &&
+	 mv .git "$REAL"
+	 echo "gitdir: $REAL" >.git) &&
+	 echo .real >>.gitignore &&
+	 git commit -m "added .real to .gitignore" .gitignore
+'
+
+test_expect_success 'status with added file in modified submodule with .git file' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	git status >output &&
+	grep "modified:   sub (new commits, modified content)" output
+'
+
 test_expect_success 'rm submodule contents' '
 	rm -rf sub/* sub/.git
 '
-- 
1.7.1.rc0.265.g16922.dirty
