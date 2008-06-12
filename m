From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git-fast-export bug, commits emmitted in incorrect order   causing
 parent data to be lost from commits turning essentially linear repo   into
 "islands"
Date: Thu, 12 Jun 2008 14:52:40 +0200
Message-ID: <g2r66q$d3j$1@ger.gmane.org>
References: <1213266100.6940.207.camel@gemini>	 <48510E2E.6090508@viscovery.net>  <1213272285.6940.222.camel@gemini> <1213272962.6940.231.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 14:54:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6mJM-0002dZ-A2
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 14:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760094AbYFLMw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 08:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760061AbYFLMw4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 08:52:56 -0400
Received: from main.gmane.org ([80.91.229.2]:36523 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759850AbYFLMwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 08:52:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K6mIL-0001zQ-DE
	for git@vger.kernel.org; Thu, 12 Jun 2008 12:52:50 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 12:52:49 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 12:52:49 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1213272962.6940.231.camel@gemini>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84754>

Yves Orton venit, vidit, dixit 12.06.2008 14:16:
> We want a more or less linear repo as the result. This bug with
> fast-export was the main showstopper in our efforts.  However, I can
> imagine that this is a problem that many people will want to solve. It
> would be nice if there was an easier way to do it that what we currently
> are doing (merging and munging multiple fast-export streams into a
> single fast-import process). While at this point its probably academic
> any suggestions as to the Best Way to do this would be very much
> welcome.

I've done something like this, "stitching" the history of different 
repos together in order to produce one repo, with each of the 
constituents in a subdir. What I did was an adaption of

http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html

but as a multistep version:

1. Create an empty repo
2. Add your to-be-stitched repos as remotes, say A B C
3. Create an empty commit
4. "git merge -s ours --no-commit a b c", where a b c are the root 
commits of A B C
5. "git read-tree --prefix=dir-A/ -u a" and analogously for b c
6. "git commit", use the common commit message of those commits

Note that git refuses the merge (4.) into an empty (headless) repo, 
which is why you need 3. There may be smarter ways.
If you don't care about recording the commits as (octopus) merges you 
can skip 3. and 4. (4. just records merge info in the index).

Then, repeat:
3'. remove dir-A etc. (I think I used git-rm, I'm sorry I can't recall).
4. as above (if you want to record as merge)
5. as above
6. as above

If not all of A B C appear in every step then make sure to remove only 
the ones (in 3'.) which you'll update in 5. You have to remove the dir 
because read-tree wants it like that.

I used this for stitching 5 or 6 repos with a short history together, so 
I repeated these steps manually rather than scripting it; all I needed 
was a list of SHA1s listing which commits from A B C etc. corresponded 
to the same "step" in the combined repo.

Cheers
Michael
