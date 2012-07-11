From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] submodules: don't stumble over symbolic links when cloning
 recursively
Date: Wed, 11 Jul 2012 21:10:28 +0200
Message-ID: <4FFDCFA4.9060602@kdbg.org>
References: <4FFDC1EE.8080106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Bob Halley <halley@play-bow.org>,
	Phil Hord <phil.hord@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 21:11:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp2Jk-00058m-Jo
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 21:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083Ab2GKTKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 15:10:34 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:14058 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756013Ab2GKTKd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 15:10:33 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CD085A7EB7;
	Wed, 11 Jul 2012 21:10:28 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7EA7119F449;
	Wed, 11 Jul 2012 21:10:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <4FFDC1EE.8080106@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201324>

Am 11.07.2012 20:11, schrieb Jens Lehmann:
> Since 69c305178 (submodules: refactor computation of relative gitdir path)
> cloning a submodule recursively fails for recursive submodules when a
> symbolic link is part of the path to the work tree of the superproject.
> 
> This happens when module_clone() tries to find the relative paths between
> work tree and git dir. When a symbolic link in current $PWD points to a
> directory in a different level determining the number of "../" needed to
> traverse to the superprojects work tree leads to a wrong result.
> 
> As there is no portable way to say "pwd -P" use cd_to_toplevel to remove
> the link from the pwd, which fixes this problem.
...
> -	a=$(cd "$gitdir" && pwd)/
> -	b=$(cd "$sm_path" && pwd)/
> +	a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
> +	b=$(cd_to_toplevel && cd "$sm_path" && pwd)/

But if you cd out, how can it be correct not to cd in again if $gitdir
and/or $sm_path are relative?

And if $gitdir and/or $sm_path are absolute, how can the earlier
cd_to_toplevel make a difference?

> +test_expect_success 'submodule update can handle symbolic links in pwd' '

Please add a SYMLINKS prerequisite.

> +	mkdir -p linked/dir &&
> +	ln -s linked/dir linkto &&
> +	(
> +		cd linkto &&
> +		git clone "$TRASH_DIRECTORY"/super_update_r2 super &&
> +		(
> +			cd super &&
> +			git submodule update --init --recursive
> +		)
> +	)
> +'

-- Hannes
