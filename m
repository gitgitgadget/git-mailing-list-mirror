X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] StGIT bash completion
Date: Sun, 12 Nov 2006 22:18:13 +0100
Message-ID: <20061112211813.19959.73406.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 12 Nov 2006 21:23:43 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31279>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjMni-0000Wi-Be for gcvg-git@gmane.org; Sun, 12 Nov
 2006 22:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753211AbWKLVWu convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006 16:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbWKLVWu
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 16:22:50 -0500
Received: from mxfep04.bredband.com ([195.54.107.79]:6896 "EHLO
 mxfep04.bredband.com") by vger.kernel.org with ESMTP id S1753211AbWKLVWs
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 16:22:48 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82]) by
 mxfep04.bredband.com with ESMTP id
 <20061112212247.LEBC15709.mxfep04.bredband.com@ironport.bredband.com> for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 22:22:47 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport.bredband.com with
 ESMTP; 12 Nov 2006 22:22:46 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id 671344CC24; Sun, 12 Nov
 2006 22:22:46 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

A minimal bash completion script for StGIT. It completes the
subcommand names, and options and patch names for some subcommands.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

I'm not good at all at bash programming -- this script was basically
put together by pattern-matching Shawns git completion code -- so
comments are even more welcome than usual.

 contrib/stgit-completion.bash |  156 +++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 156 insertions(+), 0 deletions(-)

diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.b=
ash
new file mode 100644
index 0000000..25549fb
--- /dev/null
+++ b/contrib/stgit-completion.bash
@@ -0,0 +1,156 @@
+# bash completion support for StGIT                        -*- shell-s=
cript -*-
+#
+# Copyright (C) 2006, Karl Hasselstr=C3=B6m <kha@treskal.com>
+# Based on git-completion.sh
+#
+# To use these routines:
+#
+#    1. Copy this file to somewhere (e.g. ~/.stgit-completion.bash).
+#
+#    2. Add the following line to your .bashrc:
+#         . ~/.stgit-completion.bash
+
+# The path to .git, or empty if we're not in a repository.
+_gitdir ()
+{
+    echo "$(git rev-parse --git-dir 2>/dev/null)"
+}
+
+# Name of the current branch, or empty if there isn't one.
+_current_branch ()
+{
+    local b=3D$(git symbolic-ref HEAD 2>/dev/null)
+    echo ${b#refs/heads/}
+}
+
+# List of all applied patches.
+_applied_patches ()
+{
+    local g=3D$(_gitdir)
+    [ "$g" ] && cat "$g/patches/$(_current_branch)/applied"
+}
+
+# List of all unapplied patches.
+_unapplied_patches ()
+{
+    local g=3D$(_gitdir)
+    [ "$g" ] && cat "$g/patches/$(_current_branch)/unapplied"
+}
+
+# List of all patches.
+_all_patches ()
+{
+    local b=3D$(_current_branch)
+    local g=3D$(_gitdir)
+    [ "$g" ] && cat "$g/patches/$b/applied" "$g/patches/$b/unapplied"
+}
+
+# List of all patches except the current patch.
+_all_other_patches ()
+{
+    local b=3D$(_current_branch)
+    local g=3D$(_gitdir)
+    [ "$g" ] && cat "$g/patches/$b/applied" "$g/patches/$b/unapplied" =
\
+        | grep -v "^$(< $g/patches/$b/current)$"
+}
+
+# Generate completions for patches and patch ranges from the given
+# patch list function, and options from the given list.
+_complete_patch_range ()
+{
+    local patchlist=3D"$1" options=3D"$2"
+    local pfx cur=3D"${COMP_WORDS[COMP_CWORD]}"
+    case "$cur" in
+        *..*)
+            pfx=3D"${cur%..*}.."
+            cur=3D"${cur#*..}"
+            COMPREPLY=3D($(compgen -P "$pfx" -W "$($patchlist)" -- "$c=
ur"))
+            ;;
+        *)
+            COMPREPLY=3D($(compgen -W "$options $($patchlist)" -- "$cu=
r"))
+            ;;
+    esac
+}
+
+# Generate completions for options from the given list.
+_complete_options ()
+{
+    local options=3D"$1"
+    COMPREPLY=3D($(compgen -W "$options" -- "${COMP_WORDS[COMP_CWORD]}=
"))
+}
+
+_stg_delete ()
+{
+    _complete_patch_range _all_patches "--branch --help"
+}
+
+_stg_goto ()
+{
+    _complete_patch_range _all_other_patches "--help"
+}
+
+_stg_mail ()
+{
+    _complete_patch_range _all_patches \
+        "--all --to --cc --bcc --auto --noreply --version --prefix --t=
emplate \
+         --cover --edit-cover --edit-patches --sleep --refid --smtp-us=
er \
+         --smtp-password --branch --mbox --help"
+}
+
+_stg_new ()
+{
+    _complete_options "--message --showpatch --author --authname --aut=
hemail \
+                       --authdate --commname --commemail --help"
+}
+
+_stg_pop ()
+{
+    _complete_patch_range _applied_patches "--all --number --keep --he=
lp"
+}
+
+_stg_push ()
+{
+    _complete_patch_range _unapplied_patches "--all --number --reverse=
 \
+                                              --merged --undo --help"
+}
+
+_stg_status ()
+{
+    _complete_options "--modified --new --deleted --conflict --unknown=
 \
+                       --noexclude --reset --help"
+}
+
+_stg ()
+{
+    local i c=3D1 command
+
+    while [ $c -lt $COMP_CWORD ]; do
+        if [ $c =3D=3D 1 ]; then
+            command=3D"${COMP_WORDS[c]}"
+        fi
+        c=3D$((++c))
+    done
+
+    # Complete name of subcommand.
+    if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
+        COMPREPLY=3D($(compgen \
+            -W "--help --version \
+                $(stg help|grep '^ '|sed 's/ *\([^ ]\) .*/\1/')" \
+            -- "${COMP_WORDS[COMP_CWORD]}"))
+        return;
+    fi
+
+    # Complete arguments to subcommands.
+    case "$command" in
+        delete) _stg_delete ;;
+        goto)   _stg_goto ;;
+        mail)   _stg_mail ;;
+        new)    _stg_new ;;
+        pop)    _stg_pop ;;
+        push)   _stg_push ;;
+        status) _stg_status ;;
+        *)      COMPREPLY=3D() ;;
+    esac
+}
+
