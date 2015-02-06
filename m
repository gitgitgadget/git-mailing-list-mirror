From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Fri, 06 Feb 2015 11:44:38 -0800
Message-ID: <xmqqbnl6hljt.fsf@gitster.dls.corp.google.com>
References: <20150206124528.GA18859@inner.h.apk.li>
	<20150206193313.GA4220@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:44:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJopa-0007yV-97
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 20:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbbBFTom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 14:44:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753840AbbBFTol (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 14:44:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B8B50348FC;
	Fri,  6 Feb 2015 14:44:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HW/w5nYZFf4XUosvjZyNRSwwrFA=; b=FdZBgd
	YqQccyS9nxrG5Xd/sW+6z9F2iA5tPCjP6PlzaoAtvR26pdggxuuM3bDLLfuGMnud
	FDzpgQRIptgnTmmFBNi6dPZ7lKa9FxiSMXbWCDiUoDf96nmXmQJy0OWz4idth3pQ
	0pT71e50eDo0lQQ55g0y5mf9rdq4qEmQRDWHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cnPWqpEZqtLdQBvAqVwE8NM+i9FfTbsc
	p9YKxJTACU1CgzZ2fPUWX11Crt/nJEBea+gXJQ8jrpENDmvPBsq2/044FWnbfOb6
	uwfRLA3WwvwIR5nY30kIGp9arKQX3o9mwSIfCzSCTluiutPr+OfABX0IvmxFaS62
	0xm9KQmxMUs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B00C7348FB;
	Fri,  6 Feb 2015 14:44:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36242348FA;
	Fri,  6 Feb 2015 14:44:40 -0500 (EST)
In-Reply-To: <20150206193313.GA4220@peff.net> (Jeff King's message of "Fri, 6
	Feb 2015 14:33:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 96F9EC24-AE38-11E4-80B0-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263421>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 06, 2015 at 01:45:28PM +0100, Andreas Krey wrote:
>
>>   $ git show_ref
>>   error: invalid key: pager.show_ref
>>   error: invalid key: alias.show_ref
>>   git: 'show_ref' is not a git command. See 'git --help'.
>> 
>> Apparently we need to squelch this message from
>> within git_config_get_* in this case?
> ...
> So it is not a new problem, but it is a bug that you
> cannot set pager config for such a command or alias.

Hmm, I think these are two separate issues.

 (1) you cannot define "alias.my_merge" because that is not a valid
     key.  We cannot add a new official subcommand "git c_m_d"
     because users cannot define "pager.c_m_d" for it for the same
     reason.

 (2) "git no-such-command" does not get these extraneous error
     messages, but "git no_such_command" does.

Solution to (1) would be to move to "alias.my_merge.command = ..."
and "pager.c_m_d.enabled = true".  But I do not think that would
solve (1) until we transition and start ignoring alias.my_merge
and pager.c_m_d, and I do not think of a way other than squelching
the messages to solve (1) during the transition period.

> I can think of a few possible paths forward:
>
>   1. Squelch the messages, and declare "show_ref" and friends
>      out-of-luck for pager config or aliases.
>
>   2. Relax the syntactic rules for config keys to allow more characters.
>      We cannot make this perfect (e.g., we cannot allow "." for reasons
>      of ambiguity), but I imagine we could cover most practical cases.
>
>      Note that we would need the matching loosening on the file-parsing
>      side.
>
>   3. Start phasing in pager.*.enabled (and I guess pager.*.command). We
>      would still do the lookup of pager.* for backwards compatibility,
>      but we would be careful to do so only when it is syntactically
>      valid. IOW, this looks like (1), except the path forward for
>      "show_ref" is to use the new, more robust, syntax.

I guess I ended up reaching the same conclusion; 3. with also
"alias.*.command" as the longer-term goal.
