From: Adam Heath <doogie@brainfood.com>
Subject: Re: large(25G) repository in git
Date: Thu, 26 Mar 2009 11:35:17 -0500
Message-ID: <49CBAEC5.6070606@brainfood.com>
References: <49C7FAB3.7080301@brainfood.com> <49CBA2AB.30304@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 17:37:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmsZk-0003TU-6R
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 17:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbZCZQf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 12:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756677AbZCZQfZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 12:35:25 -0400
Received: from newmail.brainfood.com ([70.103.162.5]:57502 "EHLO
	newmail.brainfood.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176AbZCZQfY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 12:35:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by newmail.brainfood.com (Postfix) with ESMTP id 14E8CF885E;
	Thu, 26 Mar 2009 11:35:23 -0500 (CDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 0.101
X-Spam-Level: 
X-Spam-Status: No, score=0.101 tagged_above=-10 required=6.6
	tests=[BAYES_50=0.001, RDNS_DYNAMIC=0.1]
Received: from newmail.brainfood.com ([127.0.0.1])
	by localhost (newmail.brainfood.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5b4k06egft1y; Thu, 26 Mar 2009 11:35:18 -0500 (CDT)
Received: from [192.168.2.49] (70-103-162-249.brainfood.com [70.103.162.249])
	by newmail.brainfood.com (Postfix) with ESMTP id 3104FF8847;
	Thu, 26 Mar 2009 11:35:18 -0500 (CDT)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <49CBA2AB.30304@oak.homeunix.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114797>

Marcel M. Cary wrote:
> My company manages code in a similar way, except we avoid this kind of
> issue (with 100 gigabytes of user-uploaded images and other data) by not
> checking in the data.  We even went so far is as to halve the size of
> our repository by removing 2GB of non-user-supplied images -- rounded
> corners, background gradients, logos, etc, etc.  This made Git
> noticeably faster.

Disk space is cheap.

> While I'd love to be able to handle your kind of use case and data size
> with Git in that way, it's a little beyond the intended usage to handle
> hundreds of gigabytes of binary data, I think.
> 
> I imagine as your web site grows, which I'm assuming is your goal, your
> problems with scaling Git will continue to be a challenge.
> 
> Maybe you can find a way to:
> 
> * Get along with less data in your non-production environments; we're
> hoping to be able to do this eventually

We do that by only cloning/checking out certain modules.

However, as is always the case, sometimes a bug occurs with production
data, and you need to use the real data to track it down.

> * Find other ways to copy it; we use rsync even though it does take
> forever to crawl over the file system
> 
> * Put your data files in a separate Git repository, at least, assuming
> your checkin, update, and release code more often than your video files.
>  That way you'll experience pain less often, and maybe even be able to
> tune your repository differently.

As already mentioned, our sub-sites *are* in separate repos.  There's
a base repository, that has just the event/backend code.  Then 32
*other* repositories, where the actual websites are.

We want to use *some* kind of versioning system.  Being able to have
history of *all* changes is extremely useful.  Not to mention being
able to track what each separate user does as they modify their files
thru their browser.

subversion is just right out.  It's centralized.  It leaves poop all
over the place.

mercurial is just right out.  If you do several *separate* commits of
*separate* files, but don't push for some time period, then eventually
do a push/pull, where the sum total of the changes is larger than some
value, mercurial will fail when it tries to then update the local
directory.  This limit is based on 2G, a hard-coded python limit(even
on a 64-bit host), because mercurial reads the entire set of changes
into a python string.

git mmaps files, does window scanning of the pack files.  It *might*
read a single file all into memory, for compression purposes; I'm not
certain on this.  We certainly haven't hit any limits that cause it to
fail outright.

I haven't tried any others.
