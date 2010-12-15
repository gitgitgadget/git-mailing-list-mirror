From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] ident: die on bogus date format
Date: Wed, 15 Dec 2010 13:53:36 -0800
Message-ID: <7vei9ipusf.fsf@alter.siamese.dyndns.org>
References: <loom.20101213T161633-993@post.gmane.org>
 <20101213170225.GA16033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 15 22:54:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSzIP-0004Kz-7O
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 22:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab0LOVxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 16:53:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab0LOVxx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 16:53:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B80D29C9;
	Wed, 15 Dec 2010 16:54:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GK3c+Cn9Q9e6bWI7Da21/evLG+o=; b=WlyxFX
	aB/bVtjmUdtEOZjs0ObCJhWdV5G6IiilrTiqFBLhcDtxypvOIcCrWzMP6hxGscMG
	OnAJPMgxBPiWOk7junc39gAuNj9AcDNNjRCmEaAQTkYuPvhogS1iD3q3ll7b+ztH
	Bl+1iF2kLNdfC1VFCrZuUBMt+qeUuP0cd+Zqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qoThRHpA2+Y0aTiaodG/Dmcov/Ckg72c
	CFy5xYYT0XL5qiobV61fxvs0jVkr445dC9LYcCysRVgDC0oPS/hIQA+fmuJ2SCs6
	c1v2ZpHCRniigbDOnE+YjKaQaGusZS4acF/oNUi8dUaeqqK6NGOn0/u9wfUYZSx4
	oGgp475DrmM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD73129C6;
	Wed, 15 Dec 2010 16:54:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4F7AA29C3; Wed, 15 Dec 2010
 16:54:05 -0500 (EST)
In-Reply-To: <20101213170225.GA16033@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 13 Dec 2010 12\:02\:25 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D88A2A70-0895-11E0-8CA6-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163792>

Jeff King <peff@peff.net> writes:

> There are two down-sides to this approach:
>
>   1. Technically this breaks somebody doing something like
>      "git commit --date=now", which happened to work because
>      bogus data is the same as "now". Though we do
>      explicitly handle the empty string, so anybody passing
>      an empty variable through the environment will still
>      work.

These days I think the bogodate parser knows what "now" is, but you can
change the example to use "ahora" instead of "now" and your argument does
not change.  But if you force user to change something in order to work
with a new version of git, it is a regression, no matter how small that
change is.

Having said that, I don't think --date=ahora is something we need to worry
about within the context of "git commit", as the regression feels purely
technical (the author-date defaults to the current time anyway, so there
is no reason to give --date=ahora to the command, even though giving an
explicit date via the flag may have some uses).  On the other hand, as
fmt_ident() is fairly low-level, there might be other callers to which it
made sense to give "now" to them, and we wouldn't know without looking.

>      If the error is too much, perhaps it can be downgraded
>      to a warning?

I think dying is actually Ok for this caller, as we already pass
IDENT_ERROR_ON_NO_NAME to fmt_ident() expecting it to die for us upon a
bad input.  Even though I suspect that we do not need to be conditional on
this (the only reason ON_NO_NAME exists is because reflogs may record your
name when you switch branches, and if you are only sightseeing it doesn't
matter if your name is "johndoe@(null)"), using IDENT_ERROR_ON_NO_DATE may
be safer perhaps?

>   2. The error checking happens _after_ the commit message
>      is written, which can be annoying to the user. We can
>      put explicit checks closer to the beginning of
>      git-commit, but that feels a little hack-ish; suddenly
>      git-commit has to care about how fmt_ident works. Maybe
>      we could simply call fmt_ident earlier?

After determine_author_info() returns to prepare_to_commit(), we have a
call to git_committer_info() only to discard the outcome from.  I think
this call was an earlier attempt to catch "You do not exist" and related
low-level errors, and the codepath feels the right place to catch more
recent errors like the one under discussion.  Instead of passing 0, how
about passing IDENT_ERROR_ON_NO_NAME and IDENT_ERROR_ON_NO_DATE there,
store and return its output from the prepare_to_commit(), and then give
that string to commit_tree() later in cmd_commit().  We can do this by
adding a new parameter (strbuf) to prepare_to_commit(), I think.
