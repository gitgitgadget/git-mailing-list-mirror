From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Mon, 21 Jan 2013 06:28:53 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130121112853.GA31693@thyrsus.com>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com>
 <20130121093658.GD7498@serenity.lan>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 21 12:29:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxFZS-000169-2z
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 12:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab3AUL3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 06:29:24 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:36508
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab3AUL3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 06:29:24 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 3996C44130; Mon, 21 Jan 2013 06:28:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130121093658.GD7498@serenity.lan>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214110>

John Keeping <john@keeping.me.uk>:
> But this is nothing more than a sticking plaster that happens to do
> enough in this particular case

I'm beginning to think that's the best outcome we ever get in this
problem domain...

>                    - if the Git repository happened to be on
> a different branch, the start date would be wrong and too many or too
> few commits could be output.  Git doesn't detect that they commits are
> identical to some that we already have because we're explicitly telling
> it to make a new commit with the specified parent.

Then I don't understand the actual failure case.  Either that or you
don't understand the effect of -i. Have you actually experimented with
it?  The reason I suspect you don't understand the feature is that it
shouldn't make any difference to the way -i works which repository branch is
active at the time of the second import.

Here is how I model what is going on:

1. We make commits to multiple branches of a CVS repo up to some given time T.

2. We import it, ending up with a collection of git branches all of which 
   have tip commits dated T or earlier. And *every* commit dated T or earlier
   gets copied over.

3. We make more commits to the same set of branches in CVS.

4. We now run cvsps -d T on the repo. This generates an incremental
   fast-import stream describing all CVS commits *newer* than T (see
   the cvsps manual page).

5. That stream should consist of a set of disconnected branches, each
   (because of -i) beginning with a root commit containing "from
   refs/heads/foo^0" which says to parent the commit on the tip of
   branch foo, whatever that happens to be.  (I don't have to guess
   about this, I tested the feature before shipping.)

6. Now, when git fast-import interprets that stream in the context of
   the repository produced in step 2, for each branch in the
   incremental dump the branch root commit is parented on the tip
   commit of the same branch in the repo.
 
At step 6, it shouldn't matter at all which branch is active, because
where an incremental branch root gets attached has nothing to do with
which branch is active. 

It is sufficient to avoid duplicate commits that cvsps -d 0 -d T and
cvsps -d T run on the same CVS repo operate on *disjoint sets* of CVS
file commits.  I can see this technique possibly getting confused if T
falls in the middle of a changeset where the CVS timestamps for the
file commits are out of order.  But that's the same case that will
fail if we're importing at file-commit granularity, so there's no new
bug here.

Can you explain at what step my logic is incorrect?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
