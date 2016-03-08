From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Also read SQUASH_MSG if a conflict on a merge squash occurred
Date: Tue, 08 Mar 2016 10:32:51 -0800
Message-ID: <xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Tue Mar 08 19:33:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adMRH-0004lN-5l
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 19:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbcCHSc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 13:32:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750701AbcCHScy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 13:32:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1182E49A08;
	Tue,  8 Mar 2016 13:32:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gaL9bA2YGR8/DmyiuCEqZ9U4TVU=; b=CMpdJt
	YbPeb6js2+w5jFOoxDs8dDH1ujKCDYdaY7znMoT4rA276d+e/WHLZOYe/UD3DF4Z
	NdSkbQJAzM3nECtF3FbDYg1VbuOOyHTOv1oJenEx4t9FNg0fAODBxCsxfa4VTHnk
	EOWdbW2WyZHgxbDM/SMMXy1cDBWO/aM2F4nDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PYZqFQLpKCe6p1oK9keNjimkay50fPue
	eHs1qjiByuLMn7Pa7/u4bJGaUfhMSepW5blFpNj8vPfdxDu8VF6Ueqb6PA7ibgN4
	i6U8iuiOPhPrNbUZXjstPHHxr8Zrd5PnN8euuj5nwBEYqqAFvo7Tv6hN5qaEsBOV
	zVQoUuVIe9M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0840A49A07;
	Tue,  8 Mar 2016 13:32:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 665AE49A04;
	Tue,  8 Mar 2016 13:32:52 -0500 (EST)
In-Reply-To: <56DE5272.2080009@cs-ware.de> (Sven Strickroth's message of "Tue,
	8 Mar 2016 05:17:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2AE8E3D0-E55C-11E5-9A92-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288447>

Sven Strickroth <sven@cs-ware.de> writes:

> Subject: Re: [PATCH] Also read SQUASH_MSG if a conflict on a merge squash occurred

A reader sees this line in the output of "git shortlog --no-merges";
does it sufficiently tell her which Git subcommand is affected by
this change, if this is a bugfix or a new feature, i.e. enough for
her to decide how important the change is?

We often prefix our log message with the name of the area followed
by a colon and describe the purpose of the change, not the means how
the objective is achieved, e.g.

    Subject: [PATCH] commit: do not lose SQUASH_MSG contents

    When concluding a conflicted "git merge --squash", the command
    failed to read SQUASH_MSG that was prepared by "git merge", and
    showed only the "# Conflicts:" list of conflicted paths.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index d054f84..0405d68 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -729,6 +729,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		if (strbuf_read_file(&sb, git_path_merge_msg(), 0) < 0)
>  			die_errno(_("could not read MERGE_MSG"));
>  		hook_arg1 = "merge";
> +		/* append SQUASH_MSG here if it exists and a merge --squash was originally performed */

	/*
         * Our multi-line comment reads more like
         * this.  That is, the first slash-asterisk is on its
         * own line, so is the last asterisk-slash.
         */

> +		if (!stat(git_path_squash_msg(), &statbuf)) {
> +			if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
> +				die_errno(_("could not read SQUASH_MSG"));
> +			hook_arg1 = "squash";
> +		}
>  	} else if (!stat(git_path_squash_msg(), &statbuf)) {
>  		if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
>  			die_errno(_("could not read SQUASH_MSG"));

This reads MERGE_MSG first and then SQUASH_MSG; is that what we
really want?  When you are resolving a conflicted rebase, you would
see the original log message and then conflicts section.  What is in
the SQUASH_MSG is the moral equivalent of the "original log message"
but in a less summarized form, so I suspect that the list of conflicts
should come to end.

The duplicated code to read the same file bothers me somewhat.

I wondered if it makes the result easier to follow (and easier to
update) if this part of the code is restructured like this:

	if (file_exists(git_path_merge_msg()) ||
            file_exists(git_path_squash_msg())) {
	    if (file_exists(git_path_squash_msg())) {
		read SQUASH_MSG;
	    }
            if (file_exists(git_path_merge_msg()))
            	read MERGE_MSG;
	    }
            hook_arg1 = "merge";
	}

but I am not sure if that structure is better.

Thanks.
