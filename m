From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] branch: fix branch operations with multiple working trees
Date: Fri, 25 Mar 2016 14:13:07 -0700
Message-ID: <xmqqzitm1ct8.fsf@gitster.mtv.corp.google.com>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
	<cover.1458927521.git.k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Fri Mar 25 22:13:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajZ2h-0007Ok-Qd
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 22:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbcCYVNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 17:13:11 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754146AbcCYVNK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 17:13:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1ECB84EB24;
	Fri, 25 Mar 2016 17:13:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IsAnoRIOex8MVU4h9uEoGQFpfKU=; b=BPeCGz
	Fg+5mKq+5CRfc7Cm9ShN/2sNHOGrq8YDfRnaWJu7WoMPQJBDe2KEx8p+yZREuht3
	3+d4dJ/D4RS/aBcZy2XpfgNxSZdR4PeCe0MKb2jPzufs4hjM9NeV/L9l08Ih/hp3
	NsdBUPvZwj/PiOaDUKWF2HNzok8RHxvDukOGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aSxiRaZwrNWGUIHc6c86Zzqs+jbR7xbW
	xR7akv1R9FQpDQy+8ZkOW55h8y0ucyS4hWQ625Q42RIHkvwRdIZsCP6iGZi/P7dH
	ZRLsjwPRtaA1ZpQkKczosc+c/WjU/gtyQ3lbPhzFam339+gaXvhSBpQfbVMPUzN6
	E1KGmnyf/fg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1572B4EB21;
	Fri, 25 Mar 2016 17:13:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 82BEC4EB20;
	Fri, 25 Mar 2016 17:13:08 -0400 (EDT)
In-Reply-To: <cover.1458927521.git.k@rhe.jp> (Kazuki Yamaguchi's message of
	"Sat, 26 Mar 2016 03:28:18 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F95B89A-F2CE-11E5-B107-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289953>

Kazuki Yamaguchi <k@rhe.jp> writes:

> [1/5]
> Adds RESOLVE_REF_COMMON_DIR to resolve_ref_unsafe(). The second - fourth
> patch depend on this. At the same time, this allows us to remove
> reimplementation of resolve_ref_unsafe() in worktree.c: parse_ref().
>
> [2/5]
> Adds REF_COMMON_DIR flag to lock_ref_sha1_basic().

While the code reduction in 1/5 is a very good and welcome change,
these new flags make me wonder if they can be easily misused in a
way that contradicts with what other parts of the system (e.g.
path.c::common_list[]) tell us.  Am I worried too much without a
good reason?

> [3/5]
> Adds create_symref_common_dir(). Same as create_symref() except it
> doesn't consider $GIT_DIR. create_symref_common_dir("HEAD", some) always
> updates .git/HEAD. The next patch uses this.

Similarly, would this allow updating "refs/remotes/origin/HEAD"
(which is also a symbolic ref) to different values for different
worktrees?  In other words, I am wondering if this new function
should be narrower in scope--e.g. used only to update "HEAD" and
no other symbolic refs.  Or will the additional flexibility be
useful?

> [4/5]
> Fixes the issue of git branch -m.
> The behavior when one failed has changed from v1: print an error and
> continue.
>
>   % git branch -m oldname newname
>   error: Unable to create '/path/to/.git/worktrees/wt/HEAD.lock': Permission denied
>   error: HEAD of working tree /path/to/wt is not updated.
>   error: Unable to create '/path/to/.git/worktrees/wt2/HEAD.lock': Permission denied
>   error: HEAD of working tree /path/to/wt2 is not updated.
>   fatal: Branch renamed to newname, but HEAD is not updated!

Sounds like a good goal.
