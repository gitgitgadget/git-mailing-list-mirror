From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: [spf:guess,iffy] [PATCH] git-svn: teach git-svn to populate
 svn:mergeinfo
Date: Fri, 2 Sep 2011 14:49:22 -0400
Organization: White Oak Technologies
Message-ID: <20110902144922.383ed0f1@robyn.woti.com>
References: <20110902140702.066a4668@robyn.woti.com>
	<4E612319.7030006@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 20:49:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzYo1-0005Ue-N2
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 20:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab1IBSt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 14:49:28 -0400
Received: from mail02.woti.us ([66.92.158.6]:55349 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754314Ab1IBSt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 14:49:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 770B3504D37F0;
	Fri,  2 Sep 2011 14:49:25 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zco8bQMGNukK; Fri,  2 Sep 2011 14:49:23 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 6D677504D37EA;
	Fri,  2 Sep 2011 14:49:23 -0400 (EDT)
In-Reply-To: <4E612319.7030006@vilain.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180631>

On Fri, 02 Sep 2011 11:40:25 -0700
Sam Vilain <sam@vilain.net> wrote:

> On 9/2/11 11:07 AM, Bryan Jacobs wrote:
> > For this particular case, it works well: svn:mergeinfo is populated
> > in such a way that the local merge history is recreated when
> > another git-svn user pulls down the repository. This patch thus
> > allows to git users to exchange branching and merging development
> > through a central SVN server without loss of fidelity and without
> > explicitly manipulating the mergeinfo property by hand.
> 
> Whee!  That's what I was intending when I wrote the original change.
> I might have written it myself back in 2008 or whenever it was, but I 
> found I didn't actually have any SVN projects I was sending commits
> to, let alone merges.  git-svn is a project with a continually
> atrophying userbase :-).  Thanks for picking it up.
> 

Glad to hear it. I think there's still work to be done, mostly because
I'm not very familiar with the git codebase and the "right" way to do
things, but I want this to work.

> > r1 --- r3 -- r4
> >   \
> >    r2 --- E
> >
> > F is lost and cannot be cherry-picked back onto the WC, as any
> > files created in E are already present but untracked locally.
> 
> Are r1 and r2 supposed to be on the same SVN branch?

No, different SVN branches.

> 
> Overall, I could believe that.  Perhaps it is simpler to detect those 
> situations in advance and insist the user dcommits them
> independently, although it appears to me that it would apply to any
> dcommit which failed for any reason part way through.  So perhaps
> there is a wider justification for fixing that.

I could do a pass through all the commits which are about to be sent
out to SVN to check if this is going to happen, yes. But I think a
better solution would be to change how the changes are replayed by
git-svn dcommit: right now, all changes are applied to the WC, then it
sequentially does an add+dcommit for each patch? Right? I think it might
be better to reset --hard to the parent, then pick each change into the
WC+index before committing. That way if you abort early, cleaning up
just consists of rebasing the stack onto the last change you sent
upstream.

If I get around to making git-svn put its stuff into notes, this would
be a lot easier since you could just reset --hard back to the original
HEAD, since none of the earlier commits would have been mangled. But of
course everyone who already imported a repo would be SOL if the new
version relied on that Hippocratic behavior...

> Sam
