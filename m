From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: better error messages for detached HEAD and
 "no destination"
Date: Mon, 28 Feb 2011 15:29:47 -0800
Message-ID: <7v8vwzhh5g.fsf@alter.siamese.dyndns.org>
References: <1298927645-2716-1-git-send-email-Matthieu.Moy@imag.fr>
 <1298927645-2716-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:30:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuCXZ-0005lJ-2S
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 00:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab1B1X34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 18:29:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977Ab1B1X3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 18:29:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF4D747D0;
	Mon, 28 Feb 2011 18:31:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ols01ndx8aVHXjQYbxn3/U3hG40=; b=h/yb4ZLUUAAQdJmQeEW2pbh
	5/rQ0ErSzCwBFoAltej2ZfxSbiU0cv6nwMsAFiyTgDxBBJ/fiJX+xuMo3EDrCRR1
	zM9jvtEjX+u/UG67q7rb/H1Kx2RFqOjMioVISAfOZS7yzcESLcKio1EXALaEvAiy
	THDI0FNBW0nLcwlj90tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nsOo1AdcgaLHY5Q5GZFEg3If4dILn/aRD7OZ/p6dmPE4pIIod
	Usm7O2IG/MlB5LQdDMUaFEGOxdaBUoDGfZ/5ZXpRM72s2eXv422PtIHisiZ/MlyN
	kVwKgNwE90sm1ZMwH2a1E5rShboSw/Hk9YdkaVnZV+AfS1+wz1Hunz9ets=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABB4747CE;
	Mon, 28 Feb 2011 18:31:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A9B7E47CD; Mon, 28 Feb 2011
 18:31:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D31307FA-4392-11E0-8A02-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168164>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> In both cases, give a hint on what to do next. We mention explicitely
> "detached HEAD" since this is the keyword to look for in documentations.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  builtin/push.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 210eb36..48fb050 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -69,7 +69,8 @@ static void setup_push_upstream(struct remote *remote)
>  	struct strbuf refspec = STRBUF_INIT;
>  	struct branch *branch = branch_get(NULL);
>  	if (!branch)
> -		die("You are not currently on a branch.");
> +		die("You are not currently on a branch (detached HEAD).\n"
> +		    "Please, checkout the branch you want to push first or specify it on the command line.");

I agree that it is a good thing to suggest specifying what to push on the
command line, but I don't think this "checkout first" is particularly a
good advice, as it requires two-step operation that is quite a roundabout
way of doing what the user wanted to do: a very specific checkout followed
by re-running of a nonspecific push.

> @@ -152,7 +153,14 @@ static int do_push(const char *repo, int flags)
>  	if (!remote) {
>  		if (repo)
>  			die("bad repository '%s'", repo);
> -		die("No destination configured to push to.");
> +		die("No destination configured to push to.\n"
> +		    "Either specify the URL from the command line or configure a remote repository using\n"
> +		    "\n"
> +		    "    git remote add <name> <url>\n"
> +		    "\n"
> +		    "and then push using the remote name like\n"
> +		    "\n"
> +		    "    git push <name>\n");
>  	}

This one would be helpful.
