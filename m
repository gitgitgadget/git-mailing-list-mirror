From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/6] environment: static list of repo-local env vars
Date: Wed, 24 Feb 2010 07:58:17 -0800
Message-ID: <7vhbp64odi.fsf@alter.siamese.dyndns.org>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1266996196-25978-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 16:58:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkJdR-0000NC-3S
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 16:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849Ab0BXP6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 10:58:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab0BXP6g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 10:58:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A596C9C440;
	Wed, 24 Feb 2010 10:58:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=12YeKli2SJ5L1P9ulubwWBb56gQ=; b=xlP40w0w1bWh0Zw7LjrA3G0
	UMKUIgYcO4zd/X6M6mj+Yr41Y0Jh+BTggxZmDpyBcmIkE7Vhe0Gal7oa7BPDvru/
	EHFluVaC3TINVqNi7/khKbef7ifkxKV1PhRqZfLQP4NnVUM/y2PDgEX+sfpgrvfK
	hTR8mR1EH3TqlQuo03iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yaE/BFUUhXQLYIPSmhosWH0Yi5Q+d5xobW595P2+zYQy5Vvk1
	ZobJkZbNHsXKx5eamjhReSbXNOEkJgxeZ/I5QAt8qOvyTQmt4a54thJX1ff9PJmu
	FEPo9OedL7FBTEc5IqKBD2ZWX5OK6Mx+63UUhxOR+LrlzGBc0PIOrohP4o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34CCC9C438;
	Wed, 24 Feb 2010 10:58:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDA909C42D; Wed, 24 Feb
 2010 10:58:19 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 728C2FA4-215D-11DF-B513-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140949>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> +/* Repository-local GIT_* environment variables */
> +const char *const local_repo_env[] = {
> +	ALTERNATE_DB_ENVIRONMENT,
> +	CONFIG_ENVIRONMENT,
> +	DB_ENVIRONMENT,
> +	GIT_DIR_ENVIRONMENT,
> +	GIT_WORK_TREE_ENVIRONMENT,
> +	GRAFT_ENVIRONMENT,
> +	INDEX_ENVIRONMENT,
> +	NO_REPLACE_OBJECTS_ENVIRONMENT,
> +	NULL
> +};
> +
> +const unsigned int local_repo_env_size = ARRAY_SIZE(local_repo_env);

This does not look very useful for two reasons.

 - It counts the NULL at the tail, so the number is one-off; you cannot
   say

	for (i = 0; i < local_repo_env_size; i++)
		do_something_to(local_repo_env[i]);

 - local_repo_env_size is not a compile time constant, so you cannot do:

	const char *env[local_repo_env_size + 20];
	memcpy(env, local_repo_env, sizeof(env[0]) * local_repo_env_size);
	for (i = local_repo_env_size; i < ARRAY_SIZE(env); i++)
		add_more_to(env + i, ...);
