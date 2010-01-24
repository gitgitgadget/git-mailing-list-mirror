From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Jan 2010, #07; Fri, 22)
Date: Sun, 24 Jan 2010 15:09:00 +0100
Message-ID: <4B5C547C.7000604@web.de>
References: <7vtyudfqju.fsf@alter.siamese.dyndns.org> <4B5B25C6.70604@web.de> <7v7hr8d1xg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 15:11:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ3Bg-0005qD-TH
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 15:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab0AXOJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 09:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168Ab0AXOJJ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 09:09:09 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:54177 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab0AXOJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 09:09:08 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id AEACE13C888B4;
	Sun, 24 Jan 2010 15:09:06 +0100 (CET)
Received: from [80.128.87.201] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NZ39F-0005iE-00; Sun, 24 Jan 2010 15:09:05 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <7v7hr8d1xg.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18nMzKoZOtPst27hrtD831D4YmMRk9znm0+0ftT
	IL3lari1K2c4RGanSVHRRCJo3Bzdp23aVTT6xY9dd+9rIiKa5B
	XVQxUB2DCVF+XyvnEbRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137898>

Am 23.01.2010 21:03, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> A patch that teaches "git diff --submodule" to display if the submodule
>> contains new untracked and/or modified files is also almost ready.
> 
> How does "git submodule summary" show them?  If it doesn't, then I don't
> think we would want to show them, either, as my understanding is that a
> longer-term plan is to use "diff --submodule" in git-gui to replace it.

Shawn applied the patch doing that yesterday, now gitk and git gui both
use "git diff --submodule" and not "git submodule summary" anymore. And
it would be really nice if both of these tools would show the dirtiness
of submodules in 1.7.0 (and after 1.7.0 i plan to teach "git submodule
summary" about dirtiness too).


>> Would
>> you consider it for inclusion into 1.7.0 too or shall i wait until after
>> the release?
> 
> If a feature is not in 'master' already, I think it is too late to be
> included in 1.7.0, if that is what you are asking.  But if you start the
> usual cycle of working on, asking others to review and polishing it before
> the release, it would give us better designed and more tested version in
> 1.7.1, no?

Sure, I'm fine with having the full functionality in 1.7.1. But a part of
it looks like a fix to me, let me explain:

Right now "git diff --submodule" doesn't show the dirty status of a
submodule at all (like it does when using it without that option and
having paid the cost to get the necessary information). So IMHO something
like the patch below should go into 1.7.0 to fix that. When applied the
output looks like this:

Submodule sub 3f35670..3f35670-dirty:

which is now consistent with the output of "git diff" without that option:

diff --git a/sub b/sub
--- a/sub
+++ b/sub
@@ -1 +1 @@
-Subproject commit 3f356705649b5d566d97ff843cf193359229a453
+Subproject commit 3f356705649b5d566d97ff843cf193359229a453-dirty


This is a stripped down version of the patch i had in mind. I would post
the rest after 1.7.0 to give detailed output about the reasons a submodule
is dirty.

What do you think?


-- >8 --
Subject: Teach diff --submodule that modified submodule directory is dirty

Since commit 8e08b4 git diff does append "-dirty" to the work tree side
if the working directory of a submodule contains new or modified files.
Lets do the same when the --submodule option is used.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 diff.c                    |    2 +-
 submodule.c               |    3 ++
 submodule.h               |    1 +
 t/t4041-diff-submodule.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index f130a36..381cc8d 100644
--- a/diff.c
+++ b/diff.c
@@ -1615,7 +1615,7 @@ static void builtin_diff(const char *name_a,
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one ? one->path : two->path,
-				one->sha1, two->sha1,
+				one->sha1, two->sha1, two->dirty_submodule,
 				del, add, reset);
 		return;
 	}
diff --git a/submodule.c b/submodule.c
index f657bee..ca0527f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -36,6 +36,7 @@ static int add_submodule_odb(const char *path)

 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
@@ -85,6 +86,8 @@ void show_submodule_summary(FILE *f, const char *path,
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
 	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
+	if (dirty_submodule)
+		strbuf_add(&sb, "-dirty", 6);
 	if (message)
 		strbuf_addf(&sb, " %s\n", message);
 	else
diff --git a/submodule.h b/submodule.h
index 0773121..2336965 100644
--- a/submodule.h
+++ b/submodule.h
@@ -3,6 +3,7 @@

 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
 int is_submodule_modified(const char *path);

diff --git a/t/t4041-diff-submodule.sh b/t/t4041-diff-submodule.sh
index 5bb4fed..4643054 100755
--- a/t/t4041-diff-submodule.sh
+++ b/t/t4041-diff-submodule.sh
@@ -191,6 +191,73 @@ EOF
 "

 commit_file sm1 &&
+test_expect_success 'submodule is up to date' "
+	git diff-index -p --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+EOF
+"
+
+test_expect_success 'submodule contains untracked content' "
+	echo new > sm1/new-file &&
+	git diff-index -p --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6..$head6-dirty:
+EOF
+"
+
+test_expect_success 'submodule contains untracked and modifed content' "
+	echo new > sm1/foo6 &&
+	git diff-index -p --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6..$head6-dirty:
+EOF
+"
+
+test_expect_success 'submodule contains modifed content' "
+	rm -f sm1/new-file &&
+	git diff-index -p --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6..$head6-dirty:
+EOF
+"
+
+(cd sm1; git commit -mchange foo6 >/dev/null) &&
+head8=$(cd sm1; git rev-parse --verify HEAD | cut -c1-7) &&
+test_expect_success 'submodule is modified' "
+	git diff-index -p --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6..$head8:
+  > change
+EOF
+"
+
+test_expect_success 'modified submodule contains untracked content' "
+	echo new > sm1/new-file &&
+	git diff-index -p --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6..$head8-dirty:
+  > change
+EOF
+"
+
+test_expect_success 'modified submodule contains untracked and modifed content' "
+	echo modification >> sm1/foo6 &&
+	git diff-index -p --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6..$head8-dirty:
+  > change
+EOF
+"
+
+test_expect_success 'modified submodule contains modifed content' "
+	rm -f sm1/new-file &&
+	git diff-index -p --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6..$head8-dirty:
+  > change
+EOF
+"
+
 rm -rf sm1
 test_expect_success 'deleted submodule' "
 	git diff-index -p --submodule=log HEAD >actual &&
-- 
1.6.6.1.559.g4914
