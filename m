From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: how to do these 2 one-liners ?
Date: Mon, 19 Mar 2007 16:09:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703191549100.6730@woody.linux-foundation.org>
References: <46d6db660703191525w613b02e1nae0f30efaca3b269@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 00:10:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTQzn-0006ye-LP
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 00:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472AbXCSXJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 19:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965558AbXCSXJz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 19:09:55 -0400
Received: from smtp.osdl.org ([65.172.181.24]:33100 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965472AbXCSXJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 19:09:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JN9pcD012366
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 16:09:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JN9pIs020111;
	Mon, 19 Mar 2007 15:09:51 -0800
In-Reply-To: <46d6db660703191525w613b02e1nae0f30efaca3b269@mail.gmail.com>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42680>



On Mon, 19 Mar 2007, Christian MICHON wrote:
> 
> in order to code a gvim plugin for git (I started something), I now miss
> 2 one-liners, and I hope experts around this list will find it easy
> to answer (for the sake of this plugin)
> 
> ================================================
> 1) how do I check the status of a single file ? ( the file is already
> added in the index)

It really depends on what you want to do.

If you want to know *what* the index contains right there and then, do for 
example:

	git ls-files --stage -- "$filename"

and it will tell you the index contents (it might be several lines: if the 
"filename" entry is a directory it will list *all* files under that 
directory, but even if it's a single file it could give you all the 
unmerged stages for that file).

On the other hand, often you want to know what the status of a file is not 
in "absolute" terms, but relative to the index or to the last commit. If 
so, you can use something like

	git diff-files --name-status -- "$filename"

which just compares the index with the current working tree. And if you 
want to check against the last commit (ie HEAD), use

	git diff-index --name-status HEAD -- "$filename"

which can also be used with "--cached" to see the difference between the 
HEAD and the index. That's how "git status" used to do it when it was a 
shell script (now it's done with a built-in).

In fact, you could look at the old git-commit.sh script before it was 
turned into a built-in with

	git show v1.4.0:git-commit.sh

and look at the "run_status" shell function.

> I usually use git-status here, but for single files that need update,
> there should be a faster way.

Indeed. HOWEVER! Note that when you ask for the status of a single file, 
that obviously means that there is no "rename detection" going on, so if 
you want to see the "renamed from Xyz", you need to do the global analysis 
that "git-status" does, and then fetch the filename info from there.

(Alternatively, you can choose to always do the single-file case first, 
and then only *if* it's a newly added file you could ask "was it renamed 
from anything else").

> 2) how do I find in historical reverse order all the commits a
> certain file belongs to since the origin ?

That's quite an expensive operation:

	git rev-list --reverse HEAD -- "$filename"

Or did you by "historical" mean "newest first"? If so, just do

	git rev-list HEAD -- "$filename"

(that's the order that git considers "natural").

> I usually do: git-log <file> | grep ^commit
> I would like to avoid piping here...

Well, "git log" is really just rev-list with fancy options to make it show 
more than just the commit name.

Of course, you *could* do

	git log --pretty=oneline -- "$filename"

which gets you pretty close. But if you literally just want the commit 
SHA1, "git rev-list" is what you're really asking for.

			Linus
