From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] filter-branch fix and tests
Date: Wed, 27 Jan 2010 17:18:16 +0100
Message-ID: <4B606748.2050209@viscovery.net>
References: <1264424786-26231-1-git-send-email-sojkam1@fel.cvut.cz> <alpine.DEB.1.00.1001261939420.4641@intel-tinevez-2-302> <201001271649.19287.sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:18:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaAb7-0001vs-0i
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 17:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab0A0QSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 11:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198Ab0A0QSV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 11:18:21 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58080 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab0A0QST (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 11:18:19 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NaAau-00021C-VO; Wed, 27 Jan 2010 17:18:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9C3901660F;
	Wed, 27 Jan 2010 17:18:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <201001271649.19287.sojkam1@fel.cvut.cz>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138165>

Michal Sojka schrieb:
> +orig_head=`git show-ref --hash HEAD`
> +export orig_head

You place the tree filter in double-quotes. Hence, orig_head will be
interpolated on the filter-branch command line. You don't need to export it.

> +test_expect_success 'rewrite submodule with another content' '
> +	git filter-branch --tree-filter "test -d submod && {
> +					 rm -rf submod &&
> +					 git rm -rf --quiet submod &&
> +					 mkdir submod &&
> +					 : > submod/file
> +					 } || : &&
> +					 test $orig_head != `git show-ref --hash HEAD`"

What is the purpose of the check in the last line?

As long as you have another command after the "} || : &&", you can just
write "}" instead.

> +test_expect_failure 'checkout submodule during rewrite' '
> +	git reset --hard original &&
> +	git filter-branch -f --tree-filter \
> +	    "git submodule update --init &&
> +	     cd submod &&
> +	     git reset --hard origin/master" HEAD

You must not change the directory without changing back. Use a sub-shell.

I'm not sure whether it's worth catering for this use-case anyway.
Replacing a submodule commit should really be done only in the
--index-filter. The tree that --tree-filter checks out is intended only as
a temporary scratch area. It is not intended as a full worktree. In
particular, since 'submodule update --init' changes the configuration, it
is extremly dangerous to call from a filter.

-- Hannes
