From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: update-index --assume-unchanged doesn't make things go fast
Date: Wed, 25 Jun 2008 12:44:30 -0400
Message-ID: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 18:45:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBY7g-00081E-Qo
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbYFYQog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 12:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbYFYQog
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:44:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:51876 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbYFYQoe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 12:44:34 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3298238fkq.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=CUYq+m4R+28NBpg2V3uXVjHmRROJSLhLRO1SuT16g0E=;
        b=AbZomJE37AI7Lw5q/KiKCbV4/AMp1Gb0gQw1d4ekS5EKbTgkgV3tm5XFOmxlBYODMG
         ME08MqIJrfeF7VHTX20IXHp6nhxdxAkEZm3NVwp9BsavkBBnNVDzzuZHcN56o5KK1wA1
         zIm5ayyoC+T+E1Hgvk3m+nihuXSEbVLQ0Ax34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=jcQ13pLtej4LhIIM7/JKAQ0x9t3m4n3+rQbUiaSOVUxswAqP7Xdc3WOJC/P2OCDIFf
         c1cjgiWeE1uSfxg+CNeFkIjfkPXI4MYC9m3V6J5UcboAY3D9c9UQrWUA15/5JjgQRsZj
         7IC+FqrQl525bhqJ/pZ60O2rsPMctfR5+EH2M=
Received: by 10.82.167.9 with SMTP id p9mr656595bue.40.1214412270696;
        Wed, 25 Jun 2008 09:44:30 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Wed, 25 Jun 2008 09:44:30 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86303>

Hi all,

Using git 1.5.6.64.g85fe, but this applies to various other versions I've tried.

I have a git repo with about 17000+ files in 1000+ directories.  In
Linux, "git status" runs in under a second, which is perfectly fine.
But on Windows, which can apparently only stat() about 1000 files per
second, "git status" takes at least 17 seconds to run, even with a hot
cache.  (I've confirmed that stat() is so slow on Windows by writing a
simple program that just runs stat() in a tight loop.  The slowness
may be cygwin-related, as I found some direct Win32 calls that seem to
go more than twice as fast... which is still too slow.)

"git status" is not so important, since I can choose not to run it.
But it turns out that every git checkout and git commit does all the
same stuff, which is really not so great.  Even worse if you consider
that "git status" is almost always what I do by hand anyway to check
things before I commit.

So anyway, I read about the git-update-index --assume-unchanged
option, and thought that might be just what I want.  So I did this
(back in Linux, where things are easier to debug):

$ strace -fe lstat64 git status 2>&1 | wc -l
17869

$ git ls-files | xargs -d '\n' git update-index --assume-unchanged

$ strace -fe lstat64 git status 2>&1 | wc -l
33

So far, so good, and "git status" is now noticeably faster on my Linux
system (maybe twice as fast).  It's also noticeably faster on my
Windows system, but not as fast as I would have hoped.  I've tracked
it down to this:

$ strace -fe getdents64 git status 2>&1 | wc -l
2729

"git status" still checks all the *directories* to see if there are
any new files.  Of course!  --assume-unchanged can't be applied to a
directory, so there's no way to tell it not to do so.

Also, "git diff" is still as slow as ever:

$ strace -fe lstat64 git diff 2>&1 | wc -l
23199

It seems to be stat()ing the files even though they are
--assume-unchanged, which is probably a simple bug.

And while we're here, "git checkout" seems to be working a lot harder
than it should be:

$ strace -fe lstat64 git checkout -b boo 2>&1 | wc -l
23227

Note that I'm just creating a new branch name here, not even checking
out any new files, so I can't think of any situation where the
checkout would fail.  Is there one?

Even if I checkout a totally different branch, presumably it should
only need to stat() the files that changed between the old and new
versions, right?  And that would normally be very fast.

I don't mind doing some of the work to improve things here, as long as
people can give me some advice.  Specifically:

1) What's a sensible way to tell git to *not* opendir() specific
directories to look for unexpected files in "git status"?  (I don't
think I know enough to implement this myself.)

2) Do you think git-diff should honour --assume-unchanged?  If not, why not?

3) Do you think git-checkout can be optimized here?  I can see why it
might want to disregard --assume-unchanged (for safety reasons), but
presumably it only needs to look at all at files that it's planning to
change, right?

4) My idea is to eventually --assume-unchanged my whole repository,
then write a cheesy daemon that uses the Win32 dnotify-equivalent to
watch for files that get updated and then selectively
--no-assume-unchanged files that it gets notified about.  That would
avoid the need to ever synchronously scan the whole repo for changes,
thus making my git-Win32 experience much faster and more enjoyable.
(This daemon ought to be possible to run on Linux as well, for similar
improvements on gigantic repositories.  Also note that TortoiseSVN for
Windows does something similar to track file status updates, so this
isn't *just* me being crazy.)

Thoughts?

Thanks,

Avery
