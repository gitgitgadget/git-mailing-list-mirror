From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: introduce "rebase.preserve" configuration option
Date: Tue, 05 Aug 2014 15:39:15 -0700
Message-ID: <xmqq61i6o92k.fsf@gitster.dls.corp.google.com>
References: <1407271714-1624-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 00:39:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEnOD-0001E6-5B
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 00:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbaHEWjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 18:39:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59115 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026AbaHEWjY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 18:39:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 250A22F6FB;
	Tue,  5 Aug 2014 18:39:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IP0qnp+uXHDGEymDlfjn2fPWK2U=; b=Z2zDEx
	Z3j+P8I4e3vHRg+JQpQGYd1gGEiKAt8lvegXzxu2kbT358HZAlKPkOyw8LkzLnk5
	Hr0ov6C8l/kQ403L5cY69M66HH2fZ4apD1Mk+lDVU1lh93R4vndIstch9lnjUKzx
	rvvBl99Spq2CUrjxS9C01TPk63S2OcD/ePWzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tLEUrBpgLlKNrqiIUE868Q9rhBzXwGRW
	HLQ547E5RsKN+LpfCRXNdGtEUPistfIN1krcPPMelY+VYK5TK+aokiaqNgzP/iLj
	U8+zSUmUfN2ViP9zYU7hMJQsoc6MqWPMQfg1MhX8xd7hBFqhU3U22MVvQz1v2Jr2
	P5tMX1hD7JE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B5D02F6FA;
	Tue,  5 Aug 2014 18:39:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 690882F6F8;
	Tue,  5 Aug 2014 18:39:17 -0400 (EDT)
In-Reply-To: <1407271714-1624-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Tue, 5 Aug 2014 22:48:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 557552B2-1CF1-11E4-8C83-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254839>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> There are several ways to configure Git to preserve merges.
> There is "pull.rebase=preserve" for all branches and
> "branch.<name>.rebase=preserve" for individual branches.
> However, there is no configuration option to preserve merges
> for all branches when running git-rebase.

How should this interact with pull.rebase?  Specifically, what
should happen with these settings?

	[rebase] preserve = true
        [pull] rebase = true

Historically, the variable was a way to tell 'pull' to use 'rebase'
to integrate (if true) or use 'merge' to integrate (if false), and
then the third value that is clearly not 'false' was added to say
"How should the underlying 'rebase' integrate the local and the
remote histories?".

In that light, one can argue 'git pull' with the above two should
run 'rebase --preserve'.  In other words, rebase.preserve tells us
"When 'rebase' is told to run, it should do the 'preserving'
variant."

But then when somebody sets pull.rebase to true, expecting that
'true' does not just mean "Yup, please use rebase, I do not like
merges", but means "Use rebase without preserve", it would be hard
to debug if the behaviour of 'git pull' is affected by a separate
variable rebase.preserve that may be defined in a far-away place in
the configuration file.

I dunno.  This kind of complications is one reason why I wouldn't
encourage adding these configurations to affect the behaviours of
commands.
