From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for a 'pre-push' hook
Date: Fri, 16 Nov 2012 12:30:19 -0800
Message-ID: <7vvcd5l290.fsf@alter.siamese.dyndns.org>
References: <CAJwKrPYwCE4ExmK09PURMfjYezn6vdCH_BBXU4WCwrnotyV9CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aske Olsson <askeolsson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 21:30:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZSYf-0004bG-2N
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 21:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552Ab2KPUaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 15:30:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49065 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525Ab2KPUaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 15:30:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ABCFADFA;
	Fri, 16 Nov 2012 15:30:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZcE0M1Ue2PNvWmWg0TUje7rFxoM=; b=g5UT6i
	ScgCsH4E5ObhAWriQEHl4JmOOE5Rpd/8iCJaeuwzdLwGWltacJMmF/efvKgucolQ
	smMFLNUyNV6sG3oPTn9Mn1kmD5+kfo9HH9ZCRPZGIzy0sjvIhbTLpvhw2f7tY/+q
	GQrnmU1DBYpsv5VuO18fZ43b8RhTnE+FfEmhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yy91GPOmlr+KEQDysh/KwvGoDnOYRHH0
	9IsHpOrqR4vk1U0caHVCCefRfj1P3pI8mpelvW8Colp5GSeUDn7sp/pN45EHKCQB
	ld5IcH12fTBi2RCRyTmEzLQTEmeRMzACLCsIZgXlylAdZhHrw5A0WhW6b6q8GGBB
	eRMEWfBho7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6873AADF9;
	Fri, 16 Nov 2012 15:30:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA411ADF8; Fri, 16 Nov 2012
 15:30:20 -0500 (EST)
In-Reply-To: <CAJwKrPYwCE4ExmK09PURMfjYezn6vdCH_BBXU4WCwrnotyV9CA@mail.gmail.com> (Aske
 Olsson's message of "Fri, 16 Nov 2012 20:42:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7113ED98-302C-11E2-907C-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209906>

Aske Olsson <askeolsson@gmail.com> writes:

> If the script .git/hooks/pre-push exists and is executable it will be
> called before a `git push` command, and when the script exits with a
> non-zero status the push will be aborted.
> The hook can be overridden by passing the '--no-verify' option to
> `git push`.
>
> The pre-push hook is usefull to run tests etc. before push. Or to make
> sure that if a binary solution like git-media, git-annex or git-bin is
> used the binaries are uploaded before the push, so when others do a
> fetch the binaries will be available already. This also reduces the
> need for introducing extra (git) commands to e.g. sync binaries.
>
> Signed-off-by: Aske Olsson <askeolsson@gmail.com>
> ---
> ...
> +[[pre-push]]
> +pre-push
> +~~~~~~~~
> +
> +This hook is invoked by 'git push' and can be bypassed with the
> +`--no-verify` option. It takes no parameter, and is invoked before
> +the push happens.
> +Exiting with a non-zero status from this script causes 'git push'
> +to abort.
> ...
> + if (!no_verify && run_hook(NULL, "pre-push")) {
> + die(_("pre-push hook failed: exiting\n"));
> + }

NAK, at least in the current form.  At least the system should tell
the hook where it is pushing and what is being pushed.

After working on my notebook, I may want to push to my desktop
machine first to test it, without having to test locally on an
underpowered CPU, but when I am publishing the end result to the
wider world, I do want to test the result beforehand.  Without
"where am I pushing", the hook would not help me to enforce testing
only for the latter.

A lazy "git push" without any other argument may be configured in my
repository to push its "maint", "master", "next" and "pu" branches
to the public repository.  I may say "git push origin +pu", while on
one of the topic branches, to push only the "pu" branches out before
I am confident that the other branches I'll eventually publish are
ready (it is more likely that I may even *know* they are broken and
do not pass the test in such a case, and that is why I am pushing
only "pu" out).  I'd want to run tests only on 'pu' in such a case.
Without "what am I pushing", the hook would not be able to help me
doing that, either.

Besides, there are five valid reasons to add a new hook to the
system, but your version of pre-push does not satisfy any of them:

     http://thread.gmane.org/gmane.comp.version-control.git/94111/focus=71069

It is more like "to always cause an action before running a git
operation locally," so you can even write

    cat >$HOME/bin/git-mypush <<\EOF
    #!/bin/sh
    run test || exit
    exec git push "$@"
    EOF
    chmod +x $HOME/bin/git-mypush

and then can run "git mypush" instead of adding this hook.
