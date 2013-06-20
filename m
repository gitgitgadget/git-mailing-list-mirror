From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty tree
Date: Thu, 20 Jun 2013 16:29:25 +0200
Message-ID: <87mwqk4zzu.fsf@linux-k42r.v.cablecom.net>
References: <20130620124758.GA2376@sigill.intra.peff.net>
	<aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
	<20130620131547.GA11073@sigill.intra.peff.net>
	<87zjuk6hr2.fsf@linux-k42r.v.cablecom.net>
	<87mwqk6h5d.fsf@linux-k42r.v.cablecom.net>
	<20130620134726.GB18200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 20 16:29:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upfrf-0004IV-LY
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 16:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244Ab3FTO32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 10:29:28 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:39949 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756403Ab3FTO31 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 10:29:27 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 20 Jun
 2013 16:29:22 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 20 Jun 2013 16:29:25 +0200
In-Reply-To: <20130620134726.GB18200@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Jun 2013 09:47:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228507>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 20, 2013 at 03:33:34PM +0200, Thomas Rast wrote:
>
>> >> I naively would have expected this to leave us in a conflicted state
>> >> over "file".  But I guess read-tree just rejects it, because we are not
>> >> doing a real three-way merge.  I'm not sure it is that big a deal; this
>> >> is more about safety than about creating a conflicted/resolvable state.
>> >
>> > Note that the test_must_fail essentially tests that the merge is rejected.
>> 
>> Bah, no it doesn't, a conflicting merge also returns a nonzero status.
>> Sigh.
>> 
>> If you meant we should actually conflict,
>
> Yes, that's what I meant.
[...]
>> diff --git i/git-pull.sh w/git-pull.sh
>> index 1f84383..b3d36a8 100755
>> --- i/git-pull.sh
>> +++ w/git-pull.sh
>> @@ -276,7 +276,7 @@ then
>>  	# lose index/worktree changes that the user already made on
>>  	# the unborn branch.
>>  	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
>> -	git read-tree -m -u $empty_tree HEAD || exit 1
>> +	git merge-recursive $empty_tree -- $(git write-tree) HEAD || exit 1
>
> I don't think there is any advantage to using merge-recursive over
> read-tree here, in the sense that there cannot be any interesting
> content-level merging going on (our ancestor is the empty tree, so we
> know that differing content cannot be resolved).
>
> So I think you could just use read-tree with a 3-way merge, but I cannot
> seem to provoke it to leave a conflict. Hrm.

I guess read-tree doesn't consider that its job; it leaves the conflict
in the index alright for me if I do this:

 git-pull.sh     | 4 ++--
 t/t5520-pull.sh | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git i/git-pull.sh w/git-pull.sh
index 1f84383..4047d02 100755
--- i/git-pull.sh
+++ w/git-pull.sh
@@ -275,8 +275,8 @@ then
 	# and try to fast-forward to HEAD.  This ensures we will not
 	# lose index/worktree changes that the user already made on
 	# the unborn branch.
-	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-	git read-tree -m -u $empty_tree HEAD || exit 1
+	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904 &&
+	git read-tree -m -u $empty_tree $(git write-tree) HEAD || exit 1
 	exit
 fi
 

But it won't write the conflict markers in the worktree.

On the topic of "do we want to conflict": one issue is that we don't
have a prior state to go to, since it was never committed.  Not even the
implicit empty tree can be passed to 'reset --keep'.  So it might be
better to *avoid* creating conflict hunks -- and fail -- so as to avoid
giving the user a state that is hard to back out of.

In the same spirit I would also support this:

> I wonder if it would make sense to update HEAD only _after_ we had
> resolved successfully. As it is now, you are left in a weird state where
> pull has reported failure, but we actually update the HEAD (and "git
> status" afterwards reflects that you are building on top of the pulled
> HEAD).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
