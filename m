From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Fixes bug: GIT_PS1_SHOWDIRTYSTATE is no not respect
 diff.ignoreSubmodules config variable
Date: Sun, 26 Dec 2010 11:14:50 -0800
Message-ID: <7vd3ooz6qd.fsf@alter.siamese.dyndns.org>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru>
 <1293240049-7744-3-git-send-email-zapped@mail.ru> <4D15E48A.9050805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zapped <zapped@mail.ru>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 26 20:15:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWw3l-000233-2A
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 20:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab0LZTPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 14:15:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab0LZTPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 14:15:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7094C27D9;
	Sun, 26 Dec 2010 14:15:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U4uXPN46jmCV5c/xDFKNuFtuqpY=; b=xajoP6
	Pg79jD6SxpyvSw3bsdV4V8RrZBApWdCGdEEfxbluExyt4/D8+ZUlqhOkG0ZT/QkG
	gVJW5SA+EXMOb3DhtLGNmkn6rJQ257+5E373zEGrCHumcWPMrlFCk5rLXZgrjiQc
	vinn5jnH0R9TurBFjNO7EgVjijgAimPeX2Pa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y9chqtPrZZ/rxNQ99t/KIyUE7z+OPGCG
	ivfYQ6IQjOnMuWKwqodnwuTVnq1eEr1jy5cohZG+oLl4KQ0s7Q2IZPPL5iOQWc2W
	zP1/h8e73NOfXI1aios+MOueImqGI30hDjxHwTcAybbeNUV16jhJ17WbO1C4FkHr
	5OC0v4vw7yA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D03627D8;
	Sun, 26 Dec 2010 14:15:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A8F3F27D3; Sun, 26 Dec 2010
 14:15:22 -0500 (EST)
In-Reply-To: <4D15E48A.9050805@web.de> (Jens Lehmann's message of "Sat\, 25
 Dec 2010 13\:33\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7FC84EDE-1124-11E0-8B48-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164196>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> So are there any reasons for the plumbing diff commands not to honor
> the diff.ignoreSubmodules setting?

There are two kinds of users of the plumbing.

One class of plumbing users is scripts that is about automation and
mechanization that want to control what they do precisely (think cron
jobs) without getting affected by the user preference stored in the
repository configuration.  This class could either:

 (1) state what they want explicitly from the command line; or
 (2) rely on built-in defaults not changing underneath them.

The behaviour of diff recursively inspecting submodule dirtiness has an
unfortunate history, in that the behaviour changed over time, and in each
step when we made a change, we thought we were making an unquestionable
improvement.  Originally we only said "submodule HEAD is different from
what we have in the index/superproject HEAD".  Later we added different
kind of dirtiness like untracked files or modified contents in submodules,
decided perhaps mistakenly that majority of users do want to see them as
dirtiness and made that the default and allowed them to be ignored by an
explicit request.  At that point, in order not to break existing scripts
(mostly of the "mechanization" class, written back when there was no such
extra dirtyness hence with no "explicit refusal" route available to them
without rewriting), hence "no configuration should affect plumbing
randomly" policy.

On the other hand, you may write user facing Porcelain in scripts and run
plumbing from there.  This class of plumbing users could either:

 (1) inspect the config itself, interpret the customization and pass
     an explicit command line flag; or

 (2) allow the plumbing honor the end user configuration stored in the
     repository or user configuration files.

It is argurably more convenient for these users if the plumbing blindly
honored the configurations, as it would have allowed the latter
implementation.  That way, we can be more lazy when writing our scripts,
and ignore having to worry about new kinds of customization added to
underlying git after a script is written---but new kinds of customization
may break your script's expectation of what will and what will not be made
customizable, and you would end up giving an explicit "do not use that
feature" in some cases, so the being able to be lazy is not necessarily
always a win.

Things may have been a bit different if the original feature change to
inspect submodules deeper, command line flags to control that behaviour
and configuration to default the flags came at the same time, but
unfortunately they happend over time.  I think we have been slowly getting
better at this, but in the case of this particular feature, the original
introduction of --ignore-submodules was in May 2008, deeper submodule
inspection and the richer --ignore-submodules=<kind> option came much
later in June 2010, and the configuration was invented later in August
2010, which would mean that allowing the plumbing to honor configuration
would have broken scripts written in the 2 years and 3 months period.

And no, this does not call for a blanket "do / do not honor configuration"
option to plumbing commands.  A more selective "do / do not honor these
configuration variables" option might be an option, though.

By the way, could we please have a real sign-off, not with a one with a
pseudonym, given to the series?
