From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: Re: git http-backend error message
Date: Tue, 16 Mar 2010 18:10:25 +0100
Message-ID: <E4235035-D3BD-44B9-9431-490400EE8A75@pelagicore.com>
References: <A55E5483-425E-4303-87F2-FABC46F6BFE5@pelagicore.com> <7v3a01v796.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 18:10:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NraHs-0008KT-G0
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 18:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759928Ab0CPRKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 13:10:30 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:55164 "EHLO
	av9-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759845Ab0CPRK3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Mar 2010 13:10:29 -0400
Received: by av9-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 683613835F; Tue, 16 Mar 2010 18:10:27 +0100 (CET)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av9-2-sn2.hy.skanova.net (Postfix) with ESMTP id 80BFA382FD
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 18:10:26 +0100 (CET)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id 698CD37E49
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 18:10:26 +0100 (CET)
In-Reply-To: <7v3a01v796.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142342>


On Mar 15, 2010, at 6:12 PM, Junio C Hamano wrote:
> Jeremiah Foster <jeremiah.foster@pelagicore.com> writes:
> 
>> error: refusing to update checked out branch: refs/heads/master
>> error: By default, updating the current branch in a non-bare repository
>> error: is denied, because it will make the index and work tree inconsistent
>> error: with what you pushed, and will require 'git reset --hard' to match
>> error: the work tree to HEAD.
>> error: 
>> error: You can set 'receive.denyCurrentBranch' configuration variable to
>> error: 'ignore' or 'warn' in the remote repository to allow pushing into
>> error: its current branch; however, this is not recommended unless you
>> error: arranged to update its work tree to match what you pushed in some
>> error: other way.
>> error: 
>> error: To squelch this message and still keep the default behaviour, set
>> error: 'receive.denyCurrentBranch' configuration variable to 'refuse'.
>> 
>> 	I am unclear about my next move. Should I just set
>> 	receive.denyCurrentBranch to 'warn' and then my commits locally
>> 	will go back up to the server?
> 
> After it becomes clear about your next move (people will try to help you
> in this thread), please also tell us what information you found lacking in
> the above advisory text that you had to ask this question.

I didn't understand the dynamics of how changing the current branch would affect the index and work tree. I thought that when I pushed to the remote repo it was equivalent to doing a commit to the remote repo. In which case I assumed there would be no inconsistency with the index. Apparently I have an incomplete understanding of the index.

>  The message is
> trying to help you decide what your next move should be, but apparently
> did not do a good job, and we want to know what improvements we should
> make.

I found the message helpful. If the suggestion of a bare repo was more explicit perhaps that would help. I am assuming of course that a bare repo was a suggestion.
> 
>> 	Or is it smarter to just create a bare repository, clone some
>> 	content into it, and then push?
> 
> It depends on what you are trying to achieve by pushing into this
> repository that is not bare, iow what this pushed-into repository is used
> for.

I was just testing out the mechanism of pushing over http, I had no important data in my repo.

> 
> Pushing into a repository is done for two reasons:
> 
> - You push into repository A so that the development done in other
>   repositories B, C, D,... can all be collected, kept safe, and
>   transferred out to other repositories (iow, B, C, D uses A as a shared
>   meeting place).
> 
>   This is the primary use case of "push", and because in repository A
>   there will not be any development of its own, people make A a (shared)
>   bare repository.

Thanks for this description. This is what I am hoping to achieve.

> 
> - You do perform your own development in repository A, and you would want
>   to interact with other repositories B, C, D,..., by doing "git pull B"
>   etc., but for network configuration reasons, you can only make
>   connection to A from B, C, D..., and not in the other direction.  In
>   this case, because "git pull B" run on A is "git fetch B" followed by
>   "git merge", you substitute the first "git fetch B" part by running
>   "git push A" on B instead, because you can make connections from B to A
>   but not A to B.
> 
>   In this case, you do not want your "git push A" run on B to overwrite
>   the branch that is checked out in A, and the above error is issued if
>   you attempted to do so.  This would show a proper arrangement for such
>   a "push instead of fetch":
> 
>   http://git.wiki.kernel.org/index.php/GitFaq#push-is-reverse-of-fetch

Thanks very much for your detailed email - it is very helpful.

Regards,

Jeremiah