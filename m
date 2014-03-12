From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] submodule: add verbose mode for add/update
Date: Wed, 12 Mar 2014 08:38:51 +0200
Message-ID: <CAGHpTBJ29oyuNojiAtsd73wau4Xsz2zuxxg04mFG0TdekeSRxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 07:38:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNcob-0002Ax-2c
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 07:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605AbaCLGiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 02:38:52 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36043 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984AbaCLGiv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 02:38:51 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so9611263obc.16
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 23:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Z9vQwdfFRrsDardw2GWRSH/ps35W/TQ8+Q8EUYYMxcw=;
        b=VIeLec0GcC8MtF7femF5DMe6grwwilTj0ln/EVKBrGZuMBb7tlqh4mcnupUI24KKKF
         hphm4SQyzqg2S2rGzTrvT9fDPVqHfxf5bg40OTQW5KP026uOshh+lgrJm+AaY2rAgpaz
         jDc16dkTOyfBmkhGHFNyosTjRoXeh6tm5u9TlHuXEAd6WC8juCewyCqg61/FjwjDZv1h
         N7kkX124EP/zOAOycUxcEXE2udArSmtFbo8zt5ZoQ5ZGcXHNOy3CNcS1rTW1/l2E7huY
         Z8xI1D5siyWfhTaXcc2UPm8zZTmqLrSwksUpVZ5e7UQVXhluVN+C01qF7ufCPMpD380H
         AE+g==
X-Received: by 10.182.196.3 with SMTP id ii3mr36658487obc.11.1394606331503;
 Tue, 11 Mar 2014 23:38:51 -0700 (PDT)
Received: by 10.182.135.74 with HTTP; Tue, 11 Mar 2014 23:38:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243922>

Executes checkout without -q
---
 git-submodule.sh | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a33f68d..5c4e057 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,11 +5,11 @@
 # Copyright (c) 2007 Lars Hjemli

 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>]
[--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>]
[--reference <repository>] [-v|--verbose] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch]
[-f|--force] [--rebase] [--reference <repository>] [--merge]
[--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch]
[-f|--force] [--rebase] [--reference <repository>] [--merge]
[--recursive] [-v|--verbose] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files]
[--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -319,12 +319,16 @@ module_clone()
  rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
  (
  clear_local_git_env
+ if test -z "$verbose"
+ then
+ subquiet=-q
+ fi
  cd "$sm_path" &&
  GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
  # ash fails to wordsplit ${local_branch:+-B "$local_branch"...}
  case "$local_branch" in
- '') git checkout -f -q ${start_point:+"$start_point"} ;;
- ?*) git checkout -f -q -B "$local_branch" ${start_point:+"$start_point"} ;;
+ '') git checkout -f $subquiet ${start_point:+"$start_point"} ;;
+ ?*) git checkout -f $subquiet -B "$local_branch"
${start_point:+"$start_point"} ;;
  esac
  ) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
 }
@@ -380,6 +384,9 @@ cmd_add()
  --depth=*)
  depth=$1
  ;;
+ -v|--verbose)
+ verbose=1
+ ;;
  --)
  shift
  break
@@ -786,6 +793,9 @@ cmd_update()
  --depth=*)
  depth=$1
  ;;
+ -v|--verbose)
+ verbose=1
+ ;;
  --)
  shift
  break
@@ -913,7 +923,11 @@ Maybe you want to use 'update --init'?")"
  must_die_on_failure=
  case "$update_module" in
  checkout)
- command="git checkout $subforce -q"
+ if test -z "$verbose"
+ then
+ subquiet=-q
+ fi
+ command="git checkout $subforce $subquiet"
  die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule
path '\$displaypath'")"
  say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out
'\$sha1'")"
  ;;
-- 
1.9.0.msysgit.0
