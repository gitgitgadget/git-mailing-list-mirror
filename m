From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Sun, 02 Sep 2012 13:41:24 -0700
Message-ID: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-10-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:44:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8H2O-00008J-Ma
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 22:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab2IBUot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 16:44:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900Ab2IBUor (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 16:44:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6E628337;
	Sun,  2 Sep 2012 16:44:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=eU204V5hTADZSQBZuT3TLM3L3uw=; b=wvzTCcXoPinRF8LI1CRo
	qJ+O0FFK904rdPf1izaARGNfcLH4i/qTRTqXg0S05FfsnHX9sQMIIwe5inUT3jnW
	ocSorwQjred1R3o2teDHl/BsXJhEJalG/pVl+Yjft596cYWyjut4S145JTyt6iMe
	SedgBVbIFdLjb2FdTv8QKXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=N+fB77cr/HF31+Y+4fZh9CRt1MLvgpoLSeKhyI1DUl+aRM
	BSc2OCQ5My+fhE60lvyV+y/KZvEAE/QZhCMS4ZGNYyfFQWxPSqJ2/IG1dK4skodL
	3tsUQ16YBMXvR6o5RFYL5ZE8ylCidvSZfuE97GeDqq9gP6OMut8Wy8zGnVISE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D30228336;
	Sun,  2 Sep 2012 16:44:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0D198334; Sun,  2 Sep 2012
 16:44:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07C553C2-F53F-11E1-AA21-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204674>

Adam Spiers <git@adamspiers.org> writes:

> +OPTIONS
> +-------
> +--stdin::
> +	Read file names from stdin instead of from the command-line.
> +
> +-z::
> +	Only meaningful with `--stdin`; paths are separated with a
> +	NUL character instead of a linefeed character.

On input, or on output, or both?

The answer should be "both", otherwise you cannot safely handle
paths with funny character in your script, even if you wanted to.
Which means that this cannot only be meaningful with "--stdin", I
think.

> +OUTPUT
> +------
> +
> +The output is a series of lines of the form:
> +
> +<path> COLON SP <type> SP <pattern> SP <source> SP <position> LF
> +
> +<path> is the path of a file being queried, <type> is either
> +'excluded' or 'included' (for patterns prefixed with '!'), <pattern>
> +is the matching pattern, <source> is the pattern's source file (either
> +as an absolute path or relative to the repository root), and
> +<position> is the position of the pattern within that source.

Let's step back a bit and think what this command is about.  What is
the reason why the user wants to run "check-ignore $path" in the
first place?  I think there are two (or three, depending on how you
count).

 (1) You have one (or more) paths at hand.  You want to know if it
     is (or some of them are) ignored, but you do not particularly
     care how they are ignored.  Think of implementing your own "git
     add" as a script.

 (2) You have one or more paths that are ignored but do not want
     them to be, and want to find out why they are.  

For the former, your script may want to see the paths sifted into
"ignored" bin and "not-ignored" bin, so

	git check-ignore [-z] --name-only $paths

that gives you only the paths without any reason is more useful.
You also may want the opposite (show only paths not ignored), but
that can be computed easily by the script, so it is of lessor
importance.

For the latter, you are debugging the set of exclude sources and
want to learn where the decision to exclude it comes from.  For that
kind of use, it would be more useful if the output mimicked error
messages from the compilers and output from "grep -n" to show the
source, e.g.

	.gitignore:13:/git-am	git-am

Emacs users can use "M-x grep<RET>git check-ignore -v git-am<RET>",
see the output, and find the hit in its output (I would imagine vim
would have a similar feature).  The output format would be something
like:

	<source> <COLON> <linenum> <COLON> <pattern> <HT> <pathname>

I do not think you need excluded/included <type> as a separate item
in the non "-z" output, as it should be clear from the <pattern>.
Substitute "<cmdline>" (literally) as source for patterns obtained
from the command line.

I would also suggest to

 (1) make --name-only the default (i.e. no need to have the
     "--name-only" option);

 (2) give the version that mimicks "grep -n" when "-v|--verbose" is
     given; and

 (3) support "--quiet"; the command would exit with status 0 if
     _any_ of the paths given is ignored, or status 1 if none of the
     paths is ignored (or error out with die() when --quiet and
     multiple paths are given).

Regarding "-z" (for script consumption), I do not object to the
broken down format, e.g., "check-ignore -z -v" may give a sequence
of

    <pathname> NUL <type> NUL <pattern> NUL <source> NUL <position> NUL

while "check-ignore -z" would give a sequence of

    <pathname> NUL
