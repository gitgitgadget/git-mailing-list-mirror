From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: mergetool local/remote improvements?
Date: Wed, 20 Feb 2008 16:40:04 -0500
Message-ID: <76718490802201340g5ce15c1fl3e4f6d4e655c96be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 22:41:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRwgT-0001sT-Df
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 22:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208AbYBTVkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 16:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbYBTVkI
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 16:40:08 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:37248 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667AbYBTVkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 16:40:06 -0500
Received: by py-out-1112.google.com with SMTP id u52so3371051pyb.10
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 13:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=0wD1ggTlBC/n9C58p3e8YYAW72mWLx0OqFFBuUoXUnk=;
        b=rGH8dPI2sDll58OH4HgvgMZcmXVUvG9x720UlucmHuMzm/chySm7zpSUZhuCA4gVbHj1zLznY81ov75pLtcJCBcoFf1mf3uAX8ReTxc1sOjAnOyn6kwfR8dnYfL8EJo7IMpMMAnCFaHVUktb7TMz6r/v+QxzonHAbtS7vn3opzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C7ohxNPJO6yKQdb+YnvryLH6w+R4bcKIgKFQMrPO1Uj/QWAZoiid9G7HJoFESnSlWey1gHyjBVM5ijwRZI6zbyFSxJU1/3Nzmpnc9LjdPwU7IAjbvydBVkLMmvhQEegfnRvAV/FNZLrs3cUREtB3bO5dbFfzGysqd1MJk4fZmPs=
Received: by 10.115.22.1 with SMTP id z1mr6094392wai.33.1203543605015;
        Wed, 20 Feb 2008 13:40:05 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Wed, 20 Feb 2008 13:40:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74547>

When in branch <mine> and doing "git rebase <upstream>", if there are
any conflicts, the merge tool will come up with the version of the file
from branch <mine> tagged with ".REMOTE" and the version from branch
<upstream> tagged ".LOCAL".

I understand the reason for this, but still, it seems backwards. So I
was going to propose something like the patch below, but I realized that
it might be more useful if mergetool took --local and --remote arguments
so that the caller could provide more meaningful names, e.g. given

--local=mybranch
--remote=theirbranch

mergetool would use mybranch/MYBRANCH in place of local/LOCAL and
similarly theirbranch/THEIRBRANCH in place of remote/REMOTE.

Of course, I then have to wonder if mergetool could use branch names by
default in those cases where branch names can be determined
unambiguously (not sure how to do that though other than for git-merge
and git-rebase to leave a hint about the operation in progress).

Thoughts?

 git-mergetool.sh |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index cbbb707..c688858 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -20,6 +20,10 @@ is_symlink () {
     test "$1" = 120000
 }

+is_rebase_merge () {
+    test -d "$GIT_DIR/.dotest-merge"
+}
+
 local_present () {
     test -n "$local_mode"
 }
@@ -162,12 +166,19 @@ merge_file () {
     cp -- "$BACKUP" "$path"

     base_mode=`git ls-files -u -- "$path" | awk '{if ($3==1) print $1;}'`
-    local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
-    remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
+    base_present && git cat-file blob ":1:$prefix$path" >"$BASE" 2>/dev/null

-    base_present   && git cat-file blob ":1:$prefix$path" >"$BASE" 2>/dev/null
-    local_present  && git cat-file blob ":2:$prefix$path" >"$LOCAL" 2>/dev/null
-    remote_present && git cat-file blob ":3:$prefix$path" >"$REMOTE"
2>/dev/null
+    if is_rebase_merge; then
+	local_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
+	local_present  && git cat-file blob ":3:$prefix$path" >"$LOCAL" 2>/dev/null
+	remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
+	remote_present && git cat-file blob ":2:$prefix$path" >"$REMOTE" 2>/dev/null
+    else
+	local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
+	local_present  && git cat-file blob ":2:$prefix$path" >"$LOCAL" 2>/dev/null
+	remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
+	remote_present && git cat-file blob ":3:$prefix$path" >"$REMOTE" 2>/dev/null
+    fi

     if test -z "$local_mode" -o -z "$remote_mode"; then
 	echo "Deleted merge conflict for '$path':"
