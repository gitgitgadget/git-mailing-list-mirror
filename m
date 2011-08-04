From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fix has_action
Date: Thu, 04 Aug 2011 12:34:19 -0700
Message-ID: <7vliv93r9g.fsf@alter.siamese.dyndns.org>
References: <1312450780-5021-1-git-send-email-nrubinstein@proformatique.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Noe Rubinstein <nrubinstein@proformatique.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 21:34:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp3gb-0004pT-VN
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 21:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab1HDTeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 15:34:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760Ab1HDTeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 15:34:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7EFA4865;
	Thu,  4 Aug 2011 15:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q/xfr3FRwnl/sIzvjpjXDCgdfHg=; b=G6iXjN
	D/Kb5NsCkkk+MoH0NuztVShG+UfhALPWcZw0Jf9JOkh1TmitCna0/z0fYxLTJ08w
	sDS25rzT9p1wUKWbYc86xEwzs8Pe4enwOllGzkTEedw00Jxr+A+bq+/hYe9LnIeH
	qDuqd6LtZUUZA4s00RpIdZGdaH4+Ko9/JESkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AywQWXbeDCX0Xho2Yl3HK3GHIH7vSyZ8
	D/QXEnqxx+Vpc1c1dfiEO80VSdma9gluqniQHGLPF17nqYCZKfUuMKuG+5WzvY/U
	NwipE/TvyOZWzx2G4a8Ygt7UE0J2uO/rPRQqG68r678nLj9Ha/gQ5IcSxnMuQO5l
	cD2YTz3iI2c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFA914864;
	Thu,  4 Aug 2011 15:34:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F05F4863; Thu,  4 Aug 2011
 15:34:21 -0400 (EDT)
In-Reply-To: <1312450780-5021-1-git-send-email-nrubinstein@proformatique.com>
 (Noe Rubinstein's message of "Thu, 4 Aug 2011 11:39:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C08C15AE-BED0-11E0-A0D9-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178765>

Noe Rubinstein <nrubinstein@proformatique.com> writes:

> When doing git rebase -i, removing all actions in the todo list is
> supposed to result in aborting the rebase.

I thought it was meant to be more like "removing all _lines_", and the
grep was a half-assed attempt to ignore lines that are clearly comments.
Checking the size of the insn sheet might be a better change in that
sense, as that would not leave any ambiguity:

	has_action () {
	  test -s "$1"
	}

> This patch fixes the bug by changing has_action to grep any line
> containing anything that is not a space nor a #.

First of all, I do not think it is a "fixes the bug". I can buy "makes
things safer by detecting user errors", of course.

More importantly, I do not think you are grepping "any line containing
anything that is not a space nor a hash". You are instead grepping lines
that do not begin with a hash or a whitespace, no?

>  has_action () {
> -	sane_grep '^[^#]' "$1" >/dev/null
> +	sane_grep '^[^#[:space:]]' "$1" >/dev/null
>  }

We tend to avoid [:character class:] to accomodate older implementations
of grep.

We earlier asked "do we have any line that begins with a character that is
not a hash '#'?"  but now we say "do we have any line that begins with a
character that is not a hash nor a space?".

If a user fat-fingers an unnecessary space into a blank line, that line
certainly will be excluded. But if the user fat-fingers ^X^I (or >> for vi
users), all lines begin with whitespace and they now get ignored?

How about removing the unnecessary negation from the logic and directly
ask what we really want to know?

That is, "Do we have a line that is _not_ comment?"

	has_action () {
          sane_grep -v -e '^#' -e '^[   ]*$' "$1" >/dev/null
	}

Hmm?
