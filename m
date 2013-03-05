From: Eric Cousineau <eacousineau@gmail.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be depth-first,
 --parent option to execute command in supermodule as well
Date: Mon, 04 Mar 2013 23:37:12 -0600
Message-ID: <51358488.2080005@gmail.com>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com> <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 06:37:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCkZW-0005IR-2W
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 06:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab3CEFhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 00:37:17 -0500
Received: from mail-ia0-f177.google.com ([209.85.210.177]:48371 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3CEFhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 00:37:16 -0500
Received: by mail-ia0-f177.google.com with SMTP id y25so410323iay.8
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 21:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zq/Jiaa6yDIKoJfv0YALu+Bgwzb8FefIhGiEZfzidjI=;
        b=eV33m4j7KKgam/ihjBNkdAoxGEQ8iYaWIchl3PeGopznbvy1H+QGU+DHRZYSl+zJYb
         ZqtJVG6zlQBFdkG5CGfe+ELdIzaAyDIVxdd5/zBn8xBd5eIGJZpkm4k5BZ9j+ClWsSoB
         1eY9NI5EKhS0FKhSeDkw8N/NpcSR4B8gW4XCq4u1wU8DjXNGo170GULzT0zTuuga7X9R
         9KqNrOzQVhw8ZZFAWV2WHPVWFvBjx9BmlF60mL56Ae5Ao14uHZZ3Y6FqtRigpGc5GZZ4
         LFASHvJtrs5MU05of2LSPQqsl9grwSdebkMg6nwg92QMosXP0nD9/z2e/LOzC45heHYf
         ZMnw==
X-Received: by 10.50.237.70 with SMTP id va6mr5058188igc.66.1362461835973;
        Mon, 04 Mar 2013 21:37:15 -0800 (PST)
Received: from [10.3.2.16] ([199.30.163.2])
        by mx.google.com with ESMTPS id l2sm13787446igb.1.2013.03.04.21.37.13
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Mar 2013 21:37:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217429>

git-submodule.sh: In foreach, make '-post-order' yield post-order 
traversal and
'--include-super' execute commands at the top-level supermodule, with 
both of these
options compatible with '--recursive'.

Signed-off-by: Eric Cousineau <eacousineau@gmail.com>
---
Sorry about missing the part about not included MIME attachments, hope 
this is in a better format now.
Jens, I changed the '--parent' option to '--include-super' which is 
hopefully less vague.
Junio, you made an excellent point about both being useful. In 
particular, I overlooked the case
for doing a submodule pull / update (if, for whatever reason, it is more 
convenient than a submodule
update, maybe for merging). In that case, you might want to initialize 
new submodules and ignore the
old ones, instead of wasting time on them with a post-order traversal pull.
I've implemented your suggestions to have a boolean '--post-order' 
option, and made the '--include-super'
option compatible with it. This way, the original behavior of 'foreach' 
is preserved.

I've updated the test and uploaded it to pastebin: 
http://pastebin.com/BgZNzFpi

  git-submodule.sh | 102 
+++++++++++++++++++++++++++++++++++++++++--------------
  1 file changed, 77 insertions(+), 25 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 004c034..652bea0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] 
[--name <name>] [--reference <re
     or: $dashless [--quiet] init [--] [<path>...]
     or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] 
[-f|--force] [--rebase] [--reference <repository>] [--merge] 
[--recursive] [--] [<path>...]
     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit 
<n>] [commit] [--] [<path>...]
-   or: $dashless [--quiet] foreach [--recursive] <command>
+   or: $dashless [--quiet] foreach [--recursive] [--include-super] 
[--post-order] <command>
     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
  OPTIONS_SPEC=
  . git-sh-setup
@@ -434,6 +434,8 @@ Use -f if you really want to add it." >&2
  cmd_foreach()
  {
      # parse $args after "submodule ... foreach".
+    # Gratuitous (empty) local's to prevent recursive bleeding
+    local include_super= recursive= post_order=
      while test $# -ne 0
      do
          case "$1" in
@@ -443,6 +445,12 @@ cmd_foreach()
          --recursive)
              recursive=1
              ;;
+        --post-order)
+            post_order=1
+            ;;
+        --include-super)
+            include_super=1
+            ;;
          -*)
              usage
              ;;
@@ -453,35 +461,79 @@ cmd_foreach()
          shift
      done

-    toplevel=$(pwd)
+    if test -n "$recursive"
+    then
+        local recursive_flags="--recursive"
+        if test -n "$post_order"
+        then
+            recursive_flags="$recursive_flags --post-order"
+        fi
+    fi
+
+    local toplevel=$(pwd)

      # dup stdin so that it can be restored when running the external
      # command in the subshell (and a recursive call to this function)
      exec 3<&0
+
+    # Use nested functions
+    super_eval() {
+        name=$(basename "$toplevel")
+        clear_local_git_env
+        path=.
+        say "$(eval_gettext "Entering '\$name'")" # Not sure of proper 
thing here
+        eval "$@" || die "$(eval_gettext "Stopping at supermodule; 
script returned non-zero status.")"
+    }

-    module_list |
-    while read mode sha1 stage sm_path
-    do
-        die_if_unmatched "$mode"
-        if test -e "$sm_path"/.git
-        then
-            say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
-            name=$(module_name "$sm_path")
-            (
-                prefix="$prefix$sm_path/"
-                clear_local_git_env
-                # we make $path available to scripts ...
-                path=$sm_path
-                cd "$sm_path" &&
-                eval "$@" &&
-                if test -n "$recursive"
-                then
-                    cmd_foreach "--recursive" "$@"
-                fi
-            ) <&3 3<&- ||
-            die "$(eval_gettext "Stopping at '\$sm_path'; script 
returned non-zero status.")"
-        fi
-    done
+    if test -n "$include_super" -a -z "$post_order"
+    then
+        super_eval "$@"
+    fi &&
+    (
+        module_list |
+        while read mode sha1 stage sm_path
+        do
+            die_if_unmatched "$mode"
+            if test -e "$sm_path"/.git
+            then
+                local name prefix path message epitaph
+                message="$(eval_gettext "Entering '\$prefix\$sm_path'")"
+                epitaph="$(eval_gettext "Stopping at '\$sm_path'; 
script returned non-zero status.")"
+                name=$(module_name "$sm_path")
+                (
+                    prefix="$prefix$sm_path/"
+                    clear_local_git_env
+                    # we make $path available to scripts ...
+                    path=$sm_path
+
+                    sm_eval() {
+                        say "$message"
+                        eval "$@" || die "$epitaph"
+                    }
+
+                    cd "$sm_path" &&
+                    if test -z "$post_order"
+                    then
+                        sm_eval "$@"
+                    fi &&
+                    if test -n "$recursive"
+                    then
+                        cmd_foreach $recursive_flags "$@"
+                    fi &&
+                    if test -n "$post_order"
+                    then
+                        sm_eval "$@"
+                    fi
+                    # Since the (...) seems to limit exit's scope, make 
sure to kill things here if something goes awry
+                    # (the `|| exit 1` at the end)
+                ) <&3 3<&- || exit 1
+            fi
+        done
+    ) &&
+    if test -n "$include_super" -a -n "$post_order"
+    then
+        super_eval "$@"
+    fi
  }

  #
-- 
1.8.2.rc1.24.g06d67b8.dirty
