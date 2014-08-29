From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] Use timer_settime for new platforms
Date: Fri, 29 Aug 2014 11:12:25 -0700
Message-ID: <xmqq61hb6u7q.fsf@gitster.dls.corp.google.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
	<1409330561-11806-9-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNQfG-0002bX-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbaH2SMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:12:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57914 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbaH2SMl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 14:12:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD68034065;
	Fri, 29 Aug 2014 14:12:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NoDYjcNicSElKgdwvWdsw1gVH+M=; b=FJ5E3m
	jrysr4Rm4nH/o5VLy1tFvxYoSe6ejB8Q+bcLaJid5wtkefr2KsVczUi1lCliTcth
	kwyeR71xUPlkRbDfj/Kz/t1Ez54H6qPe+CFPEL6/fTq2pzAwEZqIEcVbJkKH9+Qp
	6/IE3FZSkWbHBhfJEhVA7xx7JYLy+KPr92J4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UpA+K9ViEKd/8N3G6Fz78e8y5ffRK+UX
	cvKlx/8RnwkX0KOmJyDA19bJdFVmaubaP2SvRPvl38K6f9E5MczEX/g5MZbPRp9N
	N7vaHp1+fh3t4gpCwRS+7zqi5gd/0CFkeUEMO93F6LHwlfHrNv5SRxHyW+alvFgr
	whFC9/lvVdU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D105734064;
	Fri, 29 Aug 2014 14:12:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F3263404E;
	Fri, 29 Aug 2014 14:12:27 -0400 (EDT)
In-Reply-To: <1409330561-11806-9-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Fri, 29 Aug 2014 09:42:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 08A59B8A-2FA8-11E4-B705-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256172>

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index 4389722b4b1e..a39e82d67eb3 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> ...
> @@ -271,9 +271,12 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
>  	 * trigger every second even if we're blocked on a
>  	 * reader!
>  	 */
> -	early_output_timer.it_value.tv_sec = 0;
> -	early_output_timer.it_value.tv_usec = 500000;
> -	setitimer(ITIMER_REAL, &early_output_timer, NULL);
> +	struct itimerspec value;
> +	value.it_value.tv_sec = 0;
> +	value.it_value.tv_nsec = 500000L * 1000L;
> +	value.it_interval.tv_sec = 0;
> +	value.it_interval.tv_nsec = 0;
> +	timer_settime(early_output_timer, 0, &value, NULL);

Do I see decl-after-stmt up there?
