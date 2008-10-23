From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Verifying the whole repository
Date: Thu, 23 Oct 2008 07:28:04 -0700
Message-ID: <20081023142804.GA14786@spearce.org>
References: <b2cdc9f30810230659n15f44f64l571a0df3dbe104d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 16:29:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt1Bi-0005n3-Sr
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 16:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbYJWO2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 10:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbYJWO2F
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 10:28:05 -0400
Received: from george.spearce.org ([209.20.77.23]:44633 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbYJWO2F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 10:28:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2B9FF3835F; Thu, 23 Oct 2008 14:28:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <b2cdc9f30810230659n15f44f64l571a0df3dbe104d9@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98970>

Alex Bennee <kernel-hacker@bennee.com> wrote:
> As git is fundamentally hash based it's a lot easier to determine the
> health of the repository but I wonder if it's possible for silent
> corruption to creep in which won't be noticed until you try and
> checkout a historical commit of the tree. I notice there is a
> git-verify-pack command that checks the pack files are OK. Do any of
> the other commands implicitly ensure all objects in the repo are
> correct and valid? git-gc?

As David pointed out, git fsck can be used to verify all of the
hashes, but git-gc also does a quick sanity check using a CRC code
when it copies data from one pack to another pack.

Unlike CVS Git has a write-once, read-many mentality, so with
the exception of git gc (err, actually the git repack it calls)
git never modifies an existing file.  That really helps to reduce
the risk of corruption.

If you never do a gc or fsck operation (but still use say commit
or push into the repository) then yes, silent corruption can still
sneak up on you in the form of disk block corruption.

> Are there any other parts of the .git metadata that are crucial or is
> it enough to say if all objects and packs match their hashes you have
> all the information you may need to recover an arbitrary revision of
> the repo?

Don't forget about the loose objects under .git/objects/?? but
otherwise yes, you just need the object data.  The refs under
.git/refs are also useful, but the tips can be recovered if the
refs space is lost by "git fsck --unreachable".

-- 
Shawn.
