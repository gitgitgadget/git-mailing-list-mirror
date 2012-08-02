From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Thu, 02 Aug 2012 15:00:41 -0700
Message-ID: <7vehnpc5ti.fsf@alter.siamese.dyndns.org>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Adam Butcher <dev.lists@jessamine.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:00:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx3Rt-0003OG-Qh
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab2HBWAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:00:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470Ab2HBWAr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:00:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DE598590;
	Thu,  2 Aug 2012 18:00:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iR1jmPJoo5abDaJL2/xbRsgRLiY=; b=iwkhHG
	q9Ma51fZvvnXa+NFQCCYhMeQNQPqIbYCtKvr15pNaGvnKHHjDjzFYw4Gt9GlVS4d
	QvVhob7/Zn+14h5G4rM4y6qDtS6Fih63yiwIn6c35Xv1kpxJQFnYXpG4ST72Kf+E
	uRJgUxYF5zVNKuvrsrOOb0BtkxqZqovrvmB/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iKVAzg+YjQVVECjj7AEYzWYTMwZcrtfW
	ExVoBZ4/cs2S99idRu+0vPbTWpK6pZpqNfr/GFdAs+lQo/Lc63WM/vy94QExIAuP
	gvm9QQclqjvJBjTY2Vn6lcaZ6iaw8J+hRD9ew8tqJIlrF/pHKZdXFKG9xzVxEDc6
	kqv/V7oqG8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A0BB858F;
	Thu,  2 Aug 2012 18:00:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6ABB08589; Thu,  2 Aug 2012
 18:00:46 -0400 (EDT)
In-Reply-To: <85f291cec03411c61ddf8808e53621ae@imap.force9.net> (Adam
 Butcher's message of "Thu, 02 Aug 2012 22:11:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83349730-DCED-11E1-8ED8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202801>

Adam Butcher <dev.lists@jessamine.co.uk> writes:

> +# create a file containing numbers with no newline at
> +# the end and modify it such that the starting 10 lines
> +# are unchanged, the next 101 are rewritten and the last
> +# line differs only in that in is terminated by a newline.
> +seq 1 10 > seq
> +seq 100 +1 200 >> seq
> +printf 201 >> seq
> +(git add seq; git commit seq -m seq) >/dev/null
> +seq 1 10 > seq
> +seq 300 -1 200 >> seq

We would prefer to have these set-up steps in test_expect_success.
That way, we will have more chance to catch potential and unintended
breakage to "git add" and "git commit" when people attempt to update
them.

Also, the redirect target sticks to redirect operator in our
scripts, i.e. "cmd >seq" not "cmd > seq".

> +test_expect_success 'no newline at eof is on its own line without -B'
> +
> +	(git diff seq; true) > res &&

What is this subshell and true about?  A git diff does not exit with
non zero to signal differences, and even if it did, the right way to
write it would be

	test_might_fail git cmd >res &&

to allow us to make sure that the git command that may or may not
exit with zero still does not die an uncontrolled death (e.g. segv).

> +	grep "^\\\\ No newline at end of file$" res &&
> +	grep -v "^.\\+\\\\ No newline at end of file" res &&
> +	grep -v "\\\\ No newline at end of file.\\+$" res
> +'

It is preferrable not to spell "No newline at ..." part out, so that
we won't have to worry about future rewords and i18n.  There are older
tests that predate i18n and they do spell these out, but that is not
a good reason to make things worse than they already are.

"git apply" only looks at the backslash-space at the beginning of
line anyway.

> +test_expect_success 'no newline at eof is on its own line with -B' '
> +
> +	(git diff -B seq; true) > res &&
> +	grep "^\\\\ No newline at end of file$" res &&
> +	grep -v "^.\\+\\\\ No newline at end of file" res &&
> +	grep -v "\\\\ No newline at end of file.\\+$" res
> +'

Likewise.

>  test_done

Thanks.
