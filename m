From: James Vega <vega.james@gmail.com>
Subject: Re: git-apply fails on creating a new file, with both -p and --directory specified
Date: Mon, 7 Dec 2009 21:35:36 +0000 (UTC)
Message-ID: <loom.20091207T222449-752@post.gmane.org>
References: <20091123194523.GZ15966@cl.cam.ac.uk> <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 22:40:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHlJX-0001xm-Bj
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 22:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935599AbZLGVkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 16:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbZLGVkB
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 16:40:01 -0500
Received: from lo.gmane.org ([80.91.229.12]:42647 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935592AbZLGVkA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 16:40:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NHlJN-0001rm-5d
	for git@vger.kernel.org; Mon, 07 Dec 2009 22:40:05 +0100
Received: from 128.221.197.56 ([128.221.197.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 22:40:05 +0100
Received: from vega.james by 128.221.197.56 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 22:40:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.221.197.56 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.5 (KHTML, like Gecko) Chrome/4.0.249.25 Safari/532.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134788>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> "Steven J. Murdoch" <git+Steven.Murdoch <at> cl.cam.ac.uk> writes:
> 
> > This appears to be because I was both using -p to strip some path
> > components, and --directory to add different ones in. Only creating
> > new files was affected.
> 
> A very nicely done report.
> 
> In addition to your test case, I suspect that a patch that only changes
> mode would have acted funny with -p<n> option.
> 

It looks like this may have introduced a bug when staging a file
removal.  Here's an example git session showing the issue:

$ git init test
Initialized empty Git repository in /local_disk/tmp/test/.git/
$ cd test
$ echo "foo" > foo
$ git add foo
$ git commit -m 'Add foo'
[master (root-commit) 3643b5d] Add foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
$ mv foo bar
$ git add -p
diff --git a/foo b/foo
index 257cc56..0000000
--- a/foo
+++ /dev/null
@@ -1 +0,0 @@
-foo
Stage this hunk [y,n,q,a,d,/,e,?]? y

$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD ..." to unstage)
#
#       new file:   dev/null
#       deleted:    foo
#
# Changed but not updated:
#   (use "git add/rm ..." to update what will be committed)
#   (use "git checkout -- ..." to discard changes in working directory)
#
#       deleted:    dev/null
#
# Untracked files:
#   (use "git add ..." to include in what will be committed)
#
#       bar

Replacing the 'git add -p' with

  git diff | sed '/^deleted file/d' | git apply --cached

also exhibits the problem.
