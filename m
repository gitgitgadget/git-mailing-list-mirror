From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] nice ftplugin for vim, that shows the commited diff in a split'ed buffer.
Date: Tue, 17 Oct 2006 02:31:10 +0200
Message-ID: <11610450701082-git-send-email-madcoder@debian.org>
References: <11610450702261-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 17 02:31:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZcrW-000331-7W
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 02:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422974AbWJQAbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 20:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422988AbWJQAbO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 20:31:14 -0400
Received: from pan.madism.org ([88.191.16.128]:5785 "EHLO hermes.madism.org")
	by vger.kernel.org with ESMTP id S1422986AbWJQAbN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 20:31:13 -0400
Received: from hermes.madism.org (localhost.localdomain [127.0.0.1])
	by hermes.madism.org (Postfix) with ESMTP id 81636B0060;
	Tue, 17 Oct 2006 02:31:08 +0200 (CEST)
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id 398F8B005C;
	Tue, 17 Oct 2006 02:31:08 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id B155E62112; Tue, 17 Oct 2006 02:31:10 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11610450702261-git-send-email-madcoder@debian.org>
X-AV-Checked: ClamAV (using ClamSMTP) at pan.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29007>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 contrib/vim/README                 |    6 ++++
 contrib/vim/ftplugin/gitcommit.vim |   61 ++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/contrib/vim/README b/contrib/vim/README
index 9e7881f..26c1682 100644
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -6,3 +6,9 @@ To syntax highlight git's commit message
      $ cat >>$HOME/.vimrc <<'EOF'
      autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
      EOF
+
+To use the fancy split-view with the currently commited diff, you need to:
+  1. Copy ftplugin/gitcommit.vim to vim's ftplugin directory:
+     $ mkdir -p $HOME/.vim/ftplugin
+     $ cp ftplugin/gitcommit.vim $HOME/.vim/ftplugin
+  2. Auto-detect the editing of git commit files (see above).
diff --git a/contrib/vim/ftplugin/gitcommit.vim b/contrib/vim/ftplugin/gitcommit.vim
new file mode 100644
index 0000000..f9efd59
--- /dev/null
+++ b/contrib/vim/ftplugin/gitcommit.vim
@@ -0,0 +1,61 @@
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
+function! Git_diff_windows()
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
+    rightbelow vnew
+    silent! setlocal ft=diff previewwindow bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile
+    exe 'normal :r!LANG=C cd ..; git diff HEAD -- ' . list_of_files . "\n1Gdd"
+    exe 'normal :r!LANG=C cd ..; git diff HEAD -- ' . list_of_files . " \| git apply --stat\no\<esc>1GddO\<esc>"
+    setlocal nomodifiable
+    redraw!
+    wincmd p
+    redraw!
+endfunction
+
+"}}}
+
+call Git_diff_windows()
-- 
1.4.2.3
