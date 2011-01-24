From: Shuang He <shuang.he@intel.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Mon, 24 Jan 2011 18:30:43 +0800
Message-ID: <4D3D54D3.7040801@intel.com>
References: <4D3CDDF9.6080405@intel.com> <AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"apenwarr@gmail.com" <apenwarr@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 24 11:31:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhJhd-0001Tq-A9
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 11:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab1AXKbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 05:31:11 -0500
Received: from mga03.intel.com ([143.182.124.21]:65058 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab1AXKbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 05:31:09 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 24 Jan 2011 02:30:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.60,369,1291622400"; 
   d="scan'208";a="379000356"
Received: from she4-mobl3.ccr.corp.intel.com (HELO [10.254.208.56]) ([10.254.208.56])
  by azsmga001.ch.intel.com with ESMTP; 24 Jan 2011 02:30:49 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165444>

On 2011/1/24 17:53, Christian Couder wrote:
> Hi,
>
> On Mon, Jan 24, 2011 at 3:03 AM, Shuang He<shuang.he@intel.com>  wrote:
>> Hi
>>      The default git-bisect algorithm will jump around the commit tree,
>> on the purpose of taking least steps to find the first culprit commit.
>> We may find it sometime would locate a old culprit commit that we're not
>> concerned about anymore.
> Yes, it can be a problem.

I'm honored to be given so much comment :)
Thank you

>>      In most software development, there's one or two main branch which
>> is maintained for release, and a bunch of feature branches are created
>> for new feature development or bug fix.  For the reason that sometime
>> git-bisect will locate a old culprit commit would be:
>>          1. Quality of those branches may not match the main branch,
>> some functionality are broken at first and fixed later on the feature
>> branch. If git-bisect jump to there by chance, git-bisect will only find
>> that old
>> culprit commit which only exists on that feature branch
> If the quality of these branches is too bad, I think they should not
> have been merged in the first place.
> If they are not merged (and not marked as good), then git bisect will
> not look at them, since it will look only at commits that are
> ancestors of the bad commit it is given.
>
> Or if one is merged but it causes too many problems, then perhaps a
> replacement commit could be used to unmerge the branch.
>
> Another possibility is to have in a file a list of commits that are
> the last commits on these branches before the merge commits, and do a:
>
> git bisect good $(cat good_commits_file.txt)
>
> at the beginning of each bisection.
>
> So I think the long term solution in this case is not what your are suggesting.

Yeah, I agree that the issue I addressed above will not be a problem if 
all those branches are maintained very well.
Actually we've implemented a automated bisect system for Intel Linux 
Graphics Driver Project, and so we'd like the system
helps us to locate issue in an more automatic way when branches are not 
maintained as good as expected.

>>          2. Some of those branches may not synchronized with main
>> branch in time.  Say feature1 is broken when feature2 branch is created, and
>> feature1 is fixed just a moment later after feature2 branch is created,
>> and when feature2's development is done, and developer want to merge
>> feature2 branch back to master branch, feature2 will be firstly
>> synchronized to master branch tip, then merge into master.  For the same
>> reason addressed in issue 1, this will also lead git-bisect into wrong
>> direction.
> I am not sure what you mean by " feature2 will be firstly synchronized
> to master branch tip", and I think this should mean a rebase that
> would fix the bug if feature1 has already been merged into the master
> branch.
>
> But anyway in this case, I think that git bisect will find that the
> first bad commit is the last commit in the branch, just before it was
> merged. And by looking at the branch graph it should be quite easy to
> understand what happened.
>
> And then the obvious thing to do is to decide to just start a new
> bisection like it was started the first time but with an added "git
> bisect good<merge_commit>", where<merge_commit>  is the commit that
> merges the branch.

For the same reason, that we're implementing automated bisect system , 
so we want git-bisect to
be able to help with this condition also.

>>      In all, we think we do not care about branches that we're not
>> currently working, unless we're sure the regression is caused by that
>> branch.
>>
>>      To address those issue, we propose to add a new config option:
>>          core.bisectbadbranchfirst::
>>              With this algorithm, git-bisect will always try to select
>> commits
>>              that on the same branch current bad commit sits. And will
>> fall back
>>              to default git-bisect algorithm when bad-branch-first
>> algorithm does
>>              not apply
>>          +
>>          This setting defaults to "false".
> I am not opposed to an option to bisect on the first parents of the
> bad commit only. And after a very fast look at your patch it seems to
> be what it does. By the way Avery Pennarun's gitbuilder
> (https://github.com/apenwarr/gitbuilder) does the same thing. So I
> know some people are interested in such a feature.
>
> But here are some suggestions/comments:
>
> - your explanations about why it could be useful should be improved,

I don't have much data to prove it. I could just say it could help if 
branches are not maintained very well.

> - the name "bisectbadbranchfirst" seems wrong to me, because git
> branches are just some special tags; "firstparentsonly" would be a
> better name,

It's recursively applying bad branch first algorithm, not just 
constantly stick to first parent.
Given this condition:
     A -> B -> C -> D -> E -> F -> G -> H   (master)
          \ a  -> b -> c -> d -> e /  (feature 1)
               \ x -> y -> z/      (feature 2)
start with H as bad commit, and A as good commit, if y is the target bad 
commit. bad-branch-first algorithm will do it like this:
     1. In first round stick to master branch, so it will locate G as 
first bad commit
     2. In second round stick to feature1 branch, then it will locate d 
as first bad commit
     3. In third round stick to feature2 branch, then it will finally 
locate y as first bad commit
So you could see, it's always sticking to branch where current bad 
commit sit


> - before having a config option for it, why not have it first as an
> option to "git bisect start",

Agree, I have thought about it. Haven't done it yet

> - if there is a config option, then there should probably be an option
> to "git bisect start" to use the regular algorithm,

Agree

> - it seems to me that bisecting only on first parents could fail only
> if some "good" commits are not ancestors of the bad commit, and if the
> bug is fixed on a branch where such a commit is; so I don't see the
> point in defaulting to the usual algorithm in this case because in
> this case the usual algorithm just stops,

It should stop as default git-bisect do, when
There are a few cases that this algorithm will fall back to default 
algorithm:
     when bisect path is specified. Since --first-parent seems not 
working as expected when file path is specified
     when bad branch first algorithm could not find a commit to bisect

> - perhaps the message given when the first bad commit is found should
> be changed a little bit when this option is used.

Yeah, agree

> Maybe I am missing something, because as I said I didn't read your
> patch carefully, but in this case please try to give a concrete
> example.
>
> Thanks,
> Christian.
