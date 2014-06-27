From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] resolve_gitlink_ref_recursive(): verify format of symbolic refs
Date: Fri, 27 Jun 2014 10:53:47 -0700
Message-ID: <xmqqa98y2q8k.fsf@gitster.dls.corp.google.com>
References: <1403866877-15733-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:54:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0aLd-00032C-5l
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 19:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbaF0RyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 13:54:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50285 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbaF0Rx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 13:53:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 711F222767;
	Fri, 27 Jun 2014 13:53:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gCxhaHb3j0fVIAYS4cEjt14Oh9M=; b=pFO06l
	dkXyVkhR58N5aECOAkf7G1D9650iCV9ER63kFMbTmvR3cjBc2zlEMZqIm1NxIebH
	sA3Z7ZjWY/aw0LASEUSFdN/Tuyp3bPoHyur+Idznx/GTbcLaDMEuzqmcruMHupJm
	x6MJG0RS+knhSewKSvWpwaAiGbP5XRm3X6R2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cirnwEUfh4zGz5QocF7Q5ZWRSxOGtp7R
	2UC+GS7J8gHAN7BqUPMO0gz8PH4QdSBL3fsf3tR+5qK6Abw4bHb7W1OZe+jKUkpR
	PDISINR2hz7v9u0/wB6qm/gE/x7vj5HHZtIxNxYQkMREx2TUAkB3hRdLp4f/E9sz
	1yppVg2pBf0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 677CA22766;
	Fri, 27 Jun 2014 13:53:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C7B02275D;
	Fri, 27 Jun 2014 13:53:45 -0400 (EDT)
In-Reply-To: <1403866877-15733-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 27 Jun 2014 13:01:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FBC57BB6-FE23-11E3-B40F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252565>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> When reading a symbolic ref via resolve_gitlink_ref_recursive(), check
> that the reference name that is pointed at is formatted correctly,
> using the same check as resolve_ref_unsafe() uses for non-gitlink
> references.  This prevents bogosity like
>
>     ref: ../../other/file
>
> from causing problems.

I do agree that a textual symref "ref: ../../x/y" that is stored in
".git/HEAD" or in ".git/refs/L" will step outside ".git/" and it is
problematic.  But if ".git/refs/heads/a/b/LINK" has "ref: ../../x"
in it, shouldn't we interpret it as referring to the ref at
"refs/heads/x"?

> Given that symbolic references cannot be transferred via the Git
> protocol, I do not expect this bug to be exploitable.
>
>  refs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index dc45774..7da8e7d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1273,6 +1273,9 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
>  	while (isspace(*p))
>  		p++;
>  
> +	if (check_refname_format(p, REFNAME_ALLOW_ONELEVEL))
> +		return -1;
> +
>  	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
>  }
