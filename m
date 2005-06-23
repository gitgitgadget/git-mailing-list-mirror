From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 23:37:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506222325080.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
 <42BA18AF.2070406@pobox.com> <Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
 <07be01c577a7$05108660$03c8a8c0@kroptech.com> <Pine.LNX.4.58.0506222146460.11175@ppc970.osdl.org>
 <42BA4A29.7030601@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Adam Kropelin <akropel1@rochester.rr.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 09:02:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlLiU-00061h-Sf
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 09:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVFWHDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 03:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVFWGnd
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 02:43:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262526AbVFWGjR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 02:39:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N6ZqjA030964
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 23:35:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N6Zp1U031338;
	Wed, 22 Jun 2005 23:35:51 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BA4A29.7030601@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 23 Jun 2005, Jeff Garzik wrote:
> 
> Locally I have scripted
> 
>       git-diff-cache -p HEAD | diffstat -p1 | awk '{print $1}' > /tmp/lst
>       git-update-cache `cat /tmp/lst`
> 
> because of this.

Btw, that's some extremely convoluted computation.

This is exactly when you do _not_ want the diff in "patch" form, and you
really want the native git format (which is just a strange "this file
changed from this mode/sha1 to that mode/sha1" format).

So instead, try to do just

	git-diff-cache HEAD | cut -f2

and now it's going to be a whole lot simpler and faster - it won't turn 
things into a diff only to do a "diffstat" on it to turn it into a name 
again. I bet it's more reliable too.

> [again, clearly doesn't work with remove/add/mode change]

Well, it actually can work with removes, and rewriting it to be a bit 
more clean (and handle files that start with "-") gives you:

	git-update-cache --remove -- $(git-diff-cache HEAD | cut -f2)

which should actually work fine for files that you have removed. But yes,
it fundamentally _cannot_ work for new files, of course, since git will
never even try to look for files you haven't told it about. So you always 
have to add files by hand some way.

Note how the "--remove" parameter to git-update-cache really only means
"it's ok if some of the files mentioned don't exist any more, and that
means you should remove them from the cache".

Without the "--remove" flag, a filename that is listed but that doesn't
exist in the working tree is either considered an error, or is ignored
(depending on the "--ignore-missing" flag).

That's actually what "--add" means too: it means "it's ok if some of the
filenames on the command line don't currently exist in the index: if they
exist in the working directory, you should add them".

So even if it looks a bit strange, in a script it actually makes perfect
sense to write something that seems as _apparently_ senseless as:

	git-update-cache --add --remove --refresh -- "$@"

and it will refresh all existing files, and add or remove any files 
explicitly mentioned that either exist or have been removed in the working 
directory.

			Linus
