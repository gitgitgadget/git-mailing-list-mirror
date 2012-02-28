From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2a] pretty: detect missing \n\n in commit message
Date: Tue, 28 Feb 2012 09:27:26 -0800
Message-ID: <7vipiq27i9.fsf@alter.siamese.dyndns.org>
References: <010901fbfffe0f806bb19d556ebc1e512a4697f4.1330425111.git.trast@student.ethz.ch> <5234ba4babd28d9430750d227d629b4d4386b131.1330425111.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 28 18:27:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Qpt-0000wE-KS
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 18:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214Ab2B1R1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 12:27:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964891Ab2B1R1b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 12:27:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBAA364C5;
	Tue, 28 Feb 2012 12:27:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OJQttzW2VIL0wt3fTRWP+5d8yAM=; b=Vp1v4H
	DLSEclu9d1Pe2lE1K++S+puzeiwSLYFhDlFn3yAQWaTjSRfn+Si7Vs6VZglVSEBB
	sEVIWp3zyhATXTz0LuK+tPCjxdlzOuoCJQngih4M2maSvzwFOqRTdt9Uy1zXJwot
	OBEVcl4sqU5J/q5U1RGy48MBAlU7r3N012ASE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EVi21n7IfB6iS88OveTk0XqDcuHNpy57
	GCGj0gmcdDYc+WEsoTjsnIkKBmSFArLHYuZWMeJNTxvhk/o8ape6n+hrVN2YScPj
	UVEPSn9QXs19EXZJwJnJyz5SrsW+ZhgmCqpZ/w+nuZYduJp5TjJYrjrKUPCsli0J
	VlrMwC/ZMLw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2B6D64C3;
	Tue, 28 Feb 2012 12:27:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6198064C1; Tue, 28 Feb 2012
 12:27:30 -0500 (EST)
In-Reply-To: <5234ba4babd28d9430750d227d629b4d4386b131.1330425111.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 28 Feb 2012 11:37:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DF7290E-6231-11E1-9914-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191748>

Thomas Rast <trast@student.ethz.ch> writes:

> get_header()'s exit condition is finding the \n\n that separates the
> commit header from its message.  If such a double newline is not
> present, it segfaults.  Catch this case and die().
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> This would be the minimal fix to the pretty machinery so that 'git
> rev-list --pretty=something HEAD' works when there are such broken
> commits.
>
> If 2b goes in, there isn't really any point as we would never get this
> far on such a commit.
>
>
>  pretty.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/pretty.c b/pretty.c
> index 8688b8f..b7f097d 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -440,7 +440,10 @@ static char *get_header(const struct commit *commit, const char *key)
>  	const char *line = commit->buffer;
>  
>  	for (;;) {
> -		const char *eol = strchr(line, '\n'), *next;
> +		const char *eol, *next;
> +		if (!line)
> +			die (_("malformed commit object: no separating \\n\\n?"));
> +		eol = strchr(line, '\n');

The same comment applies here.

You can just return NULL in this case, I suppose?

>  		if (line == eol)
>  			return NULL;
