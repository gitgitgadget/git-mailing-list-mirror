From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Limit file descriptors used by packs
Date: Mon, 28 Feb 2011 12:38:56 -0800
Message-ID: <7vwrkjhp27.fsf@alter.siamese.dyndns.org>
References: <1298924835-23413-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 28 21:39:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu9s8-0002VX-6h
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 21:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab1B1UjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 15:39:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab1B1UjG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 15:39:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92A8541A4;
	Mon, 28 Feb 2011 15:40:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UujRtncHv8+PKpGJLlWL8hKKGO0=; b=I2q1c2
	cFRGr21Dhsv2K6+Yi5fWx5YgbHelCBwsl548c4fSAbBGApt4fLjdhYeg1q+sgCu0
	wobL+n+yuoJd7CGh5v2fNynMXsxQiHA2TB5glucujDk0Skw8vLp7ueYSdM1QFDsz
	qTxVUrg5i/Q9KQNHRiMCiv6vpOsR+Sg158ATo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VcPfnY1UmM4D1MuDdhavlDix2Jluem7q
	8O7bniLyEVnxcHKoKfxxDUN2kroIMf0t98zjXsiXub6fgLVOqSHzWJRkG4H/+9xT
	GKR+B7ui1LwucrzuR8Ef9vWpC8MiRqe4fo/rImXOIP977Oucgqw1ZKsNq7rPsl9o
	QPhBm1Qe7Ag=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7080541A2;
	Mon, 28 Feb 2011 15:40:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8EE37419E; Mon, 28 Feb 2011
 15:40:16 -0500 (EST)
In-Reply-To: <1298924835-23413-1-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Mon\, 28 Feb 2011 12\:27\:15 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4DA8894-437A-11E0-BBED-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168139>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> ...  The output file is opened by pack-objects after
> object enumeration and delete compression are done, ...

s/delete/deflate/, I guess.

> diff --git a/sha1_file.c b/sha1_file.c
> index d949b35..8863ff6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -708,9 +713,35 @@ static int open_packed_git_1(struct packed_git *p)
>  	if (!p->index_data && open_pack_index(p))
>  		return error("packfile %s index unavailable", p->pack_name);
>  
> +	if (!pack_max_fds) {
> + ...
> +		if (lim.rlim_cur < lim.rlim_max) {
> +			lim.rlim_cur = lim.rlim_max;
> +			if (!setrlimit(RLIMIT_NOFILE, &lim))
> +				max_fds = lim.rlim_max;
> +		}

This is somewhat questionable, isn't it?  We don't know why the user chose
to ulimit the process yet forcibly bust that limit without telling him?

Other than that it looks sensible.  Thanks.
