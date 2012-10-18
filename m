From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/5] branch: skip commit checks when deleting symref branches
Date: Thu, 18 Oct 2012 14:07:11 +0200
Message-ID: <507FF0EF.3070702@lsrfire.ath.cx>
References: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com> <507D315E.8040101@lsrfire.ath.cx> <7vr4oytn4q.fsf@alter.siamese.dyndns.org> <507FEF0B.1060309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Miklos Vajna <vmiklos@suse.cz>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 14:07:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOosy-0000fO-0f
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 14:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab2JRMHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 08:07:22 -0400
Received: from india601.server4you.de ([85.25.151.105]:44744 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab2JRMHU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 08:07:20 -0400
Received: from [192.168.2.105] (p4FFDA222.dip.t-dialin.net [79.253.162.34])
	by india601.server4you.de (Postfix) with ESMTPSA id 1098323E;
	Thu, 18 Oct 2012 14:07:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <507FEF0B.1060309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208000>

Before a branch is deleted, we check that it points to a valid
commit.  With -d we also check that the commit is a merged; this
check is not done with -D.

The reason for that is that commits pointed to by branches should
never go missing; if they do then something broke and it's better
to stop instead of adding to the mess.  And a non-merged commit
may contain changes that are worth preserving, so we require the
stronger option -D instead of -d to get rid of them.

If a branch consists of a symref, these concerns don't apply.
Deleting such a branch can't make a commit become unreferenced,
so we don't need to check if it is merged, or even if it is
actually a valid commit.  Skip them in that case.  This allows
us to delete dangling symref branches.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/branch.c  | 10 ++++++++--
 t/t3200-branch.sh |  9 +++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5e1e5b4..d87035a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -214,6 +214,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			die(_("Couldn't look up commit object for HEAD"));
 	}
 	for (i = 0; i < argc; i++, strbuf_release(&bname)) {
+		const char *target;
+		int flags = 0;
+
 		strbuf_branchname(&bname, argv[i]);
 		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
 			error(_("Cannot delete the branch '%s' "
@@ -225,7 +228,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(name);
 
 		name = mkpathdup(fmt, bname.buf);
-		if (read_ref(name, sha1)) {
+		target = resolve_ref_unsafe(name, sha1, 0, &flags);
+		if (!target ||
+		    (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
 			error(remote_branch
 			      ? _("remote branch '%s' not found.")
 			      : _("branch '%s' not found."), bname.buf);
@@ -233,7 +238,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
+		if (!(flags & REF_ISSYMREF) &&
+		    check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
 					force)) {
 			ret = 1;
 			continue;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ec5f70e..1323f6f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -273,6 +273,15 @@ test_expect_success 'deleting a symref' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'deleting a dangling symref' '
+	git symbolic-ref refs/heads/dangling-symref nowhere &&
+	test_path_is_file .git/refs/heads/dangling-symref &&
+	echo "Deleted branch dangling-symref (was 0000000)." >expect &&
+	git branch -d dangling-symref >actual &&
+	test_path_is_missing .git/refs/heads/dangling-symref &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'renaming a symref is not allowed' \
 '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
-- 
1.7.12
