From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 39/47] setup: limit get_git_work_tree()'s to explicit
 setup case only
Date: Tue, 18 Jan 2011 11:41:40 -0800
Message-ID: <7v1v4aknij.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 20:42:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfHRI-0005uJ-Pc
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 20:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab1ARTlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 14:41:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab1ARTlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 14:41:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC0963225;
	Tue, 18 Jan 2011 14:42:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ucB7r31qrDcAbU1Gpihf2tRhfRQ=; b=RVGuC5
	xoUBjcu+mkvipgANHqZPWDb6r8Jbc2wMMkr+4KtGBGMFXnueVJqSKBG5hb8l5qk8
	zO2ptlwQHzqqcN+wr3E9Z52ZrKzwwHtCpmTnjgM0sAd9hZ7trsOWNSNo6xjTiSNs
	fVJ0RpS5vnhJoUhDa29Uq6oVyjXofO9CBTOxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VRQguFRXOcy2sAsDNrMgF6J2PYBPuzG1
	EvtXolU0kb/EstEJoG4ECezCXKgoY1rWKag4mkuSYbCv1UwR+rxEDVfrpoP6zuIK
	kg2MwdZzUA10QJEEasX4hqSy8GqjNxywmNQV4CZgaeh0i1HZzOe7M69AcSozpPSA
	fKfxTOUOpSQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C8FB3223;
	Tue, 18 Jan 2011 14:42:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 320FC321E; Tue, 18 Jan 2011
 14:42:27 -0500 (EST)
In-Reply-To: <20110118074400.GA4185@burratino> (Jonathan Nieder's message of
 "Tue\, 18 Jan 2011 01\:44\:00 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 177510D2-233B-11E0-B004-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165212>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/setup.c b/setup.c
> index 3d73269..28b2fef 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -419,6 +419,11 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>  		return NULL;
>  	}
>  
> +	if (getenv(GIT_WORK_TREE_ENVIRONMENT)) {
> +		warning("GIT_WORK_TREE without explicit GIT_DIR is deprecated");
> +		return setup_explicit_git_dir(gitdir, cwd, offset, nongit_ok);
> +	}
> +

My knee-jerk reaction is that calling this "deprecated" is probably
confusing. git merely failed to notice misconfiguration so far and went
ahead to produce a random result when GIT_DIR is not set (hence the usual
rule is in effect to find out where the .git directory is, starting from
the assumption that you _are_ somewhere _inside_ the work tree, _and_ the
root of the work tree _is_ where that .git directory is found in) and at
the same time GIT_WORK_TREE is pointing at a random other location.

Unless that location happens to match the parent directory of the
discovered .git, this invalidates the assumption of the whole discovery
logic (iow, how you found .git to begin with). In other words, it is my
understanding that setting only GIT_WORK_TREE without setting GIT_DIR
wasn't meant to be supported at all, because there is no sane logic to
specify a consistent behaviour in such a case.

If "we first run discovery as if you were somewhere in your work tree to
find .git directory, but you are allowed to say that your working tree is
elsewhere, possibly completely unrelated to the tree hierarchy used to
find .git directory to begin with; we could accomodate these conflicting
wishes because hopefully the necessary set-up happens before we actually
need to touch anything in the work tree" were a sane specification, this
patch may start making sense. Not breaking existing scripts that rely on
the behaviour is a nice bonus. The "hopefully" part makes me worried
enough to keep me from saying that semantics is sane without thinking
though.

I notice that git(1) manual page discusses --work-tree=<path> (and
GIT_WORK_TREE) to a reasonable level of details (the most importantly, the
rule to determine where the root of the working tree is when nothing is
specified is given), but the corresponding description on --git-dir=<path>
(and GIT_DIR) is too sketchy to tell how the discovery works when nothing
is given. Perhaps that part needs to address what the semantics should be?

>  	/* #0, #1, #5, #8, #9, #12, #13 */
>  	set_git_work_tree(".");
>  	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
> @@ -443,6 +448,11 @@ static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongi
>  	if (check_repository_format_gently(".", nongit_ok))
>  		return NULL;
>  
> +	if (getenv(GIT_WORK_TREE_ENVIRONMENT)) {
> +		warning("GIT_WORK_TREE without explicit GIT_DIR is deprecated");
> +		return setup_explicit_git_dir(".", cwd, offset, nongit_ok);
> +	}
>  	inside_git_dir = 1;
>  	inside_work_tree = 0;

This is for people who do "cd .git && GIT_WORK_TREE=.. git cmd". I have to
wonder what happens to the pathspec given to the cmd---you are clearly
outside of your working tree.

A tangent.

Do we make sure that whatever GIT_WORK_TREE we end up with using is an
ancestor directory of the $CWD when we require us to be inside the working
tree? I think we should, as I don't think of a sane use case otherwise
(unless you call "cd ../neigh; GIT_WORK_TREE=../work git diff ../work/foo"
a sane way to futz with the file "foo" in the working tree "work" from a
directory "neigh" that is unrelated to the repository).
