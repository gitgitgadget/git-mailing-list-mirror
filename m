From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Wed, 09 Jul 2014 12:31:29 -0700
Message-ID: <xmqqmwci9vn1.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
	<53BCDDE2.1080301@web.de> <53BD87B3.8050901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 21:31:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4xam-0006me-Pd
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 21:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbaGITbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 15:31:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50854 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747AbaGITbi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 15:31:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 374FF28B3B;
	Wed,  9 Jul 2014 15:31:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=byZGN9Fmfxmf4ngDvsVG4LrWa/E=; b=eAHGAn
	pnvGDNONues1Ppd5B4NFOzCZM62VyOy6cnun1PhGqZvZKmSju3+X7yPzy5WnrEkF
	e8vkd4hEgyJtt4fLd6z6+ghrGav2r4G4OFxZM9mf8MbJP72sUVplfPY6FCo/kajH
	Xchzuh6F1Evian4CfeQMkY9loKEQyuj7t3XlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AoukO301digJK6ZdKntjqBcnx+6/gzon
	Knd/WZLd9hRhlAGfiqDTEMWK6LWXqjfbv0dbXSMG5xhJdf2iBykgHnxKX+RkNxPU
	AsRSaF7okrXHtYYxzmZOmsyqkY1qOgScf9eiIryQMkR49HWR91+n+cvHlunGTG0M
	DkAFMz1fwjA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D10F28B3A;
	Wed,  9 Jul 2014 15:31:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4DAF228B27;
	Wed,  9 Jul 2014 15:31:16 -0400 (EDT)
In-Reply-To: <53BD87B3.8050901@web.de> (Jens Lehmann's message of "Wed, 09 Jul
	2014 20:19:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 983D4404-079F-11E4-870C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253140>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I agree, but this case is special. The test asserts that nobody
> added, modified or removed *anything* inside the .git directory.
> The reason for problem we are seeing here is that I have to
> remove the core.worktree setting when moving the git directory
> from .git/modules into the submodule work tree.

Hmph.  Comparing the files with core.worktree removed sounds like a
workaround that knows too much about the implementation detail of
what is being tested.  I am just wondering if core.worktree will
stay forever be the only thing that is special, or there may come
other things (perhaps as a fallout of integrating things like Duy's
multiple-worktree stuff).

But perhaps we cannot do better than this.

> Could you please test the following? It should avoid this kind
> of problem by removing the core.worktree setting temporarily
> from the original config in .git/modules instead of adding it
> temporarily to .git/config:
> -----------------------8<-----------------------
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 3584755..98c86e3 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -143,18 +143,18 @@ replace_gitfile_with_git_dir () {
>  }
>
>  # Test that the .git directory in the submodule is unchanged (except for the
> -# core.worktree setting, which we temporarily restore). Call this function
> +# core.worktree setting, which we temporarily remove). Call this function
>  # before test_submodule_content as the latter might write the index file
>  # leading to false positive index differences.
>  test_git_directory_is_unchanged () {
>  	(
> -		cd "$1" &&
> -		git config core.worktree "../../../$1"
> +		cd ".git/modules/$1" &&
> +		git config --unset core.worktree
>  	) &&
>  	diff -r ".git/modules/$1" "$1/.git" &&
>  	(
> -		cd "$1" &&
> -		GIT_WORK_TREE=. git config --unset core.worktree
> +		cd ".git/modules/$1" &&
> +		git config core.worktree "../../../$1"
>  	)
>  }
