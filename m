From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT
 defined
Date: Tue, 17 Jan 2012 11:08:34 -0800
Message-ID: <7vfwfervt9.fsf@alter.siamese.dyndns.org>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 20:08:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnEOf-0006cj-W5
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 20:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab2AQTIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 14:08:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab2AQTIg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 14:08:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 399FC68D0;
	Tue, 17 Jan 2012 14:08:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4nYAuCuWtjaVdgN8DiUcfXpw374=; b=NjrKYM
	/B1PRC+JV0n3jY3tPYBPCn2Q5ShCKrCo3GkuX67dfbgoOJ8mGWox7tqLmtbY64S1
	h/u3xhB8wGv2B5a1qlt7gIa9eN8d6B5J/Vyc1scxoQcM5U3NzURwJfkiCj4tl42l
	7MZnlNS8i6wdjw+b+XArQc6iv0Zf/a4NhhLuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FZy4D6qBc6M7tFd/gGZqSh9yZ5mNGVOK
	Hrr37UEcCrx4Vg2AtY0iITj5ijCRzC8iRN3kAUB3zYT3T1VpPT+AzcOuy+WTkox7
	SrtdPeKp6OdS49GAV8M37FUYigSFNgk/otWrUsOJYwrv2bmDeBOz4JRUW9WWSvnS
	BIz0NSJRIzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FFC268CF;
	Tue, 17 Jan 2012 14:08:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99D4768CE; Tue, 17 Jan 2012
 14:08:35 -0500 (EST)
In-Reply-To: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com> (Alex
 Riesen's message of "Tue, 17 Jan 2012 14:42:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7C69D14-413E-11E1-BF43-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188711>

Alex Riesen <raa.lkml@gmail.com> writes:

> From: Alex Riesen <raa.lkml@gmail.com>
> Date: Tue, 17 Jan 2012 14:25:24 +0100
> Subject: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
>
> Otherwise the i18n is used in the scripts even with NO_GETTEXT set.
> It is very unexpected.
>
> I generally disable i18n on my working systems as they are generally very
> out-of-date and not supported by any sane developer. In particular the
> gettext provided with this (very old) Cygwin distribution is fubar and
> never produces any output.
> ---

Thanks for spotting. I agree that we should honor NO_GETTEXT here.

But the result of the patch looks almost unreadable. could we restructure
the script like this instead?

        # Decide what to do...
        GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
	if test -n "@@NO_GETTEXT@@$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
	then
		: no probing necessary
        elif test -n "$GIT_GETTEXT_POISON"
        then
                GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
        elif type gettext.sh >/dev/null 2>&1
        then
                GIT_INTERNAL_GETTEXT_SH_SCHEME=gnu
        elif test "$(gettext -h 2>&1)" = "-h"
        then
                GIT_INTERNAL_GETTEXT_SH_SCHEME=solaris
        fi
        export GIT_INTERNAL_GETTEXT_SH_SCHEME

        # ... and then carry out the decision
        case "$GIT_INTERNAL_GETTEXT_SH_SCHEME" in
        gnu)
                ... gnu definition here ...
                ;;
        solaris)
                ... solaris cdefinition here ...
                ;;
        poison)
                ... poison cdefinition here ...
                ;;
        *)
                ... fallthru definition here ...
                ;;
        esac
