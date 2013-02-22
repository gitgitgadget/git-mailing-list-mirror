From: Will Entriken <fulldecent@gmail.com>
Subject: [PATCH] submodule update: when using recursion, show full path
Date: Thu, 21 Feb 2013 23:25:56 -0500
Message-ID: <CAFwrLX7CroJ1Au-w0G7jo7F7DAu5=u2E6iVc9YUTLytVBuHVhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <hordp@cisco.com>, Jens Lehmann <Jens.Lehmann@web.de>,
	Stefan Zager <szager@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 05:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8kDK-00068L-Jp
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 05:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab3BVEZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 23:25:58 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:38196 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab3BVEZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 23:25:57 -0500
Received: by mail-qc0-f170.google.com with SMTP id d42so120162qca.29
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 20:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=IHVvIfcJjJXggRfis1Qc6lNWxrnD3r7lqOm8cPEDx5I=;
        b=fG6TVEhofooxC56eVuhmBFXKDIBLUh0puQ9DzSc2trbsjZu9diiFHgkDaYamq+qcx+
         fR1IfYATSNcM23pLWBNtRCGTgpfy478JzzIiJ0KxRX+Q/H3DqRGWURC/qhv9decEYyvk
         /uhfikkeMcA+i5+hinQdx+7Dj9JHQmtfc6aIDPsD8fmaE7MOaYC1QJ9223eUcW2GEuEa
         0WRSWzu2HJ7RkJ3Mn++9wWVYE5TPR5++Kws7+cvE5XTVymg0fP8HumPfQqN2sicWKI7H
         wvvbtT3Ll2+wu6HGu9HdTUs0F5fJPGIwxB9pfrawhpDURghuTTwVtgf3ly9Dzd24snio
         7vsA==
X-Received: by 10.224.192.197 with SMTP id dr5mr485974qab.68.1361507157009;
 Thu, 21 Feb 2013 20:25:57 -0800 (PST)
Received: by 10.49.104.84 with HTTP; Thu, 21 Feb 2013 20:25:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216817>

>From d3fe2c76e6fa53e4cfa6f81600685c21bdadd4e3 Mon Sep 17 00:00:00 2001
From: William Entriken <github.com@phor.net>
Date: Thu, 21 Feb 2013 23:10:07 -0500
Subject: [PATCH] submodule update: when using recursion, show full path

Previously when using update with recursion, only the path for the
inner-most module was printed. Now the path is printed from GIT_DIR.
This now matches the behavior of submodule foreach
---

First patch. Several tests failed, but they were failing before I
started. This is against maint, I would consider this a (low priority)
bug.

How does it look? Please let me know next steps.

Signed-off-by: William Entriken <github.com@phor.net>

 git-submodule.sh | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2365149..f2c53c9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -588,7 +588,7 @@ cmd_update()
  die_if_unmatched "$mode"
  if test "$stage" = U
  then
- echo >&2 "Skipping unmerged submodule $sm_path"
+ echo >&2 "Skipping unmerged submodule $prefix$sm_path"
  continue
  fi
  name=$(module_name "$sm_path") || exit
@@ -602,7 +602,7 @@ cmd_update()

  if test "$update_module" = "none"
  then
- echo "Skipping submodule '$sm_path'"
+ echo "Skipping submodule '$prefix$sm_path'"
  continue
  fi

@@ -611,7 +611,7 @@ cmd_update()
  # Only mention uninitialized submodules when its
  # path have been specified
  test "$#" != "0" &&
- say "$(eval_gettext "Submodule path '\$sm_path' not initialized
+ say "$(eval_gettext "Submodule path '\$prefix\$sm_path' not initialized
 Maybe you want to use 'update --init'?")"
  continue
  fi
@@ -624,7 +624,7 @@ Maybe you want to use 'update --init'?")"
  else
  subsha1=$(clear_local_git_env; cd "$sm_path" &&
  git rev-parse --verify HEAD) ||
- die "$(eval_gettext "Unable to find current revision in submodule
path '\$sm_path'")"
+ die "$(eval_gettext "Unable to find current revision in submodule
path '\$prefix\$sm_path'")"
  fi

  if test "$subsha1" != "$sha1" -o -n "$force"
@@ -643,7 +643,7 @@ Maybe you want to use 'update --init'?")"
  (clear_local_git_env; cd "$sm_path" &&
  ( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
  test -z "$rev") || git-fetch)) ||
- die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+ die "$(eval_gettext "Unable to fetch in submodule path '\$prefix\$sm_path'")"
  fi

  # Is this something we just cloned?
@@ -657,20 +657,20 @@ Maybe you want to use 'update --init'?")"
  case "$update_module" in
  rebase)
  command="git rebase"
- die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path
'\$sm_path'")"
- say_msg="$(eval_gettext "Submodule path '\$sm_path': rebased into '\$sha1'")"
+ die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path
'\$prefix\$sm_path'")"
+ say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': rebased
into '\$sha1'")"
  must_die_on_failure=yes
  ;;
  merge)
  command="git merge"
- die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path
'\$sm_path'")"
- say_msg="$(eval_gettext "Submodule path '\$sm_path': merged in '\$sha1'")"
+ die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path
'\$prefix\$sm_path'")"
+ say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged
in '\$sha1'")"
  must_die_on_failure=yes
  ;;
  *)
  command="git checkout $subforce -q"
- die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule
path '\$sm_path'")"
- say_msg="$(eval_gettext "Submodule path '\$sm_path': checked out '\$sha1'")"
+ die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule
path '\$prefix\$sm_path'")"
+ say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': checked
out '\$sha1'")"
  ;;
  esac

@@ -688,11 +688,16 @@ Maybe you want to use 'update --init'?")"

  if test -n "$recursive"
  then
- (clear_local_git_env; cd "$sm_path" && eval cmd_update "$orig_flags")
+ (
+ prefix="$prefix$sm_path/"
+ clear_local_git_env
+ cd "$sm_path" &&
+ eval cmd_update "$orig_flags"
+ )
  res=$?
  if test $res -gt 0
  then
- die_msg="$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
+ die_msg="$(eval_gettext "Failed to recurse into submodule path
'\$prefix\$sm_path'")"
  if test $res -eq 1
  then
  err="${err};$die_msg"
--
1.7.11.3
