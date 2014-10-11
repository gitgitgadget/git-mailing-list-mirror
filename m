From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-completion.bash - avoid excruciatingly slow ref completion on Cygwin
Date: Sat, 11 Oct 2014 11:51:13 -0400
Message-ID: <1413042673-24052-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 11 17:51:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xcyx9-00009e-Jl
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 17:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbaJKPv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 11:51:28 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:59430 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaJKPv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 11:51:27 -0400
Received: by mail-qc0-f169.google.com with SMTP id o8so3352298qcw.28
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aF6V+lmvqlCTBfBHWqWfHms0msdA4kvJc2P77Khzngs=;
        b=f5fb3F198Yx3Z28QoHJxhQrcYUD+wgX6l8kYKZl53ZDexLkXVZ4j0TPZJH23a0ErIn
         SGJ48ZgbPsH7q33IY4iEOrNmiQWg9eglxxpFbTLSAlp0AccSQ1TZCEuXPP4VSYwquyTy
         w/ogAlc6JjpcWOFAk7IusL84RlbJFDk/0dIuJXzWn0ce3ODWCUPmUc7n5EPdDob0UmBG
         nSzG1BwAtdXwB1cVVMOd1NG+ksxjnMX6sPCIppYRRsVjdcfdeQBNiLSL9Vg4lllkfPz5
         9wCSmYUmft/7hxu3+Lm9pdBOUAVEWYySp/udSHc7Sa/41F1NbpHyOoMUQbrOTIdWAvCY
         gXOA==
X-Received: by 10.224.38.6 with SMTP id z6mr22002628qad.4.1413042686458;
        Sat, 11 Oct 2014 08:51:26 -0700 (PDT)
Received: from marklaptop.lan (pool-173-73-114-83.washdc.fios.verizon.net. [173.73.114.83])
        by mx.google.com with ESMTPSA id o10sm7766750qar.13.2014.10.11.08.51.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Oct 2014 08:51:25 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.2.0.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$git checkout <tab> was taking about 3.5 seconds to respond on one
repository having four remotes with about 100 total refs (measured on
Cygwin).  All of the time was being claimed in "git for-each-ref" to do
its work.  This working directory was created using git-new-workdir, and
thus .git/refs and .git/packed-refs are both symlinks.  for-each-ref
operates in a way that causes the .git/refs symlink to be resolved
multiple times for each ref in the repository, and Cygwin is especially
slow in such operations.

Patching refs.c to avoid repeatedly dereferencing the symlink reduced
execution time from about 3.5 seconds to about 1.1 seconds (but no
improvement on Linux), while an alternate approach of replacing the
ref-list expansion with a shell pipeline provides a larger improvement on
Cygwin and also improves Linux.  So, the shell pipeline approach is
provided here.

Relevant timing results using the same repository on both Linux and
Cygwin:

On Cygwin:

$ time git for-each-ref --format="%(refname:short)" refs

real    0m3.523s
user    0m0.436s
sys     0m2.733s

$ time (cd "$GIT_DIR" ; cat packed-refs ; find refs/ -type f) \
	2>/dev/null | sed -ne 's@^.*refs/@refs/@p' | sort | uniq

real    0m0.503s
user    0m0.307s
sys     0m0.139s

On Linux (essentially the same hardware):

$ time git for-each-ref --format="%(refname:short)" refs

real    0m0.020s
user    0m0.006s
sys     0m0.014s

$ time (cd "$GIT_DIR" ; cat packed-refs ; find refs/ -type f) \
	2>/dev/null | sed -ne 's@^.*refs/@refs/@p' | sort | uniq

real    0m0.012s
user    0m0.006s
sys     0m0.005s

So, this is a win even on Linux, but more importantly it makes use of
tab completion tolerable on Cygwin when symlinks are involved.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 contrib/completion/git-completion.bash | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 965778e..62d976e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -319,8 +319,9 @@ __git_heads ()
 {
 	local dir="$(__gitdir)"
 	if [ -d "$dir" ]; then
-		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
-			refs/heads
+		(cd "$dir" ; cat packed-refs ; find refs/heads -type f) 2>/dev/null |
+			sed -ne 's@^.*refs/heads/@@p' |
+			sort -u
 		return
 	fi
 }
@@ -329,8 +330,9 @@ __git_tags ()
 {
 	local dir="$(__gitdir)"
 	if [ -d "$dir" ]; then
-		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
-			refs/tags
+		(cd "$dir" ; cat packed-refs ; find refs/tags -type f) 2>/dev/null |
+			sed -ne 's@^.*refs/tags/@@p' |
+			sort -u
 		return
 	fi
 }
@@ -348,17 +350,21 @@ __git_refs ()
 			format="refname"
 			refs="${cur%/*}"
 			track=""
+			(cd "$dir" ; cat packed-refs ; find refs/ -type f) 2>/dev/null |
+				sed -ne 's@^.*refs/@refs/@p' |
+				sort -u
+				return
 			;;
 		*)
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
 				if [ -e "$dir/$i" ]; then echo $i; fi
 			done
-			format="refname:short"
-			refs="refs/tags refs/heads refs/remotes"
+			(cd "$dir" ; cat packed-refs ; find refs/ -type f) 2>/dev/null |
+				sed -rne 's@^.*refs/(heads|remotes|tags)/@@p' |
+				sort -u
+				return
 			;;
 		esac
-		git --git-dir="$dir" for-each-ref --format="%($format)" \
-			$refs
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
-- 
2.1.2.2.0.14
