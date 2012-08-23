From: Junio C Hamano <gitster@pobox.com>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Thu, 23 Aug 2012 13:42:23 -0700
Message-ID: <7v393d49xs.fsf@alter.siamese.dyndns.org>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch> <7vd32h4h1t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:42:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4eEf-0003zU-9D
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 22:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933929Ab2HWUma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 16:42:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932284Ab2HWUm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 16:42:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3AE699C8;
	Thu, 23 Aug 2012 16:42:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2wvLaHIXN46ud9tyxEh10b9jD/g=; b=qDVonU
	A+E2kJZzDNiHdWIGYjhw42xmlJOEBil4s8ZGg4w3QsKaQwmQYP4fOrSssS/0XkG0
	y7lczXDs52rRdHuDqWV+lPfDUjtiy/+xmicBi38+3lGUl9wHZ5896NBWkrHdtTxg
	ECqgAbeLiegHUB0XzGpY7wN2yId4D+F1jd89I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w3OvLYEQVi52wOHgi4zbO3by1UZ+2zU2
	GKSgR7HcuWBOm1EhIYPcQSLVLQfn3Bz6ERoGZVP9vu7PH+EUU8H0e6GS8lkLDI4t
	uQuYeIgII76HxM7G42SvySncz3Eda+FONviAjTCTfcxI4CYLvlybPbpYN+Kd4bw1
	FH8RMcYiifw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFF4099C7;
	Thu, 23 Aug 2012 16:42:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCEEF99C5; Thu, 23 Aug 2012
 16:42:24 -0400 (EDT)
In-Reply-To: <7vd32h4h1t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 23 Aug 2012 11:08:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B8C8E6E-ED63-11E1-9441-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204169>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> At the very least it should be possible to change in_merge_bases() to
>> not do any of the post-filtering; perhaps like the patch below.
>
> I do not recall the details but the post-filtering was added after
> the initial naive version without it that was posted to the list did
> not work correctly in corner cases.  I wouldn't doubt that N*(N-1)
> loop can be optimized to something with log(N), but I offhand find
> it hard to believe "to not do any" could be correct without seeing
> more detailed analysis.

If "one on one side, many on the other side" in merge_bases_many()
confuses any of you in the readers, you can just ignore many-ness.
Getting merge bases for "one" against many "two"s using
merge_bases_many() is exactly the same as getting merge bases for
"one" against a (fictitious) single commit you can make by merging
all "two"s.

So we can think about the degenerate case of merge base between two
commits A and B in the following discussion.

A merge-base between A and B is defined to be a commit that is a
common ancestor of both A and B, and that is not an ancestor of any
other merge-base between A and B.  In the simplest case (illustrated
below), 1 is a merge base between A and B, but 2 is not (even though
it is an ancestor of both A and B, it is an ancestor of 1 which is a
merge base).

                  y---A
                 /
     ---2---o---1---x---B

So, the thinking goes, in order to find all merge bases, first we
can traverse from A and B, following "parent" link from children,
and painting found parents in two colors.

Start from A and B.  Follow from B to find 'x' and paint it in blue,
follow from A to find 'y' and paint it in amber.  Follow from 'x' to
'1', paint it in blue.  Follow from 'y' to '1', paint it in amber
but notice that it already is painted in blue.  Stop the traversal
there and we found a candidate '1' that could be a merge base.  We
know digging from '1' will not find more merge bases, so we should
stop there (I do not recall offhand if the current code does stop
there, though) [*1*].

There may be other paths that are not depicted in the above
illustration that reach '2' from A and B without passing '1'
through.

            o-------o
           /         \
          /       y---A
         /       /
     ---2---z---1---x---B
         \         /
          o-------o

In such a history, we may stop after finding '1' and '2' in the
first pass of "stop when a node is painted in both amber and blue".
This way, the first pass will find _all_ merge bases, but it also
may find common ancestors that are not merge bases.

So we need to notice that '1' and '2' have ancestry relation in
order to reject '2' as "common but not merge-base".  One way of
doing so is not to stop at '1' and keep digging (and eventually we
find that '2' is what we could reach from '1' that already is a
merge base), but then we will be susceptible to the same kind of
clock skew issue as the revision traverser.  Instead, merge-base
traverser chose to do this by running the same "stop traversing at
common" traverser between the candidates (in this case, '1' and
'2').

The objective of this second traversal is very different from the
first one, though.  We do not need _all_ the merge bases between '1'
and '2'; we do not even need merge bases.

The only thing we need to prove that '1' is a merge base (i.e. not
an ancestor of any other merge base candidates the first round of
traversal between A and B found) is to do the first round of the
traversal for '1' as "one" and all the other ('2' in this case) as
"two"s; if the first round of such traversal finishes without
painting '1' in both colors, that would mean '1' is not reachable
from any other candidates of merge base between A and B, so we have
proven that '1' is a merge base.

So I suspect that the postprocess phase could be made from N*(N-1)
to N (run merge_bases_many() once for each of the common ancestor
the first round found).  You might also be able to stop the
traversal used in the first phase (i.e. get_merge_bases()) a bit
earlier, if we are digging through '1' to paint 'z' (and eventually
'2') in STALE (amber+blue) color, as digging further only to paint
things in STALE color is not necessary with the postprocess.


[Footnote]

*1* Digging through '2' down may find that other candidate merge
bases we reach by traversing other paths that may not be depicted in
the above illustration, and there may be such paths to reach '1'
from A and B that does not pass '2' through.  That is a possible
alternative way to reject common ancestor that is not merge-base.
