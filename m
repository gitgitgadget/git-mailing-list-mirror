From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [RFC] rebase --root: Empty root commit is replaced with sentinel
Date: Thu, 19 Jun 2014 14:39:51 +0200
Message-ID: <53A2DA17.4060905@gmail.com>
References: <53A18198.7070301@gmail.com> <53A2CB18.7020408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Webb <chris@arachsys.com>
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 14:40:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxbdI-0005pq-Fl
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 14:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbaFSMj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 08:39:57 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:46608 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbaFSMjy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 08:39:54 -0400
Received: by mail-wi0-f178.google.com with SMTP id n15so2773824wiw.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 05:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xhEv6j0RkIZIHHXJvqFTr6uMJbieN68n77RfYqDuZ5Q=;
        b=vf/HCc/jQQWsDMwmpPSsOFco3KXOBDyyCuG5W9TLOcPNCrCqGAtTmeahvlhzuvNKyB
         gDO0lISo8JixAZvgkc6XDMEJZ8D6GgJtrWS04VDCxf5dvBahKAFLFHIB8rZnNwlscEHH
         ROv6kwfbCDpog+M8VCfrucpkbrHXfcTgARbzf7LrXYLKYNB1/mozF8H8BMJd+ag7a4Uu
         OwBxWD1vZUqbFdASUQEcDyug+HybuoQyUruU3dNoIPxKVSIdn+BMjj6bGqfGBe1ct1gX
         L+Term5o/VoffhOKRv5xPFLyagBxbV/oxRNFrKw+kdfDIFuarpyfGhh2JLmNbwhuZ3J6
         Aiiw==
X-Received: by 10.180.73.230 with SMTP id o6mr6325936wiv.30.1403181593425;
        Thu, 19 Jun 2014 05:39:53 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id f6sm33040629wiy.19.2014.06.19.05.39.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 19 Jun 2014 05:39:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A2CB18.7020408@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252111>

Hi Michael,

thanks for your reply.

On 06/19/2014 01:35 PM, Michael Haggerty wrote:
> On 06/18/2014 02:10 PM, Fabian Ruch wrote:
>> `rebase` supports the option `--root` both with and without `--onto`.
>> The case where `--onto` is not specified is handled by creating a
>> sentinel commit and squashing the root commit into it. The sentinel
>> commit refers to the empty tree and does not have a log message
>> associated with it. Its purpose is that `rebase` can rely on having a
>> rebase base even without `--onto`.
>>
>> The combination of `--root` and no `--onto` implies an interactive
>> rebase. When `--preserve-merges` is not specified on the `rebase`
>> command line, `rebase--interactive` uses `--cherry-pick` with
>> git-rev-list to put the initial to-do list together. If the root commit
>> is empty, it is treated as a cherry-pick of the sentinel commit and
>> omitted from the todo-list. This is unexpected because the user does not
>> know of the sentinel commit.
> 
> I see that your new tests below both use --keep-empty.  Without
> --keep-empty, I would have expected empty commits to be discarded by
> design.  If that is the case, then there is only a bug if --keep-empty
> is used, and I think you should mention that option earlier in this
> description.

Now that you mention it, --keep-empty is crucial for this to be a bug
(except for the case where the branch consists solely of empty commits).
I intended to use --keep-empty merely as a pedagogic tool so nobody
would get confused about what is on the to-do list.

> Also, I think this bug strikes if *any* of the commits to be rebased is
> empty, not only the first commit.

Ah, I really did not deduce that all empty commits would disappear with
--root and --keep-empty. Thanks.

>> Add a test case. Create an empty root commit, run `rebase --root` and
>> check that it is still there. If the branch consists of the root commit
>> only, the bug described above causes the resulting history to consist of
>> the sentinel commit only. If the root commit has children, the resulting
>> history contains neither the root nor the sentinel commit. This
>> behaviour is the same with `--keep-empty`.
>>
>> Signed-off-by: Fabian Ruch <bafain@gmail.com>
>> ---
>>
>> Notes:
>>     Hi,
>>     
>>     This is not a fix yet.
> 
> It is actually OK to add failing tests to the test suite, but they must
> be added with 'test_expect_failure' instead of 'test_expect_success'.
> Though of course it is preferred if the new test is followed by a commit
> that fixes it :-)

I did not plan to have this accepted but to amend the patch with a fix
later on. Also, I hoped the ready-to-apply tests would give someone else
a smoother start when taking over and compensate for a possibly
incomprehensible problem description.

>>     We are currently special casing in `do_pick` and whether the current
>>     head is the sentinel commit is not a special case that would fit into
>>     `do_pick`'s interface description. What if we added the feature of
>>     creating root commits to `do_pick`, using `commit-tree` just like when
>>     creating the sentinel commit? We would have to add another special case
>>     (`test -z "$onto"`) to where the to-do list is put together in
>>     `rebase--interactive`. An empty `$onto` would imply
>>     
>>         git rev-list $orig_head
>>     
>>     to form the to-do list. The rebase comment in the commit message editor
>>     would have to become something similar to
>>     
>>         Rebase $shortrevisions as new history
>>     
>>     , which might be even less confusing than mentioning the hash of the
>>     sentinel commit.
> 
> Since you are working on a hammer, I'm tempted to see this problem as a
> nail.  Would it make it easier to encode the special behavior into the
> todo list itself?:
> 
>     pick --orphan 0cf23b1 New initial commit
>     pick 144a852 Second commit
>     pick 255f8de Third commit

While I agree to enable pick to create orphan commits, I don't think a
user option --orphan is of much help. Firstly, does --orphan make sense
for any commit but the first one on the to-do list? Secondly, does
--orphan make sense when we are rebasing onto another branch? The second
point is related to the first in the sense that "pick --orphan" would be
used on a commit that is understood to have a parent.

> Michael

   Fabian

>>  t/t3412-rebase-root.sh | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
>> index 0b52105..a4fe3c7 100755
>> --- a/t/t3412-rebase-root.sh
>> +++ b/t/t3412-rebase-root.sh
>> @@ -278,4 +278,31 @@ test_expect_success 'rebase -i -p --root with conflict (second part)' '
>>  	test_cmp expect-conflict-p out
>>  '
>>  
>> +test_expect_success 'rebase --root recreates empty root commit' '
>> +	echo Initial >expected.msg &&
>> +	# commit the empty tree, no parents
>> +	empty_tree=$(git hash-object -t tree /dev/null) &&
>> +	empty_root_commit=$(git commit-tree $empty_tree -F expected.msg) &&
>> +	git checkout -b empty-root-commit-only $empty_root_commit &&
>> +	# implies interactive
>> +	git rebase --keep-empty --root &&
>> +	git show --pretty=format:%s HEAD >actual.msg &&
>> +	test_cmp actual.msg expected.msg
>> +'
>> +
>> +test_expect_success 'rebase --root recreates empty root commit (subsequent commits)' '
>> +	echo Initial >expected.msg &&
>> +	# commit the empty tree, no parents
>> +	empty_tree=$(git hash-object -t tree /dev/null) &&
>> +	empty_root_commit=$(git commit-tree $empty_tree -F expected.msg) &&
>> +	git checkout -b empty-root-commit $empty_root_commit &&
>> +	>file &&
>> +	git add file &&
>> +	git commit -m file &&
>> +	# implies interactive
>> +	git rebase --keep-empty --root &&
>> +	git show --pretty=format:%s HEAD^ >actual.msg &&
>> +	test_cmp actual.msg expected.msg
>> +'
>> +
>>  test_done
>>
