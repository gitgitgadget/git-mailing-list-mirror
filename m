From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Sat, 18 Jun 2005 22:35:31 +0100
Message-ID: <tnxis0b1h7g.fsf@arm.com>
References: <Pine.LNX.4.21.0506171750180.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 23:31:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Djku6-0006gZ-OE
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 23:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVFRVgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVFRVgb
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 17:36:31 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:23194 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261157AbVFRVgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2005 17:36:21 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5ILZM6i018434;
	Sat, 18 Jun 2005 22:35:22 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id WAA11867;
	Sat, 18 Jun 2005 22:35:46 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sat, 18 Jun 2005 22:35:45 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506171750180.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Fri, 17 Jun 2005 18:10:24 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 18 Jun 2005 21:35:45.0542 (UTC) FILETIME=[AF7CC260:01C5744D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel,

Thanks for your feedback.

Daniel Barkalow <barkalow@iabervon.org> wrote:
> It might be worth making the system work for having multiple series in the
> same tree. You could do this by saving the base commit for
> .git/refs/heads/<name> as .git/refs/bases/<name>, and putting patches in
> .git/patches/<name>/. Some people do a lot with
> .git/refs/heads/something; I, at least, symlink .git/HEAD to whichever one
> I'm using, so that might be the right way to tell what the user is
> doing.

Having different series would be a good idea but it might complicate
the tool usage. I will thing about it once I'm sure the basic
operations work fine.

Before commenting further on your or Jon's e-mail, I want to clarify
how I think this tool should be used (this might be misunderstood if
someone never used quilt before). First of all, a StGIT patch is a
collection of git commits. This tool *doesn't* remove or modify git
changesets.

Quilt or StGIT are intended for people maintaining their own (big)
patch on top of the Linux kernel. I will take the example of Con
Kolivas' kernel. His big patch for the -ck kernel is at
http://ck.kolivas.org/patches/2.6/2.6.12-rc6/2.6.12-rc6-ck2/patch-2.6.12-rc6-ck2.diff.bz2.
This big patch is provided mainly for the convenience of the people
wanting to test this kernel. If you want to get deeper into this
patch, you can get it split in several smaller patches
(http://ck.kolivas.org/patches/2.6/2.6.12-rc6/2.6.12-rc6-ck2/patches/).
This set of patches is called a 'series'. You even get a 'series' file
which defines the order in which the patches should be applied.

These patches in a series represent changes to different files grouped
after some criteria. Let's say you have 2 schedulers, you keep them in
2 separate patches. You can modify a scheduler and refresh
(re-generate) its patch with quilt or simply do a 'stg commit' with
StGIT and the change is taken into account for the topmost patch.

Note that the series might remain the same for a long time but the
patches it contains can change. When you want to upgrade the series of
patches to a new kernel version, with quilt or StGIT you pop all the
patches from the stack, upgrade the base (i.e. the mainline kernel)
and push the patches back onto the stack. You can have some of the
patches rejected in quilt or get merge conflicts with StGIT.

While you can simply use quilt patches on top of a git repository,
there are advantages in using StGIT:

- easier integration with a git repository with common commands like
  diff etc.

- there aren't separate commands for adding/removing files to/from the
  git repository and the StGIT patch since a StGIT patch is simply
  represented as two commit ids - the base (bottom) and the top of the
  patch (those familiar with quilt know what it means to modify a file
  without adding it first to the topmost patch)

- every time you commit some changes (with 'stg commit'), this
  changeset is added to the topmost patch on the stack (by replacing
  the top id of the patch with the new commit id). If you want to
  modify a patch, simply push/pop until it becomes the topmost one,
  make the changes and commit. All the commit history is preserved
  (unlike quilt where you update the patch with a 'refresh'
  command). With a future StGIT release you will be able to see the
  log for individual StGIT patches

- pushing a patch to the stack when the base changed is done by
  merging with a diff3 algorithm. I find this slightly superior to a
  simple 'patch -p1 < file.diff' (well, some people do not agree with
  this point)

> I think it would worth exploring defining a git type for patches and
> storing the patches inside git as well. Then a commit could identify the
> patch it applies (when it is from applying a patch), and a rebased patch
> could reference the patch it replaces, and then (with a certain amount of
> handwaving of implementation) the system could notice when the patch
> you're pushing got applied upstream. Or, at least, git could avoid 
> throwing away the history information when it goes through patches. I keep
> thinking that this would be an important feature, but I haven't got the
> familiarity with quilt to know how it should work.

I don't know whether this is still valid after clarifying the intended
use of StGIT. When a patch was merged upstream, the local push
operation should detect that the patch being pushed doesn't change
anything and, at this point, you can safely delete it.

-- 
Catalin

