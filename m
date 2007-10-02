From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 02 Oct 2007 10:44:00 -0700
Message-ID: <7vd4vxmmxr.fsf@gitster.siamese.dyndns.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<7v3awunjup.fsf@gitster.siamese.dyndns.org>
	<49137EAF-BB73-40DC-973C-E60C14B3FA7F@zib.de>
	<vpq641qroae.fsf@bauges.imag.fr>
	<7vlkamm16s.fsf@gitster.siamese.dyndns.org>
	<vpqr6keos6e.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IclnC-0007Jh-O4
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 19:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbXJBRoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 13:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755598AbXJBRoJ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 13:44:09 -0400
Received: from rune.pobox.com ([208.210.124.79]:51712 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755554AbXJBRoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 13:44:07 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 60CC6140538;
	Tue,  2 Oct 2007 13:44:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 66F79140420;
	Tue,  2 Oct 2007 13:44:24 -0400 (EDT)
In-Reply-To: <vpqr6keos6e.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue,
	02 Oct 2007 10:07:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59702>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I'd add this to be consistant with "git status". I find the "needs
> update" really short, and especially confusing for centralized systems
> users, for whom "needs update" would probably mean "new version
> available, please run '$VCS update'".

Yeah, and "needs merge" solicits 'SCM merge'.

> diff --git a/read-cache.c b/read-cache.c
> index 2e40a34..3745a48 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -869,7 +869,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
>                         }
>                         if (quiet)
>                                 continue;
> -                       printf("%s: needs update\n", ce->name);
> +                       printf("%s: Changed but not updated\n", ce->name);
>                         has_errors = 1;
>                         continue;
>                 }

I tried to stay away from touching that part on purpose.  Doing
this unconditionally may break people's existing scripts that
use update-index --refresh plumbing.

We could introduce a new option to "update-index --refresh" that
makes the output more machine readable by either NUL terminating
or c_quoting ce->name to protect the caller from potential
spaces and newlines in the name, and use that from the caller.

But for this particular case, I think a much simpler alternative
would be to do it this way:

>  # The tree must be really really clean.
> -git update-index --refresh || exit
> +git update-index -q --refresh || {
+	git status
> +	printf "cannot rebase: the work tree is not clean.\n"
> +	exit 1
> +}
>  diff=$(git diff-index --cached --name-status -r HEAD)
>  case "$diff" in
>  ?*)	echo "cannot rebase: your index is not up-to-date"
