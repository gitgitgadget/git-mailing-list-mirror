From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 02 Oct 2007 10:07:53 +0200
Message-ID: <vpqr6keos6e.fsf@bauges.imag.fr>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<7v3awunjup.fsf@gitster.siamese.dyndns.org>
	<49137EAF-BB73-40DC-973C-E60C14B3FA7F@zib.de>
	<vpq641qroae.fsf@bauges.imag.fr>
	<7vlkamm16s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 10:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icco7-00068d-SX
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 10:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbXJBIIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 04:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbXJBIId
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 04:08:33 -0400
Received: from imag.imag.fr ([129.88.30.1]:47090 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbXJBIIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 04:08:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9287rXn003666
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Oct 2007 10:07:53 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IccnJ-0003x1-A2; Tue, 02 Oct 2007 10:07:53 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IccnJ-0005VP-7R; Tue, 02 Oct 2007 10:07:53 +0200
In-Reply-To: <7vlkamm16s.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 02 Oct 2007 00\:21\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 02 Oct 2007 10:07:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59672>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> I'm also concerned about the possibility of stash/unstash to fail:
>> that means the user has to deal with two kinds of conflicts (rebase
>> can conflict, unstash can also), which can be confusing.
>
> Unstash should be invoked automatically _only_ after rebase
> completes, so I do not forsee such confusion.

Well, if rebase itself conflicts, it will stop and tell you about
conflicts, then you'll have to "rebase --continue". If unstash fails,
you'll have to resolve the conflicts, and probably do "commit", or
continue working afterwards. You don't have to deal with both at the
same time, but both do exist, and they have to be taken care of
differently.

For an advanced user with good understanding of the flow, that's OK,
but I'm still afraid of the confusion for not-so-advanced users.

But that's not a strong argument against auto-stash, just one
downside.

> But the trouble I have with the auto unstashing is more at the
> conceptual and workflow level.  You start rebasing a branch, and
> your work tree is dirty.  What branch should the local
> modification belong to?

You're in a better position than me to juge on that point.

>  # The tree must be really really clean.
> -git update-index --refresh || exit
> +o=$(git update-index -q --refresh) || {
> +	printf "cannot rebase: the work tree is not clean.\n%s\n" "$o"
> +	exit 1
> +}
>  diff=$(git diff-index --cached --name-status -r HEAD)
>  case "$diff" in
>  ?*)	echo "cannot rebase: your index is not up-to-date"

That alone would already be a real improvement.

I'd add this to be consistant with "git status". I find the "needs
update" really short, and especially confusing for centralized systems
users, for whom "needs update" would probably mean "new version
available, please run '$VCS update'".

diff --git a/read-cache.c b/read-cache.c
index 2e40a34..3745a48 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -869,7 +869,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
                        }
                        if (quiet)
                                continue;
-                       printf("%s: needs update\n", ce->name);
+                       printf("%s: Changed but not updated\n", ce->name);
                        has_errors = 1;
                        continue;
                }


-- 
Matthieu
