From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 11:31:24 -0800
Message-ID: <7vzlwe1jeb.fsf@gitster.siamese.dyndns.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	<20071213090604.GA12398@artemis.madism.org>
	<20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
	<20071213180347.GE1224@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 20:32:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2tn2-0008Df-HV
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 20:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765152AbXLMTbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 14:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765117AbXLMTbs
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 14:31:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764972AbXLMTbr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 14:31:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AAA547F89;
	Thu, 13 Dec 2007 14:31:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 06BC37DE8;
	Thu, 13 Dec 2007 14:31:30 -0500 (EST)
In-Reply-To: <20071213180347.GE1224@artemis.madism.org> (Pierre Habouzit's
	message of "Thu, 13 Dec 2007 19:03:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68185>

Pierre Habouzit <madcoder@debian.org> writes:

> I thought of that, but it's really convoluted and can definitely lead
> to very subtle issues. The number of git commands with optional
> arguments is quite low, mostly due to legacy, I don't expect _new_
> commands to take optional arguments.

I do not think we want to assume anything like that for a generic API.

> I don't really like the ambiguity
> it creates, and in some cases you just won't be able to disambiguate at
> all. Here it looks nice because --abbrev takes an integer argument, and
> it's likely that no branch nor reference names will be only made of
> digits. Though for commands taking an optional string[0] argument this is
> way more fishy.

I thought about ambiguity issues and I was only 70% sure about my
suggestion.  If you have an object, the initial unique part of whose
name consists only of decimal digits, you could get:

	git describe --abbrev 7 538538538
	git describe --abbrev 538538538 HEAD
	git describe --abbrev 538538538

and the last case needs to be disambiguated (either show HEAD with
abbreviation of 540 million digits, or show that object abbreviated to
the default length).  Because we are discussing a generic "optional
integer with default value" parser, let's not argue that only a small
integer between 0..40 makes sense to --abbrev flag in this context and
we should use that knowledge to further disambiguate [*1*].

You could say "If a flag takes an optional parameter and has a default,
an empty string means use the default", and disambiguate the lat example
in the above this way:

	git describe --abbrev 538538538
	git describe --abbrev '' 538538538

But it is not prettier than always requiring the optional parameter to
be sticked with the flag, as you suggest, like this;

	git describe --abbrev 538538538
	git describe --abbrev=538538538

So I am not entirely opposed to your version, nor I am claiming my
suggestion is better.  However, I just thought that "some parameters you
MUST stick to the flag" might create confusion to the end users, and I
wanted to see if others can come up with a less confusing alternative.
And the way I did so was to keep the discussion going by stirring the
pot a bit.

>   [0] OTOH I'm not sure there will ever be optional arguments that
>       aren't integers in git, but I may be wrong.

We could make HEAD as the default for "git branch --contains", if you
want an example.

[Footnote]

*1* We could introduce "optional integer with valid range with default",
and that would fit naturally into the scheme I outlined.  Even if the
next token parses as an integer, if it is out of range, you can say it
is not yours, and if it has to be yours, you can barf, saying "that's
out of range".

"The valid range" would be useful regardless of disambiguation. I wished
for "only valid is 1 or more" when I adjusted one of the commands to
parse_options().
