From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Where do all the tips go? (Was: Re: Sharing a massive distributed
 merge)
Date: Thu, 17 Mar 2011 08:51:58 +0100
Organization: terreActive AG
Message-ID: <4D81BD9E.1050601@terreactive.ch>
References: <4D8119BE.2090208@workspacewhiz.com> <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com> <10061287.5697.1300343903667.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:52:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q080R-0007jk-M8
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 08:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab1CQHwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 03:52:13 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:48728 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab1CQHwM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 03:52:12 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <10061287.5697.1300343903667.JavaMail.trustmail@mail1.terreactive.ch>
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169221>

On 03/17/2011 07:38 AM, Jeff King wrote:
> On Thu, Mar 17, 2011 at 01:21:19AM -0400, Jay Soffian wrote:
> 
>>> Git doesn't support distribution of a merge (although that would be
>>> extraordinarily cool), so the next best thing seemed to be force adding all
>>> files with conflict markers and then committing the merge.  We then publish
>>> the conflicting branch and have each person fix their files.  Given that the
>>> conflict markers are already in place, they can't use their favorite
>>> graphical merge tool.
>>
>> Well, this is awful, but you could do something like:
>>
>> for x in conflicted_files:
>>    git show :1:$x > $x.base
>>    git show :3:$x > $x.theirs
>>    git checkout --ours $x
>>    git add $x.base $x.theirs $x
>>
>> Commit that, then folks can use their favorite merge tools, commit the
>> result, and remove the .base and .theirs.
> 
> I don't think you need to do anything so drastic. You can just have
> everybody do the partial merge, commit, and then push their result.  And
> then as you suggest below, one person does the real merge, uses checkout
> to install the desired result state from each person's partial tree, and
> then everybody throws away their partial merges.
> 
> The trick is that each person will resolve some conflicts and commit,
> but you need to know which ones they resolved. They can't leave things
> unmerged in the final commit. So they would have to provide such a list
> to you; one way is in the commit message[1].
> 
> So let's say you have three devs, Alice, Bob, and Charlie, and one
> integrator, Matt, who will do the merge. Each of the developers does:
> 
>   git checkout -b partial-merge
>   git merge old-topic
>   git mergetool ;# or manually resolve and git add
> 
> Eventually they get tired of the conflicts and give up. So they record
> the list of resolved paths, either manually or with something like[2]:
> 
>   {
>     echo 'partial merge result'
>     echo
> 
>     git status --porcelain | perl -ne '
>       next if /^U|\?/;
>       s/^\S+\s+//;
>       print;
>     '
> 
>   } >msg
> 
> And then they stage the rest of it (knowing it will be ignored by Matt)
> and commit:
> 
>   git add -u
>   git commit -F msg
>   git push wherever partial-merge
> 
> Then Matt does the actual merge:
> 
>   git merge old-topic
> 
> which of course results in lots of conflicts. So he pulls resolved
> versions from each person's tree:
> 
>   for i in alice bob charlie; do
>     git fetch $i
>     git checkout $i/partial-merge -- \
>       `git log -1 --format:%b $i/partial-merge`
>   done
> 
> And then fixes up whatever's left manually or with git-mergetool, and
> commits the end result.
> 
> Take all of my scripting there as illustrative of the concept, but not
> necessarily a good idea. In particular, it doesn't handle quoting of
> filenames at all, and it probably doesn't handle files whose resolution
> was to be deleted (since the checkout will fail).

This discussion is great! Is there some place where this sort of a thing
usually ends up, such as a wiki or the Git Community Book
<http://book.git-scm.com/>?

Cheers,
-- 
Victor Engmark
