From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Small rerere in rebase regression
Date: Mon, 23 May 2016 12:43:11 -0700
Message-ID: <xmqqy4708ss0.fsf@gitster.mtv.corp.google.com>
References: <57434572.6030306@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 23 21:43:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vl1-0007xp-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbcEWTnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:43:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751890AbcEWTnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:43:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE7EF1C9A0;
	Mon, 23 May 2016 15:43:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L7Bi2axdLHUXIompYuGQe/K/jA0=; b=epixxo
	RdlJzgG31VnunyxyiLPy3ljhceNKzGq4ysiQUBIItvRlN7a5nyMS4PgKsv8RpjRL
	707cGIys1T3yV2Wi7cLNDOIok3SvB1lc49bPr5CJHBIAE0H5MEhVAgVqm3ANOSCe
	x7LZf2ruHybgJk/zk6WtEnZZuEcr1WPTWHCCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cEthq1jukSnBBLm0FAvUAtz9ojQkAIPt
	wSu6cewiZ7piBXXbsd1I4TV41SQdya/61AnqgJd7mPuIuxMmuCHuTl4dX83W9yTE
	CRwQKBPrHNHRdZtW1Mo72PS/CT5X2Dm1j1ij6+4Cbv1YXZzXXLsm05BKy6zRc+Uk
	HcMwuLEq9LE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B715C1C99E;
	Mon, 23 May 2016 15:43:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FE591C99B;
	Mon, 23 May 2016 15:43:13 -0400 (EDT)
In-Reply-To: <57434572.6030306@kdbg.org> (Johannes Sixt's message of "Mon, 23
	May 2016 20:01:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 961F2E86-211E-11E6-BFF7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295382>

Johannes Sixt <j6t@kdbg.org> writes:

> I'm not sure whether the new behavior is a defect in rerere.c or a
> consequence of the extra rerere call in interactive rebase...

Interesting.  When running an unnecessary "git rerere" (because it
already was run and recorded the preimage), we used to be silent.
With the updated code, we say something.

At least it seems that we do not record the same preimage as a
different variant, so the regression is hopefully merely cosmetic.

I do not think it is a crime to say "git rerere" repeatedly without
changing anything, so I do not think "rebase -i"'s call to rerere
in die_with_patch is wrong, even though some calls to it seem to be
made after seeing a "git merge" fail (which means we know 'rerere'
has been run already).

I think all plumbing that can turn an index into unmerged state has
a call to git_rerere() at the end (the only obvious exception being
"update-index" that lets you stuff higher stage entries to the
index), so as long as "rebase -i" uses them correctly, I suspect
that die_with_patch shouldn't have to have a call to "git rerere".
