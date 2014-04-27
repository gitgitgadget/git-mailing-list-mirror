From: Jakob Stoklund Olesen <stoklund@2pi.dk>
Subject: Re: [PATCH 2/2] git-svn: only look at the root path for svn:mergeinfo
Date: Sun, 27 Apr 2014 12:00:02 -0700
Message-ID: <7C3E8DB5-4E0D-48B4-B5B6-3EE268AE639F@2pi.dk>
References: <1397717646-54248-1-git-send-email-stoklund@2pi.dk> <1397717646-54248-2-git-send-email-stoklund@2pi.dk> <20140422185459.GA17248@dcvr.yhbt.net>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 21:00:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeUJL-0003mR-1I
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 21:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbaD0TAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 15:00:15 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:33182 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbaD0TAO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2014 15:00:14 -0400
Received: from homiemail-a52.g.dreamhost.com (sub5.mail.dreamhost.com [208.113.200.129])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 948408B66F
	for <git@vger.kernel.org>; Sun, 27 Apr 2014 12:00:13 -0700 (PDT)
Received: from homiemail-a52.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a52.g.dreamhost.com (Postfix) with ESMTP id 258856B82F9;
	Sun, 27 Apr 2014 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=2pi.dk; h=content-type
	:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=2pi.dk;
	 bh=XNyPmbq4qOWg1bKmtJvfgpm34ps=; b=NX1Kyk97FkULeQ+3GgIGmL2yLJKN
	81AGpt1vVuZ/c+5D19FZlWxozi7G1puyaJ0UyaH47WNGVG6H8Wk9SFHqnDVD5K7K
	1fmqKwb3uD9udSlHtnh1V5vuDHgQVY3XB9HKT3NX86j3ZPPjxLKoujlHYd4iU3kE
	FVCS7QuGwr0O3SQ=
Received: from [10.0.1.4] (173-228-90-133.dsl.dynamic.sonic.net [173.228.90.133])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: stoklund@2pi.dk)
	by homiemail-a52.g.dreamhost.com (Postfix) with ESMTPSA id 4443C6B82F5;
	Sun, 27 Apr 2014 12:00:03 -0700 (PDT)
In-Reply-To: <20140422185459.GA17248@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247221>


On Apr 22, 2014, at 11:54 AM, Eric Wong <normalperson@yhbt.net> wrote:

> Jakob Stoklund Olesen <stoklund@2pi.dk> wrote:
>> Subversion can put mergeinfo on any sub-directory to track cherry-picks.
>> Since cherry-picks are not represented explicitly in git, git-svn should
>> just ignore it.
> 
> Hi, was git-svn trying to track cherry-picks as merge before?

It would try and fail. I didn't explain that properly in the commit message.

Suppose I have a standard svn layout with $url/trunk and $url/branches/topic1. My topic1 branch has a change in subdir1 that I want to cherry-pick into trunk:

% svn switch $url/trunk
% cd subdir1
% svn merge $url/branches/topic1/subdir1
% cd ..
% svn commit

This operation will set svn:mergeinfo on $url/trunk/subdir1 where a normal full merge would set it on $url/trunk:

% svn pg svn:mergeinfo subdir1 
/branches/topic1/subdir1:3-4

When git-svn fetches these changes, it currently does examine the svn:mergeinfo change on the subdirectory as if it were a full merge. It then fails to find a revmap for /branches/topic1/subdir1:

Couldn't find revmap for file:///tmp/sdb/branches/topic1/subdir1
r5 = 5ce1f687c30495deca40730fb7be3baa0e145479 (refs/remotes/trunk)

It is looking for refs/remotes/topic1/subdir1, but we only have the refs/remotes/topic1 branch in git.

This patch makes git-svn stop trying to reconstruct those subdirectory merges that we know will fail anyway.

> This changes behavior a bit, so two independent users of git-svn
> may not have identical histories as a result, correct?

For normal subdirectory cherry-picks as described above, the behavior doesn't change. This is just a performance optimization.

For weirder cases where a whole branch has been merged onto a subdirectory of trunk, behavior does change. Currently, git-svn will mark that as a full merge in git. With this change it won't.

> Can you add a test to ensure this behavior is preserved?
> Thanks.

I'll add a test for the subdirectory merge described above.

> Sorry, I've never looked at mergeinfo myself, mainly relying on
> Sam + tests for this.
> 
> [1] - Historically, git-svn (using defaults) has always tried to
>      preserve identical histories for independent users across
>      different git-svn versions.  However, mergeinfo may be
>      enough of a corner-case where we can make an exception.


I agree. It doesn't seem worthwhile to try to preserve git-svn's historical behavior in weird corner cases.

BTW, this performance optimization matters not because of sporadic manual cherry-picks, but because certain older svn releases would replicate svn:mergeinfo on every subdirectory in a standard merge. With hundreds of subdirectories and thousands of merged branches, git-svn gets completely stuck processing all those mergeinfo lines.

Thanks,
/jakob
