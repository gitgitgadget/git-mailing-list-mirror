From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git push failure with update hook success
Date: Thu, 8 Mar 2007 09:22:53 +0000
Message-ID: <200703080922.54978.andyparkins@gmail.com>
References: <17902.59497.831409.218529@lisa.zopyra.com> <20070307170904.GB27922@spearce.org> <17902.62836.920473.810183@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 10:23:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPEq6-00066Z-L6
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 10:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbXCHJXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 04:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbXCHJXF
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 04:23:05 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:50012 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030384AbXCHJXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 04:23:00 -0500
Received: by mu-out-0910.google.com with SMTP id g7so530807muf
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 01:22:58 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LwRBerwmjWQqi3nG3gjXpUmhQC/j29Nv5tlemom3Na0MaHW5vX0M2VDlparW9mBnmjaUNvsfdQktf/7QYhdFu7EqHK7+ATSiv8/lgFffICMedVGmzIF23rac4Nww1zWUBieuD8t3V1E01pQpn4ShCkVJl+lqVDfwKMIxZIe8z1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nI1l3HQUECBQi2Mv3r+H3jfAHfX8Dv1MmNPzhShbkbteZ33YtUsnpnD+kBfhqgd84zhPQZazQheqfWpuCt2L23/PkzllUGlW9CczTLoBECvLdxIm9gEJqBEdWsDiCRKXzEnptk5YeMsIHKvfLNb69FgsDPrwKyQF+bHMFM1RAig=
Received: by 10.82.148.7 with SMTP id v7mr288822bud.1173345778599;
        Thu, 08 Mar 2007 01:22:58 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id a24sm4449775nfc.2007.03.08.01.22.57;
        Thu, 08 Mar 2007 01:22:58 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <17902.62836.920473.810183@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41723>

On Wednesday 2007 March 07 17:25, Bill Lear wrote:

> Ok, thank you for fixing this.  I guess the call run_update_hook()
> should not in fact come after the write_ref_sha1() block, and just
> before the 'return 0' line, because you don't want to run the
> write_ref_sha1() at all if the update hook complains.

Yep.  The problem is definitely real, it's a bodge to have to do the email 
generation in the update hook.  When I started writing a new update hook, I 
wanted to put it in post-update but found I couldn't.

Here's my assumption for an email generator: you want every change of revision 
to generate an email; you want only the revisions added to make that change 
to appear on an email; you want every new revision to appear on /only/ one 
email.

A lot of the magic for making emails with useful information comes from the 
fact that the update hook is given three pieces of information:
 - ref being changed
 - current revision of ref
 - potential new revision of ref

The first job of the update hook is to see if this update is allowed.  The 
sample update hook defaults to rejecting un-annotated tags - generally 
un-annotated tags are ones that you wouldn't want to distribute to the whole 
project.  It also rejects updates to remote tracking branches - obviously a 
remote shouldn't be allowed to update your local tracking branches - that's 
done by your own git-fetch; not someone elses git-push (in fact a central 
repository probably shouldn't have tracking branches at all).  This is the 
bit that in an ideal world stay in the pre-update hook.

The second job (which is the one that really should go into post-update but 
can't) is to build a useful email.  The ref parameter tells us what sort of 
ref we're updating; branch updates (i.e. refs/heads/*) and annotated tags 
(i.e. refs/tags/*) updates are the most interesting.

So; you want to send an email summarising the changes that are being added to 
the repository.  You don't want to send the entire log for every change to 
the branch in question since the beginning of time, because that would just 
make ever increasing emails.  Therefore you need the old revision. e.g.

 * -- * --- O (oldrev)
             \
              N -- N -- N (newrev)

In this case, the new revisions are found with "git-rev-list $oldrev..
$newrev".  Easy.

More difficult is when you want to be able to cope when the ref update 
was --forced.  e.g.

  * -- * -- B -- O -- O -- O (oldrev)
             \
              N -- N -- N (newrev)

In this example, the ref update was not a fast forward, newrev points at the 
tip of a branch which does not contain oldrev.  Oh dear, "git-rev-list 
$oldrev..$newrev" wouldn't return just the "N" revisions.  To get around 
this, the hook makes the assumption that emails for oldrev will already have 
been issued (otherwise how did oldrev get into the repository :-)) and finds 
the base revision of the old and new, B.  Then the new commits are given 
by "git-rev-list $baserev..$newrev".

The final tricky thing to get around is the killer for why this email 
generation has to be done in the pre-update hook.  Merges.

 * -- O (master) -- A -- A -- A -- M
       \                          /
        B --- B ---- B --- B --- B (maint)

Let's imagine that the master branch is what is being pushed, so it is about 
to be updated from O to M.  Sometime earlier, the "B" branch referenced by 
maint has received updates as normal.

The new revisions that need an email are all of the "A" nodes and the "M" 
node.  We can't simply use "git rev-list O..M" as we have before because that 
would include all of the "B" branch.  We've already had emails for those 
revisions so we'd simply be making noise.  The solution then is to cheat a 
little and say "all the revisions from O to M, but not any that reachable by 
refs already in the repository".  In git-speak:

  git-rev-list $oldrev..$newrev --not --all

Or, close to how it's written in the update-hook

 git-rev-list $newrev --not $oldrev --all

The "--all" means all of "refs/", and the revisions reachable by them.  Now 
here's the killer.  If we did that in the post-update hook (even if all the 
other information were available), this wouldn't work because the master ref 
would have been updated and would already point at "M".  In that 
case "--not --all" would include the new revisions.

Without adding some nasty switches to git-rev-list 
(like --all-except-this-branch), I can't see how the post-update hook could 
ever send emails with the necessary amount of detail.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
