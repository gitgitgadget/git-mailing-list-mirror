From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Delete gitlink entry but keep .gitmodules file unmodified
Date: Wed, 18 Apr 2012 15:42:58 +0200
Message-ID: <4F8EC4E2.6070507@web.de>
References: <4F8EBF5D.5070301@tmatesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Semen Vadishev <semen.vadishev@tmatesoft.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 15:43:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKVAD-0000bT-9y
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 15:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab2DRNnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 09:43:03 -0400
Received: from fmmailgate06.web.de ([217.72.192.247]:52670 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab2DRNnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 09:43:00 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate06.web.de (Postfix) with ESMTP id 34EA21257F8D
	for <git@vger.kernel.org>; Wed, 18 Apr 2012 15:42:59 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.175.87]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0M3Bv5-1S1Jsj3qrv-00swB0; Wed, 18 Apr 2012 15:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F8EBF5D.5070301@tmatesoft.com>
X-Provags-ID: V02:K0:VtRxs00x1Axp1Cme716B8w4X7N835nljTSD/aatJ+vt
 BXpN+l4acjhsSUiKPNycffC1BQ5DFqnsN4zpTGfB79dnrGCP5+
 kaqxAwsGmwSZVrwnGf7/KQN8qOOvknp0ms0x9SykT051PQAuGc
 QMfq4PZl7RvwQiB1gb/LKBKn5Gf3cPoRxmZKB5bo8RxHHwS1Qf
 cYmRIu4yOiIx3zPZ2ypvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195867>

Am 18.04.2012 15:19, schrieb Semen Vadishev:
> Suppose one has a properly initialized submodule in a tree like this:
> 
> $ git ls-tree HEAD
> 100644 blob d208248ba4ab1d1791dc27f451dcaedb87dc19e1    .gitmodules
> 160000 commit ec633ea81e3cf64c3735ef4acd5ff9a490ed54eb    ext
> 100644 blob 597d6924118c00054efd526d9e48f68198f7da12    file.txt
> 
> $ git show HEAD:.gitmodules
> [submodule "ext"]
>         path = ext
>         url = $URL
> 
> Then one pulls a modification that replaces 'ext' gitlink by some blob or tree entry, but keeps '.gitmodules' the same:
> 
> $ git ls-tree HEAD
> 100644 blob d208248ba4ab1d1791dc27f451dcaedb87dc19e1    .gitmodules
> 040000 tree 82e3a754b6a0fcb238b03c0e47d05219fbf9cf89    ext
> 100644 blob 597d6924118c00054efd526d9e48f68198f7da12    file.txt
> 
> Are there any possible downsides of such modification we should be aware of?

Yes, unfortunately current git isn't able to do that (even though work
is ongoing to make future versions handle that just fine). Right now
the populated submodule "ext" won't be removed when you switch to a
branch where it doesn't exist. If the new branch has a tree there,
you'll almost certainly get an error when trying to switch to it as
that would overwrite files left over from the submodule (end even if
it doesn't, you'll might get lots of untracked files in the tree
after the checkout).

As a workaround you could use a symbolic link (assuming you FS supports
that) and switch that around between two different directories:

100644 .gitmodules
100644 ext -> ext_sub
160000 ext_sub

100644 .gitmodules
100644 ext -> ext_tree
160000 ext_tree

If you then add ext_sub and ext_tree to the .gitignore of each side it
isn't present in, everything should work just fine (and when git learns
to handle that case, you can get rid of that workaround for future
commits).
