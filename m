From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH v5] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Wed, 13 Jan 2016 21:12:38 -0600
Message-ID: <87bn8o97mh.fsf@waller.obbligato.org>
References: <CAPig+cSfkz=SNOn+8yP-QN8gJ0ej1wo3HW+y3NO+QvUCOP=+8A@mail.gmail.com>
	<1449695853-24929-1-git-send-email-davidw@realtimegenomics.com>
	<87y4bunopj.fsf@waller.obbligato.org>
	<CAET=KiVY5g41YgCbGqDqUaDjrd-Do9jNf=1L6xbBPcUoGcM2Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Ware <davidw@realtimegenomics.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 04:12:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYLE-0004kr-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbcANDMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:12:48 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:59299 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752132AbcANDMq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:12:46 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aJYMK-0004Gr-BJ; Wed, 13 Jan 2016 21:14:01 -0600
In-Reply-To: <CAET=KiVY5g41YgCbGqDqUaDjrd-Do9jNf=1L6xbBPcUoGcM2Kg@mail.gmail.com>
	(David Ware's message of "Thu, 14 Jan 2016 08:33:53 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  David Ware <davidw@realtimegenomics.com> writes: >> However,
    when I apply this against master, the test doesn't actually >> pass and a
    gitk --all shows the merge commit still missing. At least if >> I understand
    the problem correctly. Can you verify whether it works for >> you? >> > >
    The commit was made against v2.6.3, when I try to apply the patch > against
    master it fails. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284013>

David Ware <davidw@realtimegenomics.com> writes:

>> However, when I apply this against master, the test doesn't actually
>> pass and a gitk --all shows the merge commit still missing.  At least if
>> I understand the problem correctly.  Can you verify whether it works for
>> you?
>>
>
> The commit was made against v2.6.3, when I try to apply the patch
> against master it fails.

Any ideas why?

> However I can verify the test passes for me when applied against
> v2.6.3, and it also passed if I merge my patched copy of v2.6.3 into
> master.

I don't think the subtree split code has changed at all in that period
and the logs bear that out.  So there must be some change in
v2.6.3..master that confounds your patch.

Re-checking the patch submission guidelines, it looks like bugfixes
should be based against maint.  I did that and the test still fails with
your changes.  It seems like we ought to rebase to maint and continue
our investigation there.

> The process I'm using to run the tests is a little strange though, it
> seems I have to make git, then make contrib/subtree, then cp
> git-subtree to the root before running the Makefile on the tests.  Let
> me know if there's a less strange process for running the subtree
> tests.

I actually have an update that makes this easier but I haven't submitted
it yet.  But yes, you've got the current process right.

> The test case actually began life as a bash script I was running
> manually and visually inspecting. It covers the 2 cases we needed in
> order to push our release
>
> 1) Merges where one parent is a superset of the changes of the other
> parents regarding changes to the subtree, in this case the merge
> commit should be copied (represented by "merge" in test case)
>
> 2) Merges where only one parent operate on the subtree, and the merge
> commit should be skipped (represented by "second merge" in test case)
>
> I haven't done an in depth look to verify the test checks the second
> case, since this bit was never actually broken. But in terms of what
> the test case should be doing only the first merge should be preserved
> in the subtree

Ok, thanks.  More on this below.

>> The "subtree_test_create_repo" takes care of creating a subdirectory and
>> initializing a repository.  Perhaps you didn't (or still don't) have the
>> test script rewrite patch that got merged a month or so ago.  If not,
>> please update to it and reformulate your test to follow the established
>> convention.  It helps *a lot* when debugging regressions.
>>
>
> I'm not a regular contributor to git (this is my first). So I'm not
> very familiar with the test harness.

:)  Welcome!  I'm just (re-)starting work on git-subtree myself so we're
on the same learning curve.  I inherited the code from the original
author and we're slowly cleaning it up.  The goal is to get it out of
contrib and add some useful features.

> Also as noted I created the patch against v2.6.3, which did not have
> the changes you mentioned.

Ok.  Your patch applied cleanly to maint and maint has the latest
version of the test file.  It should be just a matter of following what
the other tests do.  I'm more than happy to guide you through it.

>>> +             git branch noop_branch &&
>> [...]
>>> +             git checkout noop_branch &&
>>> +             echo moreText >anotherText.txt &&
>>> +             git add . &&
>>> +             git commit -m "irrelevant" &&
>>
>> This is unfortunate naming.  Why is the branch a no-op and why is the
>> commit irrelevant?  Does the test test the same thing without them?  I
>> not they should have different names.  If so, why are these needed in
>> the test?
>>
>
> This is to create a merge that operates workflow (2) mentioned above,
> i.e. a branch that has absolutely no effect on the subtree and as such
> should be skipped

Ok.  Some comments to that effect would be great.  Something like what
your wrote describing (1) and (2) about would help a lot.  I'd still
like to see these names cleaned up because they confused me when I
looked at it.  Perhaps "no_subtree_work_branch" and "Non-subtree
change?"  Feel free to pick your own names if you think of something
better.

>>> +             git checkout master &&
>>> +             git merge -m "second merge" noop_branch &&
>>> +
>>> +             git subtree split --prefix folder/ --branch subtree_tip master &&
>>> +             git subtree split --prefix folder/ --branch subtree_branch branch &&
>>> +             git push . subtree_tip:subtree_branch
>>
>> I understand the problem was discovered because of an inability to push
>> and it probably makes sense to test that since that's what exposed the
>> bug.  However, I wonder if there are some additional checks that should
>> be done.  What do you expect subtree_tip and subtree_branch to look like
>> and how do you expect them to relate to each other?  Should
>> subtree_branch be an ancestor of subtree_tip?  If so we should
>> explicitly test that.
>>
>
> it should look like this:
>
> R--A1--A2-----M---H
>   \               /
>    B-------------
>
> Where H is subtree_tip and B is subtree_branch. So yes subtree_tip is
> a descendant of subtree_branch

Ok.

> Agreed, it should probably be checking things more explicitly. And
> ideally should also be checking that commit "irrelevant" and "second
> merge" are being skipped if possible.

Right.  If you want to add those tests, great.  Otherwise, please add a
comment describing them so that others can add them later.  I just don't
want to forget to test things we know about but I don't want it to hold
up your patch.

> As I noted in my original email this patch is solely designed to fix
> the issue we ran into whilst trying to make our release (essentially
> (1) and (2) mentioned above) and other cases of this same issue are
> not addressed.
> i.e.

> - The many parent case. I've made no attempt to handle this situation
> properly in the presence of greater than 2 parents. In theory it will
> now sometimes correctly copy the merge where it wouldn't before, and
> sometimes use the old behaviour.

> - This is one I've only realised since submitting the patch: The case
> where both parents have an identical tree to the merge commit, they
> don't necessarily have the same set of commits to achieve this state,
> so this should be being checked as well. Again I don't think this
> patch makes this situation worse, it will simply result in the old
> behaviour being used.

You certainly don't have to test and/or fix every potential problem with
this patch.  Noting them in the test via comments would help guide
others to write tests for them and/or fix the problems.  Could you add a
block comment before the test that describes scenarios (1) and (2),
talks about the status of testing them in the test (i.e. (2) isn't
tested) and explains the potential problems listed above that are not
being tested?  Thanks!

Again, thank you for your contributions!

                           -David
