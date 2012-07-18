From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 1/7] git-rebase--am.sh: avoid special-casing --keep-empty
Date: Wed, 18 Jul 2012 00:27:29 -0700
Message-ID: <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:35:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOmg-0002YU-Ej
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab2GRHey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:34:54 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:56367 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab2GRHex (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:34:53 -0400
Received: by fat25 with SMTP id 25so67039fat.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 00:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=zGSDAho6oBZZY9MD1dxgXVifohLpq6xQmDnOY20GQC4=;
        b=DCJd1GSSLLdB0S80TkvbsWupQCQsTSk7uh89DnX9gQYzeP+XFw1zW7w4GFUT38VUHB
         4yFW/hEckrKoY0C2vACUmr7aW/1ANQNFrsTs9GqE4dJM3RoI3wT2VmslMiMgZkLcsoSB
         88qQ2lCFmolxVPkzUH+1SSRIf5Vj8oLYE/7O/L1Sq3hN/GIhU244KUX83IVZz5PdYCMr
         EW26MHDDQTa5eOcBr9WEQKvBkZ5EpeFUzLM7WH0yLj4VaY1c7aGsTW9AlM8tFjFa2h4k
         UzGBAh6Uu8kHoOy3L6c9p+LaVwfZUxreJKiJJSQgx39kZd79e+a3iZdxNQGYeVAofWTW
         egbA==
Received: by 10.14.179.72 with SMTP id g48mr1723183eem.2.1342596469988;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by 10.14.179.72 with SMTP id g48mr1723177eem.2.1342596469954;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id 46si17050298eed.1.2012.07.18.00.27.49
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 8402320004E;
	Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id B9D82C0EAF; Wed, 18 Jul 2012 00:27:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQnuFs2C5iBYf7GtQ3aSIFh0nCDJ3qHr/AegEU2xHV3c9rOwJhnk6D/vWXTK6ZYByn58eM/NFZ1KQnJ0OoT9zKISy1uEg4Dmo5oOavImc5Id87g0K7kyLgyzA+tMnJcWqKl+xHHsXWghP8J4M961KK0O2F14XUfOT1M+eJgWerh3FbRVeZOoAkEb3xIWOtOifQn66eck
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201667>

Since 0fbb95d (am: don't call mailinfo if $rebasing, 2012-06-26), the
patch body to apply when running 'git am --rebasing' is not taken from
the mbox, but directly from the commit. If such a commit is "empty",
'git am --rebasing' still happily applies it and commits. However,
since the input to 'git am --rebasing' only ever comes from 'git
format-patch', which completely leaves the commit out from its output
if it's empty, no empty commits are ever created by 'git am
--rebasing'. By teaching 'git am --rebasing' a --keep-empty option and
letting the caller decide whether or not to keep empty commits, we can
unify the two different mechanisms that git-rebase--am.sh uses for
rebasing.
---
 git-am.sh         | 10 +++++++++-
 git-rebase--am.sh | 20 ++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b6a5300..37641b7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -37,7 +37,8 @@ abort           restore the original branch and abort the patching operation.
 committer-date-is-author-date    lie about committer date
 ignore-date     use current timestamp for author date
 rerere-autoupdate update the index with reused conflict resolution if possible
-rebasing*       (internal use for git-rebase)"
+rebasing*       (internal use for git-rebase)
+keep-empty*     (internal use for git-rebase)"
 
 . git-sh-setup
 . git-sh-i18n
@@ -375,6 +376,7 @@ git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
 allow_rerere_autoupdate=
+keep_empty=
 
 if test "$(git config --bool --get am.keepcr)" = true
 then
@@ -414,6 +416,8 @@ do
 		abort=t ;;
 	--rebasing)
 		rebasing=t threeway=t ;;
+	--keep-empty)
+		keep_empty=t ;;
 	-d|--dotest)
 		die "$(gettext "-d option is no longer supported.  Do not use.")"
 		;;
@@ -669,6 +673,10 @@ do
 			echo "$commit" >"$dotest/original-commit"
 			get_author_ident_from_commit "$commit" >"$dotest/author-script"
 			git diff-tree --root --binary "$commit" >"$dotest/patch"
+			test -s "$dotest/patch" || test -n "$keep_empty" || {
+				go_next
+				continue
+			}
 		else
 			git mailinfo $keep $no_inbody_headers $scissors $utf8 "$dotest/msg" "$dotest/patch" \
 				<"$dotest/$msgnum" >"$dotest/info" ||
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 392ebc9..37c1b23 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -17,20 +17,12 @@ skip)
 esac
 
 test -n "$rebase_root" && root_flag=--root
-
-if test -n "$keep_empty"
-then
-	# we have to do this the hard way.  git format-patch completely squashes
-	# empty commits and even if it didn't the format doesn't really lend
-	# itself well to recording empty patches.  fortunately, cherry-pick
-	# makes this easy
-	git cherry-pick --allow-empty "$revisions"
-else
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		--src-prefix=a/ --dst-prefix=b/ \
-		--no-renames $root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"
-fi && move_to_original_branch
+test -n "$keep_empty" && git_am_opt="$git_am_opt --keep-empty"
+git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+	--src-prefix=a/ --dst-prefix=b/ \
+	--no-renames $root_flag "$revisions" |
+git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
+move_to_original_branch
 
 ret=$?
 test 0 != $ret -a -d "$state_dir" && write_basic_state
-- 
1.7.11.1.104.ge7b44f1
