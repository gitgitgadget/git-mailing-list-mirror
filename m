From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: catch garbage after marks in from/merge
Date: Mon, 02 Apr 2012 09:15:32 -0700
Message-ID: <7v398mhzyz.fsf@alter.siamese.dyndns.org>
References: <20120401225407.GA12127@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:15:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEjux-0000P2-HS
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab2DBQPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 12:15:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988Ab2DBQPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 12:15:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 871DE7EFF;
	Mon,  2 Apr 2012 12:15:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z4PZkh59aG2jo2hUQJpIErsiTW4=; b=xO4ECu
	9X8L4naQj14aBVdmCCxKNFbUqlK2Y2OZDy8CPdnRuKPzMkjTl5VTx8MWqBKrWjil
	icCmVtqTf/Po2TKOZE+TUKq3rgx+VfD0JQOzvAclTggsxf2pxcXuWhV7F6oJ/Gcb
	7k7cZz5nxN6dYto4GtEHOaBiI+StkpoJMXtNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yRU0w27wOG+wRQnAqq8NtxNrtoBLhHoh
	a+ldZWHNuXMR7UYQwKQA3shtV9blXK3DIPFtrI8ElZFgduV84g3rIlexiG7UmBmD
	N9p2/TlwVuW+L6Eu8yNX9IrPl0WOy0G8hLiQvxmUTg9ow5gm48qGD8GWge5zTzPQ
	GS6V/erNNOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E82B7EFE;
	Mon,  2 Apr 2012 12:15:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBF4D7EFD; Mon,  2 Apr 2012
 12:15:33 -0400 (EDT)
In-Reply-To: <20120401225407.GA12127@padd.com> (Pete Wyckoff's message of
 "Sun, 1 Apr 2012 18:54:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13377498-7CDF-11E1-929B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194526>

Pete Wyckoff <pw@padd.com> writes:

> A forgotten LF can lead to a confusing bug.  The last
> line in this commit command is wrong:
> ...
> It is missing a newline and should be:
>
>     from :1
>     M 100644 :103 hello.c

During my first reading of this, this introductory part made me think "oh,
so this is a patch to fix somebody who produces a wrong data that is fed
to fast-import".  But it does not seem to be the case.

Please rephrase the first sentence.  Is it a confusing _bug_, or the
program produces a garbage output when fed a garbage output?

> Make fast-import complain about the buggy input, for both
> from and merge lines that use marks.

Perhaps these two lines, negated to state the current behaviour e.g. "git
fast-import does not complain when a mark that is used in 'from' or
'merge' command to name a commit is not followed by the mandatory LF." can
be used to replace the first sentence, followed by "It does X" to describe
the user-observable breakage for a bonus point.

> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
> I spent too long tracking down the bug described in the
> commit message.  It might help future users if fast-import
> were to complain in this case.

It would help future users if the commit log actually described the
symptom caused by the bug; otherwise, future users would not notice when
hitting the same issue.

> diff --git a/fast-import.c b/fast-import.c
> index a85275d..13001bb 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2537,8 +2537,16 @@ static int parse_from(struct branch *b)
>  		hashcpy(b->branch_tree.versions[0].sha1, t);
>  		hashcpy(b->branch_tree.versions[1].sha1, t);
>  	} else if (*from == ':') {
> -		uintmax_t idnum = strtoumax(from + 1, NULL, 10);
> -		struct object_entry *oe = find_mark(idnum);
> +		char *eptr;
> +		uintmax_t idnum = strtoumax(from + 1, &eptr, 10);
> +		struct object_entry *oe;
> +		if (eptr) {
> +			for (; *eptr && isspace(*eptr); eptr++) ;

Put the empty body on a separate line, i.e.

			for ( ; isspace(*eptr); eptr++)
				; /* nothing */

> +			if (*eptr)
> +				die("Garbage after mark: %s",
> +				    command_buf.buf);

Good.

> +		}
> +		oe = find_mark(idnum);
>  		if (oe->type != OBJ_COMMIT)
>  			die("Mark :%" PRIuMAX " not a commit", idnum);

Would it help future callers if you made this small part that parses a
mark into a separate small helper function that returns an oe and
increment the pointer so that the caller can peek at the terminating
character to enforce the syntax?  E.g.

	} else if (*from == ':') {
		char *cp = from + 1;
		struct object_entry *oe = parse_mark(&cp);
		if (*cp)
			die("Garbage after mark: %s", command_buf.buf);
                if (!oe || oe->type != OBJ_COMMIT)
                	die("No such commit: %s", command_buf.buf);
	}
