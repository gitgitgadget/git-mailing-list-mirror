From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add an explicit GIT_DIR to the list of excludes
Date: Fri, 23 May 2014 13:42:43 -0700
Message-ID: <xmqqha4gi5vg.fsf@gitster.dls.corp.google.com>
References: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, jrnieder@gmail.com, git@vger.kernel.org
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 22:42:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnwIn-0000sw-1E
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 22:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbaEWUmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 16:42:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58379 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbaEWUmt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 16:42:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2AC461A529;
	Fri, 23 May 2014 16:42:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4eZ7PjzWyxpnO+vW9roHQtLhjtY=; b=SprVKk
	BVAaVpwcyT8KKFVfZKaR2YE53GzihOWUeXxV4aLkYIJpu4lF/xHkpy9YEy191IXL
	jyeSGT2ZwH2q7J0AYicw4twUx3q4UYBpOihEnOKKdNjxZR6cwx01hvXrPUaNVwmc
	b7B2BVidtW24PhW0e1TAzgCYEG+Cb9EkF/Wn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AzEIFf6sP8mGID3XibQQuTOyMtVsLvG7
	TPvZELVx9arPdfAUI3FO595ggvvnYPGIVFpPW7PRbN8Bg6+BS1P2UT7J+j66OqMT
	pIkboC8be6cCi8E5ZFReLy0wGLf48mewkxIsvaWu+H7PzJrCg1UPVa5Zz1v7Q49G
	G82EklKjJ+0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E6681A528;
	Fri, 23 May 2014 16:42:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E3EA51A524;
	Fri, 23 May 2014 16:42:44 -0400 (EDT)
In-Reply-To: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com>
	(Pasha Bolokhov's message of "Fri, 23 May 2014 10:33:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CB09A22E-E2BA-11E3-B251-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250031>

Pasha Bolokhov <pasha.bolokhov@gmail.com> writes:

> diff --git a/dir.c b/dir.c
> index 98bb50f..76969a7 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1588,6 +1588,26 @@ void setup_standard_excludes(struct dir_struct *dir)
>  {
>  	const char *path;
>  	char *xdg_path;
> +	const char *gitdir = get_git_dir();
> +
> +	/* Add git directory to the ignores first */
> +	if (strcmp(gitdir, ".git") != 0) {

It is more idiomatic and common to say

	if (strcmp(gitdir, ".git")) {

around here, I think.

>     /* "--git-dir" has been given */

... or it could have come from GIT_DIR environment, no?

Does this "additional exclude" need to kick in if GIT_DIR is set to
"/home/pasha/w/.git"?  That is, when gitdir is ".git" or ends with
"/.git"?

> +		char ngit[PATH_MAX + 1];

Hmmm.  As I recall that recently we had flurry of changes to
eradicate PATH_MAX from our codebase, I am not happy to see an
introduction of a new buffer that is fixed-size.

> +		/*
> +		 * See if GIT_DIR is inside the work tree; need to normalize
> +		 * 'gitdir', whereas 'get_git_work_tree()' always appears
> +		 * absolute and normalized
> +		 */
> +		normalize_path_copy(ngit, real_path(absolute_path(gitdir)));
> +
> +		if (dir_inside_of(ngit, get_git_work_tree()) >= 0) {
> +			struct exclude_list *el = add_exclude_list(dir, EXC_CMDL,
> +							"--git-dir option");
> +
> +			add_exclude(gitdir, "", 0, el, 0);
> +		}
> +	}
>  
>  	dir->exclude_per_dir = ".gitignore";
>  	path = git_path("info/exclude");
> diff --git a/t/t2205-add-gitdir.sh b/t/t2205-add-gitdir.sh
> new file mode 100755
> index 0000000..0c99508
> --- /dev/null
> +++ b/t/t2205-add-gitdir.sh
> @@ -0,0 +1,84 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Pasha Bolokhov
> +#
> +
> +test_description='alternative repository path specified by --git-dir is ignored by add and status'
> +
> +. ./test-lib.sh
> +
> +#
> +# Create a tree:
> +#
> +# 	a  b  c  d  subdir/
> +#
> +# subdir:
> +# 	e  f  g  h  meta/  ssubdir/
> +#
> +# subdir/meta:
> +# 	aa
> +#
> +# subdir/ssubdir:
> +# 	meta/
> +#
> +# subdir/ssubdir/meta:
> +# 	aaa
> +#
> +# Name the repository "meta" and see whether or not "git status" includes
> +# or ignores directories named "meta". The slightly deeper hierarchy is
> +# needed in order to be able to put the repository into "../meta", that is,
> +# outside the work tree and still have files called "meta" within the tree
> +#

It is not quite clear with this large blob of comment what are
noises and what exactly are being tested.  I think you have two
directories called "meta", but which one is the repository?  Or do
you have yet another one next to {a,b,c,d,subdir} called "meta" that
is not listed above?

Given that the reason why people use --git-dir is so that they can
put it completely outside the working tree (in which case, the usual
"start from cwd and go upwards while trying to see if there is .git/
that governs the working tree" logic would not work), readers would
not expect to find the directory to be used as GIT_DIR in the
hierarchy you are creating in the first place.  Because of that, it
is even more important to clearify which "meta" you mean to use as
your GIT_DIR if you want to be understood by readers.
