From: Johan Herland <johan@herland.net>
Subject: Re: git filter-branch --filter-notes/--post-rewrite?
Date: Mon, 21 Mar 2011 03:39:09 +0100
Message-ID: <201103210339.09460.johan@herland.net>
References: <hbf.20110317iwua@bombur.uio.no>
 <201103181053.58969.trast@student.ethz.ch> <hbf.20110320kak3@bombur.uio.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Mon Mar 21 03:39:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1V1c-0007i6-Uu
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 03:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab1CUCjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 22:39:16 -0400
Received: from smtp.getmail.no ([84.208.15.66]:61360 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab1CUCjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 22:39:15 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LID00EMRZDCQO20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 21 Mar 2011 03:39:12 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id B3F591EA581B_D86BA50B	for <git@vger.kernel.org>; Mon,
 21 Mar 2011 02:39:12 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C87551EA2CAF_D86BA4DF	for <git@vger.kernel.org>; Mon,
 21 Mar 2011 02:39:09 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LID00A40ZD9Y600@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 21 Mar 2011 03:39:09 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <hbf.20110320kak3@bombur.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169552>

On Sunday 20 March 2011, Hallvard B Furuseth wrote:
> Thomas Rast writes:
> >Johan Herland wrote:
> >> Looking at git-rebase.sh (where it _is_ implemented), it seems to be a
> >> matter of feeding "old_sha1 new_sha1" pairs into a "rewritten" file,
> >> and then passing that file to the stdin of "git notes copy
> >> --for-rewrite=filter- branch" (followed by passing the same file to
> >> the "post-rewrite" hook).
> 
> That appends to the notes history instead of replacing it, which seems
> broken to me.  So I'm doing fast-export <notes> | edit; fast-import.

Yeah, Rewriting the notes history along with the "real" history requires a 
bit more work. In reality, though, if the notes history is not interesting 
in itself, you can first do the notes rewrite I describe above, next prune 
the notes tree ("git notes prune") to remove the old notes from the notes 
tree, then finally drop the entire notes history except the last commit 
(using grafts + filter-branch, or using commit-tree to simply wrapping the 
notes tree object in a new parent-less notes commit).

> > I had a patch for this back when post-rewrite was invented,
> > 
> >   http://thread.gmane.org/gmane.comp.version-control.git/139919/focus=1
> >   39917
> > 
> > but Hannes replied that it should grow a real notes filter, and while
> > I dropped it there, I tend to agree with him.  Feel free to pick it up
> > again.
> 
> A notes filter would be nice, but I don't understand why there's no
> post-rewrite hook or option to let us get at the rewrite info before
> it is deleted.  For one thing a notes filter might not do just what is
> intended (as above), but one might want the mapping info for other
> things too.  E.g. just to save it in case there are mailings floating
> around which refer to old commit IDs.

We should probably apply Thomas' post-rewrite patch in any case. It gives 
the post-rewrite hook access to both the old and new commit IDs, so should 
have all the info you need to do whatever you want with the repo.

Note that after filter-branch is done, you should still be able to access 
the old objects (by using the old commit IDs directly), at least until the 
next "git gc".

> In any case, thanks for the answers.  I guess I can live with copying
> the git-filter-branch script when needed, it's not as if I run that
> every day.

Yeah, using filter-branch on an everyday basis would sound like a 
fundamental workflow problem. ;)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
