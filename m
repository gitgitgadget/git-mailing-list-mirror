From: Danny Lin <danny0838@gmail.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Thu, 7 May 2015 11:43:15 +0800
Message-ID: <CAMbsUu7vkS4D2z_gNFsujVsyHjRiXseTLGCaic=841V=HZyb_g@mail.gmail.com>
References: <CAMbsUu66AJ1hC-nDrHSojMibYp-rh=zSpEwC3hCaG-1yU71GZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git develop <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 07 05:43:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqCiX-0004oQ-77
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 05:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbbEGDnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 23:43:16 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33027 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbEGDnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 23:43:16 -0400
Received: by qgdy78 with SMTP id y78so15206312qgd.0
        for <git@vger.kernel.org>; Wed, 06 May 2015 20:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pRHKsD1K0xk00OZsADvvxIRwe2dFac6uMg/FQBP5CTg=;
        b=qgJlZoFe3xyh1b/BruBA+D+F5ucCgJX1pNM1Fw4LpnCR1uzy/DBxR2VWD33zc7Qe0i
         LOZOIQTe590DvoLnxuui+Fh/KpOH73Z/q+ROshFDwC/dmw++sg+eIuL4moslDCGyGffi
         4zfW3cjI8USizO7khCz2JI6w7x+tWf9rViFN9Huda8FOCQLF5FkHYR19Mz1HAUzdAJMl
         ndRiFLudfjotmoawhLklHtTIDUcmMHMRLPm+SZOy9BwmsK49sIz/nMN4HJplvL5R6Hbp
         X16B1hdzBS7KpojGQ6I7DHRXPGnM4CqM7vEAtaPE03QYwVPTqCNLNGV/IvCgRrpccLkP
         0Szw==
X-Received: by 10.55.23.96 with SMTP id i93mr4034097qkh.75.1430970195274; Wed,
 06 May 2015 20:43:15 -0700 (PDT)
Received: by 10.140.98.145 with HTTP; Wed, 6 May 2015 20:43:15 -0700 (PDT)
In-Reply-To: <CAMbsUu66AJ1hC-nDrHSojMibYp-rh=zSpEwC3hCaG-1yU71GZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268506>

Subject: [PATCH] contrib/subtree: portability fix for string printing

Replace all echo using printf for better portability.

Also re-wrap previous 'say -n "$str<CR>"' using a new
function state() to prevent CR chars included in the
source code, which could be mal-processed on some
shells. For example, MsysGit trims CR before executing
a shell script file in order to make it work right on
Windows even if it uses CRLF as linefeeds.

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 contrib/subtree/git-subtree.sh | 56 +++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index fa1a583..2da1433 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -29,7 +29,7 @@ rejoin        merge the new branch back into HEAD
  options for 'add', 'merge', 'pull' and 'push'
 squash        merge subtree changes as a single commit
 "
-eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
+eval "$(printf %s "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" ||
printf %s "exit $?")"

 PATH=$PATH:$(git --exec-path)
 . git-sh-setup
@@ -51,17 +51,29 @@ prefix=
 debug()
 {
     if [ -n "$debug" ]; then
-        echo "$@" >&2
+        printf "%s\n" "$*" >&2
     fi
 }

 say()
 {
     if [ -z "$quiet" ]; then
-        echo "$@" >&2
+        printf "%s\n" "$*" >&2
     fi
 }

+state()
+{
+    if [ -z "$quiet" ]; then
+        printf "%s\r" "$*" >&2
+    fi
+}
+
+log()
+{
+    printf "%s\n" "$*"
+}
+
 assert()
 {
     if "$@"; then
@@ -72,7 +84,7 @@ assert()
 }


-#echo "Options: $*"
+#log "Options: $*"

 while [ $# -gt 0 ]; do
     opt="$1"
@@ -149,7 +161,7 @@ cache_get()
     for oldrev in $*; do
         if [ -r "$cachedir/$oldrev" ]; then
             read newrev <"$cachedir/$oldrev"
-            echo $newrev
+            log $newrev
         fi
     done
 }
@@ -158,7 +170,7 @@ cache_miss()
 {
     for oldrev in $*; do
         if [ ! -r "$cachedir/$oldrev" ]; then
-            echo $oldrev
+            log $oldrev
         fi
     done
 }
@@ -175,7 +187,7 @@ check_parents()

 set_notree()
 {
-    echo "1" > "$cachedir/notree/$1"
+    log "1" > "$cachedir/notree/$1"
 }

 cache_set()
@@ -187,7 +199,7 @@ cache_set()
          -a -e "$cachedir/$oldrev" ]; then
         die "cache for $oldrev already exists!"
     fi
-    echo "$newrev" >"$cachedir/$oldrev"
+    log "$newrev" >"$cachedir/$oldrev"
 }

 rev_exists()
@@ -219,7 +231,7 @@ rev_is_descendant_of_branch()
 try_remove_previous()
 {
     if rev_exists "$1^"; then
-        echo "^$1^"
+        log "^$1^"
     fi
 }

@@ -247,7 +259,7 @@ find_latest_squash()
                         sq="$sub"
                     fi
                     debug "Squash found: $sq $sub"
-                    echo "$sq" "$sub"
+                    log "$sq" "$sub"
                     break
                 fi
                 sq=
@@ -339,9 +351,9 @@ add_msg()
 add_squashed_msg()
 {
     if [ -n "$message" ]; then
-        echo "$message"
+        log "$message"
     else
-        echo "Merge commit '$1' as '$2'"
+        log "Merge commit '$1' as '$2'"
     fi
 }

@@ -373,17 +385,17 @@ squash_msg()

     if [ -n "$oldsub" ]; then
         oldsub_short=$(git rev-parse --short "$oldsub")
-        echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
+        log "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
         echo
         git log --pretty=tformat:'%h %s' "$oldsub..$newsub"
         git log --pretty=tformat:'REVERT: %h %s' "$newsub..$oldsub"
     else
-        echo "Squashed '$dir/' content from commit $newsub_short"
+        log "Squashed '$dir/' content from commit $newsub_short"
     fi

     echo
-    echo "git-subtree-dir: $dir"
-    echo "git-subtree-split: $newsub"
+    log "git-subtree-dir: $dir"
+    log "git-subtree-split: $newsub"
 }

 toptree_for_commit()
@@ -401,7 +413,7 @@ subtree_for_commit()
         assert [ "$name" = "$dir" ]
         assert [ "$type" = "tree" -o "$type" = "commit" ]
         [ "$type" = "commit" ] && continue  # ignore submodules
-        echo $tree
+        log $tree
         break
     done
 }
@@ -474,7 +486,7 @@ copy_or_skip()
     done

     if [ -n "$identical" ]; then
-        echo $identical
+        log $identical
     else
         copy_commit $rev $tree "$p" || exit $?
     fi
@@ -526,7 +538,7 @@ cmd_add()

 cmd_add_repository()
 {
-    echo "git fetch" "$@"
+    log "git fetch" "$@"
     repository=$1
     refspec=$2
     git fetch "$@" || exit $?
@@ -599,7 +611,7 @@ cmd_split()
     eval "$grl" |
     while read rev parents; do
         revcount=$(($revcount + 1))
-        say -n "$revcount/$revmax ($createcount)
"
+        state "$revcount/$revmax ($createcount)"
         debug "Processing commit: $rev"
         exists=$(cache_get $rev)
         if [ -n "$exists" ]; then
@@ -656,7 +668,7 @@ cmd_split()
         git update-ref -m 'subtree split' "refs/heads/$branch"
$latest_new || exit $?
         say "$action branch '$branch'"
     fi
-    echo $latest_new
+    log $latest_new
     exit 0
 }

@@ -726,7 +738,7 @@ cmd_push()
     if [ -e "$dir" ]; then
         repository=$1
         refspec=$2
-        echo "git push using: " $repository $refspec
+        log "git push using: " $repository $refspec
         localrev=$(git subtree split --prefix="$prefix") || die
         git push $repository $localrev:refs/heads/$refspec
     else
-- 
2.3.7.windows.1


Typo fix for previous patch.
