From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC v1] git-p4: test case for RCS keyword problem
Date: Tue, 10 May 2011 07:47:31 -0400
Message-ID: <20110510114731.GA32450@arf.padd.com>
References: <1304927397-24614-1-git-send-email-luke@diamand.org>
 <20110509230034.GC1716@arf.padd.com>
 <4DC8F3C5.7000904@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Horowitz <michael.horowitz@ieee.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue May 10 13:47:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJlPl-0003LO-DU
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 13:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457Ab1EJLrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 07:47:40 -0400
Received: from honk.padd.com ([74.3.171.149]:42473 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab1EJLrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 07:47:39 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 23DB820B7;
	Tue, 10 May 2011 04:47:38 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7BE0C31545; Tue, 10 May 2011 07:47:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4DC8F3C5.7000904@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173328>

luke@diamand.org wrote on Tue, 10 May 2011 09:13 +0100:
> Would this cause problems switching from one branch to another? If
> there's a file with $Date:$ or $Revision:$ then every time you do
> "git checkout other_branch" or even just "git stash" git would have
> to patch up all files tagged with ktext (tens of thousands in my
> case). If you didn't you'd be right back at square one.
> 
> At that point it would be easier just to submit a one-time change to
> Perforce that simply zapped every RCS keyword in every file
> (probably resulting in all kinds of pain for perforce users though).

Checkout/branch work fine, but scaling is definitely an issue.
The clean/smudge approach scales up to tens of files, but for
thousands it would be too painful without some sort of cache of
p4 fstat info.  Which maybe could be gotten at clone time.

We've been destroying RCS keywords in our legacy p4, but there
are still a handful left to satisfy other systems that look for
$Id$ or whatever.

We can forget this approach for your use case too.  Maybe it
would work for Mike, depending on scale.

> My existing patch is pretty crude - if "git apply --check" fails
> then it parses the output, finds the files causing the problem,
> checks if they're +ktext, and then zaps every RCS keyword in the
> file in the P4 shadow repo, replacing them with just $Keyword:$.
> 
> Amazingly this seems to work, since git then sees the text it is
> expecting and is happy, while untouched RCS keywords go back to
> $KW:$ which P4 is quite happy to re-expand!
> 
> I haven't tried to handle the case where the entire file is deleted.
> This is a bit harder - the file won't be opened for edit so I
> imagine you have to do some kind of 'chmod +w' :-(

Okay.  So code would do the apply normally, then if it fails,
go and try applying to a version of the file with RCS keywords
removed, and if that worked, great.  It would be nice to do this
RCS-keyword-scrubbed checking somewhere not in the p4 workspace,
since we'd have to undo it if it turned out that was not the
problem.  I.e., it would be good if this were all quite
failsafe.

What about copying the RCS keywords _in_ to the git repo just to
create a clean diff?  Maybe the same difference, but if it eases
the deleted file case?  For each file in the diff, the keyword
expansions are just read out of the corresponding p4 file.

> Another option I wondered about is to modify git apply so that it
> spots RCS keywords and ignores them? This would then mimic what p4
> itself does.

That might make sense.  Although it feels harder to me, and
less likely to generalize in a way that would be acceptable.
Something akin to fuzzy_matchlines() that can decide "$Id$" is the
same as "$Id: //depot/proj/foo.c#3 $".  Hrm.

> And another option is to just admit that RCS keywords are stupid and
> can't be sorted out properly, put some explanation into git-p4.txt
> to explain the problem to avoid having these threads pop up, and
> then everyone just has to zap them in Perforce.

Or maybe just small steps toward a solution:  check for failure,
and if the diff chunks have what look like unexpanded keywords,
print out a message guessing why the check failed?

		-- Pete
