From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 0/8] rebase: new cherry-pick mode
Date: Wed, 29 May 2013 16:23:23 -0700
Message-ID: <7vehcpqsk4.fsf@alter.siamese.dyndns.org>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 01:23:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhpiR-0007a2-WC
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 01:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967205Ab3E2XXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 19:23:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967179Ab3E2XX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 19:23:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAA9723756;
	Wed, 29 May 2013 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IyVYc1f2u8POPrX48PpdrNtPfOI=; b=HprZAk
	mszl6zWOYZHOX0CABg9RGYyaB82ntXAlYWyB0Fim3gfxl/rMuS2rzge5TEWztAzZ
	74h7PhKDs8HyZrmu/baiu7treGG6pJ+Pp/HIe+eoUUfYntk4LxZXXEvq1DaT6rJS
	UtQXs02D23wK3BEcBDrf/Zh7E7IKx00wEFnx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sijBCDrDoh11lukO1oJFSs41kGwPrSNz
	OWjLps4o8PpJ6+TRDmAYKZ+JGEn9PFVC//gT9c27r399WfUuIf3Set4pOM1aclfJ
	b909gA+qOKlloPArJx9QO8B7boXbE4u4QnfVrqcYjgYw+xsP5GhCyLNHT/qia27z
	Jhxo2aSv82g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD00C23755;
	Wed, 29 May 2013 23:23:25 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2054B23754;
	Wed, 29 May 2013 23:23:25 +0000 (UTC)
In-Reply-To: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 28 May 2013 23:16:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2BEEF12-C8B6-11E2-AFC6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225897>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We already rely on cherry-pick for the 'am' mode, but only when using the
> --keep-empty option, and when in such mode the behavior of 'git rebase' changes
> completely; more specifically; it's completely broken. Manually enabling
> --keep-empty to be the default and running the test-suite shows a huge lot of
> failures.
>
> After fixing the --keep-empty option by creating a new cherry-pick mode, this
> patch series uses this new mode instead of the 'am' mode, and everything works.

This may be a stupid question, but does --keep-empty only fail with
the "am" mode?

More specifically, how well does "rebase -i --keep-empty" work?

If the answer is "very well", then it might make sense not to
introduce yet another cherry-pick mode, but do exactly the same
thing as what -p mode does, namely, to internally delegate the
processing to "rebase -i" codepath.  After all, multi-pick mode of
cherry-pick uses the same sequencer machinery as rebase -i uses,
so if we are already producing a correct "rebase todo" sequencer
insn list for "rebase -i" anyway, it should be the matter of not
launching the editor to edit the initial insn sheet to make it
non-interactive, isn't it?

>
> There's only two tests that fail, one because the output of the shell prompt
> changes a bit, and the other I have not yet investigated.
>
> This brings us one step closer to replace scripts with C code.
>
> Felipe Contreras (8):
>   rebase: split the cherry-pick stuff
>   rebase: cherry-pick: fix mode storage
>   rebase: cherry-pick: fix sequence continuation
>   rebase: cherry-pick: fix abort of cherry mode
>   rebase: cherry-pick: fix command invocations
>   rebase: cherry-pick: fix status messages
>   rebase: cherry-pick: automatically commit stage
>   rebase: use 'cherrypick' mode instead of 'am'
>
>  .gitignore                             |  1 +
>  Makefile                               |  1 +
>  contrib/completion/git-prompt.sh       |  2 ++
>  git-rebase--am.sh                      | 12 ++-----
>  git-rebase--cherrypick.sh              | 64 ++++++++++++++++++++++++++++++++++
>  git-rebase.sh                          | 11 ++++--
>  t/t3407-rebase-abort.sh                |  2 +-
>  t/t5520-pull.sh                        |  2 +-
>  t/t9106-git-svn-commit-diff-clobber.sh |  2 +-
>  9 files changed, 82 insertions(+), 15 deletions(-)
>  create mode 100644 git-rebase--cherrypick.sh
