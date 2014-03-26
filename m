From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 00/12] Add interpret-trailers builtin
Date: Wed, 26 Mar 2014 16:05:55 -0700
Message-ID: <xmqq4n2kh86k.fsf@gitster.dls.corp.google.com>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 00:06:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSwuB-00074F-7l
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 00:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876AbaCZXGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 19:06:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861AbaCZXF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 19:05:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 256E078F65;
	Wed, 26 Mar 2014 19:05:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=yFIE9AlydWF8xZsXUOKZIB0gnkA=; b=U+YNLfWefIAQjJa0mRu2
	JiVllnx5d/e/IXKyiss50Kjj0mQq5eE2PhhNSCvKeft9S//ivin/nwDKEY6GyEqv
	5WD1gg0JP1gCpIyvjGdzFLKopJv78waKDMccOlnKmwenzwp8krRflkPgHqmMgIc+
	y+mVPvcSGMzmOLaAEmdTH7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=miiQBagE3lFVGJCsYV8Iuuwd2nSHbAeFEVyML91SjliVdg
	WjQ1Az5fFaF9+TXNU878j+WA89G6fI+LSdtp3chvTZEbd60vUr86lmVmfOUnSgSC
	HOl4WtGSHWmeoBYvav95nGQB2NlBtbednqfrxPGnTfVZjyBXWLK1MjXHQ22+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F48778F64;
	Wed, 26 Mar 2014 19:05:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BDB078F61;
	Wed, 26 Mar 2014 19:05:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 310E0F04-B53B-11E3-AC25-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245253>

Christian Couder <chriscool@tuxfamily.org> writes:

> Until now git commit has only supported the well known
> "Signed-off-by: " trailer, that is used by many projects like
> the Linux kernel and Git.
>
> It is better to implement features for these trailers first in a
> new command rather than in builtin/commit.c, because this way the
> prepare-commit-msg and commit-msg hooks can reuse this command.

The "first" is somewhat questionable.

It is better to keep builtin/commit.c uncontaminated by any more
hard-wired logic, like what we have for the signed-off-by line.  Any
new things can and should be doable in hooks, and this filter would
help writing these hooks.

And that is why the design goal of the filter is to make it at least
as powerful as the built-in logic we have for signed-off-by lines;
that would allow us to later eject the hard-wired logic for
signed-off-by line from the main codepath, if/when we wanted to.

Alternatively, we could build a library-ish API around this filter
code and replace the hard-wired logic for signed-off-by line with a
call into that API, if/when we wanted to, but that requires (in
addition to the "at least as powerful as the built-in logic") that
the implementation of this stand-alone filter can be cleanly made
into a reusable library, so that is a bit higher bar to cross than
"everything can be doable with hooks" alternative.

> 3) Changes since version 7, thanks to Junio:
>
> * improved handling of empty trailer token
> * clearer way to create 'expected' files in tests
> * other small test cleanups
> * improved commit message
> * new way to parse config keys
> * strcasecmp() is not used anymore in some config related functions

It is unclear which of the 12 patches are unchanged since the last
round.  Are reviewers expected to re-read all of them?

> Some values from the config file are lowercased instead.
> To enable that a new patch (3/12) is introduced to rationalize
> lowercase related functions. I am not very happy with these
> changes.

I can see why you are not very happy.  Perhaps it may make you
happier if you did not move lowercase() at all, did the
xstrdup_tolower() in a cleaner and more efficient way, and only used
the latter in the code?
