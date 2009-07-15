From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-am: fix maildir support regression: accept email
 file as patch
Date: Wed, 15 Jul 2009 15:54:25 -0700
Message-ID: <7v1voheevy.fsf@alter.siamese.dyndns.org>
References: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 00:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRDN5-0002p4-IG
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 00:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbZGOWyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 18:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755234AbZGOWyf
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 18:54:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbZGOWye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 18:54:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9BF67500;
	Wed, 15 Jul 2009 18:54:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5E8D574FE; Wed, 15 Jul 2009
 18:54:27 -0400 (EDT)
In-Reply-To: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr> (Nicolas Sebrecht's message of "Thu\, 16 Jul 2009 00\:19\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75905F20-7192-11DE-99C5-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123343>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> Patch format detection introduced by a5a6755a1d4707bf2fab7752e5c974ebf63d086a
> may refuse valid patches.

This message is even worse than the previous round.

By definition what git-am does not accept is invalid, and you are
loosening that definition to include something else newly as valid.

Please describe what that new something is.

If you are claiming a5a6755 (git-am foreign patch support: introduce
patch_format, 2009-05-27) is an regression, and before it X, Y and Z
format were supported but after that only X and Y format are, then for the
same reason please specify what that Z you are resurrecting the support
for is.

That way, people who have been frustrated that their randomly formatted
files were not processible without first converting them to mbox format
will know that now their favorite format is now/again also supported.

> We keep detection on the first three lines. Emails may have:
>  - header fields in a random order;
>  - folded lines.
>
> Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
> ---
>  git-am.sh |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
>

Please do not break the thread.  Make this message a response to my
message you lifted the idea from, which in turn was sent as a response in
the thread of v2 patch.


> +		for line in "$l1" "$l2" "$l3"
> +		do
> +			printf "$line" |
> +				# The line may be a folded line
> +				sed -e '/^$/q' -e '/^[ ]/d' |
> +				grep -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
> +				is_email='false'

Running three independent printf piped to two processes in a loop is
quite silly.

I think you did not understand the point of the three liner I sent you.

	sed -e '/^$/q' -e '/^[ 	]/d' "$1" |

    The point of this is not to use the silly "we only look at the first
    three lines" rule.  Instead, it ignores these l1/l2/l3, but grabs all
    the header lines, but discards second and subsequent physical lines if
    a logical line was folded.  Which means that the effect of this is to
    pipe the whole header (again, without worrying about the indented
    remainder of folded lines) to downsream, which is the grep -v below

        grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||

    This checks if there is a line that does _NOT_ match the usual
    e-mail header pattern.  If there is such a line, it means that the
    file is not an e-mail message.  If there is no such line, we say...

        patch_format=mbox

One caveat is that the above logic alone won't catch a random file that
does not have _any_ e-mail headers in it.  So you might need to do
something like:

	LF='
        '
	case "$l1$LF$l2$LF$l3" in
        *"$LF$LF"*)
        	# has a completely empty line in there?
                # that means the message has only two headers at most;
                # that cannot be an email.
		;;
	*)
                sed -e '/^$/q' -e '/^[ 	]/d' "$1" |
                grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
                patch_format=mbox
	esac

to completely replace that "for line in..." loop.
