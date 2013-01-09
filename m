From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/19] reset: don't allow "git reset -- $pathspec" in
 bare repo
Date: Wed, 09 Jan 2013 11:32:15 -0800
Message-ID: <7vtxqq5f0g.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-5-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:32:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1OE-0004JG-NN
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249Ab3AITcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:32:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096Ab3AITcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:32:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BFCDA12C;
	Wed,  9 Jan 2013 14:32:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6t5U1+Xx1n3xGLCagkC+76cutW8=; b=tF6QgG
	rpONbQ36QzjPo8lWrs/3xntKDeVkHJkc8/essGYl2FFcZYVahFFZ3P+fvWjbNEew
	8NUynfrNcM0WTj1u1eHEGrLp9y7B6ozU8+dHnmqElGauv8Xe3f7a1i5fU8Fwy+Un
	QzkRhLSOqSCbIOaNsFq3U6rFsjV0XDAzjkSJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mMHzjvA/vNj5GIweKRarqUucCmNHGSD/
	B3MUVOABpHnz6QJ/lFXaW6BXfkDaDv6NH9uKOP1pLRtwh+K4s9MBpw6DPKCE8iIn
	xR4qcEQ5bpbiXi6+G7H80+Mzj686DXjWA8W5TMEAWZY/x3pu6QTJAzojYeh2ldJt
	3rVkjDDOc9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C287BA128;
	Wed,  9 Jan 2013 14:32:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50D58A11A; Wed,  9 Jan 2013
 14:32:17 -0500 (EST)
In-Reply-To: <1357719376-16406-5-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Wed, 9 Jan 2013 00:16:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4780B592-5A93-11E2-A569-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213083>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> ---
>  builtin/reset.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

With the patch that does not have any explicit check for bareness
nor new error message to scold user with, it is rather hard to tell
what is going on, without any description on what (if anything) is
broken at the end user level and what remedy is done about that
breakage...

>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 045c960..664fad9 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -295,8 +295,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  		else if (reset_type != NONE)
>  			die(_("Cannot do %s reset with paths."),
>  					_(reset_type_names[reset_type]));
> -		return read_from_tree(pathspec, sha1,
> -				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
>  	}
>  	if (reset_type == NONE)
>  		reset_type = MIXED; /* by default */
> @@ -308,6 +306,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  		die(_("%s reset is not allowed in a bare repository"),
>  		    _(reset_type_names[reset_type]));
>  
> +	if (pathspec)
> +		return read_from_tree(pathspec, sha1,
> +				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
> +
>  	/* Soft reset does not touch the index file nor the working tree
>  	 * at all, but requires them in a good order.  Other resets reset
>  	 * the index file to the tree object we are switching to. */
