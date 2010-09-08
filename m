From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Why does git-svn redownload revisions?
Date: Wed, 8 Sep 2010 13:19:16 -0400
Message-ID: <B1E94440-DDCA-4C10-A0EE-E08A66DF3D7E@silverinsanity.com>
References: <loom.20100908T181056-819@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Daniel Trebbien <dtrebbien@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 19:19:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtOJ0-0007ay-KM
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 19:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab0IHRTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 13:19:22 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59298 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0IHRTU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 13:19:20 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 11DE71FFC32E; Wed,  8 Sep 2010 17:19:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 91EF91FFC32C;
	Wed,  8 Sep 2010 17:19:13 +0000 (UTC)
In-Reply-To: <loom.20100908T181056-819@post.gmane.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155800>

This happens when you have a tag or branch that is a subdirectory of trunk.  It looks like tags/nano_2_1_1 is a branch off trunk/nano.  Git-svn doesn't recognize that trunk/nano@4248 is a subdirectory of trunk@4248 so it starts downloading the complete history of trunk/nano again.

On Sep 8, 2010, at 12:13 PM, Daniel Trebbien wrote:

> The issue is that the fetch runs up to revision 4250, but then mysteriously
> begins redownloading revisions 1 up to four thousand something in importing
> the `nano_2_1_1` tag:
> ...
> r4248 = 7c444dd667b9629ce92a53e8d35ad2d178e5735f (refs/remotes/trunk)
> 	M	nano/ChangeLog
> 	M	nano/configure.ac
> 	M	nano/po/cs.po

> 	M	nano/po/fi.po
> 	M	nano/po/zh_CN.po
> r4249 = 6fbad8a00fa067d1e3de913f77db08c6117843c7 (refs/remotes/trunk)
> 	M	nano/NEWS
> r4250 = 704700855e5112d75654e3e7461e896f49e10fd8 (refs/remotes/trunk)
> Found possible branch point: svn://svn.sv.gnu.org/nano/trunk/nano =>
> svn://svn.sv.gnu.org/nano/tags/nano_2_1_1, 4248
> Initializing parent: refs/remotes/tags/nano_2_1_1@4248
> 	A	mkinstalldirs
> 	A	utils.c
> 	A	nano.h
> 	A	global.c
> 	A	configure
> 	A	Makefile.in

I've encountered the same problem when importing other SVN repos.  If nano is the only subdirectory in trunk, you can fix this by changing your .git/config like this:

-	fetch = trunk:refs/remotes/trunk
+	fetch = trunk/nano:refs/remotes/trunk

This will cause issues if nano is not the only directory in trunk (it won't fetch the others) or if you have branches or tags that branch off the full trunk (you get the same problem).

Or you can downloading both trunk and nano as separate branches.  I think it fetches each revision twice, but it will prevent it from downloading the entire history for each subdirectory branch.

 	fetch = trunk:refs/remotes/trunk
+	fetch = trunk/nano:refs/remotes/nano

This will make your history look a little odd since trunk will have every commit that nano does but be a completely separate branch.  (It also seems to confuse `git-svn find-rev`.)

You can also speed imports like this by creating a local mirror with svnsync and using `git svn clone --use-svnsync-props file:///local/mirror`.  This probably isn't a good long term solution, but can be very handy when you're experimenting with getting it right.  Once you have it set up as you like delete svn-remote.svn.useSvnsyncProps, change svn-remote.svn.url to the original URL, and delete the local mirror.

I've been investigating altering the algorithm that finds branch points to understand branching off subdirectories, but haven't had the time.  It's good to know that the Minix 3 repo isn't the only one that does it.

~~ Brian
