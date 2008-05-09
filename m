From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git filter-branch --subdirectory-filter
Date: Fri, 09 May 2008 09:57:59 +0200
Message-ID: <48240407.4080104@viscovery.net>
References: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com>	 <20080509013300.GA7836@sigill.intra.peff.net> <e5e204700805090038k373bbabcyfb10d8c93ec5b3a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: James Sadler <freshtonic@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 09:59:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuNVM-0007Kd-RO
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 09:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbYEIH6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 03:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbYEIH6G
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 03:58:06 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:50658 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbYEIH6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 03:58:04 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JuNUO-0001Wr-7U; Fri, 09 May 2008 09:58:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 02A06546; Fri,  9 May 2008 09:57:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e5e204700805090038k373bbabcyfb10d8c93ec5b3a7@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81605>

James Sadler schrieb:
> Hi Jeff,
> 
> After reading your reponse and re-reading my original email, I
> realised it was totally unclear
> so I have re-explained myself below.
> 
> 2008/5/9 Jeff King <peff@peff.net>:
>> On Fri, May 09, 2008 at 11:01:47AM +1000, James Sadler wrote:
>>> and ran filter-branch with a --commit-filter to skip commits that were
>>> irrelevant to th subdir.
>> But that's part of what subdirectory-filter does, so this step is
>> unnecessary.
> 
> Yes that's true, but...
> 
> Clearer explanation:
> 
> I originally tried --subdirectory-filter by itself to see if it would
> do the job, but it filtered
> more commits than I thought it should (some commits that touched the subdir were
> missing after filter-branch was run).
> 
> I then began to question my understanding of the semantics of
> subdirectory-filter.
> 
> Is it meant to:
> A) Only keep commits where ALL of the changes in the commit only touch
> content under $DIR?
> B) Only keep commits where SOME of the changes in the commit touch
> content under $DIR?
> 
> I suspected that it was behaving as A.

It's expected to do B.

> That's when I decided to run the commit-filter first in combination
> with the tree-filter.  This would
> leave me with all commits that touched the subdir but any commit that
> touched multiple subdirs
> would be cleaned up so it only touched the subdir I want to keep.
> 
> At this point I have a bunch of commits that only make changes to
> subdir (verified using gitk), and I would
> expect subdirectory-filter to keep every single commit.

At this point you don't need subdirectory-filter. Use an --index-filter to
 keep only the subdirectory *and* remove the directory name at the same
time. Something like this:

git filter-branch --index-filter \
        'git ls-files -s thedir | sed "s-\tthedir/--" |
                GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
                        git update-index --index-info &&
         mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD

> However, after running it, I loose most of my commits.  Strangely, the
> working tree is bit-for-bit correct
> with the original version or the subdir in the old repo, but the
> history leading up to it is not.

The bit-for-bit correctness is not surprising, but the incorrect history
is. What is your definition of "correct" (i.e. can you give an example of
your expectations that are not met)? Do you have complicated history (with
merges)? Note that merges are removed if all but one of the merged
branches do not touch the subdirectory.

-- Hannes
