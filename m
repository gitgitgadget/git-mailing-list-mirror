From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/5] branch: show targets of deleted symrefs, not sha1s
Date: Thu, 18 Oct 2012 14:08:03 +0200
Message-ID: <507FF123.2030709@lsrfire.ath.cx>
References: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com> <507D315E.8040101@lsrfire.ath.cx> <7vr4oytn4q.fsf@alter.siamese.dyndns.org> <507FEF0B.1060309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Miklos Vajna <vmiklos@suse.cz>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 14:08:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOotj-0001XI-Db
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 14:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab2JRMIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 08:08:12 -0400
Received: from india601.server4you.de ([85.25.151.105]:44749 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab2JRMIM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 08:08:12 -0400
Received: from [192.168.2.105] (p4FFDA222.dip.t-dialin.net [79.253.162.34])
	by india601.server4you.de (Postfix) with ESMTPSA id D844D23E;
	Thu, 18 Oct 2012 14:08:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <507FEF0B.1060309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208001>

git branch reports the abbreviated hash of the head commit of
a deleted branch to make it easier for a user to undo the
operation.  For symref branches this doesn't help.  Print the
symref target instead for them.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/branch.c  | 19 +++++++++++--------
 t/t3200-branch.sh |  5 ++---
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d87035a..1ec9c02 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -251,15 +251,18 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			      : _("Error deleting branch '%s'"),
 			      bname.buf);
 			ret = 1;
-		} else {
-			if (!quiet)
-				printf(remote_branch
-				       ? _("Deleted remote branch %s (was %s).\n")
-				       : _("Deleted branch %s (was %s).\n"),
-				       bname.buf,
-				       find_unique_abbrev(sha1, DEFAULT_ABBREV));
-			delete_branch_config(bname.buf);
+			continue;
+		}
+		if (!quiet) {
+			printf(remote_branch
+			       ? _("Deleted remote branch %s (was %s).\n")
+			       : _("Deleted branch %s (was %s).\n"),
+			       bname.buf,
+			       (flags & REF_ISSYMREF)
+			       ? target
+			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
 		}
+		delete_branch_config(bname.buf);
 	}
 
 	free(name);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 1323f6f..80e6be3 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -265,8 +265,7 @@ test_expect_success 'config information was renamed, too' \
 test_expect_success 'deleting a symref' '
 	git branch target &&
 	git symbolic-ref refs/heads/symref refs/heads/target &&
-	sha1=$(git rev-parse symref | cut -c 1-7) &&
-	echo "Deleted branch symref (was $sha1)." >expect &&
+	echo "Deleted branch symref (was refs/heads/target)." >expect &&
 	git branch -d symref >actual &&
 	test_path_is_file .git/refs/heads/target &&
 	test_path_is_missing .git/refs/heads/symref &&
@@ -276,7 +275,7 @@ test_expect_success 'deleting a symref' '
 test_expect_success 'deleting a dangling symref' '
 	git symbolic-ref refs/heads/dangling-symref nowhere &&
 	test_path_is_file .git/refs/heads/dangling-symref &&
-	echo "Deleted branch dangling-symref (was 0000000)." >expect &&
+	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
 	git branch -d dangling-symref >actual &&
 	test_path_is_missing .git/refs/heads/dangling-symref &&
 	test_i18ncmp expect actual
-- 
1.7.12
