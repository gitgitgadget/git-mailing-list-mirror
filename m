From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Tue, 14 Oct 2014 10:26:42 -0700
Message-ID: <xmqqoatezhnx.fsf@gitster.dls.corp.google.com>
References: <1413090791-14428-1-git-send-email-max@max630.net>
	<CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
	<543D58D9.5060606@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Max Kirillov <max@max630.net>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 14 19:26:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe5s7-0004fb-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 19:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbaJNR0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 13:26:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751076AbaJNR0v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 13:26:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B02F014D12;
	Tue, 14 Oct 2014 13:26:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z5kXtlvSQhwLq8uOPv22E9L/6tY=; b=BUOB7X
	yue1FYs7EswPY7TN/94RiC9urija6B8M+OFNAc2rDb1U5FbuOsHGIdfYpG2i6XTf
	f0gjRiOUdypYW2P6Nc5nV2XftEPdYtt0dhTccg38aTCS/eGB0VNElN9QU5pvKEZB
	/afMSfxgaJz0psG+CK+L37WWv1VTJaA9Wd7U4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDRWdYvgv9h5Dv2BUBph1KIa9oi2EvAT
	TG1WUwNi/nv+KBfH2cPlevhOyh5UhC3j0YbpNXT6pXG1BX5dhjM1jirCO9Ppxz8R
	Ovbqltu8C3f41TPPMCDFvIJUC0SUAil1bTcJTazB6sy+wPHUrTTviBC+S1yhYFJ/
	XvoAybsX7Xw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A6B0814D11;
	Tue, 14 Oct 2014 13:26:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15B7D14D0F;
	Tue, 14 Oct 2014 13:26:44 -0400 (EDT)
In-Reply-To: <543D58D9.5060606@web.de> (Jens Lehmann's message of "Tue, 14 Oct
	2014 19:09:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 448E9DF2-53C7-11E4-9938-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jens Lehmann <Jens.Lehmann@web.de> writes:

> But I can't see how that can work by just sharing the modules directory
> tree, as that contains work tree related files - e.g. the index - for
> each submodule. AFAICS sharing them between work trees will work only
> if the content of the modules directory is partly present in GIT_DIR -
> for work tree related files - and only the common stuff is taken from
> GIT_COMMON_DIR (Or did I just miss the magic that already does that?).

The first time I saw the patch 3/4 in this series, my reaction was
"Huh, why should the repository data and branch tips be separated
out into multiple independent copies for the same module?  Do we
force users to synchronise between these copies?  It does not make
any sense at all."

But that was until I read your message ;-) You are right that the
index and HEAD are dependent to a particular working tree that is
checked out.  There may be other things that logically are per-
working tree.

And multiple-worktree _is_ about keeping the same repository and
history data (i.e. object database, refs, rerere database, reflogs
for refs/*) only once, while allowing multiple working trees attached
to that single copy.

So it appears to me that to create a checkout-to copy of a
superproject with a submodule, a checkout-to copy of the
superproject would have a submodule, which is a checkout-to copy of
the submodule in the superproject.

> And I didn't try to wrap my head around recursive submodules yet ...
>
> Until that problem is solved it looks wrong to pass GIT_COMMON_DIR into
> submodule recursion, I believe GIT_COMMON_DIR should be added to the
> local_repo_env array (and even if it is passed on later, we might have
> to append "/modules/<submodule_name>" to make it point to the correct
> location).
