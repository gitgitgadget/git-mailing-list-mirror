From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Possible strategy cleanup for git add/remove/diff etc.
Date: Tue, 19 Apr 2005 21:32:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504192102140.6467@ppc970.osdl.org>
References: <20050419035107.GB5554@pasky.ji.cz> <7vacnumgot.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504191846290.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:27:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO6ne-0007Ok-S7
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVDTEbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVDTEbH
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:31:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:9393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261348AbVDTEay (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 00:30:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3K4Uls4018811
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 21:30:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3K4UjoP018243;
	Tue, 19 Apr 2005 21:30:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0504191846290.6467@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Linus Torvalds wrote:
> 
> That is indeed the whole point of the index file. In my world-view, the
> index file does _everything_. It's the staging area ("work file"), it's
> the merging area ("merge directory") and it's the cache file ("stat
> cache").
> 
> I'll immediately write a tool to diff the current working directory 
> against a tree object, and hopefully that will just make pasky happy with 
> this model too. 

Ok, "immediately" took a bit longer than I wanted to, and quite frankly,
the end result is not very well tested. It was a bit more complex than I
was hoping for to match up the index file against a tree object, since
unlike the tree<->tree comparison in diff-tree, you have to compare two
cases where the layout isn't the same.

No matter. It seems to work to a first approximation, and the result is
such a cool tool that it's worth committing and pushing out immediately. 

The code ain't exactly pretty, but hey, maybe that's just me having higher 
standards of beauty than most. Or maybe you just shudder at what I 
consider pretty in the first place, in which case you probably shouldn't 
look too closely at this one.

What the new "diff-cache" does is basically emulate "diff-tree", except 
one of the trees is always the index file.

You can also choose whether you want to trust the index file entirely
(using the "--cached" flag) or ask the diff logic to show any files that
don't match the stat state as being "tentatively changed".  Both of these
operations are very useful indeed.

For example, let's say that you have worked on your index file, and are
ready to commit. You want to see eactly _what_ you are going to commit is
without having to write a new tree object and compare it that way, and to
do that, you just do

	diff-cache --cached $(cat .git/HEAD)

(another difference between diff-tree and diff-cache is that the new 
diff-cache can take a "commit" object, and it automatically just extracts 
the tree information from there).

Example: let's say I had renamed "commit.c" to "git-commit.c", and I had 
done an "upate-cache" to make that effective in the index file. 
"show-diff" wouldn't show anything at all, since the index file matches 
my working directory. But doing a diff-cache does:

	torvalds@ppc970:~/git> diff-cache --cached $(cat .git/HEAD)
	-100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
	+100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        git-commit.c

So what the above "diff-cache" command line does is to say

   "show me the differences between HEAD and the current index contents 
    (the ones I'd write with a "write-tree")"

And as you can see, the output matches "diff-tree -r" output (we always do
"-r", since the index is always fully populated). All the same rules: "+"  
means added file, "-" means removed file, and "*" means changed file. You 
can trivially see that the above is a rename.

In fact, "diff-tree --cached" _should_ always be entirely equivalent to
actually doing a "write-tree" and comparing that. Except this one is much
nicer for the case where you just want to check. Maybe you don't want to
do the tree.

So doing a "diff-cache --cached" is basically very useful when you are 
asking yourself "what have I already marked for being committed, and 
what's the difference to a previous tree".

However, the "non-cached" version takes a different approach, and is
potentially the even more useful of the two in that what it does can't be
emulated with a "write-tree + diff-tree". Thus that's the default mode.  
The non-cached version asks the question

   "show me the differences between HEAD and the currently checked out 
    tree - index contents _and_ files that aren't up-to-date"

which is obviously a very useful question too, since that tells you what
you _could_ commit. Again, the output matches the "diff-tree -r" output to
a tee, but with a twist.

The twist is that if some file doesn't match the cache, we don't have a
backing store thing for it, and we use the magic "all-zero" sha1 to show
that. So let's say that you have edited "kernel/sched.c", but have not
actually done an update-cache on it yet - there is no "object" associated
with the new state, and you get:

	torvalds@ppc970:~/v2.6/linux> diff-cache $(cat .git/HEAD )
	*100644->100664 blob    7476bbcfe5ef5a1dd87d745f298b831143e4d77e->0000000000000000000000000000000000000000      kernel/sched.c

ie it shows that the tree has changed, and that "kernel/sched.c" has is
not up-to-date and may contain new stuff. The all-zero sha1 means that to
get the real diff, you need to look at the object in the working directory
directly rather than do an object-to-object diff.

NOTE! As with other commands of this type, "diff-cache" does not actually 
look at the contents of the file at all. So maybe "kernel/sched.c" hasn't 
actually changed, and it's just that you touched it. In either case, it's 
a note that you need to upate-cache it to make the cache be in sync.

NOTE 2! You can have a mixture of files show up as "has been updated" and
"is still dirty in the working directory" together. You can always tell
which file is in which state, since the "has been updated" ones show a
valid sha1, and the "not in sync with the index" ones will always have the
special all-zero sha1.

I think this should obviate the need for Pasky keeping a separate work 
file. You can always tell what the difference to the last commit is with 
this, and you don't need to have a separate file to tell you about what 
you're supposed to do.

			Linus
