From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 12:46:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201231570.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
 <200610202047.11291.jnareb@gmail.com> <Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
 <45391F1C.80100@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 21:47:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb0Kn-0007yy-K9
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 21:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992722AbWJTTrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992727AbWJTTrJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 15:47:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992722AbWJTTrI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 15:47:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KJkiaX002636
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 12:46:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KJke1H032076;
	Fri, 20 Oct 2006 12:46:41 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45391F1C.80100@utoronto.ca>
X-Spam-Status: No, hits=-0.976 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29530>



On Fri, 20 Oct 2006, Aaron Bentley wrote:
> 
> Linus Torvalds wrote:
> > Git goes one step further: it _really_ doesn't matter about how you got to 
> > a certain state. Absolutely _none_ of what the commits in between the 
> > final stages and the common ancestor matter in the least. The only thing 
> > that matters is what the states at the end-point are.
> 
> That's interesting, because I've always thought one of the strengths of
> file-ids was that you only had to worry about end-points, not how you
> got there.
> 
> How do you handle renames without looking at the history?

You first handle all the non-renames that just merge on their own. That 
takes care of 99.99% of the stuff (and I'm not exaggerating: in the 
kernel, you have ~21000 files, and most merges don't have a single rename 
to worry about - and even when you do have them, they tend to be in the 
"you can count them on one hand" kind of situation).

Then you just look at all the pathnames you _couldn't_ resolve, and that's 
usually cut down the thing to something where you can literally use a lot 
of CPU power per file, because now you only have a small number of 
candidates left.

If you were to use one hundredth of a second per file regardless of file, 
a stupid per-file merge would take 210 seconds, which is just 
unacceptable. So you really don't want to do that. You want to merge whole 
subdirectories in one go (and with git, you can: since the SHA1 of a 
directory defines _all_ of the contents under it, if the two branches you 
merge have an identical subdirectory, you don't need to do anything at 
_all_ about that one. See?).

So instead of trying to be really fast on individual files and doing them 
one at a time, git makes individual files basically totally free (you 
literally often don't need to look at them AT ALL). And then for the few 
files you can't resolve, you can afford to spend more time.

So say that you spend one second per file-pair because you do complex 
heuristics etc - you'll still have a merge that is a _lot_ faster than 
your 210-second one.

So recursive basically generates the matrix of similarity for the 
new/deleted files, and tries to match them up, and there you have your 
renames - without ever looking at the history of how you ended up where 
you are.

Btw, that "210 second" merge is not at all unlikely. Some of the SCM's 
seem to scale much worse than that to big archives, and I've heard people 
talk about merges that took 20 minutes or more. In contrast, git doing a 
merge in ~2-3 seconds for the kernel is _normal_.

[ In fact, I just re-tested doing my last kernel merge: it took 0.970 
  seconds, and that was _including_ the diffstat of the result - not 
  obviously not including the time to fetch the other branch over the 
  network.

  I don't know if people appreciate how good it is to do a merge of two 
  21000-file branches in less than a second. It didn't have any renames, 
  and it only had a single well-defined common parent, but not only is 
  that the common case, being that fast for the simple case is what 
  _allows_ you to do well on the complex cases too, because it's what gets 
  rid of all the files you should _not_ worry about ]

Performance does matter. 

			Linus
