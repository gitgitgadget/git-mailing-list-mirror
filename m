From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make --follow support --find-copies-harder.
Date: Tue, 20 Apr 2010 20:05:52 -0700
Message-ID: <7vtyr5cxnz.fsf@alter.siamese.dyndns.org>
References: <1271762875-16548-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 05:06:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4QGS-0004AT-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 05:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab0DUDGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 23:06:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab0DUDGD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 23:06:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0B21ACFC9;
	Tue, 20 Apr 2010 23:06:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1utCifeplrbd4WGtTX9XRFuE4N4=; b=iMWMwz
	xpZn9TCCjks7UVXcCHnpBUmpRpyfu+kq3n14cEnYMzZg40SPTCAa3IbvJROKWvN3
	5ZSTJ9EpRUNWYYz5Sjx6Em3uZWZXKXASs+g9tDD906H/rVAKAammKr33p2BuizUa
	BsGSJi30EJfO/u/+JW4KxOBLUuMMb7rRRdEOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cqip4LBu7Yeqz2oEvfXt4QCPD2RyF7O/
	0a/c2bFpfaT9KMxcAavxguJEw+FOv8DyvZMbK1PcMS0gbMVPHNsV2D4FwuGsRISx
	XwhVt9ysjkvu+qRXRzeI0Uaoi0bvJEV/swXi6w2tDN0JU2RuC5SLu7QcOjQbJI2f
	z1rdOANxkfs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F7AFACFC6;
	Tue, 20 Apr 2010 23:05:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9B5FACFC4; Tue, 20 Apr
 2010 23:05:53 -0400 (EDT)
In-Reply-To: <1271762875-16548-1-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Tue\, 20 Apr 2010 19\:27\:55 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF300F30-4CF2-11DF-8B68-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145404>

Bo Yang <struggleyb.nku@gmail.com> writes:

> 'git diff --follow <commit1> <commit2> <path>' give users
> the content difference of <path> between the two commits.
> It will detect file copies/moves of <path> if there is any.

Because the "--follow" hack was done primarily as a "checkbox" item, and
also because it is not an option for the "diff" family (it is an option
for the "log" family), I would personally think that it is actually a bug
that "git diff" accepts "--follow" and pretends as if it is doing useful
work, but does so only some of the time.

    $ git diff --follow --name-status maint master -- builtin/log.c
    R089	builtin-log.c	builtin/log.c
    $ git diff --follow --name-status -R maint master -- builtin/log.c
    D	builtin/log.c
    $ git diff --follow --name-status master maint -- builtin/log.c
    D	builtin/log.c

As we can see, it doesn't quite work, and it is not a fault of 750f7b6
(Finally implement "git log --follow", 2007-06-19) by Linus, exactly
because the feature wasn't designed to work with "diff" to begin with.

If we were to add a support of "--follow" to "diff" family, I suspect that
we need to

 (1) make sure we get only one path, just like "log" family does;

 (2) add a logic to notice the reverse situation as demonstrated above and
     deal with it in a sensible way, without any --find-copies option
     given by the user.

among other things.  Also we of course need to document it as a new "diff"
option when we are done.
