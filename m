From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Add import -p option
Date: Tue, 8 Sep 2009 22:43:39 +0100
Message-ID: <b0943d9e0909081443g47978cb7mee241d74dc52adf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:44:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml8Tv-0001Lb-Ec
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 23:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbZIHVnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 17:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZIHVnj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 17:43:39 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:38859 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbZIHVni (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 17:43:38 -0400
Received: by bwz19 with SMTP id 19so31349bwz.37
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=WTjQz5bDABJlNTliQx+q8pIv/xl+/idw2T8tn0Ah+9c=;
        b=YpHYlP76IZezhHGSwxTXy+itkHbp8zjL127L6Sfle7p3jOc+mZRNO+JdSRW+miSbg1
         W2STGLB6s352Jkn9hI7blbxP/IjCz+Isla1bqy9/3Dd6f7VnBgA9A1N+BJQy26XUkStg
         u4EsraZWOZARSxuYifxURP3z0lveO5Cgknaiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=hd7uBNK601IBs9JuxwBDoNer7IVcl1MDhI0lfBQ2tme8jPUtGBby3+DOgEuZiRrxN2
         5RfsIEy0w1gq8xKnJrI3vFn8MPIHpe6SO27DXfS5tvxV7goZKPWHbdCd0eD7mu3Gb0Mk
         nvLLIkAYzThw2rMDj0X2EpgIXKDEDJ30Z1d8o=
Received: by 10.223.144.67 with SMTP id y3mr6310889fau.40.1252446219744; Tue, 
	08 Sep 2009 14:43:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128042>

This patch renames some of the existing import options and adds the -p
(--strip) option which allows stripping the leading slashes of the diff
paths.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 stgit/commands/imprt.py |   13 ++++++++-----
 stgit/git.py            |    4 +++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 8067beb..0bbacbc 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -57,7 +57,9 @@ options = [
         short = 'Import a patch from a URL'),
     opt('-n', '--name',
         short = 'Use NAME as the patch name'),
-    opt('-t', '--strip', action = 'store_true',
+    opt('-p', '--strip', type = 'int', metavar = 'N',
+        short = 'Remove N leading slashes from diff paths (default 1)'),
+    opt('-t', '--stripname', action = 'store_true',
         short = 'Strip numbering and extension from patch name'),
     opt('-i', '--ignore', action = 'store_true',
         short = 'Ignore the applied patches in the series'),
@@ -69,7 +71,7 @@ options = [
         short = 'leave the rejected hunks in corresponding *.rej files'),
     opt('-e', '--edit', action = 'store_true',
         short = 'Invoke an editor for the patch description'),
-    opt('-p', '--showpatch', action = 'store_true',
+    opt('-d', '--showdiff', action = 'store_true',
         short = 'Show the patch content in the editor buffer'),
     opt('-a', '--author', metavar = '"NAME <EMAIL>"',
         short = 'Use "NAME <EMAIL>" as the author details'),
@@ -104,7 +106,7 @@ def __create_patch(filename, message, author_name,
author_email,
         patch = os.path.basename(filename)
     else:
         patch = ''
-    if options.strip:
+    if options.stripname:
         patch = __strip_patch_name(patch)

     if not patch:
@@ -152,9 +154,10 @@ def __create_patch(filename, message,
author_name, author_email,
             base = git_id(crt_series, options.base)
         else:
             base = None
-        git.apply_patch(diff = diff, base = base, reject = options.reject)
+        git.apply_patch(diff = diff, base = base, reject = options.reject,
+                        strip = options.strip)
         crt_series.refresh_patch(edit = options.edit,
-                                 show_patch = options.showpatch,
+                                 show_patch = options.showdiff,
                                  sign_str = options.sign_str,
                                  backup = False)
         out.done()
diff --git a/stgit/git.py b/stgit/git.py
index 268c44b..0886207 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -818,7 +818,7 @@ def repack():
     GRun('repack', '-a', '-d', '-f').run()

 def apply_patch(filename = None, diff = None, base = None,
-                fail_dump = True, reject = False):
+                fail_dump = True, reject = False, strip = None):
     """Apply a patch onto the current or given index. There must not
     be any local changes in the tree, otherwise the command fails
     """
@@ -840,6 +840,8 @@ def apply_patch(filename = None, diff = None, base = None,
     cmd = ['apply', '--index']
     if reject:
         cmd += ['--reject']
+    if strip:
+        cmd += ['-p', strip]
     try:
         GRun(*cmd).raw_input(diff).no_output()
     except GitRunException:
