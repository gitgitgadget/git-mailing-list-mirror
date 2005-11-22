From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: index manipulation -- how?
Date: Mon, 21 Nov 2005 21:23:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511212113080.13959@g5.osdl.org>
References: <20051122050337.46450.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 06:26:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeQdF-00010j-8b
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 06:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVKVFXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 00:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVKVFXs
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 00:23:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932305AbVKVFXs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 00:23:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAM5NknO032741
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 21 Nov 2005 21:23:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAM5Nk0i023145;
	Mon, 21 Nov 2005 21:23:46 -0800
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20051122050337.46450.qmail@web31808.mail.mud.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12525>



On Mon, 21 Nov 2005, Luben Tuikov wrote:
> 
> How do I reverse a _single_ "git-update-index" operation?
> Be it --add or just an update.

An "add" is easy enough to undo: just do a

	git-update-index --force-remove filename

which will remove the entry from the index even if the file on your 
filesystem still remains (so you can "git add" it later when you do want 
to commit it).

For a file that you had in your old index, but you've updated (either mode 
or SHA1), you need to figure out what the old mode/sha1 was. USUALLY this 
would be just the state that you still have in your HEAD tree, but if 
you want to go back to something else, you'd need to figure out what that 
was.

If it's the "last commit" state (ie just your HEAD state), then do

	git-ls-tree HEAD filename

which will show you the info, and then you do

	git-update-index --cacheinfo <mode> <sha1> filename

from that state.

You could obviously script something like "git-downdate-index":

	#!/bin/sh
	filename="$1"
	tree_info=$(git-ls-tree HEAD -- "$filename")
	if [ -z "$tree_info" ]; then
		git-update-index --force-remove -- "$filename"
	else
		echo "$tree_info" | while read mode type sha1 name; do
			git-update-index --cacheinfo "$mode" "$sha1" "$filename"
		done
	fi

but the above is totally untested, and "git-downdate-index" is a really 
sucky name too, so you'd need to rename it and test whether it does what 
you want.

Hmm?

		Linus
