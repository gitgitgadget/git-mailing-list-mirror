From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: On Tabs and Spaces
Date: Sat, 20 Oct 2007 15:54:16 +0200
Message-ID: <200710201554.16576.robin.rosenberg.lists@dewire.com>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IigGH4ieKe3PzGc"
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@mit.edu>
X-From: git-owner@vger.kernel.org Sat Oct 20 15:52:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjEkc-0007Oa-8y
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 15:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763502AbXJTNvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 09:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763212AbXJTNvm
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 09:51:42 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14941 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1761723AbXJTNvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 09:51:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1E93D802E1B;
	Sat, 20 Oct 2007 15:43:00 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18755-05; Sat, 20 Oct 2007 15:42:59 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 874AD80266F;
	Sat, 20 Oct 2007 15:42:59 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61834>

--Boundary-00=_IigGH4ieKe3PzGc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

tisdag 16 oktober 2007 skrev Michael Witten:
> What are the rules about tabs and spaces in source code?
> 
> I'm having a terrible time with formatting,
> especially in the perl scripts; there is a
> mix of spaces and tabs.
> 
> from what I can deduce, single tabs are used
> to introduce the equivalent of 8 spaces while
> 4 explicit spaces are used for half a tab.

A looong time ago I worked with a system that did not have *this* problem. 
The code had a straight left margin. No indent. The code was initially written 
just after the origin of time_t (content, not name) and that it was written 
on punched cards probably explains the left margin, efter all you can indent 
the cards if you like to.

I "accidentally" did indent code once, but only once, since I got a lot of 
complains from others about not following coding standards. My solution was 
to write a Brief macro to indent the code before working on it and undent 
before submitting my work to test. We never had a discussion on tabs vs 
spaces.

Btw, some of that code was "logically" indented 22 levels. I'm still amazed 
att those long sheets of code people annotated with pencil to discover the 
logical structure.

So it is possble to simply not care about tabs and spaces, except where
there is a syntactic difference.

Fast-formward twenty years and back to the topic.

I think it is ok to start or end a *big* series of changes with a re-format 
patch, iff the series already introduces a *lot* of changes. 

In the previously submitted and rejected patch to cvsexportcommit this
was not the case, I rewrote it heavily and that would have been a window
for for reformatting, but I didn't see a need, probably because I used emacs
and probably the original author too. Now I realize the file *is* actually 
indented inconsistently. Add to that that I am responsible for some of it. 
Next person to do any major work on it should submit a fix-indentation patch  
very much like the one MIchael did. The problem with reviewing such patches
still exists, it is not possible to just read such patches, one has to apply 
them and verify them with other tools.

I've been through enough many bracket and indentation discussions to see that 
it really doesn't matter as much what style is used as long as the same style 
is used throughout a whole source file. There are some coding styles that 
works bad with the patch/apply style  submitting code, but those are not an 
issue here.

As for TAB size. The most authoritative read "stupid") programs on the issue, 
i.e. cat (unix) and type (dos/windows) agree that tab stops are located at 
every eight position starting (8,16 etc).

Attached is an updated version of a script I've been using lately to clean up 
commits. First it only removed trailing whitespace, but after this thread I 
changed it to (try to) tabify changes. Should we use such scripts more 
actively to root out inconsistencies a patch at a time?

-- robin

--Boundary-00=_IigGH4ieKe3PzGc
Content-Type: application/x-shellscript;
  name="washammend"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="washammend"

#!/bin/bash -e
#
# Rewrite the last commit to remove any trailing whitespace
# in the new version of changed lines.
# Then replace space-based indentation with TAB based indentation
# based on TABS at every eight position
#
[[ -z $TRACE ]] || set -x
trap "rm -f $tmpf" 0
tmpf1=$TMP/$$.1.diff
tmpf2=$TMP/$$.2.diff
git show --binary >$tmpf1
perl -p -e 's/^(\+.*?)[ \t]+$/$1/; while(m/^(\+\t*)( {1,7}\t| {8})(.*)/) { $_=$1."\t".$3."\n"; }' <$tmpf1 >$tmpf2
if ! cmp -s $tmpf1 $tmpf2
then
	git apply --binary --index -R --whitespace=nowarn $tmpf1
	git apply --binary --index $tmpf2
	EDITOR=true git commit --amend
else
	echo "No changes"
fi

--Boundary-00=_IigGH4ieKe3PzGc
Content-Type: application/x-shellscript;
  name="washtrailing"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="washtrailing"

#!/bin/bash -e
#
# Rewrite the last commit to remove any trailing whitespace
# in the new version of changed lines.
#
#
[[ -z $TRACE ]] || set -x
trap "rm -f $tmpf" 0
tmpf1=$TMP/$$.1.diff
tmpf2=$TMP/$$.2.diff
git show --binary >$tmpf1
perl -p -e 's/^(\+.*?)[ \t]+$/$1/;' <$tmpf1 >$tmpf2
if ! cmp -s $tmpf1 $tmpf2
then
	git apply --binary --index -R --whitespace=nowarn $tmpf1
#	git apply --index --whitespace=error $tmpf2
	git apply --binary --index --whitespace=strip $tmpf1
	EDITOR=true git commit --amend
else
	echo "No changes"
fi

--Boundary-00=_IigGH4ieKe3PzGc--
