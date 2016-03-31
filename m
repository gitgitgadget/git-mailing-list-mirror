From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Thu, 31 Mar 2016 12:26:28 -0700
Message-ID: <xmqqmvpemot7.fsf@gitster.mtv.corp.google.com>
References: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	matthieu.moy@grenoble-inp.fr
To: Elena Petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:26:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aliEl-0004Ts-O2
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 21:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbcCaT0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 15:26:32 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752539AbcCaT0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 15:26:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3807151DC7;
	Thu, 31 Mar 2016 15:26:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bHOcLY65P0ywz5wXXN6qPBciZdw=; b=PYkAc3
	6Tr4vM//6Ney9ImZHQw5yZ2ArCQOcndnxzOqWur75OcvqYcYd8nBLVg1JuYUG06X
	HfmiBmNvGwkZ5tiim4um8bsqZywa860Qb9LjsxuXQI++QmdAlR3q5LTljoQvyp+s
	z8EMy0s3gx/qNk62AfuxRqKcfv7u2xbsIMhuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jZMFrjI7V+x9pjqeCufamcjU/loF9KqO
	K27Z+MJBDRsoA2q887Ek0QqiuhA5SU+TfGkEHiFY7+7wAFBaJ0G8dOGIss0o4c4W
	Ybf7sEm6WoDqtE187f7xzk5SyWtbjXRaaDQzSmdDUiSipy5veRTbDzn5QFguKuz6
	spU2YLu6Y74=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FA1D51DC6;
	Thu, 31 Mar 2016 15:26:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9B42751DC5;
	Thu, 31 Mar 2016 15:26:29 -0400 (EDT)
In-Reply-To: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com>
	(Elena Petrashen's message of "Thu, 31 Mar 2016 12:25:27 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78059AC4-F776-11E5-A4F3-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290452>

Elena Petrashen <elena.petrashen@gmail.com> writes:

> @@ -214,6 +221,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		const char *target;
>  		int flags = 0;
>  
> +		expand_dash_shortcut (argv, i);
> +		if(!strncmp(argv[i], "@{-", strlen("@{-")))
> +			at_shortcut = 1;
>  		strbuf_branchname(&bname, argv[i]);
>  		if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
>  			error(_("Cannot delete the branch '%s' "
> @@ -231,9 +241,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  					    | RESOLVE_REF_ALLOW_BAD_NAME,
>  					    sha1, &flags);
>  		if (!target) {
> -			error(remote_branch
> -			      ? _("remote-tracking branch '%s' not found.")
> -			      : _("branch '%s' not found."), bname.buf);
> +			error((!strncmp(bname.buf, "@{-", strlen("@{-")))
> +				? _("There is not enough branch switches to"
> +					" delete '%s'.")
> +				: remote_branch
> +					? _("remote-tracking branch '%s' not found.")
> +					: _("branch '%s' not found."), bname.buf);

I was expecting that the check for "@{-" in bname.buf would be done
immediately after strbuf_branchname(&bname, argv[i]) we see in the
previous hunk (and an error message issued there), i.e. something
like:

        orig_arg = argv[i];
        if (!strcmp(orig_arg, "-"))
		strbuf_branchname(&bname, "@{-1}");
	else
		strbuf_branchname(&bname, argv[i]);
        if (starts_with(bname.buf, "@{-")) {
		error("Not enough branch switches to delete %s", orig_arg);
                ... clean up and fail ...
	}

That would give you sensible error message for "branch -d -",
"branch -d @{-1}" and "branch -d @{-4}" if you haven't visited
different branches enough times.

The hope was that the remainder of the code (including this error
message) would not have to worry about this "not enough switches"
error at all if done that way.

> @@ -262,6 +275,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  			       (flags & REF_ISBROKEN) ? "broken"
>  			       : (flags & REF_ISSYMREF) ? target
>  			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
> +			if (at_shortcut && advice_delete_branch_via_at_ref)
> +			       delete_branch_advice (bname.buf,
> +				find_unique_abbrev(sha1, DEFAULT_ABBREV));
>  		}

The existing !quiet report already said "deleted branch" with the
concrete branch name, not "@{-1}" or "-", taken from bname.buf at
this point.

If the advice on how to recover a deletion by mistake would help the
user, wouldn't that apply equally to the case where the user made a
typo in the original command line, i.e. "branch -d foo" when she
meant to delete "branch -d fooo", as well?  If we drop the "at_shortcut"
check from this if() statement, wouldn't the result be more helpful?

Thanks
