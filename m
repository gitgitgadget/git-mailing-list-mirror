From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH] rebase --preserve-merges keeps empty merge commits
Date: Fri, 01 Feb 2013 16:05:20 -0500
Message-ID: <510C2E10.1050403@cisco.com>
References: <1358023561-26773-1-git-send-email-hordp@cisco.com> <CANiSa6gM1gpj0A6PC0qNVSaWvVrOBnSnjn2uKR9-cHSLAZ2OVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, phil.hord@gmail.com,
	Neil Horman <nhorman@tuxdriver.com>,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 22:05:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1No0-00073F-QF
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 22:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472Ab3BAVFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 16:05:30 -0500
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:26264 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227Ab3BAVF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 16:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4837; q=dns/txt; s=iport;
  t=1359752728; x=1360962328;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=Xu5mYUvhG+u+MoV9ykLq83l722r6wbE1qPmuPNld4w4=;
  b=PSZoVVuxTfOJOaF28an24CgWJk+wibtC8vi81q/EteEAVuCNePvCqkkW
   ITPxNBZwwoCGw3bXGSNx0+ETZqWM6pa3FHP/YobebH+kVqvD10KKWAQsb
   8XG0CVYP/0OtprgjulQJ+LXax0sITI12i10obgcRb7sgDHBLj7YgWCiZz
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAC0tDFGtJV2b/2dsb2JhbABFhki4ZxZzgh4BAQEDASNVAQULCxgCAgUWCwICCQMCAQIBRQYNAQUCAQGIBwYMsCqSWoEjjxiBEwOIZol9gzSBHYRTimCDGg
X-IronPort-AV: E=Sophos;i="4.84,579,1355097600"; 
   d="scan'208";a="168970517"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-9.cisco.com with ESMTP; 01 Feb 2013 21:05:28 +0000
Received: from [64.100.104.138] (dhcp-64-100-104-138.cisco.com [64.100.104.138])
	by rcdn-core-4.cisco.com (8.14.5/8.14.5) with ESMTP id r11L5RE5002443;
	Fri, 1 Feb 2013 21:05:27 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <CANiSa6gM1gpj0A6PC0qNVSaWvVrOBnSnjn2uKR9-cHSLAZ2OVA@mail.gmail.com>
X-Enigmail-Version: 1.5
X-TagToolbar-Keys: D20130201160520748
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215273>


Martin von Zweigbergk wrote:
> I'm working on a re-roll of
> http://thread.gmane.org/gmane.comp.version-control.git/205796
>
> and finally got around to including test cases for what you fixed in
> this patch. I want to make sure I'm testing what you fixed here. See
> questions below.

Thanks for that.  I should have done this myself.

> On Sat, Jan 12, 2013 at 12:46 PM, Phil Hord <hordp@cisco.com> wrote:
>> Since 90e1818f9a  (git-rebase: add keep_empty flag, 2012-04-20)
>> 'git rebase --preserve-merges' fails to preserve empty merge commits
>> unless --keep-empty is also specified.  Merge commits should be
>> preserved in order to preserve the structure of the rebased graph,
>> even if the merge commit does not introduce changes to the parent.
>>
>> Teach rebase not to drop merge commits only because they are empty.
> Consider a history like
>
> # a---b---c
> #      \   \
> #       d---l
> #        \
> #         e
> #          \
> #           C
>
> where 'l' is tree-same with 'd' and 'C' introduces the same change as 'c'.
>
> My test case runs 'git rebase -p e l' and expects the result to look like
>
> # a---b---c
> #      \   \
> #       d   \
> #        \   \
> #         e---l
>

This is probably right, but it is not exactly the case that caused my itch.
I think my branch looked like this:

# a---b---c
#      \   
#       d---f
#        \   \
#         e---g
#              \
#               l

where g is tree-same with f.  That is, e merged with f, but all of e's
changes were dropped in the merge.

So when I ran 'git rebase -p c l', I expected to end up with this:

# a---b---c
#          \   
#           d---f
#            \   \
#             e---g
#                  \
#                   l

But instead, I got an error because git-rebase--interactive.sh decided
that g was empty, so it dropped it by commenting it out of the todo
list:

pick d
pick e
pick f
#pick g
pick l

At the end of this attempt, I got some odd error about a cherry-pick
have incorrect parameters or somesuch.  I bisected the problem to a
commit that clued me in to one of my commits being silently dropped.
And that is specifically what I fixed.

This happened only because 'is_empty_commit' checks for tree-sameness
with the first parent; it does not consider whether there are multiple
parents.  Perhaps it should.

>> A special case which is not handled by this change is for a merge commit
>> whose parents are now the same commit because all the previous different
>> parents have been dropped as a result of this rebase or some previous
>> operation.
> And for this case, the test case runs 'git rebase -p C l'. Is that
> what you meant here?
>
> Before your patch, git would just say "Nothing to do"

Huh.  That is worse than I thought.

> and after your
> patch, we get
>
> # a---b---c
> #      \   \
> #       d   \
> #        \   \
> #         e   \
> #          \   \
> #           C---l
>
> As you say, your patch doesn't try to handle this case, but at least
> the new behavior seems better. I think we would ideally want the
> recreated 'l' to have only 'C' as parent in this case. Does that make
> sense?

This is not what I meant, but it is a very interesting corner case.  I
am not sure I have a solid opinion on what the result should be here.
I feel like it should look the same as you show here, since neither
'c' nor 'C' is a candidate for collapsing during this rebase.  But I may
be missing some subtlety here.


Here is the corner case I was thinking of.  I did not test this to see
if this will happen, but I conceived that it might.  Suppose you have
this tree where

# a---b---c
#      \   
#       d---g---l
#        \ /
#         C

where 'C' introduced the same changes as 'c'.

When I execute 'git rebase -p l c', I expect that I will end up with
this:

# a---b---c---d---
#              \  \
#               ---g---l

That is, 'C' gets skipped because it introduces the same changes already
seen in 'c'.  So 'g' now has two parents: 'd' and 'C^'.  But 'C^' is 'd',
so 'g' now has two parents, both of whom are 'd'.  

I think it should collapse to this instead:

# a---b---c---d---g---l

I don't think this occurs because of my patch, and I am not sure it
occurs at all.  It is something that I considered when I was thinking of
failure scenarios for my patch.

I expect it also may happen if 'C' is an already-empty commit, or if
it is made empty after conflict resolution involving the user. I
mentioned it because I thought my patch _could_ address this if my
is_merge_commit test would also consider whether the parents are
distinct from each other or not.

I hope this is clear, but please let me know if I made it too confusing.

Phil
