From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] contrib/subtree: Split history with empty trees correctly
Date: Wed, 27 Jan 2016 20:55:29 -0600
Message-ID: <87k2mul8f2.fsf@waller.obbligato.org>
References: <56991CFC.7060705@ruhr-uni-bochum.de>
	<xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
	<87twmbaizo.fsf@waller.obbligato.org> <569EE046.9040506@semantics.de>
	<871t9cvqsp.fsf@waller.obbligato.org> <569F6DF0.60900@semantics.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Ware <davidw@realtimegenomics.com>, <git@vger.kernel.org>
To: Marcus Brinkmann <m.brinkmann@semantics.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 03:55:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOckM-00054y-8Q
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 03:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbcA1Czm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 21:55:42 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:39377 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755291AbcA1Czk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 21:55:40 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aOclz-0003fK-VR; Wed, 27 Jan 2016 20:57:28 -0600
In-Reply-To: <569F6DF0.60900@semantics.de> (Marcus Brinkmann's message of
	"Wed, 20 Jan 2016 12:22:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  [ Sorry it took a few days to reply. I am absolutely slammed
    at work and will be for the next few weeks at least. The good news is that
    it's resulting in some nice work on git-subtree! :) ] Marcus Brinkmann <m.brinkmann@semantics.de>
    writes: [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query  
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284975>

[ Sorry it took a few days to reply.  I am absolutely slammed at work
  and will be for the next few weeks at least.  The good news is that
  it's resulting in some nice work on git-subtree!  :) ]

Marcus Brinkmann <m.brinkmann@semantics.de> writes:

> On 01/20/2016 05:05 AM, David A. Greene wrote:
>> Marcus Brinkmann <m.brinkmann@semantics.de> writes:
>> 
>>> 'git subtree split' will fail if the history of the subtree has empty
>>> tree commits (or trees that are considered empty, such as submodules).
>>> This fix keeps track of this condition and correctly follows the history
>>> over such commits.
>> 
>> Thanks for working on this!  Please add a test to t7900-subtree.sh.
>
> I couldn't get the tests to run and I couldn't find documentation on how
> to run it.  If you enlighten me I can add a test :)

Just run "make test" in contrib/subtree.  You have to build git first.

>> Can you explain the logic here?  The old code appears to be using the
>> lack of a tree to filter out "mainline" commits from the subtree history
>> when splitting.  If that test is only done before seeing a proper
>> subtree commit and never after, then any commit mainline commit
>> following the first subtree commit in the rev list will miss being
>> marked with set_notree and the cache will not have the identity entry
>> added.
>> 
>> Test #36 in t7900-subtree.sh has a mainline commit listed after the
>> first subtree commit in the rev list, I believe.
>> 
>> I'm not positive your change is wrong, I'd just like to understand it
>> better.  I'd also like a comment explaining why it works so future
>> developers don't get confused.  Overall, I am trying to better comment
>> the code as I make my own changes.
>
> It's possible the patch does not work for some cases.  For example, I
> don't know how the rejoin variant of splits work.

I'm not so much worried about catching all cases of the bug you
identified, though it would be good if the patch did.  I'm much more
concerned about not causing a regression in existing functionality.

> Some observations:
>
> 1) The notree list is never actually used except to identify which
> commits have been visited in check_parents.

It's really verifying that we visited parents before children in the
split code, I think.  That seems like a good check to keep.

Let me make sure I understand your fix too.  Are you essentially
skipping empty commits when splitting?  You original patch said that
split failed but didn't say how.  Did git-subtree spit out an error
message, or did the failure manifest in some other way?  If I knew the
failure mode it might help me understand your changes better.

I see you explain the proble below (thanks!) but I'd still like to know
how you discovered it.  It will help in constructing a test.

> 2) I have no idea what use case is covered by the "if [ -n "$newparents"
> ]; then cache_set $rev $rev; fi".  I left it in purely for traditional
> reasons.  So, clarifying that would go a long way in understanding the
> code, and if there is a test for that, I will figure it out.

As far as I understand things, $newparents being non-empty means that
the commits parents were split out and $newparents contains the hashes
of the split commits, so that when this commit is split it can set up
the proper parent links.

If the commit doesn't have a tree in the subdirectory, then I *think*
the split codesimply sets the identity entry in the cache so that any
future commit that has this (empty) one as a parent will see it in the
$newparents list.  Since copy_or_skip checks for parents with empty
trees and does not link split commits to them, I don't understand the
purpose of including these commits in $newparents.

So you may very well be right that it just doesn't matter if we skip
these altogether.

> 3a) The bug happens because on the first commit that deletes the subdir,
> newparents will not be empty, and the "cache_set $rev $rev" will kick in
> and subsequently (when the subdir is added again) the history will
> divert into the $rev commit which is not rewritten, but part of the
> unsplit tree.  This seems very wrong to me!  See 2).

Ah, so the problem isn't empty commits per se, it's the fact that a
subdirectory was deleted and re-added.  That makes sense.  I didn't
understand that from your original commit message though I now remember
you discussed it in the first e-mail you sent.  It would be good to
clarify this in the final commit.

I agree that the behavior you describe is wrong.  So the fix basically
relies on the fact that there is some tree in the subdirectory, which
later gets deleted, but since "found_first_commit" triggered, we'll just
skip those empty commits and never see them in the cache so that when a
tree appears again we won't link to mainline commits.  Have I got it
right?

Currently the split code is all-or-nothing.  You split the whole history
or none of it.  Eventually I want to make it flexible enough to allow
splitting ranges of commits or individual commits.  I'm wondering how
your code will work if the split range starts or ends within the set of
empty subdirectory commits.  It's not something you really have to worry
about since I'd deal with it when I write the code, but it's something
that popped into my head.

> 3b) To be very clear: It seems logically inconsistent to me to ever call
> set_notree and cache_set on the same rev.  It also seems logically
> inconsistent to me to call cache_set rev1 rev2 where rev2 is not
> rewritten.  Both seem to be invariant errors that could be caught by
> assertions.  They probably should.  In fact, I think my patch makes the
> questionable if-case to be dead code, because newparents is never
> non-empty before found_first_commit is true.  As such, I think it could
> be eliminated.  But I am not 100% sure, as I don't know the intention of
> the original code.

After your walk-through and some exploring of the code, I think you are
right.  Like you I am not 100% sure but it would definitely be nice to
clean this bit of code up.

> 4) My patch only preserves the special handling of empty trees up to the
> first commit that introduces subdir, because we don't want an empty
> commit at the beginning.  After that, empty subdirs are not special at
> all - the empty tree is replaced by EMPTY_TREE and handled as if it's a
> normal subdir commit.  copy_and_skip will do the right thing.

I agree.

> 5) I didn't test any case with multiple parents (merge commits).  There
> are several of those cases (merge commits into empty subdirs, branches
> with different non-empty subdirs from empty ones), and they don't apply
> to my use case (git-svn conversion).  I read the copy_and_skip code and
> see that it optimizes some of those cases, and although I didn't see an
> obvious problem, I didn't think too deeply about it.

Yeah, that's definitely a concern.  I've run some tests on the current
git-subtree with merge commits and IIRC the results made sense.  I
should add those tests to the testbase.

I'm definitely inclined to accept your patch after this discussion but I
do want to see a few things:

1. A testcase

2. A more expanded commit message basically describing what you said in
   3-4 above, plus a bit more from your original e-mail describing the
   subdirectory delete and re-creation.  It will help people who come
   along later understand the history of the code.

3. Remove the questionable cache_set.  I agree that it seems wrong and
   copy_and_skip ignores it anyway.  Let's get rid of this cruft.
   Include something in the commit message about why this was done.

Thanks for the thorough explanation and for your work on this.  If you
can re-roll with the above and the existing tests pass, I think we can
pass this on to Junio.

Looking forward to the re-roll!

                           -David
