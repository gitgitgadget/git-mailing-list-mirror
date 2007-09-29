From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sat, 29 Sep 2007 23:48:25 +0200
Message-ID: <E5C688F2-4A8D-402A-9757-5007BE4A8B25@zib.de>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 23:47:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibk9R-000809-9P
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 23:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbXI2Vqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 17:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbXI2Vqz
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 17:46:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:55693 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520AbXI2Vqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 17:46:55 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8TLkocQ002886;
	Sat, 29 Sep 2007 23:46:50 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db10149.pool.einsundeins.de [77.177.1.73])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8TLkmEX029683
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 29 Sep 2007 23:46:49 +0200 (MEST)
In-Reply-To: <20070929000056.GZ3099@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59493>


On Sep 29, 2007, at 2:00 AM, Shawn O. Pearce wrote:

>>   * There's a ton of extraneous output from git-fetch. I would  
>> love to
>>     see it reduced to a single-line progress bar, (even if a
>>     multiple-staged progress bar). I'm imagining a final line
>>     something like:
>>
>> 	Computing (100%) Transferring (100%)
>>
>>     But you can imagine more accurate words than those, (I'm not even
>>     sure what all of the things mean that git-fetch is currently
>>     reporting progress on).
>
> Yea.  About half of that output is from pack-objects and either
> unpack-objects or index-pack.  The other part is from git-fetch
> itself as it updates the local tracking branches (if any are to be
> updated).  Now that git-fetch is in C and reasonably stable maybe
> I can look into making this prettier.  Few people really grok the
> pack-objects/index-pack output, nor do they care.  They just want
> to know two things:
>
>   - Is git working or frozen in limbo?
>   - Is git frozen because my network sucks, or git sucks?
>   - When will this be done?  Please $DIETY, I want to go home!
>     Make the fetch finish!
>
> The C based git-fetch made the http protocol almost totally silent.
> (No more got/walk messages.)  But that's actually also bad as it
> now doesn't even let you know its transferring anything at all.
>
> There are serious issues here about getting the user the progress
> they really want.  The last item ("When will this be done?") is
> actually not possible to determine under either the native git
> protocol or HTTP/FTP.  We have no idea up front how much data must
> be transferred.  In the native git case we do know how many objects,
> but we don't know how many bytes that will be.  It could be under
> a kilobyte in one project.  That same object count for a different
> set of objects fetch could be 500M.  Radically different transfer
> times would be required.

Often you know that you have a good connection and you are not
interested in any progress reporting at all. _No_ output would be
perfect. A return code of 0 would already tell you all you need
to know. If you'd like to know more you could pass something like
'--verbose' or '--progress'.

Quite often git prints a lot of very technical information that
is not very interesting as long as things succeed without error.
Some examples are
- git fetch (see above)
- git rebase: prints a lot of details that I'm not interested in
   unless the rebase fails.
- git push: prints updates of remote heads. A message about
   failing to update a remote head may get lost.
- git merge: the fact that a merge is a fast forward merge gets
   printed at the very top, followed by (often a lot of) diffstat.
   I know diffstat can help to judge if the merge did what you
   expected. But even more important is the fact that the merge
   was just a fast forward, which may get buried under lots of output.

Maybe git should become more quiet, as other unix tools are, and
per default only report problems. Technical details and progress
could be requested explicitly by '--verbose' or similar. We could
pipe all the technical output to a per-repository logfile, which
can be consulted in case of errors. The log could be cropped
during 'git gc'.


	Steffen
