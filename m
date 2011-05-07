From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit: do not cleanup template
Date: Sat, 07 May 2011 13:13:29 -0700
Message-ID: <7vwri2uv4m.fsf@alter.siamese.dyndns.org>
References: <1304783624-9919-1-git-send-email-billiob@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Boris Faure <billiob@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 07 22:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QInsl-00022t-Ls
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 22:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab1EGUNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 16:13:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029Ab1EGUNh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 16:13:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34ED047BE;
	Sat,  7 May 2011 16:15:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/27pKpu+2d2V7K0Ruhb8dwKt0U8=; b=ZuQloW
	rTaxb8UjzFDpJCNz5DOLWGv4M3t0AR27J/PDoxoyWtFdQsrKamcMRc+QpWboG0lM
	fsHJM//SSLPLqx/mYg3a0qhfM5FBgb+//g0ZOBKpufxZPUljaFrnp0tySI5uV6hl
	jjthxE31sRt8Ip8SbBw1a/pYdzzjkOQTQJdjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BPXpvL1txnDMTqW2wwFYIAmNj0kOXVBP
	C/QgEQxHyIigHD/kpYc2f+SKaVgzJxGmmI7lPc9DMjcN482yrCi6DefykUeZexMY
	OIRqP/TOC4pu6Urqjbp+gkLEmT0vq1g3ncT98VCK15IaktNn9GwF64m9Jn9t46Md
	Y8pa7ycQk8c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1217247BD;
	Sat,  7 May 2011 16:15:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2036C47BC; Sat,  7 May 2011
 16:15:36 -0400 (EDT)
In-Reply-To: <1304783624-9919-1-git-send-email-billiob@gmail.com> (Boris
 Faure's message of "Sat, 7 May 2011 17:53:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C723D9E0-78E6-11E0-B736-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173065>

These two commits change the longstanding behaviour. It is hard to tell if
the existing behaviour is something people who use commit log message
templates have relied on (in which case your patch will be a regression to
them) or they all shared the sense of annoyance and have been wishing to
be improved (in which case nobody will be inconvenienced with your patch).
They need to be explained a bit better why these changes are needed.

My gut feeling is that it is relatively easy to justify [1/2]. We prepare
the message file to be edited by the committer in sb by reading from
different message sources, and usually we would want to clean up what is
in sb before writing it out, but you may want to enforce a particular
format by using the template (such as having a leading whitespace) and the
way to tweak and fix that appearance should be by editing the template,
not by automatically running stripspace() here [*1*] when the message came
from the template.

I cannot tell offhand how you justify [2/2], though. What motivated you to
remove this blank line? At this point in the codepath, it does not look
like it should matter if the original message came from your template or
from somewhere else.

If the blank line is unneeded after "# You may be committing a merge..."
for readability, wouldn't that blank line be unneeded when you took the
message from other places, no?

It might make sense to move that newline before "if (whence != FROM_COMMIT)"
block, though, to make the logic easier to follow, regardless of the use
of the template file.

[Footnote]

*1* I however have a feeling that this call is here because other people
wanted to clean it up here because otherwise mistakes like trailing
whitespaces or excess blank lines and whatnot made in the template will
propagate down to the actual commit log message. But we run stripspace
again after the editor returns, so I think that worry is unfounded if we
are using an editor.
