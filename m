From: Jay Soffian <jaysoffian@gmail.com>
Subject: [RFC/PATCH] rebase: add -x option to record original commit name
Date: Fri,  5 Feb 2010 20:19:26 -0500
Message-ID: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 02:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdZQK-0007Yr-A0
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 02:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933849Ab0BFBZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 20:25:15 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:48220 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223Ab0BFBZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 20:25:14 -0500
Received: by ywh36 with SMTP id 36so4580506ywh.15
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 17:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dD9uk0SAXYNFy43zAlNlSNBOgRcMCCJsMSoiGNudC/s=;
        b=hzKfawc5nBi6ORiiwdc8QejxP3WhIJdhtMTrF6uhHHvNojU1g7uOqaakEDQV+lZMwE
         VY+rMhMbbqeRroeYTrU05cp0fbeTUNi0+wZyV3H5OA4AFbNkgUiXOpwrJ3c9yDwlQOe0
         epAnMqWdcBe5XpoFC/wDuKQJmqp1WAVsboqz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xuhvgfenQ48+2ztDz3IE9taO3ZubOEFr6k3lcVPy36YTWL4/c2gKpZo8bIEr8UsFwl
         qWxf2Hx7qkyYhPmz1yQLVtkh9ugsHgufcTZTBvu/qwEnqgAp5zql5nrF+kjRZMod2bEa
         cg/4TArFN6uvRLnHrVKzYNgLv5lxsXgyJtoE8=
Received: by 10.101.170.12 with SMTP id x12mr4841588ano.127.1265419178011;
        Fri, 05 Feb 2010 17:19:38 -0800 (PST)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id 13sm1190507gxk.13.2010.02.05.17.19.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 17:19:37 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc1.200.g9c1f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139135>

It is often more convenient to use rebase --onto than cherry-pick when
relocating a range of commits, as cherry-pick only supports a single commit at a
time.

This commit teaches rebase the "-x" to record the original commit name, in the
same way as cherry-pick's "-x" option.
---

Note that I explictly did not add support for anything but the simple
format-patch + am codepath. I think it's unlikely to want to record the
original commit name in cases where "-m/-p" are needed. 

However, this option might be useful when using "--interactive", but I wanted
to get feedback first as rebase--interactive is a little scarier to patch. :-)

Thoughts?

 Documentation/git-rebase.txt |    5 +++++
 git-am.sh                    |   14 ++++++++++++++
 git-rebase.sh                |    9 +++++++++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 823f2a4..2fb0e96 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -315,6 +315,11 @@ which makes little sense.
 	so that the commit marked for squashing comes right after the
 	commit to be modified, and change the action of the moved
 	commit from `pick` to `squash` (or `fixup`).
+
+-x::
+	Append to the original commit message a note that indicates which commit
+	this change originated from, similar to cherry-pick's -x option. This
+	option is not compatible with -m, -p or --interactive.
 +
 This option is only valid when '--interactive' option is used.
 
diff --git a/git-am.sh b/git-am.sh
index c8b9cbb..83805eb 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -31,6 +31,7 @@ abort           restore the original branch and abort the patching operation.
 committer-date-is-author-date    lie about committer date
 ignore-date     use current timestamp for author date
 rerere-autoupdate update the index with reused conflict resolution if possible
+add-commit-name* (internal use for git-rebase)
 rebasing*       (internal use for git-rebase)"
 
 . git-sh-setup
@@ -296,6 +297,7 @@ git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
 allow_rerere_autoupdate=
+add_commit_name=
 
 while test $# != 0
 do
@@ -347,6 +349,8 @@ do
 		allow_rerere_autoupdate="$1" ;;
 	-q|--quiet)
 		GIT_QUIET=t ;;
+	--add-commit-name)
+		add_commit_name=t ;;
 	--)
 		shift; break ;;
 	*)
@@ -454,6 +458,7 @@ else
 	echo "$keep" >"$dotest/keep"
 	echo "$scissors" >"$dotest/scissors"
 	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
+	echo "$add_commit_name" > "$dotest/add_commit_name"
 	echo "$GIT_QUIET" >"$dotest/quiet"
 	echo 1 >"$dotest/next"
 	if test -n "$rebasing"
@@ -507,6 +512,10 @@ then
 else
 	no_inbody_headers=
 fi
+if test "$(cat "$dotest/add_commit_name")" = t
+then
+	add_commit_name=t
+fi
 if test "$(cat "$dotest/quiet")" = t
 then
 	GIT_QUIET=t
@@ -630,6 +639,11 @@ do
 		then
 			echo "$ADD_SIGNOFF"
 		fi
+		if test "$add_commit_name" = t
+		then
+			test -z "$commit" && die "Internal error: expecting a commit name."
+			echo "(cherry picked from commit $commit)"
+		fi
 	    } >"$dotest/final-commit"
 	    ;;
 	*)
diff --git a/git-rebase.sh b/git-rebase.sh
index fb4fef7..511599e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -53,6 +53,7 @@ git_am_opt=
 rebase_root=
 force_rebase=
 allow_rerere_autoupdate=
+add_commit_name=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -353,6 +354,10 @@ do
 	--rerere-autoupdate|--no-rerere-autoupdate)
 		allow_rerere_autoupdate="$1"
 		;;
+	-x)
+		git_am_opt="$git_am_opt --add-commit-name"
+		add_commit_name=t
+		;;
 	-*)
 		usage
 		;;
@@ -386,6 +391,10 @@ else
 		die "previous rebase directory $dotest still exists." \
 			'Try git rebase (--continue | --abort | --skip)'
 	fi
+	if test -n "$add_commit_name"
+	then
+		die "-x not compatible with --merge"
+	fi
 fi
 
 # The tree must be really really clean.
-- 
1.7.0.rc1.200.g9c1f9
