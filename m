From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] t4059: rewrite to be adaptive to hunk filtering
Date: Sat, 11 Apr 2015 22:48:22 -0700
Message-ID: <xmqq61916gnt.fsf@gitster.dls.corp.google.com>
References: <1428006853-21212-1-git-send-email-max@max630.net>
	<1428076716-4449-1-git-send-email-max@max630.net>
	<1428076716-4449-5-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Apr 12 07:48:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhAkv-0005NI-P4
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 07:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbbDLFsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 01:48:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750802AbbDLFsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 01:48:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC31048EB0;
	Sun, 12 Apr 2015 01:48:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6lg/azSPAGmmdqph2twnvfr1Wu0=; b=gmNHg0
	L20EEC8RqtVc+RV3Pky8Eq90I5qh1cdXtdYixjIV2/KP/MSOO1aTGgE3dkCrXgV2
	sPVWc1yLJLTJIn+HqW7k/TH6dsz7fzxe7r+xi2F5xp1Qqe51bhv80qfw37YBOGtt
	0T1Z5iuBUkO5I3r38pCZKarf6udcZBGAv1hOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lQ4EbYoTEppHFIgu8CJgbKo10d3hgDy1
	dm8okC0akc4lcNDWlPwrXROhe/sMLmAUZf8yzu49Gj/ofbKQ/DIMd7uqI2JQ58Q7
	t5O598H9yAWiCaPnvk7zf9ovflYf3q44lZYKGmk7nCRWVB5/TXtLChFQqkhUo6GG
	JhEFvTxYKEA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4FF548EAF;
	Sun, 12 Apr 2015 01:48:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37C6848EAD;
	Sun, 12 Apr 2015 01:48:23 -0400 (EDT)
In-Reply-To: <1428076716-4449-5-git-send-email-max@max630.net> (Max Kirillov's
	message of "Fri, 3 Apr 2015 18:58:36 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8803026A-E0D7-11E4-8067-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267038>

Max Kirillov <max@max630.net> writes:

> Looks like there is no exact specification what `diff -c` and
> `diff --cc` should output. Considering this it is not reasonable to
> hardcode any specific output in test.

OK.

> Rather, it should verify that file
> selection behaves the same as hunk selection.

Hrm, really?  "git diff --raw" and "git diff -p -w" on two trees
would not show identical set of paths, when the blob object are
different byte-wise but are equivalent at the content level per
given definition of equivalence (e.g. "-w").  Given that --cc is
to look at the differences at hunk/content level to combine and omit
uninteresting ones from the output, relative to -c output, I would
imagine that the file selection and the hunk selection are expected
to behave differently.

So, having said that I am a bit skeptical about the description of
the goals, there are a few nits on the implementation, too.

> +# the difference in short file must be returned if and only if it is shown in long file
> +for fn in win1 win2 merge delete base only1 only2 only1discard only2discard; do
> +	if git diff --cc merge branch1 branch2 mergebase -- long/$fn | grep -q '^[ +-]\{3\}2\(change[12]|merge\)\?$'
> +	then

Just like the earlier parts of this patch, write a newline when you
do not have to write a semicolon, and split lines after pipe when
your pipeline gets long, i.e.

	for fn in win2 win2 ...
        do
		if git diff --cc ... |
			grep 'pattern'
		then

Do I smell some GNUism in your "grep" patterns?

You have

    '^[ +-]\{3\}2\(change[12]|merge\)\?$'

but matching zero-or-one repetition with ? is not in BRE, and \? to
use it in BRE is a GNU extension.

Also in BRE , '|' is not an alternation (and making it into such
with '\|' in BRE is a GNU extension IIRC.

Worse, you are not using backslash here to invoke GNU extension, so
I suspect the grep invocations in the patch may not be working as
you expect.

Doubly worse, what is shown by "diff -c" for line 2 seems to be
three [- +] columns, followed by one of

    2
    2change1
    2change2
    2merged

followed by the end of line, so your "|merge" part may never match.

We encourage people to avoid \{m,n\}, because, it is not supported
by some implementations even though it is specified in POSIX for
BRE.

Perhaps spelling out what you are expecting a bit more explicitly,
e.g.

	grep -e "^[-+ ][-+ ][-+ ]2$" \
             -e "^[-+ ][-+ ][-+ ]2change[12]$" \
             -e "^[-+ ][-+ ][-+ ]2merged$"

might be a reasonable way to write this in a more portable and
readable way.  And turn that into a helper shell function to make it
more readable and maintainable for a bonus point.

Thanks.
