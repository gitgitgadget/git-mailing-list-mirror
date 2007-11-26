From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] best way to show diff of commit
Date: Mon, 26 Nov 2007 01:25:19 +0100
Message-ID: <20071126002519.GA11133@efreet.light.src>
References: <20071125211831.GA21121@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
To: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 01:25:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwRnI-000308-V4
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 01:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbXKZAZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 19:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756648AbXKZAZ2
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 19:25:28 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:58278 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160AbXKZAZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 19:25:27 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 2CDD05726D;
	Mon, 26 Nov 2007 01:25:26 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 24mcK1EBqYGu; Mon, 26 Nov 2007 01:25:23 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id D013057287;
	Mon, 26 Nov 2007 01:25:22 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IwRmp-0004bJ-QT; Mon, 26 Nov 2007 01:25:19 +0100
Content-Disposition: inline
In-Reply-To: <20071125211831.GA21121@artemis.corp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66030>

On Sun, Nov 25, 2007 at 22:18:31 +0100, Pierre Habouzit wrote:
>   Hi there,
> 
>   There is specific script I run in my vim with git, that tries to show
> from the 'status' git commit shows in the buffer which list of files has
> changed, and builds a diff from it quite clumsily[0].
> 
>   I wonder how hard it would be for git commit to "stash" the current
> commit being sent somewhere editors would be able to have a look at (an
> alternate index is probably fine). Note that maybe I'm stupid and
> overlooked that such a thing already exists.  I'd like to have it in two
> flavors: normal and amend mode. normal mode would show what the
> resulting commit diff looks like, and the amend mode only shows the
> incrementall diff the amend adds to the previous commit.

Such thing does already exist. When the editor is called, the index pointed
to by GIT_INDEX_FILE (or the default index if unset) is exactly what will
be in the commit.

Hm, looking at the builtin-commit.c that is currently cooking in next, it
does not seem to be the case there. It probably should, so the editor can
inspect what will be commited.

>   My question is: what do you think is the best way to do that, and
> where ?

Are you talking about the ftplugins/git.vim script from vim-scripts package,
right?

All it needs to do is call 'git diff --cached'. The below patch seems to work
here (tried commit, commit -a, commit --amend, commit -a --amend and commit
from subdirectory and they seemed to all work).

>   [0] the issue with this approach is that it's completely broken in
>       amending mode (does not shows the proper thing), and the generated

I didn't find any issue with amending mode (showed incremental diff for me
all right). The problem was when a file was being touched by the commit but
work tree had unstaged changes. Such changes were shown when they shouldn't.

>       diffs aren't excellent, because as an editor plugin, it's hard to
>       treat renames and copies easily, so I generate really really nasty
>       diffs in that case too.

With --cached, detecting copies is just a matter of adding -C. In the patch
below I added only one -C, but it should probably be user-configurable to use
no, one or two (equivalent of --find-copies-harder).

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

---8<---
--- vim-scripts/ftplugin/git.vim.orig	2007-07-24 09:46:19.000000000 +0200
+++ vim-scripts/ftplugin/git.vim	2007-11-26 01:01:59.000000000 +0100
@@ -14,41 +14,6 @@
 "{{{ function Git_diff_windows
 
 function! Git_diff_windows(vertsplit, auto)
-    let i = 0
-    let list_of_files = ''
-
-    " drop everything until '#  (will commit)' and the next empty line
-    while i <= line('$')
-        let line = getline(i)
-        if line == '# Changes to be committed:'
-            let i = i + 3
-            break
-        endif
-
-        let i = i + 1
-    endwhile
-
-    " read file names until we have EOF or an empty line
-    while i <= line('$')
-        let line = getline(i)
-        if line =~ '^#\s*[a-z ]*:.*->.*$'
-            let file = substitute(line, '^#[^:]*:.*->\s*\(.*\)\s*$', '\1', '')
-            let list_of_files = list_of_files . ' '.file
-            let file = substitute(line, '^#[^:]*:\s*\(.*\)\s*->.*$', '\1', '')
-            let list_of_files = list_of_files . ' '.file
-        elseif line =~ '^#\s*[a-z ]*:'
-            let file = substitute(line, '^#[^:]*:\s*\(.*\)\s*$', '\1', '')
-            let list_of_files = list_of_files . ' '.file
-        elseif line =~ '^#\s*$'
-            break
-        endif
-
-        let i = i + 1
-    endwhile
-
-    if list_of_files == ""
-        return
-    endif
 
     if a:vertsplit
         rightbelow vnew
@@ -56,15 +21,8 @@
         rightbelow new
     endif
     silent! setlocal ft=diff previewwindow bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile
-    let gitDir = system('git rev-parse --git-dir 2>/dev/null')
-    let gitDir = substitute(gitDir, '.git\n', '', '')
-    let wd = getcwd()
-    if gitDir != ''
-        exe 'cd '.gitDir
-    endif
-    exe 'normal :r!LANG=C git diff HEAD -- ' . list_of_files . "\n1Gdd"
-    exe 'normal :r!LANG=C git diff --stat HEAD -- ' . list_of_files . "\no\<esc>1GddO\<esc>"
-    exe 'cd '.wd
+    exe "normal :r!LANG=C git diff --cached -C\n1Gdd"
+    exe "normal :r!LANG=C git diff --stat --cached -C\no\<esc>1GddO\<esc>"
     setlocal nomodifiable
     noremap <buffer> q :bw<cr>
     if a:auto
