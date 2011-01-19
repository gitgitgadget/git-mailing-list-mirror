From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Wed, 19 Jan 2011 11:13:39 -0800
Message-ID: <7vei88u2os.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino> <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino> <20110119124230.GD23222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:13:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfdTf-00037y-7o
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab1ASTNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:13:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab1ASTNt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 14:13:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44E9F4A85;
	Wed, 19 Jan 2011 14:14:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ozCCoqJk6txtL/ZAcGKwNBm3acU=; b=L7I6SZ
	SdEpaClDUTouYxBnKx0NIpFx+NJs6rgrA2+E5qP4aVUBNWU4foiHIeD0e7TDpGNq
	D4Dyutqlg0dF7OA+X+ZT1JAQ+qRbrbA5/dbME6SoL9RORkIQZu9w3Mdph6n2F3yH
	EV1cgV36zKdcmxFAguFXTinR9PMWheCkjE/UM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eIECAGGCFtCuF6IJwQzazVVLuosKSDda
	3+QHaVVZBXav85fOPx+BDveusVdemWy2Qa9kp24KMVjxht78N9buecroGOtRBjB6
	3rUSE3M/URbeBrCeTRjSrV6XyBYiMpi8mYslXgDxt6nyrWkOXzbrsTqPMVY/fqog
	yxwCCnvP0Nk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14F144A82;
	Wed, 19 Jan 2011 14:14:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BD7BB4A7F; Wed, 19 Jan 2011
 14:14:26 -0500 (EST)
In-Reply-To: <20110119124230.GD23222@burratino> (Jonathan Nieder's message of
 "Wed\, 19 Jan 2011 06\:42\:30 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 57AA4D14-2400-11E0-97E6-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165277>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In the usual case, git commands are run from within a git worktree.
> The toplevel directory and associated .git dir are found by chdir-ing
> to .. repeatedly until .git is a valid repository.
>
> That behavior can be overridden in two ways.

Hmm, I wouldn't call them "two ways".

We originally had GIT_DIR and people who wanted to use a working tree
without an embedded .git (hence having to use GIT_DIR) complained that
they cannot work from subdirectories while cd'ing around; GIT_WORK_TREE
was added to augment the mechanism to allow them to specify where their
root is.  Saying "two ways" sounds as if it is sane to do one without
doing the other, which is not the case here.

For the same reason (another tangent), although t1510 seems to have
complex rules about "relative to", it does not make much sense to specify
a path in GIT_WORK_TREE relative to user's $cwd.  The mechanism is to
allow people to chdir around inside their working tree that does not have
an embedded .git directory to begin with.

> diff --git a/setup.c b/setup.c
> index 3d73269..c0f5846 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -411,6 +411,16 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>  	if (check_repository_format_gently(gitdir, nongit_ok))
>  		return NULL;
>  
> +	/* Accept --work-tree to support old scripts that played with fire. */
> +	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
> +		warning("pretending GIT_DIR was supplied alongside GIT_WORK_TREE");
> +		if (offset != len && !is_absolute_path(gitdir))
> +			gitdir = xstrdup(make_absolute_path(gitdir));
> +		if (chdir(cwd))
> +			die_errno("Could not come back to cwd");
> +		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
> +	}
> +
>  	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
>  	if (is_bare_repository_cfg > 0) {
>  		set_git_dir(offset == len ? gitdir : make_absolute_path(gitdir));
> @@ -443,6 +453,19 @@ static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongi
>  	if (check_repository_format_gently(".", nongit_ok))
>  		return NULL;
>  
> +	/*
> +	 * Accept --work-tree, reluctantly.
> +	 */
> +	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
> +		const char *gitdir;
> +
> +		warning("pretending GIT_DIR was supplied alongside GIT_WORK_TREE");
> +		gitdir = offset == len ? "." : xmemdupz(cwd, offset);
> +		if (chdir(cwd))
> +			die_errno("Could not come back to cwd");
> +		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
> +	}
> +
>  	inside_git_dir = 1;
>  	inside_work_tree = 0;
>  	if (offset != len) {

This seems to be a good workaround to resurrect the historical buggy
behaviour, but it makes the already ugly code even uglier. Can we do
something about it?

I wonder if it would make it more readable if we restructure
setup_git_directory_gently_1() slightly, perhaps by making the loop to
discover the .git directory/file into a separate helper function that
returns:

 - the path to the discovered .git;
 - if the .git was found as an ancestor of the original $cwd (to handle "bare");
 - if the discovery was aborted due to ceiling (or hitting root);

and make the caller decide what kind of setup to call outside the loop.

But that is a minor point.
