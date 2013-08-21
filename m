From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff: Clarify operation when not inside a repository.
Date: Wed, 21 Aug 2013 11:33:02 -0700
Message-ID: <xmqqwqneuc69.fsf@gitster.dls.corp.google.com>
References: <201308211734.r7LHYwNh008859@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Wed Aug 21 20:33:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCDDm-0000mx-6w
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 20:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab3HUSd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 14:33:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688Ab3HUSdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 14:33:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7409A3B7A2;
	Wed, 21 Aug 2013 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EOoqSI978TbF8Z7+gSd6th5lG0k=; b=chKuV8
	E1zoy1STI1Z8rW13bKCZyzfCCnKzrdzBW9SdyNx95YE4xIzo96B4QFzBv+KZAHea
	1ksVvUFTPtyb2HbYOxAt4ZIil6foMXp6Hkeie+W/mjVrw1h88v9hoQMhBIHehiMu
	fzeoFfjLCGoZIvByxT1gLji1UNEk9j4X/kraU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jwqQBS6wfiLkdmPOFEEe4JcscItgsNYN
	jR0nQR3FpRvt45gFeFHmfQv0wI/+V0/mV+5QSutqinZ89RgdhdupuqAc6n0klTYW
	3innbgviohO0hHlIGNcBUtKCcaMcvT3t/p9kkKy06h2K/Ij+3ps9yb3z3HKEJcpK
	LjcPlj2JrAg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 660393B7A0;
	Wed, 21 Aug 2013 18:33:21 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 953B73B796;
	Wed, 21 Aug 2013 18:33:19 +0000 (UTC)
In-Reply-To: <201308211734.r7LHYwNh008859@hobgoblin.ariadne.com> (Dale
	R. Worley's message of "Wed, 21 Aug 2013 13:34:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 26F1E528-0A90-11E3-B5BB-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232712>

worley@alum.mit.edu (Dale R. Worley) writes:

> Unfortunately, the error message presupposes that the decision to
> execute diff-no-index reflects the user's intention, thus leaving me
> confused, as the error message is only:
>     usage: git diff [--no-index] <path> <path>
> and does not cover the case I intended.  This patch changes the
> message to notify the user that he is getting --no-index semantics
> because he is outside of a repository:
>     Not within a git repository:
>     usage: git diff [--no-index] <path> <path>
> The additional line is suppressed if the user specified --no-index.

It makes perfect sense for your situation, I think.

Do we say "within" in other error messages for similar situations?
Many commands require you to be in a working tree---the ones marked
as NEED_WORK_TREE in git.c call setup.c::setup_work_tree() to do
this check---and the error message phrases "run in a work tree".  We
would want to use the matching phrasing here, too.

For that matter, as no_index variable knows we didn't get an
explicit "--no-index", we can be even more explicit, e.g.

	fatal: If you want to compare two files outside a working
        tree, use "git diff <fileA> <fileB>".

which hopefully will also clarify the consequence of the command,
i.e. compares two files that are _outside_ a working tree.

I am not sure which one is better, though.  Just a random thought
that came to my mind while reading your error message.

> The documentation is expanded to state that execution outside of a
> repository forces --no-index behavior.  Previously, the manual implied
> this but did not state it, making it easy for the user to overlook
> that it's possible to run git-diff outside of a repository.

I am not sure if "forced" is a good description here.  An explicit
"--no-index" does force the command to ignore the fact that the
command is run inside a working tree and compare two paths without
involving Git at all, but the behaviour you saw was to fall back to
the no-index hack instead of failing (the latter of which is a
logical but unfriendly thing to do, as Git is about data managed by
Git, and running Git command that wants a working tree without
having a working tree).  It feels that it is more like "Also, this
mode is used when the command is run outside a working tree" to me.

>  Documentation/git-diff.txt |    3 ++-
>  diff-no-index.c            |    6 +++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 78d6d50..9f74989 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -31,7 +31,8 @@ two blob objects, or changes between two files on disk.
>  +
>  If exactly two paths are given and at least one points outside
>  the current repository, 'git diff' will compare the two files /
> -directories. This behavior can be forced by --no-index.
> +directories. This behavior can be forced by --no-index or by 
> +executing 'git diff' outside of a working tree.
>  
>  'git diff' [--options] --cached [<commit>] [--] [<path>...]::
>  
> diff --git a/diff-no-index.c b/diff-no-index.c
> index e66fdf3..98c5f76 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -215,9 +215,13 @@ void diff_no_index(struct rev_info *revs,
>  		     path_inside_repo(prefix, argv[i+1])))
>  			return;
>  	}
> -	if (argc != i + 2)
> +	if (argc != i + 2) {
> +	        if (!no_index) {
> +		        fprintf(stderr, "Not within a git repository:\n");
> +		}
>  		usagef("git diff %s <path> <path>",
>  		       no_index ? "--no-index" : "[--no-index]");
> +	}
>  
>  	diff_setup(&revs->diffopt);
>  	for (i = 1; i < argc - 2; ) {
