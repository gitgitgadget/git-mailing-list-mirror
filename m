From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log --pretty/--oneline: ignore log.decorate
Date: Thu, 08 Apr 2010 10:14:24 -0700
Message-ID: <7vljcx6f4f.fsf@alter.siamese.dyndns.org>
References: <7vtyrr6nes.fsf@alter.siamese.dyndns.org>
 <7vmxxggsl4.fsf@alter.siamese.dyndns.org>
 <20100408073014.GA15474@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Drake <sdrake@xnet.co.nz>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 19:14:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzvJW-0002Le-Gh
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 19:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833Ab0DHROm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 13:14:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653Ab0DHROk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 13:14:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA433A8354;
	Thu,  8 Apr 2010 13:14:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PskieJjVJZR9A032NfjF4vTTR2w=; b=EmpHN7
	xrVbeSWhuJVAnsuSDc2ph1K+mVsDl5Fdux7OmaEa0LfdfZzf/z1K2twnkmh7cCwm
	HS8UpoVD3jgYP6HGB/qazyhOQ3WUjkMo8mjz5agppcwdYyq37029r/6Sp/BlIcE0
	YEE95D4BPn+MkmzBZlwkIicqylZ5+MP4ChD0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YcVwXyl1a7d/pduVcrmKxOJHsUQl1jlw
	suRC/3RX9NYQ1PTMw4ehFcLgJzYdv8jjMVS+Otlt6lgM7pUpjSPEc1i6YhC5ueLb
	YB/Bb9sxu+lvkwEftrDlA5thdgm/7pcdnpURji54rVA7fOHsljeeT+sUCCosvmRj
	GRTuqyPQ9vc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78ECEA8353;
	Thu,  8 Apr 2010 13:14:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88D7EA834A; Thu,  8 Apr
 2010 13:14:27 -0400 (EDT)
In-Reply-To: <20100408073014.GA15474@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 8 Apr 2010 03\:30\:14 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35363022-4332-11DF-9D50-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144365>

Jeff King <peff@peff.net> writes:

>> > * sd/log-decorate (2010-02-17) 3 commits
>> >   (merged to 'next' on 2010-03-08 at 58a6fba)
>> >  + log.decorate: usability fixes
>> >  + Add `log.decorate' configuration variable.
>> >  + git_config_maybe_bool()
>> >
>> > Needs squelching the configuration setting when "--pretty=raw" is given,
>> > at least, or possibly when any "--pretty" is explicitly given.
>> 
>> This is necessary if we want to let users specify log.decorate and still
>> use gitk.  A patch should look like this (of course untested).
>
> Hmm. You took the "any --pretty" option with this patch.

Yeah, I considered to further narrow it down to the --pretty=raw case;
because that is not something we do for the default --show-notes, I opted
for consistency.  But a decoration and notes are quite different, and
such a consistency perhaps is not worth it.  How about this on top?

-- >8 --
Subject: log: only "--pretty=raw" defeats log.decorate from the command line

Unlike notes that are often multi-line and disrupting to be placed in many
output formats, a decoration is designed to be a small token that can be
tacked after an existing line of the output where a commit object name sits.

Disabling log.decorate for something like "log --oneline" would defeat the
purpose of the configuration.

We _might_ want to change it further in the future to force scripts that
do not want to be broken by random end user configurations to explicitly
say "log --no-decorate", but that would be an incompatible change that
needs the usual multi-release-cycle deprecation process.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-log.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 7f4186f..017fcf8 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -108,10 +108,11 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	}
 
 	/*
-	 * defeat log.decorate configuration interacting with --pretty
+	 * defeat log.decorate configuration interacting with --pretty=raw
 	 * from the command line.
 	 */
-	if (!decoration_given && rev->pretty_given)
+	if (!decoration_given && rev->pretty_given
+	    && rev->commit_format == CMIT_FMT_RAW)
 		decoration_style = 0;
 
 	if (decoration_style) {
