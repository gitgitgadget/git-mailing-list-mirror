From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Thu, 07 Jun 2012 11:07:01 -0700
Message-ID: <7vpq9bgfne.fsf@alter.siamese.dyndns.org>
References: <1338927687-29822-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339075029-27109-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339075029-27109-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 07 20:07:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sch71-0002EF-AH
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 20:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760065Ab2FGSHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 14:07:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760006Ab2FGSHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 14:07:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3395B856E;
	Thu,  7 Jun 2012 14:07:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kl37JQNhMQgjqYdEnP7Hi+G30T8=; b=IO9mnn
	WM029E+/oUO68D79Q99o+jrMRWLa8Rey4SnnTZmALLARegAQrpCCKeQNGaHMCSUw
	ceHApFCjFTTDfQr/dirsE+LNN6IUC8hh0GarOHaGCykZGfNujwmzgEjVlVNcHYBB
	mDx/I4IELcr7oAftVrwDtlp5JaRnfnOPiWVwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cnRcPIMztBDM//JVAtyBvSGH0+TgErNL
	pd3e+V0RQGpoWdin0yl9cjrynwtDey9kqfBASJmnR3mv8rRMEHJ3Z6esd2TEvjvD
	V2DXQ41n/W2We+tlaURbcxEqMk/f4fUnHwpXl0SyUuCPrc13LO/btAimTtjuo0b/
	S5iaT60aHmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A8A0856B;
	Thu,  7 Jun 2012 14:07:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B46F48569; Thu,  7 Jun 2012
 14:07:02 -0400 (EDT)
In-Reply-To: <1339075029-27109-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Lucien Kong's message of "Thu, 7 Jun 2012 15:17:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 954CE11E-B0CB-11E1-95BF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199432>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> +static int split_commit_in_progress(struct wt_status *s)
> +{
> +	int split_in_progress = 0;
> +	const char *head = read_line_from_git_path("HEAD");
> +	const char *orig_head = read_line_from_git_path("ORIG_HEAD");
> +	const char *rebase_amend = read_line_from_git_path("rebase-merge/amend");
> +	const char *rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");

By declaring these newly allocated memory you own in this function
and free() yourself as "const char *", the only thing you are
gaining is the need to cast constness away when you call free().

Why are these necessary?

> +	if (!head || !orig_head || !rebase_amend ||
> +			!rebase_orig_head || !prefixcmp(head, "refs/heads/"))
> +		return split_in_progress;

Can't .git/HEAD be a symlinked symref?
