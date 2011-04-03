From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 4/4] builtin/show: do not prune by pathspec
Date: Sun, 03 Apr 2011 15:16:30 +0200
Message-ID: <4D98732E.5010709@drmicha.warpmail.net>
References: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org> <cover.1301649372.git.git@drmicha.warpmail.net> <6509d23c538dfabd4fac8870d29a69b1dd11a516.1301649372.git.git@drmicha.warpmail.net> <7vwrjdej42.fsf@alter.siamese.dyndns.org> <7v7hbdefy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?Tmd1eeG7hQ==?= =?UTF-8?B?biBUaMOhaSBOZ+G7jWMgRHV5?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 15:16:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6NAP-00024M-5y
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 15:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab1DCNQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 09:16:28 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55885 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752430Ab1DCNQ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 09:16:27 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2622D20664;
	Sun,  3 Apr 2011 09:16:27 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 03 Apr 2011 09:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=8S619/ZAGXUSSpDXkulMB3OZegw=; b=QTsAxEWhK6DzcE4iqlWvdSUFvn0nwXA4DPGUakhqT6KU6ivNw1K0WzFugWBmpYjaARnWHrLE1LVwWS7XwhGUVcOMjPWv046WLF6wP1z2HU194kk1HhZhPao9uzwmqcJCHKsM7eKr51XvN/4b6d7kbwrSgTB7D5t4Tkt/wM4Pr6A=
X-Sasl-enc: oZTXFKh4YGh2Bq/nFvBXKRZSUHXLbWazUfQMUwPQG9jp 1301836586
Received: from localhost.localdomain (p54858924.dip0.t-ipconnect.de [84.133.137.36])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 52D5B409FA2;
	Sun,  3 Apr 2011 09:16:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7v7hbdefy3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170690>

Junio C Hamano venit, vidit, dixit 02.04.2011 00:59:
> I attempted to rewrite the log message in a bit more objective voice like
> this:
> 
>     builtin/show: do not prune by pathspec
>     
>     "git show $commit -- $path" does not show anything for a commit that does
>     not change the $path.  While this may be technically correct, it is somewhat
>     unexpected from the end user's point of view.
>     
>     Unless "show" is used as "log -p", e.g. "git show HEAD~5..", it makes more
>     sense to show at least the log message for commits, even they are
>     uninteresting with respect to $path.

Definitely more diplomatic ;)

>     Turn off commit pruning (but keep diff limiting of course) so that the
>     command shows the log message and the diff that the commit introduces to
>     the path.  The diff part may be empty for a given commit that does not
>     touch the path.
>     
>     As an intended side effect, users mistaking "git show commit -- path"
>     for "git show commit:path" are automatically reminded that they asked
>     git to show a commit, not a blob.
>     
>     Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> which made me realize that this change does regress for no-walk case.

Well, it's an intended change of behaviour, so the term "regress" is
diplomatically problematic...

> 
> What if you (or your homegrown tool or alias) are feeding a list of
> candidate commits that may have touched the path, without walking, and are
> expecting them to be filtered?
> 
>     $ git show A B C D -- path
> 
> We used to get a nice output of "git show C -- path" in such a case but
> now the output will be cluttered with the log message from a commit that
> is totally uninteresting with respect to the given path.
> 
> I really wanted to like this patch, because I _very much_ liked the
> "intended" ;-) side effect.
> 
> I am torn.
> 

I would probably discard the "tool" aspect (for a porcelain). FWIW, we
never even documented that "git show" takes pathspec arguments, and only
experienced users know that "git show" has anything to do with "git log"
and friends (we mention only the relation to diff-tree).

That being said, we could detect in addition whether there is only one
positive rev (and no walk being done) and turn off pruning only in that
case. That would still catch users' (mis)expectation about "show rev --
file" but not impact anyone using it as a filter on more than 1 rev.
(Personally, I find the distinction between walk and no-walk modes clearer.)

Michael
