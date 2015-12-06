From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Sat, 05 Dec 2015 19:51:03 -0800
Message-ID: <xmqqr3j0nsk8.fsf@gitster.mtv.corp.google.com>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
	<20151202005338.GD28197@sigill.intra.peff.net>
	<xmqq37vl7fux.fsf@gitster.mtv.corp.google.com>
	<20151202024403.GA29329@sigill.intra.peff.net>
	<xmqqlh9c6byy.fsf@gitster.mtv.corp.google.com>
	<20151202164712.GA16636@sigill.intra.peff.net>
	<xmqqd1uo69vf.fsf@gitster.mtv.corp.google.com>
	<20151202175144.GA18550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: James <rouzier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 04:51:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5QM5-0005uM-RK
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 04:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbbLFDvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 22:51:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754034AbbLFDvN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 22:51:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6D69302F9;
	Sat,  5 Dec 2015 22:51:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U7v0uLaV+4VCk/raYmLdBzvWICw=; b=duvQEb
	87ue/+0wjW12GT9J0NgLybk+AT3BlXgzL1E+HQxe9MowdoaDj3flTJ2LUZI2oW3h
	BGkeWWbU1OQkiSLBJU3cCUF/JE/eMxyiPu5JZFgql1k4OYBiLqogXsR0PH/tLLvj
	8OMApS77CtxZr3j4JDtAr8bqUhLWwRmcomRGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BweVrWU7xJr8fqROrdXTyqWWGOSzoykR
	I07BLSu7W2ticmU5YaNU0gTYN3rkiIkFgFb+/dvHTS/dcUaOBruw7HeavrHiJD7k
	x3EEA3rOvsoYXJ5eNWvVLIJMwDQZgetnTAuUqEYWsm0e9Jme5Cb+bIVZsFyyzudP
	PbeQ0Gr7PRs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F4C1302F8;
	Sat,  5 Dec 2015 22:51:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D6AC9302F7;
	Sat,  5 Dec 2015 22:51:06 -0500 (EST)
In-Reply-To: <20151202175144.GA18550@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Dec 2015 12:51:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 945593A6-9BCC-11E5-BB2A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282040>

Jeff King <peff@peff.net> writes:

> My motivation isn't exactly code sharing. It is that you sometimes want
> to affect sub-commands of a program, and cannot pass command line
> options to them yourself.
>
> For instance, "git-stash --include-untracked" will call "git clean"
> under the hood. There is no way to say "...and treat foo.* as ignored
> for this invocation". It could grow its own "-e" option, but that does
> not help any other third-party scripts which call "git clean".
>
> So IMHO this is not really about command-line options, but about the
> environment in which a command is executed. Environment variables are
> the obvious way to do that; "git --foo" options are just syntactic sugar
> to set the variables. We could just add variables without matching
> options.

I'd be even more wary of that, as different commands use ignore
patterns for different purposes.  A script may invoke "clean" and
"add" and would want to use different sets of ignore patterns to
emulate "precious" class (which we do not have), for example, by
giving a wider ignore pattern for "add" to prevent a file that must
be kept untracked outside the index while telling "clean -X" that
that file is not expendable with a narrower ignore pattern.  That is
just one example that comes to me without thinking about the issues
too hard, so I am reasonably sure that it would hurt the ecosystem
to promote that the ignore pattern can be used for specifying
important per-invocation input to a script.

In any case, what we've been discussing may be an interesting and
potentially important tangent, but it still is a tangent while
evaluating the patch in question.  I do not think I'd be using the
new "--exclude-from=<file>" option to "clean" (simply because I do
not think I've ever used the existing "-e" option to it unless I am
merely testing the command to make sure it works as advertised)
myself, but I do not immediately see how it would hurt us in the
future to add it now.  So...
