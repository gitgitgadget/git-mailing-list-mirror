From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 2 Aug 2007 10:49:29 +0200
Message-ID: <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de>
References: <46AFCF3E.5010805@alum.mit.edu>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-38--568544459
Cc: git@vger.kernel.org, users@cvs2svn.tigris.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 02 10:50:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGWNv-0004OS-7B
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 10:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbXHBIuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 04:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbXHBIuI
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 04:50:08 -0400
Received: from mailer.zib.de ([130.73.108.11]:46750 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbXHBIuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 04:50:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l728matr027834;
	Thu, 2 Aug 2007 10:49:42 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l728mZ8k018260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 2 Aug 2007 10:48:36 +0200 (MEST)
In-Reply-To: <46AFCF3E.5010805@alum.mit.edu>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54524>


--Apple-Mail-38--568544459
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Michael,

On Aug 1, 2007, at 2:09 AM, Michael Haggerty wrote:

> I am looking forward to your feedback.  Even better would be if  
> somebody
> wants to join forces on this project.  I would be happy to supply the
> cvs2svn knowledge if you can bring the git experience.

I tried it with revision trunk@3930 of cvs2svn. The results are as  
follows.

some WARNING: problem encoding log message: [...]

cvs2svn Statistics:
------------------
Total CVS Files:              9578
Total CVS Revisions:         66771
Total CVS Branches:         229121
Total CVS Tags:             371259
Total Unique Tags:             112
Total Unique Branches:          79
CVS Repos Size in KB:       210390
Total SVN Commits:           18178
First Revision Date:    Fri Jul 23 10:26:11 1999
Last Revision Date:     Thu Jul 19 17:50:40 2007
------------------
Timings (seconds):
------------------
3295   pass1    CollectRevsPass
    0   pass2    CollateSymbolsPass
3642   pass3    FilterSymbolsPass
    0   pass4    SortRevisionSummaryPass
    1   pass5    SortSymbolSummaryPass
  109   pass6    InitializeChangesetsPass
   56   pass7    BreakRevisionChangesetCyclesPass
   66   pass8    RevisionTopologicalSortPass
   54   pass9    BreakSymbolChangesetCyclesPass
   99   pass10   BreakAllChangesetCyclesPass
   92   pass11   TopologicalSortPass
   46   pass12   CreateRevsPass
    7   pass13   SortSymbolsPass
    2   pass14   IndexSymbolsPass
   70   pass15   OutputPass
7540   total


I checked that CVS head and two other branches match when checked
out from CVS and from the imported git archive. Everything is ok
(ignoring some differences introduced by keyword expansion).
Note, I tried earlier to use cvs2svn to import to svn followed by
git-svnimport to import to git. The repository resulting from
this two step import not even passed this minimal requirement of
matching checkouts from cvs and git.

cvs2svn created a lot of branches that are not present in CVS,
with names identical to CVS tags. Apparently these branches are
used to create a commit matching a certain CVS tag.

I checked one suspicious commit that indicates to me if the root
points of branches are right. Note, git-cvsimport fails this check;
parsecvs and cvs2svn pass the check.

The branching structure looks, ... hmm ..., interesting. cvs2svn
manufactured commits to get the branching points right.
Apparently our CVS has some weired commits like 'unlabeled-1.1.1'
and two other named tags (maybe vendor branches?) that cause
these manufactured commits. In gitk I see long lines running
parallel to the cvs trunk all down to these weired CVS tags. They
are not very useful, altough they might be correct. Note,
parsecvs imports our repository without such basically useless
links.  However, I can't verify if parsecvs gets something wrong.
Other branches are created over a couple of commits mixing in
several branches (maybe again our weired commits already
mentioned). See branching1.png, branching2.png, branching3.png.
[ I have to apologize, our cvs repository contains proprietary
   information, so I can't publish it's history freely. ]

cvs2svn is the first tool besided parsecvs that worked for me,
that is imported the whole repository, passed the basic test of
matching checkouts from cvs and git, and got the one suspicious
commit right that I'm using for verifying the branching points.

[ I have no time to go into the details of all these tests.
   Therefore only a very short summary:
   All tools needed basic cleanup of a few corrupted ,v files and
      ,v files that were duplicated in Attic.
   git-cvsimport fails to create branches at the right commit.
   fromcvs's togit surrendered during the import.
   fromcvs's tohg accepted more of the history, but finally
     surrendered as well.
   parsecvs works for me (crashes on corrupted ,v files).
   cvs2svn followed by git-svnimport create wrong state at the
     tips of branches.
   cvs2svn direct git import works for me (reports corrupted ,v files).
   ]

Right now, I'd prefer the import by parsecvs because of the
simpler history. However, I don't know if I loose history
information by doing so. I'd start by a run of cvs2svn to validate
the overall structure of the CVS repository. Dealing with corruption
in the CVS repository seems to be superior in cvs2svn. It reports
errors when parsecvs just crashes.


	Steffen



--Apple-Mail-38--568544459
Content-Type: multipart/appledouble;
	boundary=Apple-Mail-39--568544459
Content-Disposition: inline


--Apple-Mail-39--568544459
Content-Transfer-Encoding: base64
Content-Type: application/applefile;
	name=branching1.png
Content-Disposition: inline;
	filename=branching1.png

AAUWBwACAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAJAAAAMgAAAAoAAAADAAAAPAAAAA4AAAAAAAAA
ABAAYnJhbmNoaW5nMS5wbmc=

--Apple-Mail-39--568544459
Content-Transfer-Encoding: base64
Content-Id: <E6E19432-17D8-45D6-88A2-364028120EE3@local>
Content-Type: image/png;
	x-mac-type=0;
	x-unix-mode=0644;
	x-mac-creator=0;
	name=branching1.png
Content-Disposition: inline;
	filename=branching1.png

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
7YT+XPwPA+TGLFF94UUAAAAASUVORK5CYII=

--Apple-Mail-39--568544459--

--Apple-Mail-38--568544459
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



--Apple-Mail-38--568544459
Content-Type: multipart/appledouble;
	boundary=Apple-Mail-40--568544458
Content-Disposition: inline


--Apple-Mail-40--568544458
Content-Transfer-Encoding: base64
Content-Type: application/applefile;
	name=branching2.png
Content-Disposition: inline;
	filename=branching2.png

AAUWBwACAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAJAAAAMgAAAAoAAAADAAAAPAAAAA4AAAAAAAAA
ABAAYnJhbmNoaW5nMi5wbmc=

--Apple-Mail-40--568544458
Content-Transfer-Encoding: base64
Content-Id: <36B71E82-A0DD-4E61-B140-9A51C0BA0FA5@local>
Content-Type: image/png;
	x-mac-type=0;
	x-unix-mode=0644;
	x-mac-creator=0;
	name=branching2.png
Content-Disposition: inline;
	filename=branching2.png

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

--Apple-Mail-40--568544458--

--Apple-Mail-38--568544459
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



--Apple-Mail-38--568544459
Content-Type: multipart/appledouble;
	boundary=Apple-Mail-41--568544458
Content-Disposition: inline


--Apple-Mail-41--568544458
Content-Transfer-Encoding: base64
Content-Type: application/applefile;
	name=branching3.png
Content-Disposition: inline;
	filename=branching3.png

AAUWBwACAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAJAAAAMgAAAAoAAAADAAAAPAAAAA4AAAAAAAAA
ABAAYnJhbmNoaW5nMy5wbmc=

--Apple-Mail-41--568544458
Content-Transfer-Encoding: base64
Content-Id: <3E8A4DE1-C9CD-4A68-8B45-4EF673F09E6F@local>
Content-Type: image/png;
	x-mac-type=0;
	x-unix-mode=0644;
	x-mac-creator=0;
	name=branching3.png
Content-Disposition: inline;
	filename=branching3.png

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
PbwAAAAASUVORK5CYII=

--Apple-Mail-41--568544458--

--Apple-Mail-38--568544459
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed






--Apple-Mail-38--568544459--
