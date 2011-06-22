From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetool: Don't assume paths are unmerged
Date: Wed, 22 Jun 2011 14:26:47 -0700
Message-ID: <7v62nx5zhk.fsf@alter.siamese.dyndns.org>
References: <92B6FB42-FE0D-48DC-ABD0-BA1903D842D2@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 23:26:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZUwq-0001Qo-1l
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 23:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758891Ab1FVV0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 17:26:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758618Ab1FVV0u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 17:26:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 10EA14AD3;
	Wed, 22 Jun 2011 17:29:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OFtBVDrMFYQ7GDVvcv3GnrmIOzg=; b=JRfjsj
	ubOGDGRxxKiwOBR4sEY++lQXPdab7DeZLhgG9qGE2ZdjfeaTdXrPFpIVEbuCn/jF
	kP8A8JZkd/otxxSnDkAgqTJeUW+OWkpiYeB0ycCdL/5er7hEYUnov0GEYQKuK5dZ
	OMfBXiASgHcl9u2DPd+MMRI/k2/fpJwh1bi9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kWEnenFQJk3PweOvDsiRYiciU0bEIbNH
	wYiibSCm5ofnSrS1VZ/XWQkPzDn7uN060ar/BJvc7+jzCLY7NJwK0Gj7P+/uCkve
	zDlwGSBfFqv8HAi+5d0Nvafw87NnLKuZdIk+zfVnUXPVFcPoP4J5XodJURvX+9OE
	RFydPeeFgUg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 080AC4AD2;
	Wed, 22 Jun 2011 17:29:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4118E4AD1; Wed, 22 Jun 2011
 17:29:00 -0400 (EDT)
In-Reply-To: <92B6FB42-FE0D-48DC-ABD0-BA1903D842D2@JonathonMah.com> (Jonathon
 Mah's message of "Tue, 21 Jun 2011 19:46:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4EA18C2-9D16-11E0-A4E4-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176255>

Jonathon Mah <me@JonathonMah.com> writes:

> Like commit, mergetool now treats its path arguments as restricting
> operation to the listed paths. Running "git mergetool subdir" will
> prompt to resolve all conflicted blobs under subdir.
>
> Previously mergetool would assume each path was in an unresolved state,
> and get confused when it couldn't check out their other stages.
>
> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> ---

This does two unrelated things, no?

 - Given the name of a file from the command line, current mergetool gets
   confused if the given file is not in a conflicted state (bugfix).

 - Instead of taking command line arguments as literal filenames, treat
   them as pathspec like any sane git subcommand does, allowing the users
   more flexibility (new feature).

And the title of the patch advertises only the first point.  Using the
command line argument as pathspec may make a lot of sense, and code
reduction in git-mergetool.sh with this patch may also be a good change.

> diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
> index 8c79ae8..f1f4e7a 100644
> --- a/Documentation/git-mergetool.txt
> +++ b/Documentation/git-mergetool.txt
> @@ -16,9 +16,10 @@ Use `git mergetool` to run one of several merge utilities to resolve
>  merge conflicts.  It is typically run after 'git merge'.
>  
>  If one or more <file> parameters are given, the merge tool program will
> -be run to resolve differences on each file.  If no <file> names are
> -specified, 'git mergetool' will run the merge tool program on every file
> -with merge conflicts.
> +be run to resolve differences on each file (skipping those without
> +conflicts).  Specifying a directory will include all unresolved files in
> +that path.  If no <file> names are specified, 'git mergetool' will run
> +the merge tool program on every file with merge conflicts.

The documentation may also have to reword <file> written back in the days
when they were literal filenames, not pathspecs.

> +	matches=$(git ls-files -u -- "$1" | sed -e 's/^[^	]*	//' | sort -u)

Would we want to catch and signal a typo like this?

	git mergetool Mkaefile
	git mergetool Documentaiton/

when there is a conflict in Makefile and some file in Documentation/
directory, and user obviously wanted to name them but botched typing? I
think you are just letting these typos silently go.

> @@ -392,7 +410,7 @@ test_expect_success 'directory vs modified submodule' '
>      test "$(cat submod/file16)" = "not a submodule" &&
>      rm -rf submod.orig &&
>  
> -    git reset --hard &&
> +    git reset --hard >/dev/null 2>&1 &&

What is the justification for this change?

Please do not make "sh txxx.sh -v" less useful.
