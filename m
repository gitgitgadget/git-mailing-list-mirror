From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prefer sysconf(_SC_OPEN_MAX) over
 getrlimit(RLIMIT_NOFILE,...)
Date: Wed, 22 Aug 2012 10:23:00 -0700
Message-ID: <7v4nnualjf.fsf@alter.siamese.dyndns.org>
References: <002301cd807f$4e19ad80$ea4d0880$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:23:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Ee6-0002Ic-Mq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822Ab2HVRXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:23:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964824Ab2HVRXE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:23:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25C4B9157;
	Wed, 22 Aug 2012 13:23:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cGqi2uq+13aY5oSfEqnFGuTBlNI=; b=LQ5ma5
	xisjIQBkNz8d6vuUXzfcINysU3vDeER+F1UpVDmLODRjcnzMDy+SSbFTqiqNu6Iv
	GfoSSf1mzgIke8mjt3H5VFqC5WbpQrVR8N1ALws5U3CICtnu/EYGdN6N7qFuVydO
	VfRaNIeUOw2cwVAoJM+GbNGl83gLGyJjIJDKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HRW/2mFQKOK2Dhrr43b0q0iCM0hlSC/Y
	b61BSbR/d8XQ+/KsSEp2U8Mb/Ph445wITb/JHQVOsk+BMyPhaouCc114b+9Mdt8N
	yc8JuTwSVleC1OKu1o7NMZLXz/z92By/0M04PpzcIdWE4EJDQp6dV2z2P2v7JeHc
	SA3W2fEKSH4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 127089156;
	Wed, 22 Aug 2012 13:23:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AD559155; Wed, 22 Aug 2012
 13:23:02 -0400 (EDT)
In-Reply-To: <002301cd807f$4e19ad80$ea4d0880$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 18:00:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06F2FD06-EC7E-11E1-A7CC-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204037>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
>  sha1_file.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index af5cfbd..76714ad 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -747,6 +747,9 @@ static int open_packed_git_1(struct packed_git *p)
>                 return error("packfile %s index unavailable", p->pack_name);
>
>         if (!pack_max_fds) {
> +#ifdef _SC_OPEN_MAX
> +               unsigned int max_fds = sysconf(_SC_OPEN_MAX);
> +#else
>                 struct rlimit lim;
>                 unsigned int max_fds;
>
> @@ -754,6 +757,7 @@ static int open_packed_git_1(struct packed_git *p)
>                         die_errno("cannot get RLIMIT_NOFILE");
>
>                 max_fds = lim.rlim_cur;
> +#endif
>
>                 /* Save 3 for stdin/stdout/stderr, 22 for work */
>                 if (25 < max_fds)
> --
> 1.7.12

Looks sane but it would be more readable to make this a small helper
function, so that we do not need to have #ifdef/#endif in the
primary flow of the code.

By the way, I noticed that you seem to be sending patches out of
git, instead of "diff -ru", which is a good sign ;-).  But all of
your patches are whitespace damaged and cannot be applied X-<.
