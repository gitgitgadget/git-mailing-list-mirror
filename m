From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 17:38:54 +0200
Message-ID: <46263B8E.9080500@dawes.za.net>
References: <200704171041.46176.andyparkins@gmail.com> <"200704171803.58940.a n  dyparkins"@gmail.com> <200704172012.31280.andyparkins@gmail.com> <alpine.LFD.0.98.0704171530220.4504@xanadu.home> <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz> <alpine.LFD.0.98.0704171624190.4504@xanadu.home> <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz> <alpine.LFD.0.98.0704171708360.4504@xanadu.home> <4625B99D.9090409@dawes.za.net> <alpine.LFD.0.98.0704180748460.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 17:40:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeCG8-0000ot-Vp
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 17:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbXDRPjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 11:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbXDRPjt
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 11:39:49 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:35262 "EHLO
	spunkymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753984AbXDRPjt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 11:39:49 -0400
Received: from [10.54.171.19] (vc-196-207-32-232.3g.vodacom.co.za [196.207.32.232])
	by spunkymail-a4.g.dreamhost.com (Postfix) with ESMTP id D4950131A21;
	Wed, 18 Apr 2007 08:39:42 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <alpine.LFD.0.98.0704180748460.2828@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44900>

Linus Torvalds wrote:
> 
> On Wed, 18 Apr 2007, Rogan Dawes wrote:
>> Or similarly, when checking an "ODF" file in, the attribute would lead to an
>> appropriate script creating the "tree" of individual files.
>>
>> Does this sound workable?
> 
> I think it sounds very interesting, and I'd much rather do _those_ kinds 
> of rewrites than keyword unexpansion. And yes, some kind of generic 
> support for rewriting might give people effectively the keywords they want 
> (I think the CVS semantics are not likely to be logical, but people can 
> probably do something that works for them), and at that point maybe the 
> keyword discussion goes away too.
> 
> However, I don't know if it is "workable".
> 
> The thing is, it's easy enough (although potentially _very_ expensive) to 
> run some per-file script at each commit and at each checkout. But there 
> are some fundamental operations that are even more common:
> 
>  - checking for "file changed", aka the "git status" kind of thing
> 
>    Anything we do would have to follow the same "stat" rules, at a 
>    minimum. You can *not* afford to have to check the file manually.
> 
>    So especially if you combine several pieces into one, or split one file 
>    into several pieces, your index would have to contain the entry 
>    that matches the _filesystem_ (because that's what the index is all 
>    about), but then the *tree* would contain the pieces (or the single 
>    entry that matches several filesystem entries).

Right. I would imagine that the script would have to take care of 
setting timestamps in the filesystem appropriately, as well as passing 
them back to git when queried.

e.g. expanding test.odf/: (since we store it as a directory)

git calls "odf.sh checkout test.odf/ <sha1> <perms> <stat>"

odf checkout calls back into git to find out the details of the files 
under test.odf/, and creates a zip file containing the individual files, 
with appropriate timestamps.

User then opens the file using OO.o or whatever, makes some changes and 
saves the file.

The user then runs git status:

git calls "odf.sh stat test.odf/" (again, triggered by an attribute)

odf.sh does the equivalent of "zip -l" to get up to date stat info for 
the component files, and passes it back to git (via stdout?)

User commits his changes:

git calls "odf.sh checkin test.odf/"

odf.sh unpacks the individual files, calls back into git to create 
individual objects (using a fast-import-alike protocol over stdout?)


> 
>  - what about diffs (once the stat information says something has 
>    potentially changed)? You'd have to script those too, and it really 
>    sounds like some very basic operations get a _lot_ more expensive and 
>    complex.
 >
>    This is also related to the above: one of the most fundamental diffs is 
>    the diff of the index and a tree - so if the index matches the 
>    "filesystem state" and the trees contain some "combined entry" or 
>    "split entry", you'd have to teach some very core diff functionality 
>    about that kind of mapping.
> 
> In other words, I think it's too complicated. Not necessarily impossible, 
> but likely harder and more complex than it's really worth.
> 
> Having a 1:1 file mapping (like the CRLF<->LF object mapping is) is a lot 
> easier. You just have to make sure that the index has the *stat* 
> information from the filesystem, but the *sha1* identity information from 
> the git internal format, and things automatically just fall out right. But 
> if you have anything but a 1:1 relationship, it gets hugely more complex.
> 
> 			Linus

Absolutely. I just raised it now since it was originally mentioned quite 
a long time ago as a possible feature of git, and I couldn't see how it 
might work.

Thanks for your time,

Rogan
