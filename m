From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git repack command on larger pack file
Date: Sun, 25 Oct 2015 23:41:23 -0700
Message-ID: <xmqq611ujfn0.fsf@gitster.mtv.corp.google.com>
References: <loom.20151026T065553-934@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sivakumar Selvam <gerritcode@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 07:41:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqbTG-0008QU-FV
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 07:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbbJZGl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 02:41:26 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750955AbbJZGlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 02:41:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01C692001E;
	Mon, 26 Oct 2015 02:41:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zFi1l05ZvpuFHpM9zbTwyKsoj2w=; b=IAMK3L
	DDSBkreqygfzObM4uCE4pxOZ1thygfqp4g33o9JlhKJPYtAQ8iVuRT6GjNlN8iQs
	PxNVIGWNbI8k20VfJJJQZaXJUIlz1J68t9wa5f5uaMJ/h4ULcESln21q+gMt+uUB
	PPm/0okBYCWspRjE/b6uxJBYWY2PS+AxB0lgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TTyd4O/ZKtmXxzdcmFeMfxrEMJTj1nJ8
	jd8f0hqBVLcu2l1X+YdKhrdJcZTd0UxMmOPAzMM7Vv01bYXDK1RHFNlpoUc+zK6a
	WjdtdBzOCrajBkuzOe8kGveQaYTMBeYYDYMnoGWW1E+KPF22es4zBSdMZAi0BzxF
	soo/eIW7Yw0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDBCA2001D;
	Mon, 26 Oct 2015 02:41:24 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 74DF92001C;
	Mon, 26 Oct 2015 02:41:24 -0400 (EDT)
In-Reply-To: <loom.20151026T065553-934@post.gmane.org> (Sivakumar Selvam's
	message of "Mon, 26 Oct 2015 05:57:36 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 938F4E98-7BAC-11E5-9BBA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280183>

Sivakumar Selvam <gerritcode@gmail.com> writes:

>    I ran git repack on a single larger repository abc.git where the pack
> file size 34 GB. Generally it used to take 20-25 minutes in my server to
> complete the repacking. During repacking I noticed, disk usage was more, So
> I thought of splitting the pack file into 4 GB chunks. I used the following
> command to do repacking.
>    git repack -A -b -d -q --depth=50 --window=10 abc.git
>
>    After adding --max-pack-size=4g to the above command again I ran to split
> pack files..
>    git repack -A -b -d -q --depth=50 --window=10 --max-pack-size=4g abc.git
>  
>    When I finished running, I found 12 pack files with each 4 GB and the
> size is 48 GB. Now my disk usage has increased by 14 GB. Again, I ran to
> check the performance, but the size (48 GB) and time to repacking takes
> another 35 minutes more. Why this issue?

Hmmm, what is "this issue"?  I do not see anything surprising.

If you have N objects and run repack with window=10, you would
(roughly speaking, without taking various optimization we have and
bootstrap conditions into account) check each of these N objects
against 10 other objects to find good delta base, no matter how big
your max pack-size is set.  And that takes the bulk of time in the
repack process.  Also it has to write more data to disk (see below),
it has to find a good place to split, it has to adjust bookkeeping
data at the pack boundary, in general it has to do more, not less,
to produce split packs.  It would be surprising if it took less
time.

Each pack by definition has to be self-sufficient; all delta in the
pack must have its base object in the same pack.  Now, imagine that
an object (call it X) would have been expressed as a delta derived
from another object (call it Y) if you were producing a single pack,
and imagine that the pack has grown to be 4 GB big just before you
write object X out.  The current pack (which contains the base
object Y already) needs to be closed and then a new pack is opened.
Imagine how you would write X now into that new pack.  You have to
discard the deltified representation of X (which by definition is
much smaller, because it is an instruction to reconstitute X given
an object Y whose contents is very similar to X) and write the base
representation of X to the pack, because X can no longer be
expressed as a delta derived from Y.  That is why you would need to
write more.
