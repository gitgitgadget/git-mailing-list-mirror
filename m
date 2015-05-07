From: Danny Lin <danny0838@gmail.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Thu, 7 May 2015 11:39:47 +0800
Message-ID: <CAMbsUu66AJ1hC-nDrHSojMibYp-rh=zSpEwC3hCaG-1yU71GZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git develop <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 07 05:39:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqCfB-0002qF-Fx
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 05:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbbEGDjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 23:39:49 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34092 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbbEGDjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 23:39:48 -0400
Received: by qcyk17 with SMTP id k17so15358154qcy.1
        for <git@vger.kernel.org>; Wed, 06 May 2015 20:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=4mo4eCTuogFeF05F6dXVQy8FaKGPolo9cETSpcXXxYE=;
        b=O1CRmCSqF3r67mcNNG+K4lE36aMw+8/9TVEiiz8l8O5t1ozVdzG2VX8cOyhTAvnUN4
         9ZpchrXAtco68xZN5md9QON/1THMNp+Y8HXPdVmk1Bqkux0VbYSbH6GZdmOXsyLgUJDX
         5jvoahVB2lu+6vo874vN0AuUg+obwfVMeRFhmbtVm2JKpmISFGharz0bgJCRpDTliNdD
         LRNHHnsWun8jegoL8aZFljaDtEHrqsH3TSir/+CVbS6uSXr+tYXzbiSZTNBi16lrBT8b
         DzXjOZVzrbw3V3xhnpioNqJs5gWyLYI/eY9cmrPgv2epmCq61tsWvSbJMVoeRz13dwFO
         P40Q==
X-Received: by 10.140.51.106 with SMTP id t97mr2524589qga.44.1430969987520;
 Wed, 06 May 2015 20:39:47 -0700 (PDT)
Received: by 10.140.98.145 with HTTP; Wed, 6 May 2015 20:39:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268505>

Replace all echo using printf for better portability.

Also re-wrap previous 'say -n "$str<CR>"' using a new
function state() so to prevent CR chars included in
the source code, which could be mal-processed on some
shells (e.g. MsysGit trims CR before executing a shell
script file in order to make it work right on Windows
even if it uses CRLF as linefeeds.

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



2015-05-07 3:58 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Wed, May 6, 2015 at 3:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Danny Lin <danny0838@gmail.com> writes:
>>
>>> cmd_split() prints a CR char by assigning a variable
>>> with a literal CR in the source code, which could be
>>> trimmed or mis-processed in some terminals. Replace
>>> with $(printf '\r') to fix it.
>
> For future readers of the patch who haven't followed the email
> discussion, it might be a good idea to explain the problem in more
> detail. Saying merely "could be trimmed or mis-processed in some
> terminals" doesn't give much for people to latch onto if they want to
> understand the specific problem. Concrete information would help.
>
Added related information.

>>> Signed-off-by: Danny Lin <danny0838@gmail.com>
>>> ---
>>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>>> index fa1a583..3a581fc 100755
>>> --- a/contrib/subtree/git-subtree.sh
>>> +++ b/contrib/subtree/git-subtree.sh
>>> @@ -596,10 +596,11 @@ cmd_split()
>>>      revmax=$(eval "$grl" | wc -l)
>>>      revcount=0
>>>      createcount=0
>>> +    CR=$(printf '\r')
>>>      eval "$grl" |
>>>      while read rev parents; do
>>>          revcount=$(($revcount + 1))
>>> -        say -n "$revcount/$revmax ($createcount)
>>> "
>>> +        say -n "$revcount/$revmax ($createcount)$CR"
>>
>> Interesting.  I would have expected, especially this is a portability-fix
>> change, that the change would be a single liner
>>
>> -       say -n ...
>> +       printf "%s\r" "$revcount/$revmax ($createcount)"
>>
>> that does not touch any other line.
>
> Unfortunately, that solution does not respect the $quiet flag like
> say() does. I had envisioned the patch as reimplementing say() using
> printf rather than echo, and having say() itself either recognizing
> the -n flag or just update callers to specify \n when they want it
> (which is probably the cleaner of the two approaches).
>
If a more thorough portability fix is desired, I'd prefer a work like this
(see the patch above).
