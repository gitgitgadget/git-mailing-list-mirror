From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Can't understand the behaviour of git-diff --submodule
Date: Fri, 26 Oct 2012 21:08:30 +0200
Message-ID: <508ADFAE.1050800@web.de>
References: <CAC9WiBgzbsury2f9FyAu=Pgn31f2uCtq7AvsVWGWEwoV6KbyjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:08:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRpGu-0007Ie-St
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966090Ab2JZTIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:08:34 -0400
Received: from mout.web.de ([212.227.17.11]:64183 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966087Ab2JZTIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:08:32 -0400
Received: from [192.168.178.41] ([79.193.90.117]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lo0Hw-1SufFG3za4-00gbqj; Fri, 26 Oct 2012 21:08:31
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CAC9WiBgzbsury2f9FyAu=Pgn31f2uCtq7AvsVWGWEwoV6KbyjA@mail.gmail.com>
X-Provags-ID: V02:K0:1X0/PAK0hs81lgfCFx7+dAjWEX8dF1TZiWB81fbmXup
 MCKDx+x+tCFGSzD2BlwUmqLszxjlloitQSfPnEol2sY0qn9+/l
 rQFQGQcVLKdqmXiOtTvkAI3yxaLs126vDID3tAbXDJs6Uwf4qD
 Dd8iXjQAqbgZLo/xpmHkcmYcRY9Hb5CTxUIY+MluVOxM/KSE+P
 ZzumPAufg/VmxmcoFPRzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208479>

Am 26.10.2012 16:07, schrieb Francis Moreau:
> I'm trying to use the --submodule switch with git-diff but doesnt
> understand the following behaviour:
> 
> $ git diff 2c9a257718d1803de720f95766ff256d33accad5 HEAD
> diff --git a/configs b/configs
> index 16c6a89..ce12289 160000
> --- a/configs
> +++ b/configs
> @@ -1 +1 @@
> -Subproject commit 16c6a89f245f0eed7fb0bce8e027c59fcf1d543e
> +Subproject commit ce12289c5bfca7b2c423d9f1871c13ad1ba1dc32
> 
> but adding the --submodule option gives:
> 
> $ git diff --submodule=log 2c9a257718d1803de720f95766ff256d33accad5 HEAD
> Submodule configs 16c6a89...ce12289 (commits not present)
> 
> Could anybody enlight me ?

The output "Submodule configs 16c6a89...ce12289 (commits not present)"
contains same SHA-1s, only in their abbreviated form. That is the same
information you get without the --submodule option, but in shorter
format: it says the submodule moved from 16c6a89 to ce12289 in the
given commit range of the superproject (and the "..." part tells us it
wasn't a fast-forward). The "(commits not present)" part indicates that
even though git diff would have wanted to show you what happened in the
submodule between 16c6a89 and ce12289 by displaying the first line of
each commit message, it couldn't because these commit(s) are not present
in the submodule repo. If you do a "git log --oneline 16c6a89...ce12289"
inside the submodule you'll get an "unknown revision" error for the same
reason.

The "(commits not present)" part should go away and the output of the
short commit messages should appear when you do a "git fetch" inside the
submodule (at least unless someone forgot to push these submodule commits
upstream). As "git fetch" does attempt to fetch all referenced submodules
too, I suspect that you have unpushed commits (e.g. they might have been
dropped because of a rebase). In this case a "git submodule update" will
fail for the same reason.

Does that make it clearer?
