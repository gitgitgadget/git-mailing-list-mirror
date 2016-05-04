From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: introduce the 'core.hideDotFiles' setting
Date: Wed, 04 May 2016 12:06:12 -0700
Message-ID: <xmqqr3dhhcd7.fsf@gitster.mtv.corp.google.com>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 21:06:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay27o-00065M-VW
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbcEDTGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:06:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750825AbcEDTGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:06:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A64817E7D;
	Wed,  4 May 2016 15:06:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PQ7LUb3WCN1uthDUd8rsDFoD6u8=; b=EnTClt
	zrx6TpTt0X46wnXsGHEtmLRwidmGdLqZJngRhViWIqRS1AReNr97Di/Gx8NP/9rI
	cq+9yEHwXE8wQA90C9tCpf+alF3asakVfVM4r0YFRwzPPurHj3AVDttIj+jbpcYe
	1Yd+GIiFpGHxTfG0vdurF/xhz2kRDFm6vzz+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V6Ssf+GuVEJFGB1aQr7nHyqLSZQW+U7W
	MwN3hpimBKw+vRKnuXb1V4x5iytdms3QP/bmLqEexqFIqPJu2TkjhU7fZmiaUZze
	E6z8Bz66EM/PIoi0coVwWkH771O/SC6PH2+VYSaxEU8LdkKxWtW3gMMfmkhWNjE3
	ZNSFFNFZDFo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D7E117E7C;
	Wed,  4 May 2016 15:06:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E467417E7B;
	Wed,  4 May 2016 15:06:13 -0400 (EDT)
In-Reply-To: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 4 May 2016 16:40:45 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 457366CA-122B-11E6-975D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293568>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index b2d8d40..c4269ac 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -370,6 +370,7 @@ int init_db(const char *template_dir, unsigned int flags)
>  	check_repository_format();
>  
>  	reinit = create_default_files(template_dir);
> +	mark_as_git_dir(get_git_dir());
>  
>  	create_object_directory();
>  

I agree with the goal of the change, but I am having a hard time
justifying this addition.  Primarily because I do not understand the
need for this.

In order to be prepared to handle HIDE_DOTFILES_TRUE case,
mingw_mkdir() needs to be taught about needs_hiding() and
make_hidden() already.  Why isn't it sufficient to teach
needs_hiding() to check with !strcmp(basename(path, ".git"))
under HIDE_DOTFILES_DOTGITONLY?

I do not understand why core.hideDotFiles needs to be explicitly
copied to the config file in the resulting repository, either.

Once you created a repository, Git won't unhide the hidden .git of
that reposiotry, so the idea must be to propagate the setting to a
new repository that will further be created, but wouldn't that get
the "please hide" preference from the same place as we have got the
preference to hide .git when the current repository was created
anyway?
