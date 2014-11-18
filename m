From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 13:05:29 -0800
Message-ID: <xmqqa93ousme.fsf@gitster.dls.corp.google.com>
References: <20141118203204.GM6527@google.com>
	<Pine.LNX.4.44L0.1411181541590.2918-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:05:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqpxx-0008Gg-ON
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 22:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbaKRVFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 16:05:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932159AbaKRVFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 16:05:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 089331F73A;
	Tue, 18 Nov 2014 16:05:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m6S9tcKlqPLzQlKnwM42lV7oNS8=; b=NtdFaC
	WYJz1tKWq8F0GSmjvvJxDf0i4nSoQWZn9JyKAguX+zGauPZ0a3OqVoHAeweg8V1N
	9gIvXu5qh1vk9expmNfUN9Fa62+N/UgRoXdtag0jJg7LU+vLd4BQKKTgdNyv/fnI
	G9G6mgXph3KAZHargQlFcKEEGvQ/SjBfsgyaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UTdhWT2nkgbN1MS/y70tTY33Bppj7xD1
	mLIaRj3x6dqHUcQOEWrKLqyNBDPVFOC0NvaAXA/6rGYrTDJjOPicU3g7kDgGQbaO
	GH64NjCqwnnWHtIToO1PZCoF39BMsf2pDTqJsT6FVN3EfP22TdQZi/gpVlURTRC1
	gsJ+a0HDQLU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7A331F739;
	Tue, 18 Nov 2014 16:05:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61ADF1F738;
	Tue, 18 Nov 2014 16:05:32 -0500 (EST)
In-Reply-To: <Pine.LNX.4.44L0.1411181541590.2918-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Tue, 18 Nov 2014 15:45:43 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A210907E-6F66-11E4-87D7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 18 Nov 2014, Jonathan Nieder wrote:
>
>> Alan Stern wrote:
>> 
>> > Tracking down regressions.  Bisection isn't perfect.  Suppose a
>> > bisection run ends up saying that B is the first bad commit.  It's easy
>> > enough to build B and test it, to verify that it really is bad.
>> >
>> > But to be sure that B introduced the fault, it would help to find the
>> > latest commit that doesn't include B's changes -- that is, the latest
>> > commit that B isn't reachable from (or the maximal elements in the set
>> > of all such commits).
>> 
>> Isn't that B^ (or B^ and B^2, if B is a merge)?
>
> No.  Here's a simple example:
>
>             Y
>            /
>           /
>          X--B
>
> In this diagram, X = B^.  But B isn't reachable from either X or Y, 
> whereas it is reachable from one of X's children (namely Y).

Around here when we draw history horizontally we place parents on
the left hand side and the children on the right hand side.  X is
B's parent and does not include B's changes.  Y is not B's parent.
Y is a child of X so it has all the imperfection of X inherited to
it (except the ones that is fixed by Y itself), but there is no way
it inherited the bug B introduced relative to X.

Why do you say B is reachable from Y?

If you mean that B is a merge between X and Y, then that is already
covered by what Jonathan wrote "(or B^ and B^2 if B is a merge)".

    X----Y
     \    \
      .----B

Admittedly it is a needless merge (there should normally be one or
more commits between X and B on the other branch to make a merge B
worthwhile---you could just have fast forwarded Y to B), but that
does not break the reachability or bisectability in any way.

Confused...
