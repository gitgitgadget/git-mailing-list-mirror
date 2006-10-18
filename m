From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Nice ftplugin for vim, that shows the commited diff in a split'ed buffer.
Date: Wed, 18 Oct 2006 02:39:36 +0200
Message-ID: <11611319761977-git-send-email-madcoder@debian.org>
References: <7vodsbmlkr.fsf@assigned-by-dhcp.cox.net> <1161131976193-git-send-email-madcoder@debian.org> <11611319762395-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 18 02:44:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzTP-0008Bj-C5
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWJRAjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWJRAjk
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:39:40 -0400
Received: from pan.madism.org ([88.191.16.128]:42708 "EHLO hermes.madism.org")
	by vger.kernel.org with ESMTP id S1751185AbWJRAji (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:39:38 -0400
Received: from hermes.madism.org (localhost.localdomain [127.0.0.1])
	by hermes.madism.org (Postfix) with ESMTP id 59AC0B005D;
	Wed, 18 Oct 2006 02:39:34 +0200 (CEST)
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id E7CB1B0062;
	Wed, 18 Oct 2006 02:39:33 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id 980CD62129; Wed, 18 Oct 2006 02:39:36 +0200 (CEST)
To: Jeff King <peff@peff.net>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11611319762395-git-send-email-madcoder@debian.org>
X-AV-Checked: ClamAV (using ClamSMTP) at pan.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29154>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 contrib/vim/README                 |   10 +++++
 contrib/vim/ftplugin/gitcommit.vim |   75 ++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/contrib/vim/README b/contrib/vim/README
index 9e7881f..e5ca9ae 100644
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -6,3 +6,13 @@ To syntax highlight git's commit message
      $ cat >>$HOME/.vimrc <<'EOF'
      autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
      EOF
+
+To use the fancy split-view with the currently commited diff, you need to:
+  1. Copy ftplugin/gitcommit.vim to vim's ftplugin directory:
+     $ mkdir -p $HOME/.vim/ftplugin
+     $ cp ftplugin/gitcommit.vim $HOME/.vim/ftplugin
+  2. Auto-detect the editing of git commit files (see above).
+  3. You can configure the diff to spawn automatically by setting:
+     let git_diff_spawn_mode = 1 (or 2) for an horiz (resp. vert) split.
+     else you have the bindings ,gd or ,ghd to spawn an horiz split with
+     the diff, and ,gvd for the same with a vertical diff.
diff --git a/contrib/vim/ftplugin/gitcommit.vim b/contrib/vim/ftplugin/gitcommit.vim
new file mode 100644
index 0000000..a9cb946
--- /dev/null
+++ b/contrib/vim/ftplugin/gitcommit.vim
@@ -0,0 +1,75 @@
+if exists("b:did_ftplugin")
+  finish
+endif
+
+let b:did_ftplugin = 1
+
+setlocal tw=74
+setlocal nowarn nowb
+
+"{{{ function Git_diff_windows
+
+function! Git_diff_windows(vertsplit, auto)
+    let i = 0
+    let list_of_files = ''
+
+    " drop everything until '#  (will commit)' and the next empty line
+    while i <= line('$')
+        let line = getline(i)
+        if line =~ '^#\s*(will commit)$'
+            let i = i + 2
+            break
+        endif
+
+        let i = i + 1
+    endwhile
+
+    " read file names until we have EOF or an empty line
+    while i <= line('$')
+        let line = getline(i)
+        if line =~ '^#\s*[a-z ]*:.*->.*$'
+            let file = substitute(line, '\v^#[^:]*:.*->\s*(.*)\s*$', '\1', '')
+            let list_of_files = list_of_files . ' '.file
+            let file = substitute(line, '\v^#[^:]*:\s*(.*)\s*->.*$', '\1', '')
+            let list_of_files = list_of_files . ' '.file
+        elseif line =~ '^#\s*[a-z ]*:'
+            let file = substitute(line, '\v^#[^:]*:\s*(.*)\s*$', '\1', '')
+            let list_of_files = list_of_files . ' '.file
+        elseif line =~ '^#\s*$'
+            break
+        endif
+
+        let i = i + 1
+    endwhile
+
+    if list_of_files == ""
+        return
+    endif
+
+    if a:vertsplit
+        rightbelow vnew
+    else
+        rightbelow new
+    endif
+    silent! setlocal ft=diff previewwindow bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile
+    exe 'normal :r!LANG=C cd ..; git diff HEAD -- ' . list_of_files . "\n1Gdd"
+    exe 'normal :r!LANG=C cd ..; git diff HEAD -- ' . list_of_files . " \| git apply --stat\no\<esc>1GddO\<esc>"
+    setlocal nomodifiable
+    if a:auto
+        redraw!
+        wincmd p
+        redraw!
+    endif
+endfunction
+
+"}}}
+
+noremap <buffer> ,gd :call Git_diff_windows(0, 0)<cr>
+noremap <buffer> ,ghd :call Git_diff_windows(0, 0)<cr>
+noremap <buffer> ,gvd :call Git_diff_windows(1, 0)<cr>
+
+if g:git_diff_spawn_mode == 1
+    call Git_diff_windows(0, 1)
+elseif g:git_diff_spawn_mode == 2
+    call Git_diff_windows(1, 1)
+endif
-- 
1.4.2.3
