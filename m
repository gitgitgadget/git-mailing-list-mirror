From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Tue, 03 Apr 2012 00:54:05 +0200
Message-ID: <4F7A2E0D.9030402@lsrfire.ath.cx>
References: <201203291818.49933.mfick@codeaurora.org> <7v7gy2q1kq.fsf@alter.siamese.dyndns.org> <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com> <20120330093207.GA12298@sigill.intra.peff.net> <20120330094052.GB12298@sigill.intra.peff.net> <4F7780F5.3060306@lsrfire.ath.cx> <20120402201432.GA26503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 00:54:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEq8i-0000mG-1t
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 00:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab2DBWyP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 18:54:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:34329 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab2DBWyP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 18:54:15 -0400
Received: from [192.168.2.105] (p4FFD9E0B.dip.t-dialin.net [79.253.158.11])
	by india601.server4you.de (Postfix) with ESMTPSA id E4EC32F8048;
	Tue,  3 Apr 2012 00:54:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120402201432.GA26503@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194574>

Am 02.04.2012 22:14, schrieb Jeff King:
> On Sun, Apr 01, 2012 at 12:11:01AM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Speed up prepare_revision_walk() by adding commits without sorting
>> to the commit_list and at the end sort the list in one go.  Thanks
>> to mergesort() working behind the scenes, this is a lot faster for
>> large numbers of commits than the current insert sort.
>
> I think this is probably a sane thing to do, but I have two slight
> misgivings:
>
>    1. Is it worth the complexity of the linked-list mergesort? I was
>       planning to just build an array, qsort it, and then put the res=
ults
>       into a linked list. The patch for that is below for reference.
>
>       It's a lot less code and complexity for the same performance
>       (actually, I measured it at 1% faster, but that is probably
>       negligible). The downside is that it is not nicely encapsulated=
 in
>       commit_list_sort_by_date(). We call the latter from two other
>       places; I don't know if they can be fed with enough commits to
>       actually benefit from the performance gain or not.

Using a temporary array here is just sad, because linked lists are=20
already sortable, albeit not with qsort().  Your measurements seem to=20
answer my question regarding the overhead of the callback functions of=20
mergesort(), in any case. :)

Adding mergesort() only pays if we have other linked lists that we want=
=20
to sort in-place.  I didn't search thoroughly for such a use case, but =
I=20
think we tended to prefer arrays so far instead.

>       So I wonder if in the long term we would benefit from a better =
data
>       structure, which would make these problems just go away. That b=
eing
>       said, there is a lot of code to be updated with such a change, =
so
>       even if we do want to do that eventually, a quick fix like this=
 is
>       probably still a good thing.

Using a more appropriate data structure sounds good in general. How=20
about using a skip list?  (Or perhaps I need to lay the hammer of linke=
d=20
lists to rest for a while to stop seeing all data structures as the=20
proverbial nails, or something. ;-)

> Here's the qsort-in-array patch, for reference.

It looks nice and to the point, but breaks several tests for me (t3508,=
=20
t4013, t4041, t4202, t6003, t6009, t6016, t6018 and t7401).  Not sure w=
hy.

Ren=C3=A9
