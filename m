From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 09/13] new_branch(): verify that new branch name is a valid
 full refname
Date: Wed, 19 Oct 2011 14:52:09 -0700
Message-ID: <7vobxcbqeu.fsf@alter.siamese.dyndns.org>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
 <1319057716-28094-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 19 23:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGe3c-00039b-W3
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176Ab1JSVwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:52:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64039 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957Ab1JSVwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:52:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17FF662CB;
	Wed, 19 Oct 2011 17:52:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+SSdh3bLnjYVWn7lvmUawQ+7xBU=; b=rQOteg
	CQhgR7/UizMegiVNzEZPgnG4qRBiQzaEyLg5P378qNadSMiHYNEAho+V4yR+qgh3
	wLjNPzc8g8/I3NeCjKf7u+mshSYAilIsjtPsdlKgl/NtK3IxKICoPXEdJxGR4Ide
	0BK/NkCUglVO+E675v2d4QhqVoYaAxvmxlGQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hHeqfOcWZvhXbp/+7Jaeh5KWZw9NyEXe
	83zVWXFWhosgAaYyZMOo/PK/zxRg8Hnp/iir0O9/OAXpg183IQ+EmfVic2lRgOu9
	si6egn3yMekpTLr3v+FZLKjoE6u07wsN6chtkCobeTCV3qWHZPC+lJH+K/qO7KKL
	sRQv07+zZ7c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F74662CA;
	Wed, 19 Oct 2011 17:52:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8261862C6; Wed, 19 Oct 2011
 17:52:10 -0400 (EDT)
In-Reply-To: <1319057716-28094-10-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Wed, 19 Oct 2011 22:55:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98BFB1EA-FA9C-11E0-9881-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183984>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>
> Is it possible to omit the REFNAME_ALLOW_ONELEVEL option from this
> call?

I _think_ it takes an unadorned branch name, so the most prudent would be
to check the result of prefixing "refs/heads/" to *name with REFNAME_FULL.

>  fast-import.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index 8d8ea3c..51cf898 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -722,7 +722,7 @@ static struct branch *new_branch(const char *name)
>  
>  	if (b)
>  		die("Invalid attempt to create duplicate branch: %s", name);
> -	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
> +	if (check_refname_format(name, REFNAME_FULL|REFNAME_ALLOW_ONELEVEL))
>  		die("Branch name doesn't conform to GIT standards: %s", name);
>  
>  	b = pool_calloc(1, sizeof(struct branch));
