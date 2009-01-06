From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Quick command to count commits
Date: Tue, 6 Jan 2009 11:30:14 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901061120530.3057@localhost.localdomain>
References: <1231267896595-2118851.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:32:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKHes-0003S2-V0
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 20:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbZAFTas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 14:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbZAFTar
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 14:30:47 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42401 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750836AbZAFTar (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 14:30:47 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n06JUEI9022706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Jan 2009 11:30:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n06JUE5Y008575;
	Tue, 6 Jan 2009 11:30:14 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1231267896595-2118851.post@n2.nabble.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.444 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104711>



On Tue, 6 Jan 2009, Henk wrote:
>
> For GitExtensions (windows git ui) I need a command to count all commits. I
> now use this command:
> git.cmd rev-list --all --abbrev-commit | wc -l
> 
> This works perfect but its very slow in big repositories. Is there a faster
> way to count the commits?

Nope. Possibly drop the --abbrev-commit part, but it's not going to hurt 
_that_ much, and maybe avoiding piping the data can be a win in some 
cases.

Basically, to get commit counts, you need to traverse the whole history, 
or at least cache it. So the only way to speed things up is

 - make sure your repository is well-packed. That will speed things up by 
   an absolutely huge amount, if they weren't well-packed before. Just a 
   single large pack-file, not lots of small packs, and not lots of loose 
   objects.

 - you can certainly cache it. Just index by the sha1sum of all the heads, 
   and you have a great cache. Just keep a single entry. So _if_ the 
   repository seldom changes, and you do this a lot, you'll at least only 
   pay the price once.

IOW, do something like this:

	#!/bin/sh
	revs=$(git rev-parse --all)
	index=$(echo "$revs" | sha1sum | cut -d' ' -f1)
	cached=$(cat .git/commit_nr_cache)
	cached_index=$(echo "$cached" | cut -d' ' -f1)
	if [ "$index" == "$cached_index" ]; then
		echo "$cached" | cut -d' ' -f2
		exit
	fi
	nr=$(git rev-list $revs | wc -l)
	echo "$index $nr" > .git/commit_nr_cache
	echo $nr

and you now have a stupid single-entry cache.

Totally untested. You'll need to do _some_ work yourself ;)

		Linus
