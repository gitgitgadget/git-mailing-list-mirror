From: Junio C Hamano <gitster@pobox.com>
Subject: Re: proposal for extending smudge/clean filters with raw file access
Date: Thu, 12 May 2016 13:14:56 -0700
Message-ID: <xmqq7fezdoe7.fsf@gitster.mtv.corp.google.com>
References: <20160512182432.GA27427@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Thu May 12 22:15:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x0m-0006aJ-2j
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbcELUPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:15:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750956AbcELUPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:15:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 49CC31AF07;
	Thu, 12 May 2016 16:14:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pE4R3SkYYQBmJ65HEFV/xJ8R7E8=; b=vGtI7q
	1mkZmd66be0KUo6ArCiVVEB7c9v6v6ZpeSde/wuDowHPFHnVzpaACfAbqlx5uXnl
	L5ncZ45t0KXJDjL7AMP0a1Ys3Ofa6AaLbJ0MSIulXRfZe9BiGL5aVtspNcfe/FRS
	in9AIIbPgigmFuuzbWx3fWgjpZFnf4wqfhd78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H7rZjAAxMflyAbYpGGlTCvyoUTz6lMEX
	uCcW204tIj3F8cFmiE4AqHWuHCUYG7Uw9IEIYldBq2XGf/eLnZb9l2URi0mUTcTK
	lX99y8s6rzFdBQ++xBxk2S9WbfW+6z2sTmbs3pZc+KPGrLBR7kXbGmRC7ZfSTAIf
	FJsEHCPmIkY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F52B1AF06;
	Thu, 12 May 2016 16:14:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B29D01AF04;
	Thu, 12 May 2016 16:14:58 -0400 (EDT)
In-Reply-To: <20160512182432.GA27427@kitenet.net> (Joey Hess's message of
	"Thu, 12 May 2016 14:24:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3353C99A-187E-11E6-A777-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294449>

Joey Hess <id@joeyh.name> writes:

> The clean filter has to consume the whole file content on stdin;
> not reading it all will make git think the clean filter failed.
> But, git-annex often doesn't need to read the whole content of a
> work-tree file in order to clean it.

This side, I do not think we even need a new variant.  We can just
update the code to interact with "clean" so that it the writer to
the pipe ignores SIGPIPE, detects EPIPE on write(2), says "ah, the
other end does not need the full input to produce its output".  The
reader from the pipe consumes its output without failing AS LONG AS
the "clean" filter exits with zero (we do check its exit status,
right?)

And I think we should do the same for any codepath that spawns
custom script and feeds it via a pipe from us (I am talking about
hooks here).  

What may require a new variant is when your clean filter may not
even need earlier contents of the file, in which case we are better
off not opening the file ourselves and slurping it into core, only
to pipe it and earlier part discarded by the filter.  "clean-from-fs"
filter that gets a path on the working tree and feeds us via pipe
would be appropriate to deal with such a requirement.

> The smudge filter has to output the whole file content to stdout.

We cannot do a similar "we can just unconditionally update" like I
said on the "clean" side to "smudge", so it would need a new
variant.  I do not want to call it anything "raw", as there is
nothing "raw" about it.  "smudge-to-fs" would be a better name.
