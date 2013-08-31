From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: skip ill-formed references
Date: Sat, 31 Aug 2013 12:32:17 -0500
Message-ID: <CAMP44s0Ht4tu3XuKW5BYFZFMHVMwMZtD8dJgULHqdb47__Hq5g@mail.gmail.com>
References: <20130831011542.GA10486@wheezy.local>
	<CAMP44s2f7S4STbCOuh35sgdrgAdw-2Tw1LDkjhO37hXLxX3mRQ@mail.gmail.com>
	<loom.20130831T155657-714@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sat Aug 31 19:32:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFp27-0002Bc-K4
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 19:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab3HaRcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 13:32:19 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:60225 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab3HaRcT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 13:32:19 -0400
Received: by mail-lb0-f177.google.com with SMTP id p5so2717932lbi.8
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hHzFCJ0iqR1STIUvUiFZieZ1yZd4VRqnpn/OOvG8WWg=;
        b=v8e2oajLPJoNhPkpgS7vVS3bq4/6DV7JJyLGURzK0EpT89gHcrzbRHgk7OTtXq8Jn1
         0p+v+D7bSTLsaFWba2j92V+XMKxeSriatClhfZfXSGDyKO4h+kwnavPI5zo16kCPGrLw
         9RLFXzZnd/7SC7iYD8tupvXhCs93RQ+svQNG0FYFzSRoiMy3OA9zJzb2ckkGPPjV1wHt
         gQrCnM6HYijf+AkJecCE5YXcfuaAWzYF47gyZejv4yWnJ/aPs/uW5bKT/jiAx61gEh3T
         MKruxHXmax9iNl/OXWMYiKVMixE2j1S864iBYk93ldSZN8fuj56VPc1n7RM5fULlhe0e
         rhlA==
X-Received: by 10.152.26.72 with SMTP id j8mr13180115lag.19.1377970337796;
 Sat, 31 Aug 2013 10:32:17 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 31 Aug 2013 10:32:17 -0700 (PDT)
In-Reply-To: <loom.20130831T155657-714@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233526>

On Sat, Aug 31, 2013 at 8:58 AM, Max Kirillov <max@max630.net> wrote:
> Felipe Contreras <felipe.contreras <at>
> gmail.com> writes:
>> Which repository triggered this?
>
> Tha was some of the vim repositories, upstream
> https://code.google.com/p/vim/ or debian
> anonscm.debian.org/hg/pkg-vim/vim, or both.
> They contain tags with ~ symbol.

Thanks.

> I don't have any experience with bazaar yet, so
> cannot say much about it.

That code is independent from bazaar. the ref_is_valid() method should
return True or False depending on whether Git thinks it's a valid ref
or not, it's independent from Bazaar or Mercurial, and all
remote-helpers could share the same one.

So this is what I have in mind:

--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -617,6 +617,9 @@ def list_head(repo, cur):
     print "@refs/heads/%s HEAD" % head
     g_head = (head, node)

+def ref_is_valid(name):
+    return not True in [c in name for c in '~^: \\']
+
 def do_list(parser):
     repo = parser.repo
     for bmark, node in bookmarks.listbookmarks(repo).iteritems():
@@ -635,15 +638,24 @@ def do_list(parser):

     if track_branches:
         for branch in branches:
-            print "? refs/heads/branches/%s" % gitref(branch)
+            branch = gitref(branch)
+            if not ref_is_valid(branch):
+                continue
+            print "? refs/heads/branches/%s" % branch

     for bmark in bmarks:
-        print "? refs/heads/%s" % gitref(bmark)
+        bmark = gitref(bmark)
+        if not ref_is_valid(bmark):
+            continue
+        print "? refs/heads/%s" % bmark

     for tag, node in repo.tagslist():
         if tag == 'tip':
             continue
-        print "? refs/tags/%s" % gitref(tag)
+        tag = gitref(tag)
+        if not ref_is_valid(tag):
+            continue
+        print "? refs/tags/%s" % tag

     print

-- 
Felipe Contreras
