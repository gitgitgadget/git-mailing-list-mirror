From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] cogito: Avoid slowness when timewarping large trees.
Date: Fri, 24 Mar 2006 11:43:52 -0500
Message-ID: <20060324164352.GA20684@spearce.org>
References: <20060324084423.GA30213@coredump.intra.peff.net> <7vd5gc16u2.fsf@assigned-by-dhcp.cox.net> <20060324105543.GA2543@coredump.intra.peff.net> <7v3bh814z4.fsf@assigned-by-dhcp.cox.net> <20060324112246.GA5220@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 17:44:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMpOR-00088T-Vq
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 17:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWCXQoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 11:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWCXQoE
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 11:44:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47338 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932248AbWCXQoC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 11:44:02 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FMpO9-0004WN-9n; Fri, 24 Mar 2006 11:43:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DDE8B20FB89; Fri, 24 Mar 2006 11:43:52 -0500 (EST)
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20060324112246.GA5220@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17926>

Jeff King <peff@peff.net> wrote:
> On Fri, Mar 24, 2006 at 03:01:35AM -0800, Junio C Hamano wrote:
> 
> > >   git-read-tree --reset "$base"
> > Exactly.  That's what I meant.  Thanks.
> 
> Hmm. That doesn't actually work, though. If I have a history like this:
> 
> $ cg-init -m "initial"
> $ cg-tag initial
> $ echo contents >file
> $ cg-add file
> $ cg-commit -m "added file"
> 
> and I try this:
> $ echo changes >file
> $ git-read-tree --reset master
> $ git-read-tree -m -u master initial
> 
> I get this:
> fatal: Entry 'file' not uptodate. Cannot merge.
> 
> If I do an update-index before the second read-tree, then I simply get:
> fatal: Entry 'file' would be overwritten by merge. Cannot merge.
> 
> Is there something I'm missing, or is a 'git reset --hard' really what
> we want here (in that case, the fact that git reset changes the HEAD
> might be a problem)?


This is sort of what I'm doing in pg-reset-tree, which is kind
of like 'git-reset --hard' but I think it is faster when $force
is unset:

  # Remove files left over from merge conflicts and files which are
  # somehow modified.  If this makes a directory empty it may have
  # been a new directory so delete that too.
  #
  (git-ls-files -z \
    --others \
    --ignored \
    --exclude='*#1' \
    --exclude='*#2' \
    --exclude='*#3' \
    --exclude='*.rej'
   git-diff-index --name-only -z HEAD
  ) | perl -n0e 'chomp; unlink; 1 while (s,/[^/]*$,, && rmdir)'
  
  # Rebuild the index and working directory.  We'll only checkout the
  # files which don't exist.  This resets the modified files we deleted
  # just above; remaining files will have their stat information updated
  # in the index.
  #
  git-read-tree --reset HEAD &&
  git-checkout-index --index --all $force \
    || die "Can't reset index and working directory."

  # Now that the working directory is clean we can safely merge it to
  # to our target tree, $new_base.
  #
  git-read-tree -m -u HEAD $new_base

The $force in git-checkout-index may or may not be set to
'--force'; its usually not set as its not usually necessary.
Unfortunately I've got a case where I'm mounting a directory
exported by SAMBA onto a Windows 2000 system and if I don't include
--force during git-checkout-index it doesn't work right about 1/3
of the time.  (It appears to be bad stat information coming from
Cygwin/Windows/SAMBA/Solaris.)

You can't skip the git-checkout-index step (I've tried) as the
ls-files/diff-index above causes the modified files (in your test
above 'changes') to disappear from the working directory and the
read-tree may not bring it back.

Now that I think about it isn't this sort of where you were before
in cg-seek?

-- 
Shawn.
