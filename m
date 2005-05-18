From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/1] Diff-helper update
Date: Wed, 18 May 2005 08:41:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Wed May 18 18:00:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYQvS-0001cX-84
	for gcvg-git@gmane.org; Wed, 18 May 2005 17:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVERPob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 11:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVERPmR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 11:42:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:64917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262273AbVERPj0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 11:39:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4IFdIU3015819
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 May 2005 08:39:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4IFdH86002433;
	Wed, 18 May 2005 08:39:17 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 17 May 2005, Junio C Hamano wrote:
>
> This is just a cover letter but the next patch implements the
> rename detection I told you about.

Ok. I now have one more worry: git-diff-tree with "--stdin".

I actually find that thing to be surpremely useful, and I use it for not 
just my silly git-whatchanged script, but also to make release notes. I 
just do

	git-rev-tree HEAD ^LAST_RELEASE | cut -d' ' -f2 | git-diff-tree -v -s --stdin

and that's wonderful. And sometimes I use "-p" instead of "-s", because 
I'm not making release notes, but because I'm doing a "whatchanged" with 
full diffs.

In other words, try something like this on the kernel tree:

	git-whatchanged -p include/asm-i386 arch/i386 | less -S

and stare in wonder at just how _useful_ this simple thing is.

Maybe it's just that I've not used all that many different SCM systems,
and I've certainly not used all the features of the ones I _have_ used, so
maybe I never knew, but dammit, I've never seen anybody else do something
quite that useful (at least doing it fast enough that it _remains_
useful).

(Replace "arch/i386" with "drivers/usb" or "fs/ext3" or whatever,
depending on just what your area of interest happens to be).

In other words, I'm very happy with git.

However, git-diff-helper doesn't understand these things, and the builtin
diff doesn't do the rename thing. Yet it would be very very useful to do.

Now, if you do just a

	git-whatchanged include/asm-i386 arch/i386

(or you can even use "-z" if you want to), it turns out hat git-diff-tree 
actually does output perfectly usable material. Each "set of diffs" is 
clearly separated, and there is no ambiguos material: all lines are 
either:
 - empty or start with a whitespace
 - start with "diff-tree ", "Author: " or "Date: "
 - are valid input for diff-helper

So what I'd suggest is one (or both) of two possibilities:
 - make the internal diff logic also able to do the same rename handling 
   as the external diff-helper. This may or may not be complex, I've not 
   looked at it.
 - change diff-helper subtly: instead of printing "cannot parse %s", any
   nonrecognized line would be a "ignore this line, but process all
   pending potential renames".

The above would mean that I could either just do

	git-whatchanged include/asm-i386 arch/i386 | git-diff-helper

or continue to use

	git-whatchanged -p include/asm-i386 arch/i386

and still get the "nice" output (and it's a _feature_ that a rename within
the arch/i386 then shows up as a rename, but a rename that crosses the
boundary shows up as a "create" or "delete" event).

Comments? 

			Linus
