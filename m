From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/9] git-clean: refactor git-clean into two phases
Date: Tue, 14 May 2013 16:27:00 -0700
Message-ID: <7vvc6ldtx7.fsf@alter.siamese.dyndns.org>
References: <cover.1368518327.git.worldhello.net@gmail.com>
	<7c551bf22bc45cfcdd62d1baf6300f3f86244312.1368518327.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 01:27:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcOcf-0000gI-6o
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 01:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758585Ab3ENX1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 19:27:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758538Ab3ENX1D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 19:27:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE701EC1E;
	Tue, 14 May 2013 23:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QKPZTqYjx6toqS82hTpC6Mh0VKs=; b=qpyan/
	/UAP/mtHBB51ODoQL/xD2JYrqEipji8+kNb8dsl2iylAZqshFHt7V3l08N5uxmQ8
	254dHCXlo+Ii9mya7dRRx/xr4ZDAezAtTq9Ha7ah1mxgsp+9BT4fCkxUojijiHsC
	t/r+xI5SPkcvysNqLa7zMQh3d5NEFCTxXhDm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e4vQ7MXL9UhFSoK8eweiCfo6Qs8h/08t
	JrPElof65tYH3hEJlAxDUGd/ionfdaaE0dBrMxPTvjX+bzSJI8VbHCtCe4PfqDBo
	qd7wExVHobyWuaebyNdV3BhVj+L3fmqLwBg7Vinu85iBhxawkxKVgau+Qv32xzyK
	U35uL3qQxCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0BDC1EC1B;
	Tue, 14 May 2013 23:27:02 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E85D1EC19;
	Tue, 14 May 2013 23:27:01 +0000 (UTC)
In-Reply-To: <7c551bf22bc45cfcdd62d1baf6300f3f86244312.1368518327.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Tue, 14 May 2013 16:45:15 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7D95F7A-BCED-11E2-B4B9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224369>

Jiang Xin <worldhello.net@gmail.com> writes:

> +/*
> + * Give path as relative to prefix.
> + *
> + * This function is a combination of path_relative (in quote.c) and
> + * relative_path (in path.c)
> + */
> +static const char *path_relative(const char *in, const char *prefix)
> +{
> +...

Hmph.  Is it possible to reuse the public one (in path.c) here and
in quote.c, perhaps after enhancing it a bit to serve needs of the
callers of two existing ones and the new callers of this one?

> @@ -242,11 +287,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  				continue; /* Yup, this one exists unmerged */
>  		}
>  
> -		/*
> -		 * we might have removed this as part of earlier
> -		 * recursive directory removal, so lstat() here could
> -		 * fail with ENOENT.
> -		 */
>  		if (lstat(ent->name, &st))
>  			continue;

I am guessing that the reason why you removed the comment is because
during this phase there is no way we "might have removed".  But if
that is the case, does it still make sense to run lstat() and ignore
errors from the call?
