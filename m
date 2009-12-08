From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Mon, 07 Dec 2009 23:11:08 -0800
Message-ID: <7vvdgindo3.fsf@alter.siamese.dyndns.org>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
 <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
 <7v3a3mqhhd.fsf@alter.siamese.dyndns.org>
 <20091208054724.GA21347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	James Vega <vega.james@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:11:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHuEL-0002VW-Pt
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 08:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbZLHHLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 02:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbZLHHLS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 02:11:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbZLHHLR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 02:11:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C181E86946;
	Tue,  8 Dec 2009 02:11:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v/fzRCJONoSkgTJbdgm8ZfUd6sM=; b=WcHogS
	0QgvHvMfZ4b6wgeHBVbyvEYIdwiYsCUF1m4UMPX3A4qe9Nihlega3N/uGBNQ7O30
	whIZy6nLjZgYqPCbdPN8nidb73+nDvncO469zrlJLIvgiVp3r0qZ4uNe0B6l39G1
	cVf6hFilTqj84loT4yztbgiZHwG/Q+AFeFEJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AstI2aS+BlDRuwwbdL1E7gSntjnVmoAW
	Ij7yY/HsPU6WeUy7c5bPGbyTwgrlxahza/wCA6Wc+kT6DVmqZz1wCETL8ARFz8NT
	coUKWL65xZVH2SfKzMIL0ohY0pTq2L/GCuAWWppQ0qqpcP3to3RWx/pmh+0MCfxE
	z5RLTHR1vss=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A43F586945;
	Tue,  8 Dec 2009 02:11:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B8B386943; Tue,  8 Dec
 2009 02:11:10 -0500 (EST)
In-Reply-To: <20091208054724.GA21347@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 8 Dec 2009 00\:47\:24 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E072B9B6-E3C8-11DE-8E78-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134825>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 07, 2009 at 07:20:30PM -0800, Junio C Hamano wrote:
>
>> An update.  I tried your reproduction recipe with 1.6.5.2 and it doesn't
>> reproduce, but with 1.6.5.3 it does.
>
> Thanks, both, for a very helpful bug report.  24ab81a was totally bogus,
> but we lacked a test for deleting a non-empty file. That test and a fix
> for the problem are in the patch below.

Thanks.

> I am still slightly concerned that James's
>
>   git diff | sed '/^deleted file/d' | git apply --cached
>
> behaves as it does. What should git-apply do with a patch like:
>
>   diff --git a/foo b/foo
>   index 257cc56..0000000
>   --- a/foo
>   +++ /dev/null
>   @@ -1 +0,0 @@
>   -foo
>
> ? I can see either turning it into a deletion patch (because /dev/null
> is special) or barfing (because /dev/null as a special case should have
> appeared in the "diff" line). But creating a dev/null file seems very
> wrong.

I was wondering about the same thing while bisecting.  By the current
definition of "diff --git", removing the "deleted file" or "new file" line
makes the patch an invalid "git format diff".  See the beginning of
parse_git_header() where we say "we don't guess" and initialize both
is_new and is_delete to false (and we flip them upon seeing "deleted file"
and "new file", but never with "/dev/null").

> But maybe it is not worth worrying about too much. That patch format is
> not generated intentionally by any known software.

I think some recent other SCMs produce what they claim to be "diff --git",
but I don't know if they implement the format correctly enough.  I am not
worried about their implemention of binary patches (if they do not
implement it correctly they will most likely get garbage), but do they get
the abbreviated hash on the "index" line correctly?  You can put garbage
on the line and most of the time it would work but it will break "am -3"
by breaking "apply --build-fake-ancestor".

I just checked "hg diff --git"; at least it shows "deleted file".

> That would take some refactoring, though, as pulling the deletion hunk
> out means we are re-ordering the headers. So right now if you did that
> your ($head, @hunk) output would be something like:
>
>        diff --git a/foo b/foo
>        index 257cc56..0000000
>        --- a/foo
>        +++ /dev/null
>        deleted file mode 100644
>        @@ -1 +0,0 @@
>        -foo
>
> which is pretty weird.

I agree it is weird.

> And it also opens the door to editing the hunk to stop the deletion, but
> still tweak the content change. Right now if you edit a deletion patch,
> you can't remove the 'deleted' bit, and if your edit result keeps any
> content in the file, apply will complain. I'm not sure that particular
> feature would be useful though (I have certainly never wanted it).

Interesting.  Does "add -p" (especially its [e]dit codepath) know enough
about what it is doing?  If so, it should be able to add "deleted file" on
its own (and remove it when the result of editing and picking hunks makes
the patch a non-deletion).  For example, if you have a two-liner in the
index and have deleted one line in the work tree, and run "add -p":

        diff --git a/foo b/foo
        index 3bd1f0e..257cc56 100644
        --- a/foo
        +++ b/foo
        @@ -1,2 +1 @@
         foo
        -bar

you *should* be able to edit it into a patch that removes all lines.

Perhaps the "add -i" at the end should offer, after noticing that the
chosen and edited hunks will make the postimage an empty file, a chance
for the user to say "I not only want to remove the contents from the path,
but want to remove the path itself" in such a case?

I dunno.
