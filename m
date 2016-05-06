From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] exec_cmd.c, sideband.c, Makefile: avoid multiple PREFIX definitions
Date: Fri, 06 May 2016 09:55:11 -0700
Message-ID: <xmqqd1oz5dow.fsf@gitster.mtv.corp.google.com>
References: <1462483733-3496-1-git-send-email-philipoakley@iee.org>
	<1462483733-3496-2-git-send-email-philipoakley@iee.org>
	<xmqqk2j89n9y.fsf@gitster.mtv.corp.google.com>
	<1C7D96C1B53D45CCAA8658C9DBB1AAB5@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "GitList" <git@vger.kernel.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri May 06 18:55:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayj2A-00070R-KL
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758612AbcEFQzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:55:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758028AbcEFQzP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 12:55:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0E3618CF5;
	Fri,  6 May 2016 12:55:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N+SmCg8ZsS6LoqeiAqqvAr5nObk=; b=hh4tLY
	n3eDkzQL+2Hx9tqgW3cbwcW/j7ZxltTbPpN7ESVpC+p+ut3jiP1GJfPx4cDjgc6W
	l4VquYXMSilyizIdpYnWe6jlSQAoUuld8EYJExF0OvbFhEXUb12Ml5tn0PWIGbVt
	fHLSCUKbG1N5FIP/NpbbcvAXU/qD5z192Dnkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nBHd/DJImZKWUNkTEq8IyDfMgWvAyiAo
	ljeCUTh6XViQqId00NegPv8LviLAVWua9WYZbuzl+33YgDRavEtycmwo+XoGGXBo
	LPKul0jCAVKfrdCgNarTsJcuUs1ckjLXXg1e9s348vEpm5jPDleqRmXUIL6Ctw4T
	GD+8FvrrF7M=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A905818CF4;
	Fri,  6 May 2016 12:55:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4005E18CF3;
	Fri,  6 May 2016 12:55:13 -0400 (EDT)
In-Reply-To: <1C7D96C1B53D45CCAA8658C9DBB1AAB5@PhilipOakley> (Philip Oakley's
	message of "Fri, 6 May 2016 08:23:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4CF368D8-13AB-11E6-9FCB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293831>

Dropped "git-for-windows" <git-for-windows@googlegroups.com> from
the Cc: list, as I seem to be getting bounces from it due to its
moderation policy.

"Philip Oakley" <philipoakley@iee.org> writes:

> Perhaps EXEC_CMD_PREFIX, for that is what it is?

That name is doubly wrong, I have to say.

This is used only after RUNTIME_PREFIX heuristics to learn the
binary location from argv[0] fails, or the result of it does not
have expected suffix string (i.e. GIT_EXEC_PATH . BINDIR . "git").
The code even says this:

	if (!prefix &&
	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
		prefix = PREFIX;
		trace_printf("RUNTIME_PREFIX requested, "
				"but prefix computation failed.  "
				"Using static fallback '%s'.\n", prefix);
	}

Notice "static fallback" there?

I have a very strong preference for the name to reflect that fact.
I.e.  send a signal to those who do not use RUNTIME_PREFIX
configuration that they do not have to care.

Also "EXEC" is wrong, too.  The way the 'prefix' variable we see
above is used is that system_path() takes a directory path to
various installed component of the Git package, e.g. GIT_MAN_PATH
is the location for manual pages, as its "path" parameter, and
then 

	strbuf_addf(&d, "%s/%s", prefix, path);

is used to formulate the absolute path for it.  A name with "EXEC"
in it would incorrectly hint that it points at a rough equivalent to
/usr/local/bin/ or /usr/local/libexec/git/, but PREFIX corresponds
more to /usr/local/.

Even if J6t's point about these two separate PREFIXes should never
exist at the same time is correct, I think it is a good change to
use a more explicit name for this variable that is used to
communicate between Makefile and the *.c source.

As to your "RUNTIME_PREFIX_FALLBACK is very long" objection, I do
not care ;-) More seriously, this is not something typed very often.
It appears only twice in this codepath and having clear names to
tell readers what it is about is much more important.

I do agree the most logical name, after understanding all of the
above, which is RUNTIME_PREFIX_STATIC_FALLBACK, may be a bit too
long, though.
