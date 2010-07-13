From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use dev_t for device id (st_dev) from stat in
 setup_git_directory_gently()
Date: Tue, 13 Jul 2010 13:55:35 -0700
Message-ID: <7voceb2jaw.fsf@alter.siamese.dyndns.org>
References: <1279011720-21424-1-git-send-email-harinath@hurrynot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Raja R Harinath <harinath@hurrynot.org>
X-From: git-owner@vger.kernel.org Tue Jul 13 22:55:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmW8-0002YD-9e
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 22:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273Ab0GMUzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 16:55:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757144Ab0GMUzm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 16:55:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCDD5C430A;
	Tue, 13 Jul 2010 16:55:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=exJkAWp5xgrkSc+BCQIcY/awCms=; b=SIcqfQ
	m+oyPfJIM4q4txWz7x4Xe8VYDDoJyjUbSzyNs9AlAe3WzN5UNuDTG/WCbGlcMl04
	kvxsXiTZUidTMZBJ7lx8QlmCeFXKVxeC1bbs0in9sZk9QkP8Q3uhNOe/FIVk5azR
	fy46wP9O55+YQ+j3m7JlEmUFmxTgnNWrXAuHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ELeDRMkU82cdYn2Hd99ybmYxB+Rr4tT0
	w68KR/roQK5HRYmjQBBsyw8SDGNsU/ERNJacF0sFa54B8Xx0Vht3yW3gZRqfaQH1
	QIpQz3WDbAeAF4kRrPAdD1bs3a22MK6rsZWjJ/lI7/bZG6F6ooHfheWomjIvLa6/
	GVBU3WAd5tE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB87BC4309;
	Tue, 13 Jul 2010 16:55:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2D1AC4308; Tue, 13 Jul
 2010 16:55:36 -0400 (EDT)
In-Reply-To: <1279011720-21424-1-git-send-email-harinath@hurrynot.org> (Raja
 R. Harinath's message of "Tue\, 13 Jul 2010 14\:32\:00 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE5C9F2A-8EC0-11DF-BBE1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150912>

Raja R Harinath <harinath@hurrynot.org> writes:

> The original declaration was int, which seems to cause trouble on my
> machine.  It causes spurious "filesystem boundary" errors when running
> the testsuite.  The cause seems to be
>
>   $ stat -c%d .
>   2147549952
>
> which is too large for a 32-bit int type.
>
> Using the correct type, dev_t, solves the issue.  (Because I'm
> paranoid and forgetful, I checked -- yes, Unix v7 had dev_t.)
>
> Other uses of st_dev seem to be reasonably safe.   fill_stat_cache_info
> truncates it to an 'unsigned int', but that value seems to be used only
> to validate the cache, and only if USE_STDEV is defined.
> ---

Makes sense; thanks.

Sign-off?


>  setup.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 7e04602..87c21f0 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -323,7 +323,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	const char *gitdirenv;
>  	const char *gitfile_dir;
>  	int len, offset, ceil_offset, root_len;
> -	int current_device = 0, one_filesystem = 1;
> +	dev_t current_device = 0;
> +	int one_filesystem = 1;
>  	struct stat buf;
>  
>  	/*
> -- 
> 1.7.2.rc2.11.g03e33
