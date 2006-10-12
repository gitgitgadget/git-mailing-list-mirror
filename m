From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] git-revert with conflicts to behave as git-merge with conflicts
Date: Thu, 12 Oct 2006 14:52:42 -0700 (PDT)
Message-ID: <20061012215242.16419.qmail@web31810.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1617166853-1160689962=:13221"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Oct 13 00:18:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY8Tx-0001tf-MH
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 23:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWJLVwq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 17:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWJLVwq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 17:52:46 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:25481 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751132AbWJLVwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 17:52:46 -0400
Received: (qmail 16421 invoked by uid 60001); 12 Oct 2006 21:52:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DoYBfG+i7N37pI43KB37lDLVXpgFrIpRD3z5RMipyjH9DuEpNgB3FJa1wLiXMxp6Q8nhBfLuUlpkZ5fMC+KTSZhcJz089WMn81Grf7hXot1DOxWanq/DSSdpDPT4xliLVWmXyRgb8BS59DnsYYMTYBLSNHOhHm4K4RkQnACVNKg=  ;
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Thu, 12 Oct 2006 14:52:42 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28803>

--0-1617166853-1160689962=:13221
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

In a busy project, reverting a commit almost always results
in a conflict between one or more files (depending on the
commit being reverted).  It is useful to record this
conflict in the commit-to-be message of the resulting commit
(after the resolve).  The process now becomes:

git-revert <SHA-1>
<git complains and prints failed automatic>
<user manually resolves>
git-update-index <resolved files>
git-commit -s

And the commit message is now a merge of the revert commit
message and the conflict commit message, giving the user a
chance to edit it or add more information:
---cut---
Revert "title of reverted commit"

This reverts commit <SHA-1>

Conflicts:

    <filename>
    ...
---cut---

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 git-commit.sh |    4 ++--
 git-revert.sh |   11 ++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)
--0-1617166853-1160689962=:13221
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/git-commit.sh b/git-commit.sh
index 4bd0e46..81c3a0c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -441,7 +441,7 @@ then
 elif test "$use_commit" != ""
 then
 	git-cat-file commit "$use_commit" | sed -e '1,/^$/d'
-elif test -f "$GIT_DIR/MERGE_HEAD" && test -f "$GIT_DIR/MERGE_MSG"
+elif test -f "$GIT_DIR/MERGE_MSG"
 then
 	cat "$GIT_DIR/MERGE_MSG"
 elif test -f "$GIT_DIR/SQUASH_MSG"
@@ -607,7 +607,7 @@ then
 	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
 	rlogm=$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
 	git-update-ref -m "$rloga: $rlogm" HEAD $commit "$current" &&
-	rm -f -- "$GIT_DIR/MERGE_HEAD" &&
+	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" &&
 	if test -f "$NEXT_INDEX"
 	then
 		mv "$NEXT_INDEX" "$THIS_INDEX"
diff --git a/git-revert.sh b/git-revert.sh
index 4fd81b6..2e23cf4 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -145,9 +145,18 @@ git-read-tree -m -u --aggressive $base $
 result=$(git-write-tree 2>/dev/null) || {
     echo >&2 "Simple $me fails; trying Automatic $me."
     git-merge-index -o git-merge-one-file -a || {
+	    mv -f .msg .git/MERGE_MSG
+	    {
+		echo '
+Conflicts:
+'
+		git ls-files --unmerged |
+		sed -e 's/^[^	]*	/	/' |
+		uniq
+	    } >>"$GIT_DIR/MERGE_MSG"
 	    echo >&2 "Automatic $me failed.  After resolving the conflicts,"
 	    echo >&2 "mark the corrected paths with 'git-update-index <paths>'"
-	    echo >&2 "and commit with 'git commit -F .msg'"
+	    echo >&2 "and commit the result."
 	    case "$me" in
 	    cherry-pick)
 		echo >&2 "You may choose to use the following when making"
-- 
1.4.3.rc2.g6f09-dirty


--0-1617166853-1160689962=:13221--
