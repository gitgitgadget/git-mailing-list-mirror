From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] builtin/show: do not prune by pathspec
Date: Mon, 04 Apr 2011 14:49:59 -0700
Message-ID: <7v1v1h8z5k.fsf@alter.siamese.dyndns.org>
References: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
 <cover.1301649372.git.git@drmicha.warpmail.net>
 <6509d23c538dfabd4fac8870d29a69b1dd11a516.1301649372.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 23:50:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6rfC-00015K-2w
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 23:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab1DDVuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 17:50:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1DDVuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 17:50:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7175544D7;
	Mon,  4 Apr 2011 17:52:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fvW3bGYLWmJkG/ilIeOyxfo2hBQ=; b=uvRb3r
	JJnuHF0vFO3FuaVWsa7hzRwtHA5KkVltw6vHWRTPsXJyMlQTaqHpleJ7QEzS33cV
	7VlH3/GOx5mOaM8OD17DCqVyZOHoSKi7X+pxUxFSYFKXGgU6IM3izzCObmedV8Hk
	k+p+IVogVJ7SrY2Dr4pa4z5A+if4XJlpPMJog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xOrYjh/hyyDXcFSiFXDSdYacvupqKuII
	3oXQYIeu6tLq6cKDpi0Ym4xzFiJkRlUsZ2AUPaL/9B6PlYaIRxR+qY7dGX9KRBNd
	BmA1Ri/NOWNwcl+qBcw8zNeGKTjsydq7ohW592MVz2Y1HmZtgdyL4O/RnaXmFQmU
	N0IKxpmt8RI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19D4544D6;
	Mon,  4 Apr 2011 17:52:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3246D44CA; Mon,  4 Apr 2011
 17:51:53 -0400 (EDT)
In-Reply-To: <6509d23c538dfabd4fac8870d29a69b1dd11a516.1301649372.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 1 Apr 2011 11:20:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C542CC80-5F05-11E0-9570-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170839>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index 916019c..474a76d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -420,6 +420,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  	opt.def = "HEAD";
>  	opt.tweak = show_rev_tweak_rev;
>  	cmd_log_init(argc, argv, prefix, &rev, &opt);
> +	if (rev.no_walk)
> +		rev.prune = 0;

This is not your fault, but I am somewhat disgusted by the reason why

    $ git show master..next [ -- Documentation ]

works by "walking" the history.  It takes completely different codepath
from "git log" with the same set of arguments.

 * first log_init() grabs '^master' and 'next' into the rev.pending object
   array;

 * we pop '^master' first, make it the only object in the rev.pending
   object array, and let cmd_log_walk() call prepare_revision_walk() on it
   to limit the list.  Since we don't have any positive ref, we get
   nothing;

 * then we pop 'next', make it again _the only_ object in the rev.pending
   object array; prepare_revision_walk() on the same codepath now limits
   the list to exclude what is reachable from 'master', only because we
   have processed '^master'.

Yikes.  In other words, the reason the current code works is only by
accident.

This is a tangent, but we _might_ want to (perhaps at git 2.0) update the
revision parsing machinery so that we can clear the object flags more
easily and have

    $ git log A..B C..D [ -- pathspec ]

compute the union of (commits reachable from B but not from A) and
(commits reachable from D but not from C).  I say we _might_ because we
would still want to compute what the current code computes in some cases,
and we may be able to express it as "^A ^C B D", but I am not sure if we
want to go that route and end up with a general set operation (with unions
and intersections, perhaps even using parentheses to express precedence).

More general set operation is certainly doable, and at that point it
probably does not matter that we cannot stream the output as we are doing
something complex (IOW, we would be revs->limited, giving up the latency),
but I don't know if it is useful in the first place to support such
general case.  Because the most complex set operations that I run every
day is

    $ git log ^master $topic1 $topic2 $topic3... -- $pathspec

and I don't recall cases in which I wished A..B C..D showed commits
within A..B that are reachable from C.
