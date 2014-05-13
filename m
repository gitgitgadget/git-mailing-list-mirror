From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 2/2] t: git-show: adapt tests to fixed 'git show'
Date: Tue, 13 May 2014 23:09:50 +0300
Message-ID: <20140513200910.GB6857@wheezy.local>
References: <20140512230943.GC32316@wheezy.local>
 <20140512231107.GE32316@wheezy.local>
 <xmqqiop9o4y5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 22:10:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJ1g-0005fj-1N
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbaEMUKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:10:08 -0400
Received: from p3plsmtpa12-09.prod.phx3.secureserver.net ([68.178.252.238]:44707
	"EHLO p3plsmtpa12-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752234AbaEMUKG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 16:10:06 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa12-09.prod.phx3.secureserver.net with 
	id 1Y9o1o00H3gsSd601Y9rv3; Tue, 13 May 2014 13:10:01 -0700
Content-Disposition: inline
In-Reply-To: <xmqqiop9o4y5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248811>

On Tue, May 13, 2014 at 12:26:42PM -0700, Junio C Hamano wrote:
> Hmph.  Having these as two separate commits would mean that 1/2
> alone will break the test, hurting bisectability a little bit.  The
> necessary adjustments in this patch is small enough that we may be
> better off squashing them into one.

Ok, will squash them.

>>  t/t1507-rev-parse-upstream.sh |  2 +-
>>  t/t7600-merge.sh              | 11 +++++------
>>  2 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
>> index 2a19e79..672280b 100755
>> --- a/t/t1507-rev-parse-upstream.sh
>> +++ b/t/t1507-rev-parse-upstream.sh
>> @@ -100,7 +100,7 @@ test_expect_success 'merge my-side@{u} records the correct name' '
>>  	git branch -D new ;# can fail but is ok
>>  	git branch -t new my-side@{u} &&
>>  	git merge -s ours new@{u} &&
>> -	git show -s --pretty=format:%s >actual &&
>> +	git show -s --pretty=tformat:%s >actual &&
>>  	echo "Merge remote-tracking branch ${sq}origin/side${sq}" >expect &&
>>  	test_cmp expect actual
>>  )
> 
> This seems to me that it is updating how the output is produced, not
> updating the expected outputs from commands with arguments we have
> been testing.  I have been expecting to see changes to the pieces of
> the code that prepare the expected output, so that we can compare
> old expectations, which would have been expecting something strange,
> with new expectations from the updated code, which would show that
> the new behaviour is a welcome change because it would produce more
> sensible output.
> 
> Having said all that, for this particular test piece, I agree with
> the patch that using --pretty=tformat:%s is a lot more sensible and
> using --pretty=format:%s and expecting its output to be terminated
> with the newline was an unrealistic test.  After all, "tformat" is
> the version with "line terminator" semantics, as opposed to "item
> separator" semantics offered by "--pretty=format:", and the test
> merely was depending on the bug to expect a complete line output
> (i.e. "echo" without "-n"), which you fixed.  The new test makes a
> lot more sense and is relevant to the real world use, and I would
> have preferred to see it explained as such in the log message.

In analogous cases with non-merge commits I have found the
form "--format=...", in t3505-cherry-pick-empty.sh for
example, so I have decided that merges should also use it. The
form "--pretty=tformat:..." seems more explicit to me, so I
have chosen this one.

Will add the message as you have suggested.

>> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
>> index 10aa028..b164621 100755
>> --- a/t/t7600-merge.sh
>> +++ b/t/t7600-merge.sh
>> @@ -57,11 +57,10 @@ create_merge_msgs () {
>>  		git log --no-merges ^HEAD c2 c3
>>  	} >squash.1-5-9 &&
>>  	: >msg.nologff &&
>> -	echo >msg.nolognoff &&
>> +	: >msg.nolognoff &&
>>  	{
>>  		echo "* tag 'c3':" &&
>> -		echo "  commit 3" &&
>> -		echo
>> +		echo "  commit 3"
>>  	} >msg.log
>>  }
> 
> These are updating the expectation.  We used to expect an
> unnecessary trailing blank line, and now we do not, which clearly
> shows that the previous fix is a welcome change.
> 
>> @@ -71,7 +70,7 @@ verify_merge () {
>>  	git diff --exit-code &&
>>  	if test -n "$3"
>>  	then
>> -		git show -s --pretty=format:%s HEAD >msg.act &&
>> +		git show -s --pretty=tformat:%s HEAD >msg.act &&
>>  		test_cmp "$3" msg.act
>>  	fi
>>  }
> 
> It is hard to judge what is fed as "$3" here without context, but
> this is in line with the "--pretty=tformat aka --format is the
> normal thing to use" we saw in 1507.  The same for the other hunk.
> 
>> @@ -620,10 +619,10 @@ test_expect_success 'merge early part of c2' '
>>  	git tag c6 &&
>>  	git branch -f c5-branch c5 &&
>>  	git merge c5-branch~1 &&
>> -	git show -s --pretty=format:%s HEAD >actual.branch &&
>> +	git show -s --pretty=tformat:%s HEAD >actual.branch &&
>>  	git reset --keep HEAD^ &&
>>  	git merge c5~1 &&
>> -	git show -s --pretty=format:%s HEAD >actual.tag &&
>> +	git show -s --pretty=tformat:%s HEAD >actual.tag &&
>>  	test_cmp expected.branch actual.branch &&
>>  	test_cmp expected.tag actual.tag
>>  '
> 
> How about squashing these two into a single patch, and at the end of
> the log message for 1/2, add this to explain the changes to the
> test:
> 
>     Also existing tests are updated to demonstrate the new
>     behaviour.  Earlier, the tests that used "git show -s
>     --pretty=format:%s", even though "--pretty=format:%s" calls for
>     item separator semantics and does not ask for the terminating
>     newline after the last item, expected the output to end with
>     such a newline.  They were relying on the buggy behaviour.  Use
>     of "--format=%s", which is equivalent to "--pretty=tformat:%s"
>     that asks for a terminating newline after each item, is a more
>     realistic way to use the command.
> 
>     The update to verify_merge in t7600 adjusts the the merge
>     message that used to expect an extra blank line in the output,
>     which has been eliminated with this fix.
> 
> or something like that?
> 
> 
