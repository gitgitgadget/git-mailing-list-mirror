From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: display a more helpful error message if the file was deleted
Date: Wed, 16 Dec 2015 11:56:47 -0800
Message-ID: <xmqq37v2dv5s.fsf@gitster.mtv.corp.google.com>
References: <1450224047-25527-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 20:57:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9IC4-0004Ub-E0
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 20:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966548AbbLPT44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 14:56:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966113AbbLPT4z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 14:56:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CA9A3435E;
	Wed, 16 Dec 2015 14:56:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CWcFUmTeclCmrcsA2bcdiIvabhY=; b=kyN56S
	77kRNj6mOCZFLBvBCByclIiI8yjz1H1BICNimmRlyHSiCJ3JJFM04Yhi0K2oip0n
	hozE4dK0UMK5EBzZjFOZk3cR7sBCq4Cu1BwPPYeU92XtDYG+2i7z3CyVVkK1jQYj
	5+JTggej0AkDYhNwfWJ87T3lzuCVVOGzZ6whQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PpTYGHuTDnsE9m1n9nlxBkVRTkmLZykt
	0rHyCp04H+Mc/MWq5WuISquo1gy8jhETE+0kV+cAC7h7nFFtllNquDTUc6AQGvel
	/OBKWa/+YwNWqHMlxqtyNKQjAkp923rLNJEu5cp285kNQtYn6otL4kYLf6KMZorW
	gnJF65LSYXw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6416E3435C;
	Wed, 16 Dec 2015 14:56:49 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D610A3435B;
	Wed, 16 Dec 2015 14:56:48 -0500 (EST)
In-Reply-To: <1450224047-25527-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Tue, 15 Dec 2015 17:00:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 249637A8-A42F-11E5-A0B5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282583>

Alex Henrie <alexhenrie24@gmail.com> writes:

> `git blame 22414770 generate-cmdlist.perl` currently results in:
>     fatal: cannot stat path '22414770': No such file or directory
>
> This patch changes the error message to:
>     fatal: ambiguous argument 'generate-cmdlist.perl': unknown revision
>     or path not in the working tree.
>     Use '--' to separate paths from revisions, like this:
>     'git <command> [<revision>...] -- [<file>...]'"
>
> That way, the user knows to rewrite the command as
> `git blame 22414770 -- generate-cmdlist.perl`.

It is unfortunate that the command line parser of 'blame' needs to
cater to an oddball syntax, 'git annotate <path> [<rev>]'.

This change still makes us emit the following funny errors:

    $ ./git blame 00000000 generate-cmdlist.prel
    fatal: bad revision 'generate-cmdlist.prel'
    $ ./git blame generate-cmdlist.prel 00000000
    fatal: bad revision '00000000'

and gives the users a wrong impression that the early argument is
the path and then comes the revision.

I'll take the patch as-is, because the original is not better, i.e.

    $ git blame 00000000 generate-cmdlist.prel
    fatal: cannot stat path '00000000': No such file or directory
    $ git blame generate-cmdlist.prel 00000000
    fatal: cannot stat path 'generate-cmdlist.prel': No such file or directory

and the change is not making things worse.

But I think in the longer term we should deprecate and eventually
remove 'git annotate' with its odd syntax, so that we can lose the
special case we have in the command line parser of 'git blame'.

Thanks.

>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/blame.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 1df13cf..f070272 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2683,8 +2683,6 @@ parse_done:
>  		argv[argc - 1] = "--";
>  
>  		setup_work_tree();
> -		if (!file_exists(path))
> -			die_errno("cannot stat path '%s'", path);
>  	}
>  
>  	revs.disable_stdin = 1;
