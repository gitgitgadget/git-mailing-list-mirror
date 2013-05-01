From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Wed, 1 May 2013 17:18:47 -0500
Message-ID: <CAMP44s2sRsJR9xxty9F4c7-G3HQrK3N=-o7KBSpG5TYpdhu-9w@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-4-git-send-email-artagnon@gmail.com>
	<CAMP44s1tHC+i+Wug_UuPnprZNvaPgLMNBX9MZi49SFv4iO62SQ@mail.gmail.com>
	<CALkWK0nTSMYvh8VMgQ6Q0EoPMmRa2vyodz+tDmpPp1d6KYmq8w@mail.gmail.com>
	<CAMP44s0sRqsmhbv-GA5x0FPc5msouSoGaU_Wg51E0F9bNsmkjg@mail.gmail.com>
	<CALkWK0=Z81f4c1X3uXO4O5q_Dj2hRJjSY-i-aDtZ0KqSyo5Wtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 00:18:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfMU-0006pa-NV
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759292Ab3EAWSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:18:51 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:49083 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669Ab3EAWSt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:18:49 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so1856991lbi.1
        for <git@vger.kernel.org>; Wed, 01 May 2013 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=y9+BqBpUb3c7wGtONNXQz3bwE5VObMEJDgbax63QB/k=;
        b=cA5v43gqLMOka6keQI4UkyVpS6WMV1oZ1KO1j5PlFu8d6yeCrngli6OfICPLtIuhO9
         jwrqdewMq5bUKitsFFUHn6xpM3EY+mTy0qhBmvaoHw+J1bin6VLQS7GWm9y+SlrHGd5e
         0vAblA+pxxU5TCIF9cHybG7nGFcFWoXcp+5PbnGRwh28u7p7nj4XsnKFhl7feJ0+5UgP
         io483dB0+B09EBu9/kl6hIOZVunwWuUL7MMdBhaYnCKKMcWKPIHwqEDGPtE6SZkFrpn4
         RkEqbWfP/eP+jY/WQozhfpZhREZJre8qKVNf0RYWPPMGXB4AJaZcTbi/3uQ9rmPpntDJ
         FQ7g==
X-Received: by 10.112.135.70 with SMTP id pq6mr1797716lbb.82.1367446727824;
 Wed, 01 May 2013 15:18:47 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 15:18:47 -0700 (PDT)
In-Reply-To: <CALkWK0=Z81f4c1X3uXO4O5q_Dj2hRJjSY-i-aDtZ0KqSyo5Wtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223155>

On Wed, May 1, 2013 at 2:40 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Wed, May 1, 2013 at 1:36 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>>> This is not a reorganization patch.  I said "simplify": not refactor.
>>
>> I'd say you should start with a reorganization, and then a simplification.
>
> You don't think I already tried that?  There is no way to sensibly
> reorganize the old logic sensibly, in a way that doesn't break
> anything.

There's always a way.

See, I tried to split your patch into logical changes, so I started with this:

--- a/sha1_name.c
+++ b/sha1_name.c
@@ -460,23 +460,26 @@ static int get_sha1_basic(const char *str, int
len, unsigned char *sha1)
        if (len && ambiguous_path(str, len))
                return -1;

-       if (!len && reflog_len) {
-               struct strbuf buf = STRBUF_INIT;
-               int ret;
-               /* try the @{-N} syntax for n-th checkout */
-               ret = interpret_branch_name(str+at, &buf);
-               if (ret > 0) {
-                       /* substitute this branch name and restart */
-                       return get_sha1_1(buf.buf, buf.len, sha1, 0);
-               } else if (ret == 0) {
-                       return -1;
+       if (reflog_len) {
+               if (!len) {
+                       struct strbuf buf = STRBUF_INIT;
+                       int ret;
+                       /* try the @{-N} syntax for n-th checkout */
+                       ret = interpret_branch_name(str+at, &buf);
+                       if (ret > 0) {
+                               /* substitute this branch name and restart */
+                               return get_sha1_1(buf.buf, buf.len, sha1, 0);
+                       } else if (ret == 0) {
+                               return -1;
+                       }
+                       /* allow "@{...}" to mean the current branch reflog */
+                       refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
+               } else {
+                       refs_found = dwim_log(str, len, sha1, &real_ref);
                }
-               /* allow "@{...}" to mean the current branch reflog */
-               refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
-       } else if (reflog_len)
-               refs_found = dwim_log(str, len, sha1, &real_ref);
-       else
+       } else {
                refs_found = dwim_ref(str, len, sha1, &real_ref);
+       }

        if (!refs_found)
                return -1;

Truly no functional changes at this point, but then this:

--- a/sha1_name.c
+++ b/sha1_name.c
@@ -473,7 +473,7 @@ static int get_sha1_basic(const char *str, int
len, unsigned char *sha1)
                                return -1;
                        }
                        /* allow "@{...}" to mean the current branch reflog */
-                       refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
+                       refs_found = dwim_log("HEAD", 4, sha1, &real_ref);
                } else {
                        refs_found = dwim_log(str, len, sha1, &real_ref);
                }

Bam! Now we have a functional change. @{1} is different from HEAD@{1},
but this change makes them the same. Not only is this a functional
change, it's a behavioral change.

Of course, this would be easy to see if you had bothered to split your
patch into logical changes, but you didn't, so the change is lost in a
mess. This is why it's not recommended to do that.

>>> I'm claiming that there is no functional change at the program level,
>>> with the commenting*.  If you want to disprove my claim, you have to
>>> write a test that breaks after this patch.
>>
>> The burden of proof resides in the one that makes the claim, I don't
>> need to prove that there are functional changes, merely that you
>> haven't met your burden of proof.
>
> Oh, but I have.  All the tests (along with the new ones I added in [1/5]) pass.

That is only proof that those tests pass.

> Scientific theories stand until you can find one observation that disproves it.

Yeah, I would like to see a scientist claiming "There are exactly
three multiverses. You don't think so? Prove me wrong. Na na na na!".
Not going to happen.

You are the one making a claim, you are the one that has the burden of
proof, and you haven't met it.

And even though I don't have to prove your claim is false, I already
did; @{1} is different now. If you want more, see below.

>> That being said, perhaps there are no _behavioral_ changes, because
>> you are relegating some of the current functionality to dwim_log, but
>> the code most certainly is doing something completely different.
>> Before, get_sha1_basic recursively called itself when @{-N} resolved
>> to a branch name, now, you rely on dwim_log to do this for you without
>> recursion, which is nice, but functionally different.
>
> Your point being?  That I shouldn't say "no functional changes"
> because the logic is changing non-trivially at this level?

Exactly. You shouldn't say there are no functional changes, if, in
fact, there are functional changes.

>>>> It's not true, there might not be any @{u} in there.
>>>
>>> This entire structure is a success-filter.  At the end of this, if
>>> !refs_found, then there has been a failure.
>>
>> That's irrelevant, this 'else' case is for !reflog_len, there might or
>> might not be @{u} in there.
>
> There's no need to associate one comment with one line of code.
> People can see clearly see the failure case following it.

Is that the way you defend your comments? People can see that the
comment is wrong?

What is the point of the comment then? People can see the context, so
there's no need for a comment, specially one that is wrong.

>>> The Git project is already suffering from a severe shortage of
>>> comments [1], and you're complaining about too many comments?
>>
>> Irrelevant conclusion fallacy; let's suppose that the Git project is
>> indeed suffering from a shortage of comments, that doesn't imply that
>> *these* comments in their present form are any good.
>
> Is there anything _wrong_ with the comments, apart from the fact that
> they seem to be too big?  I'm saying things that I cannot say in the
> commit message.

I just pointed to one comment being wrong. Other than that, yeah, they
are unnecessary.

Aside from the fact that there are wrong and unnecessary comments,
unmentioned functionality changes, there are behavioral changes:

1) @{1} has changed

2) @{-1}@{-1} now doesn't return an error

3) @{-1}{0} returns an invalid object

I wrote a test to show these changes:

*** t1513-at-combinations-strict.sh ***
ok 1 - setup
ok 2 - HEAD = refs/heads/new-branch
ok 3 - @{1} = commit
ok 4 - HEAD@{3} = commit
not ok 5 - @{3} is nonsensical
#	
#		test_must_fail git rev-parse --symbolic '@{3}'
#	
ok 6 - @{-1} = refs/heads/old-branch
ok 7 - @{-1}@{1} = commit
not ok 8 - @{-1}{0} = commit
#	
#		if [ 'commit' == 'commit' ]; then
#			echo 'old-two' >expect &&
#			git log -1 --format=%s '@{-1}{0}' >actual
#		else
#			echo 'commit' >expect &&
#			git rev-parse --symbolic-full-name '@{-1}{0}' >actual
#		fi &&
#		test_cmp expect actual
#	
ok 9 - @{u} = refs/heads/upstream-branch
ok 10 - @{u}@{1} = commit
ok 11 - @{-1}@{u} = refs/heads/master
ok 12 - @{-1}@{u}@{1} = commit
ok 13 - @{u}@{-1} is nonsensical
ok 14 - @{1}@{u} is nonsensical
not ok 15 - @{-1}@{-1} is nonsensical
#	
#		test_must_fail git rev-parse --symbolic '@{-1}@{-1}'
#	
# failed 3 among 15 test(s)
1..15

They all pass without your patch. So yeah, there's a reason you were
not able to show fulfill your burden of proof; your claim wasn't true.

Here's the test:

#!/bin/sh

test_description='test various @{X} syntax combinations together'
. ./test-lib.sh

check() {
test_expect_${4:-success} "$1 = $2" "
	if [ '$2' == 'commit' ]; then
		echo '$3' >expect &&
		git log -1 --format=%s '$1' >actual
	else
		echo '$2' >expect &&
		git rev-parse --symbolic-full-name '$1' >actual
	fi &&
	test_cmp expect actual
"
}

nonsense() {
test_expect_${2:-success} "$1 is nonsensical" "
	test_must_fail git rev-parse --symbolic '$1'
"
}

test_expect_success 'setup' '
	test_commit master-one &&
	test_commit master-two &&
	git checkout -b upstream-branch &&
	test_commit upstream-one &&
	test_commit upstream-two &&
	git checkout -b old-branch master &&
	test_commit old-one &&
	test_commit old-two &&
	git checkout -b new-branch &&
	test_commit new-one &&
	test_commit new-two &&
	git branch -u master old-branch &&
	git branch -u upstream-branch new-branch
'

check HEAD refs/heads/new-branch
check "@{1}" commit new-one
check "HEAD@{3}" commit old-two
nonsense "@{3}"
check "@{-1}" refs/heads/old-branch
check "@{-1}@{1}" commit old-one
check "@{-1}{0}" commit old-two
check "@{u}" refs/heads/upstream-branch
check "@{u}@{1}" commit upstream-one
check "@{-1}@{u}" refs/heads/master
check "@{-1}@{u}@{1}" commit master-one
nonsense "@{u}@{-1}"
nonsense "@{1}@{u}"
nonsense "@{-1}@{-1}"

test_done

-- 
Felipe Contreras
