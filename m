From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 16:11:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>  <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de> <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 16:11:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynX1-0001FS-Da
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759523AbZJPOJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 10:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759430AbZJPOJG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:09:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:45356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759378AbZJPOJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:09:05 -0400
Received: (qmail invoked by alias); 16 Oct 2009 14:08:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 16 Oct 2009 16:08:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lmA8FJPNlvLozkfdmlR+udgcvFLHAiLWzduFkRc
	PZwzM8AQ6xJapK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130487>

Hi,

On Fri, 16 Oct 2009, jamesmikedupont@googlemail.com wrote:

> On Fri, Oct 16, 2009 at 1:26 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> Here is the discussion on foundation-l :
> >> http://www.gossamer-threads.com/lists/wiki/foundation/181163
> >
> > I found the link to the bazaar repository there, but do you have a Git
> > repository, too?
> 
> Not yet. Where should I put it?  Any suggestions.

github.com has a nice interface.

BTW after reading some of the code, I am a bit surprised that you did not 
do it as a .php script outputting fast-import capable text...

> >> the question is, is there a blame tool that we can use for multiple 
> >> horizontal diffs on the same line that will be needed for wikipedia 
> >> articles?
> >
> > I am not quite sure what you want to do horizontally there... Can you
> > explain what you want to see?
> 
> Yes, I would like to see all the contributors to each word or line.
> 
> Basically one line of blame per contributor, so many lines of output.
> Ideally we would have something that is usable in a html display. Lets
> say, just an blame attribute for each word. so on one line :
> 
> This is a line with two changes first change Second change  end of line
> 
> It would look like this in html :
> This is a line with two changes <span blame=revisionid>first
> change</span><span blame=revisionid>Second change</span> end of line
> 
> The blame edit could look like this :
> REVISION ID 1    48     :  This is a line with two changes first
> change first change \
> REVISTION ID 2  48 C:   Second change end of line

Okay, so basically you want to analyze the text on a word-by-word basis 
rather than line-by-line.

Or maybe even better: you want to analyze the text character-by-character.  
That would also nicely circumvent to specify just what makes a word a word 
(subject for a lot of heated discussion during the design of the 
--color-words=<regex> patch).

Basically, if I had to implement that, I would not try to modify 
builtin-blame.c, but write a new program linking to libgit.a, calling the 
revision walker on the file you want to calculate the blame for.  (One of 
the best examples is probably in builtin-shortlog.c.)

Then I would introduce a linked-list structure which will hold the blamed 
regions in this form:

	struct region {
		int start;
		struct region *next;
	};

Initially, this would have a start element with the start offset 0 
pointing to the end element with start offset being set to the size of the 
blob.

Most likely you will have to add members to this struct, such as the 
original offsets (as you will have to adjust the offsets to the different 
file revisions while you go back in time), and the commit it was 
attributed to.

Then I would make modified "texts" from the blob of the file in the 
current revision and its parent revision, by inserting newlines after 
every single byte (probably replacing the original newlines by other 
values, such as \x01).

The reason for this touchup is that the diff machinery in Git only handles 
line-based diffs.

Then you can parse the hunk headers, adjust the offsets accordingly, and 
attribute the +++ regions to the current commit (by construction, the 
offsets are equal to the line number in the hunk header).  Here it is most 
likely necessary to split the regions.

You should also have a counter how many regions are still unattributed so 
you can stop early.

Ciao,
Dscho
