From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule--helper, module_clone: always operate on absolute paths
Date: Fri, 01 Apr 2016 12:18:23 -0700
Message-ID: <xmqq7fghi1ds.fsf@gitster.mtv.corp.google.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
	<1459469849-9643-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	jacob.keller@gmail.com, norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:18:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am4an-00036J-7N
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 21:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbcDATS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 15:18:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751045AbcDATS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 15:18:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D5AF4F89D;
	Fri,  1 Apr 2016 15:18:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=681n2iAp7mtlVQ0vtJx7ER9ck5I=; b=j0QG4D
	Ub102nZOesTtvrR8hKDTXfShs4Ua2nDGVVLDSQojFLy12/+J1TMIN0W8dD6LSFsa
	ObCXlN65KR3GML2VG6Ae7nTXcjr7SygOULYG4T/praB/+hOAsgFuy8KOf+hszEwP
	XZoFCPkH4QHyyT8bsszph6Q9apThO5qmSOyUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jyagtXCn+5VHUPaVJmswjqw2yIaPS0u7
	NLtCsSb4SDoJ5Ms+ARbeqZy6EDwfb+xlM0ffa6qXxYx6tTEk5IOi17oxeRt9wp68
	KbVCvy9RUL0nBFMHjAAcAuLf45Ro6dFUeFaJhQpqUKP88KfOgpg71AY/6ZtHzHRB
	FAFC9nZ/I3s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 547E24F89C;
	Fri,  1 Apr 2016 15:18:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B590A4F89B;
	Fri,  1 Apr 2016 15:18:24 -0400 (EDT)
In-Reply-To: <1459469849-9643-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 31 Mar 2016 17:17:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8176579C-F83E-11E5-AB31-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290575>

Stefan Beller <sbeller@google.com> writes:

> +	char *sm_gitdir_rel, *p, *path = NULL;
> +	const char *sm_gitdir;
>  	struct strbuf rel_path = STRBUF_INIT;
>  	struct strbuf sb = STRBUF_INIT;
>  
> @@ -198,7 +199,14 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  		die(_("submodule--helper: unspecified or empty --path"));
>  
>  	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> -	sm_gitdir = strbuf_detach(&sb, NULL);
> +	sm_gitdir_rel = strbuf_detach(&sb, NULL);
> +	sm_gitdir = absolute_path(sm_gitdir_rel);

With this change, sm_gitdir will always be absolute, which means the
parameter to clone_submodule() call (immedately after this hunk)
will now be always absolute.  I do not think "git clone" called from
there will leave anything in the resulting repository that depends
on the --separate-git-dir=<dir> being relative or absolute, so this
change should not cause us new problems.

By the way, this line is the last use of sm_gitdir_rel before it
gets freed.  I wonder

	sm_gitdir = absolute_path(sb.buf);

would be sufficient.  We can lose the variable, and free() on it at
the end of this function, and an extra allocation if we can do so.

> +	if (!is_absolute_path(path)) {
> +		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), path);
> +		path = strbuf_detach(&sb, 0);
> +	} else
> +		path = xstrdup(path);
>  
>  	if (!file_exists(sm_gitdir)) {
>  		if (safe_create_leading_directories_const(sm_gitdir) < 0)

Other than that, looks good to me.

Thanks.
