From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 01:06:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
References: <20050414002902.GU25711@pasky.ji.cz> <20050413212546.GA17236@64m.dyndns.org>
 <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Christopher Li <git@chrisli.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 10:04:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLzJc-0002bH-Ty
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 10:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVDNIGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 04:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVDNIGF
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 04:06:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:38355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261458AbVDNIFL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 04:05:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3E84ws4010339
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 01:04:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3E84vLi015431;
	Thu, 14 Apr 2005 01:04:58 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, Junio C Hamano wrote:
> 
> I now have a Perl script that uses rev-tree, cat-file,
> diff-tree, show-files (with one modification so that it can deal
> with pathnames with embedded newlines), update-cache (with one
> modification so that I can add an entry for a file that does not
> exist to the dircache) and merge (from RCS).  Quick and dirty.

That's exactly what I wanted. Q'n'D is how the ball gets rolling.

In the meantime I wrote a very stupid "merge-tree" which does things
slightly differently, but I really think your approach (aka my original
approach) is actually a lot faster. I was just starting to worry that the 
ball didn't start, so I wrote an even hackier one.

My really hacky one is called "merge-tree", and it really only merges one 
directory. For each entry in the directory it says either

	select <mode> <sha1> path

or

	merge <mode>-><mode>,<mode> <sha1>-><sha1>,<sha1> path

depending on whether it could directly select the right object or not.

It's actually exactly the same algorithm as the first one, but I was 
afraid the first one would be so abstract that it (a) might not work and 
(b) wouldn't get people to work it out. This "one directory at a time with 
very explicit output" thing is much more down-to-earth, but it's also
likely slower because it will need script help more often.

That said, I don't know. MOST of the time there will be just a single 
"directory" entry that needs merging, and then the script would just need 
to recurse into that directory with the new "tree" objects. So it might 
not be too horrible.

But I'm really happy that you seem to have implemented my first 
suggestion and I seem to have been wasting my time. 

>  5. for each path involved:
> 
>   5.0 if neither heads change it, leave it as is;
>   5.1 if only one head changes a path and the other does not, just
>       get the changed version;
>   5.2 if both heads change it, check all three out and run merge.

You missed one case: 

    5.0.1 if both heads change it to the same thing, take the new thing

but maybe you counted that as 5.0 (it _should_ fall out automatically from
the fact that "diff-tree" between the two destination trees shows no
difference for such a file).

Now, arguably, your 5.2 will do things right, but the thing is, it's 
actually fairly _common_ that both heads have changed something to the 
same thing. Namely if there was a previous merge that already handled that 
case, but that previous merge may not be a proper parent of the new 
commits.  So from a performance standpoint you really don't want to 
consider that to be a merge - you just pick up the new contents directly.

See?

(My stupid "merge-tree" should show the algorithm in painful obviousity. 
Of course, my stipid merge-tree may also be painfully buggy. You be the 
judge).

> It does not currently commit.  You can go to ./,,merge-temp/ and
> see show-diff to see the result of the merge.  Files added in
> one head has already been run "update-cache" when the script
> ends, but changed and merged files are not---dircache still has
> the common ancestor view.

That sounds good.

> Also to implement 'changed only by one-side' without actually
> checking the file out, I needed to add one option to
> 'update-cache'.  --cacheinfo flag is used this way:
> 
>     $ update-cache --cacheinfo mode sha1 path

Yes. My "merge-tree" needs the exact same thing.

Looks good from your explanation, but I'm too tired to look at the code. 
It's 1AM, and the kids get up at 7.

I'm not much of a hacker, I usually crash by 10PM these days ;^)

			Linus
