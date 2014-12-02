From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Add another option for receive.denyCurrentBranch
Date: Mon, 01 Dec 2014 16:51:01 -0800
Message-ID: <xmqqk32aoowa.fsf@gitster.dls.corp.google.com>
References: <cover.1417033080.git.johannes.schindelin@gmx.de>
	<cover.1417041787.git.johannes.schindelin@gmx.de>
	<ff9c17b14b4418ae9743a094989d5478dab19701.1417041788.git.johannes.schindelin@gmx.de>
	<xmqqr3wjnd65.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 01:51:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvbgW-0007QR-Cw
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 01:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbaLBAvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 19:51:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754233AbaLBAvP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 19:51:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6231223A43;
	Mon,  1 Dec 2014 19:51:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VBBUYPxnoUYZP01/65k+B0o0kuo=; b=Sbcljv
	oPU0Jl8noybqyHN4lUv7k7URF8TvGXb0epuB47t+u5ogjb4hH7pCDFpbr+7AHLh3
	6G9nhEmm42bApKQ8eolqVp6qgNpsIvN3mD/U534XlzyXW6leZujUH4jNcMlw/gYG
	VNYMV2lx0whD+YvAT9IQZuXTfs7IMj8GmWkak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgq3jby6DWiIKMhDFWflOHDxsc1OU0Sh
	2mpUzrHbhoXfRxgE7hXgtOcHlaQS5Ag5leqRoW0kaWMezFtr1M223d2ZaTmXkX6k
	T5fZsJQwUQ0kaxeDNWqVWT1z6VYtN8/uqAJeNfFhuU4c7zL9cLU1IcQgqdSdJgmM
	xNTEmFuLpkA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A5B023A42;
	Mon,  1 Dec 2014 19:51:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6D5423A3F;
	Mon,  1 Dec 2014 19:51:02 -0500 (EST)
In-Reply-To: <xmqqr3wjnd65.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Dec 2014 15:49:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4A377942-79BD-11E4-B964-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260517>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> +static const char *update_worktree(unsigned char *sha1)
>> +{
>> +...
>> +	const char *work_tree = git_work_tree_cfg ? git_work_tree_cfg : "..";
>
> I overlooked this one, but is there a reason why this has to look at
> an internal implementatino detail which is git_work_tree_cfg,
> instead of asking get_git_work_tree()?
>
> I am wondering if that reason is a valid rationale to fix whatever
> makes get_git_work_tree() unsuitable for this purpose.
>
> Cc'ing Duy who has been working on the part of the system to
> determine and set-up work-tree and git-dir.

Answering myself...

This is because you know receive-pack runs inside the $GIT_DIR,
whether it is a bare or non-bare repository, so either core.worktree
points at a directory that is otherwise unrelated to the $GIT_DIR
(but is the correct $GIT_WORK_TREE), or the top of the working tree
must be ".." for a non-bare repository.  I haven't checked the code,
but we probably are not even doing the repository/working-tree
discovery to set up the data necessary for get_git_work_tree() to
give us a correct answer.

Doing an optional set-up to make get_git_work_tree() work would
involve more damage to the codebase than necessary, I would suspect,
so let's keep this part of the code as-is.

That is, unless I am over-estimating the "damage" necessary.

Thanks.
