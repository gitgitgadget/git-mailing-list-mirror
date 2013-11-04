From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Mon, 04 Nov 2013 11:02:29 -0800
Message-ID: <xmqqli14yoqi.fsf@gitster.dls.corp.google.com>
References: <20131103211731.15716.95056.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Nov 04 20:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdPQ6-0005mx-KO
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 20:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab3KDTCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 14:02:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38287 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484Ab3KDTCd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 14:02:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2FEF4E6FA;
	Mon,  4 Nov 2013 14:02:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oqxH6YT8VY8GFC3P+MhB12J1wMY=; b=uzzpIn
	N3EsZDXWh6HgRVWQv0hmv7iGI7jTKWelxMWZNWbckUc0EzYvtZrsRWslEdACmRgC
	JE1U+StxnpksomvqtjTPn8mB9ZATJDUtN/mwA7ib67NzTMGpxM0aXyIQ4+cjALyz
	fHvyDwhib+AXM1GKyG1PkkAJLEwDB14Ojqe6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QgIwdiJIQa8u1JiNlO4NJVnK4e41UyC7
	vu/60a7VHBCSpaS1AoENZfrJj/XbgvSUwmYJByD1GtBNVNhuCl8vCF6M3k7Pvi/6
	FCIsELg14v8gt42C/gON1nRjb12nzclG+8IvsKBzZNH5DiqUuS4KQwFk7SfcU2rs
	5S4BEHD7BBA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 908CB4E6F9;
	Mon,  4 Nov 2013 14:02:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C66D84E6E2;
	Mon,  4 Nov 2013 14:02:30 -0500 (EST)
In-Reply-To: <20131103211731.15716.95056.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 03 Nov 2013 22:17:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A7C40DEC-4583-11E3-95D9-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237296>

Christian Couder <chriscool@tuxfamily.org> writes:

> This RFC patch shows the work in progress to implement a new
> command:
>
> 	git interpret-trailers
>
> 1) Rational:
>
> This command should help with RFC 822 style headers, called
> "trailers", that are found at the end of commit messages.
>
> For a long time, these trailers have become a de facto standard
> way to add helpful information into commit messages.
>
> Until now git commit has only supported the well known
> "Signed-off-by: " trailer, that is used by many projects like
> the Linux kernel and Git.
>
> It is better to implement features for these trailers in a new
> command rather than in builtin/commit.c, because this way the
> prepare-commit-msg and commit-msg hooks can reuse this command.
>
> 2) Current state:
>
> Currently the usage string of this command is:
>
> git interpret-trailers [--trim-empty] [--infile=file] [<token[=value]>...]
>
> The following features are implemented:
> 	- the result is printed on stdout
> 	- the [<token[=value]>...] arguments are interpreted
> 	- a commit message passed using the "--infile=file" option is interpreted
> 	- the "trailer.<token>.value" options in the config are interpreted
>
> The following features are planned but not yet implemented:
> 	- some documentation
> 	- more tests
> 	- the "trailer.<token>.if_exist" config option
> 	- the "trailer.<token>.if_missing" config option
> 	- the "trailer.<token>.command" config option
>
> 3) Notes:
>
> * "trailer" seems better than "commitTrailer" as the config key because
> it looks like all the config keys are lower case and "committrailer" is not
> very readable.

And closes the door for other things from later acquiring trailers?

> * "trailer.<token>.value" looks better than "trailer.<token>.trailer", so
> I chose the former.

If that is a literal value, then I think ".value" is indeed good.

> * Rather than only one "trailer.<token>.style" config option, it seems
> better to me to have both "trailer.<token>.if_exist" and
> "trailer.<token>.if_missing".

As there is no ".if_exist", ".if_missing", etc. here, I cannot guess
what these "seemingly independent and orthogonal, but some
combinations are impossible" configuration variables are meant to be
used, let alone agreeing to the above claim that they are better
than a single ".style".  I think you took the ".style" from my
thinking-aloud message the other day, but that aloud-thinking lead
to ".style" by taking various use cases people wanted to have
footers into account, including:

 - just appending, allowing duplication of the field name (e.g. more
   than one "cc:" can name different recipients);

 - appending, allowing duplication of the field <name,val> pair
   (e.g. a patch that flowed from person A to B and possibly
   somewhere else then finally back to A may have "Signed-off-by:
   A", chain of other's Sob, and another "Signed-off-by: A");

 - appending, but without consecutive repeats (e.g. the same
   "Signed-off-by:" example; person A does not pass a patch to
   himself, adding two same <name,val> pair next to each other);

 - adding only if there is no same <name> (e.g. "Change-Id:");

 - adding only if there is no <name,val> pair (e.g. "Closes: #bugId");

 - adding one if there is none, replacing one if there already is.

I do not think it is easier for users to express these (and other)
semantics as combinations of "seemingly independent and orthogonal,
but some combinations are impossible" configuration variables.

> * I might send a patch series instead of just one big patch when there will
> be fewer big changes in the code.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  .gitignore                    |   1 +
>  Makefile                      |   1 +
>  builtin.h                     |   1 +
>  builtin/interpret-trailers.c  | 284 ++++++++++++++++++++++++++++++++++++++++++
>  git.c                         |   1 +
>  strbuf.c                      |   7 ++
>  strbuf.h                      |   1 +

I think you're better off having trailers.c at the top level that is
called from builtin/interpret-trailers.c (aside from names), so that
we can later hook the former up with builtin/commit.c codepath.
