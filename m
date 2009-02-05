From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Bram Cohen speaks up about patience diff
Date: Thu, 5 Feb 2009 21:19:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902052113590.7491@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 21:21:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVAj0-0005j3-0O
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbZBEUT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbZBEUT5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:19:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:43731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753744AbZBEUT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:19:57 -0500
Received: (qmail invoked by alias); 05 Feb 2009 20:19:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp027) with SMTP; 05 Feb 2009 21:19:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+GqGR5Bv+GiIqRZl5WraEv1Vu8VxbaewtKDytqGM
	0tOfne9xVB57WZ
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108605>

Hi,

Bram sent me two mails explaining a bit more of the details behind 
patience diff, and invited me to forward the content.  So here you are:

-- snipsnap --
From: Bram Cohen <spam-protected-as-per-brams-request@spam.la>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sent: Wednesday, February 4, 2009 3:52:54 PM
Subject: patience diff advantages/disadvantages

Hey Johannes, I just did some web searching for patience search and came 
across the recent discussion of it. I'm not on whatever mailing list that 
discussion was on, but I have some thoughts on it which you might wish to 
share.

The reverse engineered intuition that non-unique lines are 'less 
important' than unique lines is a correct one, and specifically the case 
of lots of curly bracket lines in C and END lines in Pascal and similar 
cases are the main motivating factor.

For most common cases, any reasonable diff algorithm will give the same 
result. The cases where the results are quite dramatic are ones where the 
amount of change between the two versions is very large. The test cases 
being tried in recent discussion are from developers familiar with version 
control, who are being very judicious in their development process and 
intentionally trying to keep things from diverging too badly. In those 
cases, outputs will generally speaking always be the same and where they 
aren't the differences are frequently a judgement call.

The really bad cases are ones where two versions have diverged 
dramatically and the developer isn't being careful to keep patch sizes 
under control. Under those circumstances a diff algorithm can occasionally 
become 'misaligned' in that it matches long sections of curly brackets 
together, but it winds up correlating the curly brackets of functions in 
one version with the curly brackets of the next later function in the 
other version. This situation is *very ugly*, and can result in a totally 
unusable conflict file in the situation where you need such things to be 
presented coherently the most. I have in fact seen it happen (in fact, 
it's happened to me). I don't have a sample of it, but as you can imagine 
such a sample case must by its nature be rather large and uninsightful - 
it basically just looks ugly.

So 'unique lines' is a simple cross-language proxy for 'unimportant 
lines'. 'short lines' of course also can work, but might give false 
positives and it depends what you mean by 'short'. There's also an 
implementation and code maintainability advantage to unique lines. The 
patience algorithm is far simpler to understand and implement than the 
fancy-shmancy recent LCS algorithms. While patience sorting is far from 
obvious, LCS algorithms with good asymptotics are extremely opaque. I 
suspect that a properly implemented patience diff could be just as fast if 
not faster than LCS, but that would require quite a bit more algorithmic 
magic than I for one am prepared to design, test and debug. In very real 
terms the amount of time effort, and trickery the different 
implementations have had put into them is very different, so current speed 
differences aren't exactly a fair comparison (although far from 
irrelevant, because nobody with the necessary expertise is volunteering to 
spend that much time on patience diff as of yet).

Some other things I forgot to mention - it isn't clear from the discussion 
whether you're doing the heuristic of matching beginning/ending lines when 
everything else doesn't match (this heuristic could also be applied first, 
which would be faster and almost always yield the same results). That's 
important so that long sections of white space get matched to each other. 
Also, I disagree that LCS is necessarily a good idea when matching, say 
12121 to 212. What was meant by that case is highly ambiguous, and the 
most conservative thing is to simply give a conflict for the whole 
section. (If matching, say, 12121 to 1212 then the first lines match 
heuristic will make them mostly match with an extra 1 at the end of the 
first one).

The most difficult real-world diff cases have to do with lots of blank 
lines, if we represent a blank line by 'S', then the diff from 'SSSSS' to 
'SSSXSSS' is highly ambiguous - an extra S was added, but there are four 
reasonable places for assuming it was put in, each of which a reasonable 
case can be made for, and I suspect that there's an analogue to Arrow's 
theorem that trying to do the right thing in particular edge cases must 
necessarily result in intermediary cases where the criteria are in direct 
conflict. (My patience implementation, by the way, will match the first 
three lines of the five Ss to the the first three of the second set of Ss, 
and the last two to the last two, with the string XS inserted into the 
middle, which is arguably the best behavior, but could under some 
circumstances result in very confused three-way merges dependending on 
what happened on the other side).
