From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 3/3] Fixes bug: GIT_PS1_SHOWDIRTYSTATE is no not respect
 diff.ignoreSubmodules config variable
Date: Mon, 27 Dec 2010 12:14:25 +0100
Message-ID: <4D187511.3090104@web.de>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-3-git-send-email-zapped@mail.ru> <4D15E48A.9050805@web.de> <7vd3ooz6qd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Zapped <zapped@mail.ru>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 12:15:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXB3Q-0000aL-1Y
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 12:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab0L0LPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 06:15:46 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:43247 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab0L0LPq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 06:15:46 -0500
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 34BA018484BEE;
	Mon, 27 Dec 2010 12:14:28 +0100 (CET)
Received: from [93.240.118.28] (helo=[192.168.178.53])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PXB23-00020u-00; Mon, 27 Dec 2010 12:14:27 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vd3ooz6qd.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/UHnQgT9FAsXqok4LTWjyKjZPVVsW7RZ+irP20
	KFQMUPdH7fe+uyAglofMzGU4Z/QNxDhpMxTkAlGNr9jzksAJ/+
	EyN/OrCvG7dOoxo6bzKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164219>

Am 26.12.2010 20:14, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> So are there any reasons for the plumbing diff commands not to honor
>> the diff.ignoreSubmodules setting?

Thank you for explaining those reasons in detail.

> One class of plumbing users is scripts that is about automation and
> mechanization that want to control what they do precisely (think cron
> jobs) without getting affected by the user preference stored in the
> repository configuration.  This class could either:
> 
>  (1) state what they want explicitly from the command line; or
>  (2) rely on built-in defaults not changing underneath them.
> 
> The behaviour of diff recursively inspecting submodule dirtiness has an
> unfortunate history, in that the behaviour changed over time, and in each
> step when we made a change, we thought we were making an unquestionable
> improvement.  Originally we only said "submodule HEAD is different from
> what we have in the index/superproject HEAD".  Later we added different
> kind of dirtiness like untracked files or modified contents in submodules,
> decided perhaps mistakenly that majority of users do want to see them as
> dirtiness and made that the default and allowed them to be ignored by an
> explicit request.  At that point, in order not to break existing scripts
> (mostly of the "mechanization" class, written back when there was no such
> extra dirtyness hence with no "explicit refusal" route available to them
> without rewriting), hence "no configuration should affect plumbing
> randomly" policy.

Good point. But unfortunately the diff plumbing commands are affected by
the "submodule.<name>.ignore" ignore settings I introduced in August in
aee9c7d6 and 302ad7a9. Maybe we should revert the part of these patches
that changed the plumbing commands?

> On the other hand, you may write user facing Porcelain in scripts and run
> plumbing from there.  This class of plumbing users could either:
> 
>  (1) inspect the config itself, interpret the customization and pass
>      an explicit command line flag; or
> 
>  (2) allow the plumbing honor the end user configuration stored in the
>      repository or user configuration files.
> 
> It is argurably more convenient for these users if the plumbing blindly
> honored the configurations, as it would have allowed the latter
> implementation.  That way, we can be more lazy when writing our scripts,
> and ignore having to worry about new kinds of customization added to
> underlying git after a script is written---but new kinds of customization
> may break your script's expectation of what will and what will not be made
> customizable, and you would end up giving an explicit "do not use that
> feature" in some cases, so the being able to be lazy is not necessarily
> always a win.

Agreed.

> Things may have been a bit different if the original feature change to
> inspect submodules deeper, command line flags to control that behaviour
> and configuration to default the flags came at the same time, but
> unfortunately they happend over time.  I think we have been slowly getting
> better at this, but in the case of this particular feature, the original
> introduction of --ignore-submodules was in May 2008, deeper submodule
> inspection and the richer --ignore-submodules=<kind> option came much
> later in June 2010, and the configuration was invented later in August
> 2010, which would mean that allowing the plumbing to honor configuration
> would have broken scripts written in the 2 years and 3 months period.
> 
> And no, this does not call for a blanket "do / do not honor configuration"
> option to plumbing commands.  A more selective "do / do not honor these
> configuration variables" option might be an option, though.

What about a new "--ignore-submodules=config" option to tell the plumbing
that it should honor the config?


And it looks like the PS1 problem that started this discussion is a
valid example for mixed usage of porcelain and plumbing commands. In a
first attempt to fix the problem by using "git diff --cached" instead
of "git diff-index --cached" I noticed that those two commands give
different results when new submodules were created and had been added
to the index. "git diff --cached" ignores them while "git diff-index
--cached" shows them. Anything I am missing here?
