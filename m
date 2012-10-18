From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/5] branch: delete symref branch, not its target
Date: Thu, 18 Oct 2012 14:05:17 +0200
Message-ID: <507FF07D.8040608@lsrfire.ath.cx>
References: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com> <507D315E.8040101@lsrfire.ath.cx> <7vr4oytn4q.fsf@alter.siamese.dyndns.org> <507FEF0B.1060309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@suse.cz>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Oct 18 14:05:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOor3-0006cH-Cb
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 14:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab2JRMF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 08:05:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:44740 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab2JRMF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 08:05:26 -0400
Received: from [192.168.2.105] (p4FFDA222.dip.t-dialin.net [79.253.162.34])
	by india601.server4you.de (Postfix) with ESMTPSA id 4307623E;
	Thu, 18 Oct 2012 14:05:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <507FEF0B.1060309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207999>

If a branch that is to be deleted happens to be a symref to another
branch, the current code removes the targeted branch instead of the
one it was called for.

Change this surprising behaviour and delete the symref branch
instead.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/branch.c  |  2 +-
 t/t3200-branch.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 97c7361..5e1e5b4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -239,7 +239,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (delete_ref(name, sha1, 0)) {
+		if (delete_ref(name, sha1, REF_NODEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote branch '%s'")
 			      : _("Error deleting branch '%s'"),
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 79c8d01..ec5f70e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -262,6 +262,17 @@ test_expect_success 'config information was renamed, too' \
 	"test $(git config branch.s.dummy) = Hello &&
 	 test_must_fail git config branch.s/s/dummy"
 
+test_expect_success 'deleting a symref' '
+	git branch target &&
+	git symbolic-ref refs/heads/symref refs/heads/target &&
+	sha1=$(git rev-parse symref | cut -c 1-7) &&
+	echo "Deleted branch symref (was $sha1)." >expect &&
+	git branch -d symref >actual &&
+	test_path_is_file .git/refs/heads/target &&
+	test_path_is_missing .git/refs/heads/symref &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'renaming a symref is not allowed' \
 '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
-- 
1.7.12
