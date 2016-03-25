From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/5] submodule--helper clone: lose the extra prefix option
Date: Fri, 25 Mar 2016 13:54:59 -0700
Message-ID: <xmqq60wa2s7w.fsf@gitster.mtv.corp.google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
	<1458931156-29125-6-git-send-email-sbeller@google.com>
	<xmqqfuve2vln.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, Jens.Lehmann@web.de,
	jacob.keller@gmail.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 21:55:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajYlF-0006iX-Cj
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 21:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbcCYUzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 16:55:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753321AbcCYUzF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 16:55:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BF2D4E6D1;
	Fri, 25 Mar 2016 16:55:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tt0fj4d8itseLfh7ZzejMbEE/E4=; b=INyeOF
	LCx6+1doWt/FFR8gZTK7RlrPqaJMLoJOMCC3ku68JMTjXgySrSXhKtAjkm2yUa0g
	pTHFLLKkWGc0x2eZ0ES1l8vtxkOmVRzs50aEF3HV8ZmkzCnSKk5srxOj1clB9qs0
	Gp5B14k4CdjKTs/wsleGSPeIn/84SIqlDc8Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pa5YbHnVERt3M01rBeu5ddM2lsMVgksE
	FKcnsb+iE+TZY9hg0uA3QAuiKzsbPo36J9N6tS0Cqk7X9y2wmhKmle4lQwjTFQwN
	KrZm+tsVXs9JItDtzxRIaPX08S565hT4EogFgDyldRcqWKK6kveMuUaNe2URYDRO
	DrbKHFpgh1g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA97B4E6CA;
	Fri, 25 Mar 2016 16:55:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AD5DB4E6C9;
	Fri, 25 Mar 2016 16:55:00 -0400 (EDT)
In-Reply-To: <xmqqfuve2vln.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 25 Mar 2016 12:41:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D73AB132-F2CB-11E5-8B80-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289951>

Junio C Hamano <gitster@pobox.com> writes:

> This helper is called from the root level of the superproject's
> working tree (after cd_to_toplevel is done), and has options like
> --url.  If the user named --url with a relative pathname to a local
> repository directory (or a bundle file), shouldn't it be adjusted,
> and wouldn't prefix the only clue what that given path is relative
> to?  Same for --reference repository's path.
>
> I am not sure removing "--prefix=$wt_prefix" without doing "git -C
> $wt_prefix" on the calling side is the right thing to do.  Even
> though the options list used by this function does not seem to use
> OPTION_FILENAME, parse-options API takes prefix exactly because
> relative pathnames need to be adjusted, and it smells like that the
> breakage brought in by this change is merely hidden by existing bugs
> in the code that does not use prefix to adjust relative paths.

As you may be able to guess from the above, I do not fundamentally
oppose to using "-C $wt_prefix" in place of "--prefix $wt_prefix".

These two should be equivalent, from the callers' point of view.

If you use the "--prefix $wt_prefix" thing, then the called program,
which starts at the root level of the working tree, just overrides
the prefix that it would get from the caller, as "prefix" its own
startup sequence computes when it is invoked by its caller is not
useful for adjusting the things that are relative to the directory
the caller originally was invoked at.

The resulting behaviour should be as if the called program were
originally started inside $wt_prefix directory, the start-up
sequence crawled up the directory hierarchy to find the root level
of the working tree and derived $wt_prefix as the prefix that is
given as the third parameter of any builtin cmd_foo().

And that is what would happen if you used "git -C $wt_prefix" to run
the program.  So "git -C $wt_prefix" should be functionally
equivalent to "--prefix $wt_prefix", even though the former is less
efficient by having to do the discovery and series of chdir(2) only
to discover the prefix the caller already has.

What bugs me the most is that, even though they should be
equivalent, you need 1/5 (or 1&2 in the old series) only when you
use "git -C $wt_prefix" but not "--prefix $wt_prefix".  That means
that they are not equivalent.  And it is not clear why, i.e. where
they differ.

It could be that the way "--prefix $wt_prefix" work is insufficient
and "git -C $wt_prefix" does more complete job, and the codepath
that implements "--prefix $wt_prefix" needs to do more to become
truly equivalent.  If that is a case, it means that there is a bug
in "--prefix $wt_prefix" codepath and the callers of the program may
be compensating for the bug by doing wrong things in order to work
around the bug.  When switching to "git -C $wt_prefix", you may be
seeing the effect of these wrong things the callers do, exposed as
bugs that need to be fixed with 1/5 (or 1&2 in the old series).

And I'd want to see the log message explain how the two ways are not
equivalent and what "--prefix $wt_prefix" and the current callers
that use that mechanism get wrong.
