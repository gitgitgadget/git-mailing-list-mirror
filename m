From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 08:55:03 +0200
Organization: At home
Message-ID: <e0827k$7tk$1@sea.gmane.org>
References: <20060326014946.GB18185@pasky.or.cz> <7virq1sywj.fsf@assigned-by-dhcp.cox.net> <e06fl8$p9f$1@sea.gmane.org> <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org> <e06hts$1ne$1@sea.gmane.org> <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Mar 27 08:55:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNld3-0002SJ-Tp
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 08:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWC0Gyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 01:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWC0Gyz
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 01:54:55 -0500
Received: from main.gmane.org ([80.91.229.2]:45468 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750753AbWC0Gyz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 01:54:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FNlcr-0002Qd-BU
	for git@vger.kernel.org; Mon, 27 Mar 2006 08:54:53 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Mar 2006 08:54:53 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Mar 2006 08:54:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18074>

Linus Torvalds wrote:

> On Sun, 26 Mar 2006, Jakub Narebski wrote:
>> 
>> If (2) is common enough then discussed improvements to rename detection,
>> namely comparing basenames as a base for candidate selection is a good
>> idea.
> 
> BK had this "renametool" which got started automatically when you applied
> a patch that removed one or more files and added one or more files, so
> that you could then pair up the files manually.
[...]
> The thing is, the fast rename detection that is in the "next" branch
> really does a lot better, and it's fast enough.

I was thinking about the fast ename detection algorithm in "next" branch.


That is the question if recording additional (helper) information about
contents copying and moving like the mentioned "renametool" did is worth
the effort, both in coding it and from user's point of view. Or would
better contents copying and moving detection ("renames detection") for
whatchanged and similar suffice.

I am of opinion that voluntary information about contents moving and copying
in the commits would help.

Purposes:
1.) Record contents moving and similarity information which cannot or cannot
be easily calculated; see Paul Jakma response in this thread
  MessageID: <Pine.LNX.4.64.0603270642090.5276@sheen.jakma.org>
for example copying fragment of code, small fragment of the whole file,
creating documentation or header file from code, or code skeleton from
template, or rewrite of code in different language (e.g. shell script to
perl, script to compiled code e.g. Perl or Python to C).
2.) Caching the results of similarity algorithm/rename detection tool (also
Paul Jakma post), including remembering false positives and undetected
renames, for efficiency. Calculated automatically parts might be
throw-away.

Sources of information:
1.) Manually entered information *at commit*, including *-rm, *-mv, *-cp
like commands (which nobody likes) and systematized (pseudolanguage?) for
copying and moving contents in the log messages.
2.) Semi-manual tools like the mentioned "renametool" of BK.
3.) Support from editor (remebering where copied and pasted, or cut and
pasted fragment came from, and providing prefilled command to record
contents moving ("renames") or prefilled commit log containing this
information. Hard to get, probably most useful.
4.) Information from resolved merges and results of diagnosis (pickaxe like)
tools, especially recording "renames" which were not detected, and removing
"renames" which were detected falsily.  

Is that the place where I should provide code (patch) for testing the
idea :) ?

>> I wonder how common is (2) compared to (1)+(2) i.e. move to other dir
>> and rename, old-dir/old-file.c to new-dir/new-subdir/new-file.c
>
> For example, one common case was a directory structure like
> 
> ..
> type-file1.c
> type-file2.c
> otherfiles.c
> yet-more.c
> ..
> 
> being split up into a subdirectory
> 
> ..
> type/file1.c
> type/file2.c
> otherfiles.c
> yet-more.c
> ..
> 
> (eg drivers/scsi/aic7xx-* being given a subdirectory of it's own, as
> drivers/scsi/aic7xx/*). So the basename wouldn't stay the same, because it
> contained some piece of data that became redundant with the move.

Perhaps fast rename detection algorithm needs some smart similarity estimate
for names, which would put more weight in the parts closer to basename, and
would detect */type-file1.c and */type/file1.c as similar.

-- 
Jakub Narebski
Warsaw, Poland
