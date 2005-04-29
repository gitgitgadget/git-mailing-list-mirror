From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Odd decision of git-pasky-0.7 to do a merge
Date: Fri, 29 Apr 2005 10:07:17 +0100
Message-ID: <20050429100717.A5035@flint.arm.linux.org.uk>
References: <20050429083615.A32271@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 29 11:02:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRRNq-0000jg-S6
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 11:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVD2JHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 05:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVD2JHb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 05:07:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4361 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262477AbVD2JHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 05:07:21 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DRRSw-0004Fz-JS
	for git@vger.kernel.org; Fri, 29 Apr 2005 10:07:18 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DRRSv-00044C-Lo
	for git@vger.kernel.org; Fri, 29 Apr 2005 10:07:17 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050429083615.A32271@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Apr 29, 2005 at 08:36:16AM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 08:36:16AM +0100, Russell King wrote:
> This is what happened this morning to a tree which only gets pulled
> from Linus' tree.  No other changes are ever committed to it.
> 
> Why it decided that a merge was necessary is beyond me.  Any ideas?
> Did Linus forget to merge his tree properly?

Ok, there's something weird going on here.  On hera:

rmk@hera:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(0)$ SHA1_FILE_DIRECTORY=./objects fsck-cache
expect dangling commits - potential heads - due to lack of head information
dangling commit c60c390620e0abb60d4ae8c43583714bda27763f
rmk@hera:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(0)$ md5sum objects/03/97236d43e48e821cce5bbe6a80a1a56bb7cc3a
fd1369dbbd494b1839ad3d633a5d088e  objects/03/97236d43e48e821cce5bbe6a80a1a56bb7cc3a
rmk@hera:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(0)$ md5sum objects/9e/734775f7c22d2f89943ad6c745571f1930105f
b3b788308b7f137231652b5e97cb08c0  objects/9e/734775f7c22d2f89943ad6c745571f1930105f

In my repository:

$ fsck-cache
bad sha1 file: .git/objects/03/97236d43e48e821cce5bbe6a80a1a56bb7cc3a
root 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
bad sha1 file: .git/objects/9e/734775f7c22d2f89943ad6c745571f1930105f
expect dangling commits - potential heads - due to lack of head information
dangling commit 7598082671ce811737eca8119968dc056d78ac4b
$ md5sum objects/03/97236d43e48e821cce5bbe6a80a1a56bb7cc3a
fd1369dbbd494b1839ad3d633a5d088e  objects/03/97236d43e48e821cce5bbe6a80a1a56bb7cc3a
$ md5sum objects/9e/734775f7c22d2f89943ad6c745571f1930105f
b3b788308b7f137231652b5e97cb08c0  objects/9e/734775f7c22d2f89943ad6c745571f1930105f

These two objects appear to be tags according to cat-file -t on hera,
so these probably aren't the cause - it's more likely that git-pasky-0.7
doesn't know how to handle these objects.


> Tracked branch, applying changes...
> Merging e8108c98dd6d65613fa0ec9d2300f89c48d554bf -> c60c390620e0abb60d4ae8c43583714bda27763f
> 	to bdceb6a0162274934386f19f3ea5a9d44feb0b20...

Ok.  So.

rmk@hera:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(0)$ SHA1_FILE_DIRECTORY=./objects merge-base c60c390620e0abb60d4ae8c43583714bda27763f bdceb6a0162274934386f19f3ea5a9d44feb0b20
bdceb6a0162274934386f19f3ea5a9d44feb0b20

$ merge-base c60c390620e0abb60d4ae8c43583714bda27763f bdceb6a0162274934386f19f3ea5a9d44feb0b20
e8108c98dd6d65613fa0ec9d2300f89c48d554bf

Hmm.  At this point, I think we need something which graphically
shows the layout of the commit tree to work out what's going on,
and why my merge-base picked that particular commit id.

However, at this point, I think I can say that git obviously isn't
working as designed for me.

-- 
Russell King

