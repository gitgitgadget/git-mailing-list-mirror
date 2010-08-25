From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/fetch.c: ignore merge config when not
 fetching from branch's remote
Date: Wed, 25 Aug 2010 14:54:04 -0700
Message-ID: <7vtymipddv.fsf@alter.siamese.dyndns.org>
References: <pzml8liT3RErVlMrdxbSkHmhBs1RMvwYma9UXgvG6WY@cipher.nrlssc.navy.mil>
 <O7UxM6KEqdDAhjJAF7ODSlo_kZavb8gBCJ6laH3QPOlG9a1q29koMQOkS7wDMj0BpyrLYfAcEh4@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, galak@kernel.crashing.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 25 23:54:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoNvM-00071H-P7
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 23:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab0HYVyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 17:54:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab0HYVyS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 17:54:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B46A6D01FC;
	Wed, 25 Aug 2010 17:54:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FdP5sYCTtVoRBhjU1ruC8rNnxos=; b=pDfuMD
	/0DI4X0vGKT6dyGBAUqKDG4y4hVvhAS4W2dqdSTgiCf7zb9Atc78Tv3gxpXbZwH0
	a2YSeUC45KEmP6rvrIvKXkHDpkCOffG8XdYLqaMvJzoNdS3bjeuUPun45y38EJng
	CgPAItYEJRECja6AjUh8O+dnmZJswAlx7BAIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yuk+Ra2Ormy00V4d0OmgJpaClanZTaLz
	Nq9KG/2AU73q4mmKJIjzaRI8i6EdJND6Klc7PElAoYqiY6GPiFWBE/xvB6g85WWF
	Y+hrMkW8sVsaTSEnApGPfb1uFyC0OEYoFTyjwyMwdmfj4bJ9x1ZBk8rI783Cfb/S
	AzaYdq02Ms8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BFE9D01FB;
	Wed, 25 Aug 2010 17:54:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 465E3D01F9; Wed, 25 Aug
 2010 17:54:06 -0400 (EDT)
In-Reply-To: <O7UxM6KEqdDAhjJAF7ODSlo_kZavb8gBCJ6laH3QPOlG9a1q29koMQOkS7wDMj0BpyrLYfAcEh4@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed\, 25 Aug 2010 12\:52\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B33E5A8-B093-11DF-A673-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154481>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ea14d5d..be6c27a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -146,7 +146,8 @@ static struct ref *get_ref_map(struct transport *transport,
>  		struct remote *remote = transport->remote;
>  		struct branch *branch = branch_get(NULL);
>  		int has_merge = branch_has_merge_config(branch);
> -		if (remote && (remote->fetch_refspec_nr || has_merge)) {
> +		if (remote && (remote->fetch_refspec_nr || (has_merge &&
> +				!strcmp(branch->remote_name, remote->name)))) {

Couldn't branch->remote_name or remote->name be NULL here?

I think remote->name would be the same as the URL given on the command
line (i.e. no risk of being NULL), and has_merge would be false even when
branch.<name>.merge is specified if branch.<name>.remote is missing
(i.e. no risk of running this strcmp() to begin with), but the latter
safety guarantee is a bit too subtle for my taste to go without a in-code
comment.

Thanks.
