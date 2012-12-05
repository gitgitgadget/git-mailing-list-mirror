From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Perform minimal stat comparison when some stat fields
 are not set
Date: Wed, 05 Dec 2012 15:43:47 -0800
Message-ID: <7vhao0jc98.fsf@alter.siamese.dyndns.org>
References: <1354742425-71417-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 00:44:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgOdP-0000u1-PN
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 00:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab2LEXnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 18:43:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765Ab2LEXnu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 18:43:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 156F7A204;
	Wed,  5 Dec 2012 18:43:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mKa8PJLFFTxk9lFT5yIGKa5qz28=; b=uRibbq
	aE95Ta3yCtYCToYy7JNyFVYIZU/1CUu+unrifoNQEX9Gc9BQfF+9eGC2vNZFzKHh
	7pUyjArVF4uO/8Y4TSPFl5PPqlL+AS16besq39L2TRo8UwbGYCyzuncTXy/MlcTO
	1nBUbfZXcfPu3mbkK8X77xJ6oUindvlgGYYuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BmfUCqhKcm2l0jwyMc0pjlnW9kcis3DE
	GhQ9W+pcbRRjeCKANjOa8hF+o8kxg9mXv7n+R/oiTOko6q68xfvYZ9P4mQr1G1a8
	VC8ESKqe3vcaupzUH7Vpjc9dxip2SkbPmQmtDNM3fee5oyXmRsRqx4/bVC5ts4oO
	WcKQCFd/FPk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01734A203;
	Wed,  5 Dec 2012 18:43:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B7C7A202; Wed,  5 Dec 2012
 18:43:49 -0500 (EST)
In-Reply-To: <1354742425-71417-1-git-send-email-robin.rosenberg@dewire.com>
 (Robin Rosenberg's message of "Wed, 5 Dec 2012 22:20:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E28CE26-3F35-11E2-9A9F-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211145>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> At least JGit does sets uid, gid, ctime, ino and dev fields to zero
> on update. To Git this looks like the stat data does not match and
> a full file compare will be forced even it size and mtime match. This
> is in practice unnecessary. Sense JGit's presence by checking if ino
> and dev is zero.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  read-cache.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index fda78bc..6f13a22 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -197,21 +197,26 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>  	}
>  	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
>  		changed |= MTIME_CHANGED;
> -	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
> +
> +	int minimal_stat = (ce->ce_ino == 0 && ce->ce_dev == 0);

decl-after-stmt.

Besides, is it sane to do this unconditionally to affect people who
do not use JGit?
