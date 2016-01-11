From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Correctly handle transient files in shared repositories
Date: Mon, 11 Jan 2016 13:12:06 -0800
Message-ID: <xmqqa8obx1ll.fsf@gitster.mtv.corp.google.com>
References: <cover.1452085713.git.johannes.schindelin@gmx.de>
	<cover.1452537321.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:12:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIjl8-0003rX-LQ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759203AbcAKVMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:12:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751761AbcAKVMI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:12:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4468939E18;
	Mon, 11 Jan 2016 16:12:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=96jYUWSYoZcbnxfu9uI6Nx+qnp4=; b=GWs6qJ
	O0cqnRb3pOnx1yGrXAN0uIZPWb78c4pbne6FS0gJkas3nuZDDSEdaQD+nqyTqBnU
	RRD5s+FDJ+E4QH+DgI8SaphIylm66I5C/TwV2ivRswjdFjv4IGEPAfpf5t88qboh
	coIrwvO5toKASvl066DdKmptAJSexwrur9T6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XppmyJCvXhD/plAO/khjFcuozxhTDP2Y
	r3QU5YZo9wI59IGPYNMmKPD1SADMsZXeNbb8TuvmEnHpzLtuHXivj4g2GbDLl8o0
	8600luO/H4GH2rvjKOkcSlggJyBdGesu1W8ZLTJZDy/HAjK/9jReB7f+h023LS4F
	DyuCcPlkv+8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 39A3739E17;
	Mon, 11 Jan 2016 16:12:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D91039E12;
	Mon, 11 Jan 2016 16:12:07 -0500 (EST)
In-Reply-To: <cover.1452537321.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Mon, 11 Jan 2016 19:35:42 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8C36762-B8A7-11E5-9645-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283720>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Transient files, e.g. commit messages, are writable only by the owner,
> even in shared repositories, to avoid interference between competing
> users working on the same files.
>
> These files are typically not deleted after use. As a consequence, we
> have to delete such files before writing when they are owned by someone
> else than the current user.
>
> The only change relative to v2 is that the second commit message
> clarifies why apply, fsck and fast-import are left unchanged.

I do not think it clarifies to make "fsck" whose lost and found are
written to GIT_DIR and "apply"'s ".rej" share the same "we dunno"
reasoning, though.

For "apply"'s .rej and "rerere"'s resolution, the reason why we
should not touch these codepaths is because we know we should not
muck with permission bits of working tree files (i.e. checkout
refrains from doing so, and these codepaths should be consistent),
not because it is not clear.  It _is_ clear we should not, and that
is because we don't.

I said "I am not convinced" but that is for future discussion of
possibly changing the behaviour of checkout and other things that
touch the working tree files, which hasn't even started.

Other than that, the resulting tree looks good to me, though.

Thanks.

> Reported-by: Yaroslav Halchenko <yoh@onerussian.com>
>
>
> Johannes Schindelin (2):
>   commit: allow editing the commit message even in shared repos
>   Handle more file writes correctly in shared repos
>
>  builtin/commit.c      |  2 +-
>  builtin/fast-export.c |  2 +-
>  builtin/fetch.c       |  2 +-
>  git-compat-util.h     |  1 +
>  wrapper.c             | 13 +++++++++++++
>  5 files changed, 17 insertions(+), 3 deletions(-)
