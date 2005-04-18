From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] "checkout-cache -m" writes unmerged contents for each
 stage.
Date: Sun, 17 Apr 2005 19:05:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171833450.7211@ppc970.osdl.org>
References: <7v1x99vwdg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:00:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNLYi-00084g-IU
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVDRCEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVDRCEL
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:04:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:22230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261598AbVDRCEB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:04:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3I23ts4005668
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 19:03:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3I23sH7019145;
	Sun, 17 Apr 2005 19:03:55 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x99vwdg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Junio C Hamano wrote:
>
> This is the alternative strategy I mentioned in my previous
> message.  A new -m option to checkout-cache causes it to store
> contents of unmerged paths in path~1~, path~2~, and path~3~.

I don't think this is wrong, but it all seems a bit hacky. The reason I 
didn't apply your other patch was that I just don't feel quite comfortable 
with what is the RightThing(tm) to do yet.

I'm actually fairly certain that the right thing to do is to silently 
ignore all unmerged entries. They just aren't "interesting" from a 
checkout-cache perspective, least of all when given the "-a" flag. So even 
warning about them seems to be pointless.

The other issue is that obviously we _do_ need to have some way to merge
them, but as far as I can tell, we've really got that already in
"show-files --unmerged"  together with "cat-file blob xxxx". I do believe 
that it's a damn ugly script, and that maybe we could create some helper 
plumbing to make it more obvious, but I haven't quite decided what the 
right helper interface would be.

Writing files to the current working directory I don't like, especially as
we don't even necessarily write all three files (so with your example
code, if there was a left-over xxx~1~ file from a previous merge, your
merger would really get confused now since it thinks it has an original
file that didn't actually really exist). So I'd much rather write them to
a /tmp directory instead, let the user merge them some way.

I'm actually thinking that maybe the _right_ interface is to do something 
like this:

	merge-cache <program> <filename>

and what that does is to look up the <filename> in the cache, and if it 
has any merge entries, unpack all of them (which may be just one file, of 
course) into up to three separate files (mkstemp()), and then execve the 
supplied program name with those three files as arguments 1,2,3 (empty 
argument if no file), and "filename" as argument 4.

So now the program could be a simple script:

	#!/bin/sh
	#
	# This is the git merge script, called with
	#
	#   $1 - original file (or empty string)
	#   $2 - file in branch1 (or empty string)
	#   $3 - file in branch2 (or empty string)
	#   $4 - pathname in repository
	#
	#
	# Case 1: file removed in both
	#
	if [ -z "$2" && -z "$3" ]; then
		rm -- "$4"
		update-cache --remove -- "$4"
		exit 0
	fi
	#
	# Case 2: file exists in just one
	#
	if [ -z "$2" || -z "$3" ] then
		cat "$2""$3" > "$4"
		update-cache --add -- "$4"
		exit 0
	fi
	#
	# Case 3: file exists in both
	#
	src="$1"
	if [ -z "$1" ]; then
		src=/den/null
	fi	
	merge "$3" "$src" "$2" && cp "$3" "$4" && update-cache --add -- "$4"

or you could so something fancier.

This would _seem_ to be a very simple way to generate a nice merge (the 
merge script can obviously be a lot smarter than the above thing, 
including doing nice graphical merge interfaces).

An extension of this might be to make "merge-cache" take several 
filenames, and merge them one at a time (stopping if the merge program 
returns a failure code). And obviously this also expands trivially to the 
normal "-a" case, which would do the same, except it would just call the 
merge program for any file it finds that needs merging)

What do you think? I can whip up a "merge-cache" program like that in five 
minutes, and it _seems_ like the right interface..

		Linus
