From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] fix checking out a being-rebased branch
Date: Tue, 19 Apr 2016 13:43:46 -0700
Message-ID: <xmqqpotlz5vh.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
	<1460897965-486-1-git-send-email-pclouds@gmail.com>
	<xmqqpotm6cfq.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BCg3GO1g0Z+S+bDYT3Bdh8d8q0WHz=JoeALvYwfNrM0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>, rethab.ch@gmail.com,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 22:43:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ascV0-0001if-SF
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 22:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbcDSUnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 16:43:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752858AbcDSUnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 16:43:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B28C314D71;
	Tue, 19 Apr 2016 16:43:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HXinpx5a9QqwvVI9xyttmtUrn+Y=; b=uqpfb+
	mXHGvN4g3ulz280ltddKIsHoqz/EkmPLiD+X4XX/q5IYCVz5IeQZZuTUKaIWdaqv
	Wl3Y9+XuVIB8/ZXw18eV6+H7YD9owCXFED17mb0i6h+cF7l64M4/6gKOr3Knleyv
	xHFrEKSIWCwxy6V5odpDhL66gk0aAYVVR2csI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e1eSt9cOdVFb3kO/c+/7jhYlg+GHvkc+
	M/UqxrAuPNkcoGNaP9l0IXpveiGOVHjVjXQ4YfhtQmi4ge2vbzlM6/fyf3CWCmDS
	zsB5dhFC1bgeFfL/JiXmYwJLeZvrG9vfsU/8A4DhjDY8TbcK38SNK+P/1Rys2Iwv
	gP4y5TfZWdw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A998914D70;
	Tue, 19 Apr 2016 16:43:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22FB514D6F;
	Tue, 19 Apr 2016 16:43:48 -0400 (EDT)
In-Reply-To: <CACsJy8BCg3GO1g0Z+S+bDYT3Bdh8d8q0WHz=JoeALvYwfNrM0A@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 19 Apr 2016 08:04:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6AA2F338-066F-11E6-9A19-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291923>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Apr 19, 2016 at 12:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Another option is leave wt_status_get_state() alone, factor out the
>>> rebase-detection code and use that for worktree/checkout. We save a
>>> few syscalls this way too.
>>>
>>> Comments?
>>>
>>>   [01/07] path.c: add git_common_path() and strbuf_git_common_path()
>>>   [02/07] worktree.c: store "id" instead of "git_dir"
>>>   [03/07] path.c: refactor and add worktree_git_path()
>>>   [04/07] worktree.c: add worktree_git_path_..._head()
>>
>> I actually wondered how ky/branch-[dm]-worktree topics to avoid
>> "branch -d" and "branch -m" from removing or renaming a branch that
>> is checked out in other worktrees from screwing them up.  There may
>> be a missed opportunity to clean them up with using these?
>
> branch-m-worktree uses info populated at get_worktrees() phase.
> branch-d-worktree uses find_shared_symref() which is modified in this
> series in order to detect rebase branch. So both topics have the same
> problem when a branch is being rebased and if I do it right, I'll fix
> them both without extra code.

Yup, that was exactly why I brought it up.

> Actually I may need to check branch-m-worktree again, renaming a
> branch under rebase might cause problems, I need to have a closer
> look at git-rebase*.sh.

Thanks.
