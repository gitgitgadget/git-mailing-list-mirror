From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding git hooks
Date: Mon, 28 Apr 2014 09:43:10 -0700
Message-ID: <xmqq4n1dtnfl.fsf@gitster.dls.corp.google.com>
References: <1398504843.79785833@f133.i.mail.ru>
	<7vy4yshul9.fsf@alter.siamese.dyndns.org>
	<20140426175002.GC21493@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Suvorov Ivan <sv_91@inbox.ru>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:43:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weoeb-0006ke-Ij
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897AbaD1Qn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:43:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755802AbaD1QnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:43:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6F3880C2C;
	Mon, 28 Apr 2014 12:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZLRxrg1MYfQjyb/oXG3GTGEAbWg=; b=u0FEOa
	uZ4ghojKVpeMt/3Zs7+p08LkSqm1lEGjqABDHPtAv4amxTc+LhMz1ZgdGkDJ1ezA
	jQL8y4XF1kPGdYPSy0TV16I29ROx90fL+TAzlk3D+XaEYHw7Xu+qKT6/zBm+gtwX
	YjhqX89yOwvjgvqC8Te7WY3BJCe6eePxlzKNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UKxtA8fr7PZ4GNOpT7aafV/UNCIcaH6d
	MpbZB428cTjLAEdW+eBX28Ul9RL0DWlrwNXZKHW4N6qSoBD3n/0Q5vrxrDtnVN3j
	4B0qOUquSZjUl5wyw/FW8Kfu/+yVD/scdBUcEtof5Pt1IBZ2CvWQOxJxUgHlwpsd
	VpTRNIo/UKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC80080C2B;
	Mon, 28 Apr 2014 12:43:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA7B380C25;
	Mon, 28 Apr 2014 12:43:11 -0400 (EDT)
In-Reply-To: <20140426175002.GC21493@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 26 Apr 2014 13:50:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2FAFD8F4-CEF4-11E3-BF97-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247382>

Jeff King <peff@peff.net> writes:

> On Sat, Apr 26, 2014 at 10:24:50AM -0700, Junio C Hamano wrote:
>
>> Suvorov Ivan <sv_91@inbox.ru> writes:
>> 
>> > I want to extend the functionality of git due to the possibility of
>> > separation of the user repository into 2 parts - one part will be
>> > stored as usual, under version control git, and the second part will
>> > be stored in another location such as an FTP-server.
>> 
>> Sounds like you are looking for git-annex, perhaps?
>
> I agree that is the right approach, but git-annex and git-media work
> _above_ the object layer, and taint the history by storing symlinks in
> git instead of the real sha1s. I'd love to see a solution that does the
> same thing, but lives at the pack/loose object layer. Basically:
>
>   1. Teach sha1-file.c to look for missing objects by hitting an
>      external script, like:
>
>         git config odb.command "curl https://example.com/%s"
>
>      and place them in an alternates-like separate object database.
>
>   2. Teach the git protocol a new extension to say "don't bother sending
>      blobs over size X". You'd have to coordinate that X with the source
>      from your odb.command.

Yes, I'd love to see something along that line in the longer term,
showing all the objects as just regular objects under the hood, with
implementation details hidden in the object layer (just like there
is no distinction between packed and loose objects from the point of
view of read_sha1_file() users), as a real solution to address
issues in larger trees.

Also see http://thread.gmane.org/gmane.comp.version-control.git/241940
where Shawn had an interesting experiment.

> You'd probably want to wrap up the odb.command in a more fancy helper.
> For example, for performance, we'd probably want to be able to query it
> for "which objects do you have", as well as "fetch this object". And it
> would be nice if it could auto-query the "X" for step 2, and manage
> pruning local objects (e.g., when they become deep in history).
>
> We'd probably also want to teach a few places in git to treat external
> objects specially. For example, they should probably be auto-treated as
> binary, so that a "log -p" does not try to fetch all of them. And
> likewise, things like "log -S" should probably ignore them by default.
>
> I have a messy sketch of step 1 that I did quite a while ago, but
> haven't proceeded further on it.
