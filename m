From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "Racy" GIT
Date: Mon, 24 Oct 2005 09:34:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510240905340.10477@g5.osdl.org>
References: <20051024092952.GZ30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 18:38:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU5HH-0000mE-MX
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 18:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVJXQeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 12:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVJXQeX
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 12:34:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751145AbVJXQeX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 12:34:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9OGYGFC032648
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 24 Oct 2005 09:34:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9OGYFRh030426;
	Mon, 24 Oct 2005 09:34:15 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051024092952.GZ30889@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10546>



On Mon, 24 Oct 2005, Petr Baudis wrote:
> 
>   Guess what - the second cg-commit didn't commit the new version of the
> file. git-diff-index didn't show anything. GIT just didn't care about
> the change.

Yeah. This is why I wanted to use the "tv_nsec" field originally.

As it is, if you change a file within a second so that the length is the 
same (and inode stays the same), the stat cache can't help you.

Now, this will only trigger if you do a git-update-index (either directly 
or like in your example, indirectly though doing a commit that does it) 
and then change it again immediately, so in practice it shouldn't matter. 
Except for scripts.

In scripts, you can avoid this certain ways:

 - add a "sleep 1" (gaah, just joking, but it works)

 - use "git-apply --index" (which updates the index on its own on any 
   files it changes) to apply any patches.

 - use an explicit "git-update-index -- filename"

 - if you actually change the inode number, it should be ok, ie

	sed script < a > b && mv b a

   will change the inode number, and that should trigger the index tests 
   too. NOTE!! This isn't guaranteed, especially if you do it twice (it 
   might re-use the original one)

Note that "git-update-index --refresh" will _not_ work, since it looks if 
it changed. But an explicit filename will force an update if you know it 
changed.

And yes, I guess we should document this in big letters.

(There _are_ actually tricks you can do to make this usually less of an 
issue:

 - if the git-update-cache --refresh finds file where the mtime matches 
   the current date. It sets a flag. At the end, it waits for the next 
   second to roll around before returning.

might work well enough)

		Linus
