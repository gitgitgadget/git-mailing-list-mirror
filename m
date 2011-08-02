From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/19] Allow querying all attributes on a file
Date: Tue, 02 Aug 2011 08:34:26 -0700
Message-ID: <7vwrevg73x.fsf@alter.siamese.dyndns.org>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
 <1311828418-2676-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 02 17:34:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoGzM-0005CF-FZ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 17:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721Ab1HBPec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 11:34:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318Ab1HBPea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 11:34:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E0EC3D5D;
	Tue,  2 Aug 2011 11:34:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fhU0UGTpcAWmmkHMVSjugllnQ/o=; b=lnYySo
	VbeeRQhv0E+HGOwyms8xhAyWIAlzrVVqPp2Jc+EIG5TYV8UWcOVPEk1tmtxGPXn1
	hmapg5Rj1dpqfTrzEl8ctNO3x5Lywijzn6Vx6G7Bk+qxwUiJI5hQER+a2i6Og4mT
	RlAhljEoNff/7X0c6SQ7EsC7Nm2lnw1uUl03o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kw3+AeO1pVHtM9ftDF/91KBJLSLsp5rG
	XrcX2ufY3X8uBt4hB5FX0YvSvV3cgLnmUxrLBCQ/rRFka7wsz3UdCJLvbSr+bc/v
	afi5mjfQenFltbypad7F88S+Et0F6KLm5xnnqUKL/9e97qOGQkUCawBZO/a6TpLn
	pcoz/8Y4bKE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34A043D5C;
	Tue,  2 Aug 2011 11:34:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAFA03D5B; Tue,  2 Aug 2011
 11:34:28 -0400 (EDT)
In-Reply-To: <1311828418-2676-10-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Thu, 28 Jul 2011 06:46:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E902844C-BD1C-11E0-9CD9-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178476>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Add a function, git_allattrs(), that reports on all attributes that
> are set on a path.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/technical/api-gitattributes.txt |   45 +++++++++++++++++-------
>  attr.c                                        |   43 +++++++++++++++++++++++
>  attr.h                                        |    9 +++++
>  3 files changed, 84 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
> index ab3a84d..640240e 100644
> --- a/Documentation/technical/api-gitattributes.txt
> +++ b/Documentation/technical/api-gitattributes.txt
> @@ -22,19 +22,6 @@ Data Structure
> ...
>  (JC)

The last line, I think, can now be dropped. This was a marker saying "we
lack documentation for this API; bug this person for necessary information
and write one".

> diff --git a/attr.c b/attr.c
> index bfa1f43..9c2fca8 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -737,6 +737,49 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
>  	return 0;
>  }
>  
> +int git_allattrs(const char *path, int *num, struct git_attr_check **check)
> +{
> +	struct attr_stack *stk;
> +	const char *cp;
> +	int dirlen, pathlen, i, rem, count, j;
> +
> +	bootstrap_attr_stack();
> +	for (i = 0; i < attr_nr; i++)
> +		check_all_attr[i].value = ATTR__UNKNOWN;
> +
> +	pathlen = strlen(path);
> +	cp = strrchr(path, '/');
> +	if (!cp)
> +		dirlen = 0;
> +	else
> +		dirlen = cp - path;
> +	prepare_attr_stack(path, dirlen);
> +	rem = attr_nr;
> +	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
> +		rem = fill(path, pathlen, stk, rem);

Shouldn't the above part at least should be refactored instead of copied
and pasted from git_checkattr()?
