From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement limited context matching in git-apply.
Date: Mon, 10 Apr 2006 12:35:40 -0600
Message-ID: <m1k69xffcz.fsf@ebiederm.dsl.xmission.com>
References: <m1d5fqi23b.fsf@ebiederm.dsl.xmission.com>
	<m13bgmht9v.fsf@ebiederm.dsl.xmission.com>
	<m1irphhj1p.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0604100821340.9504@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 20:37:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT1GK-0004Ih-3n
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 20:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWDJSg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 14:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWDJSg7
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 14:36:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12265 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932102AbWDJSg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 14:36:58 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k3AIZhZv031032;
	Mon, 10 Apr 2006 12:35:43 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k3AIZfeO031031;
	Mon, 10 Apr 2006 12:35:41 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604100821340.9504@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 10 Apr 2006 08:25:16 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18591>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 10 Apr 2006, Eric W. Biederman wrote:
>> 
>> If I just loop through all of Andrews patches in order
>> and run git-apply --index -C1 I process the entire patchset
>> in 1m53s or about 6 patches per second.  So running
>> git-mailinfo, git-write-tree, git-commit-tree, and
>> git-update-ref everytime has a measurable impact,
>> and shows things can be speeded up even more.
>
> git-write-tree is actually a fairly expensive operation on the kernel. It 
> needs to write the 1000+ tree objects - and while _most_ of them already 
> exist (and thus don't actually need to be written out), we need to 
> generate the tree object and its SHA1 in order to notice that that is the 
> case.
>
> I'm almost certain that 90%+ of the overhead you see is the tree writing, 
> not the rest of the scripting.

Well it is easy enough to time.  Looking at the timings
going from just git-apply to git-apply && git-write-tree
does seem to about the double the amount of time taken,
or take me to about 4 minutes.  With everything else
in there things happen in the 6-7 minute range with
in the hot cache scenario.  So write-tree is closer
to 50% of the overhead.

Is it possible to cache the sha1 of unmodified directories?

If we did that we could probe to see if the hash already
existed before we attempted to look for the subdirectories.

The pain would is remembering which directory sha1 are
current.  If nothing else we can modify: 
remove_cache_entry, and add_file_to_cache to clear
the parent directories cached sha1 when we update an
index entry.  But I keep thinking there should
be something more elegant.  Like using ce_flags,
or comparing mtime values.

...

Ok taking a quick look at write-tree to see where
the bottle neck is:  

I made two modified versions of write-tree. 
- git-write-tree-nowritetree which calls return just before calling
    write_tree.
- git-write-tree-nosha1write which does everything except call
    sha1_file_write.

With just git-apply and git-write-tree-nosha1write it takes
me about 3m:20s to process 2.6.17-rc1-mm2.

With just git-apply and git-write-tree-nowritetree it takes:
real    2m59.985s
user    1m38.353s
sys     0m31.445s

With just git-apply and /bin/true it takes:
real    2m1.581s
user    1m3.169s
sys     0m29.903s


Looking at the individual numbers:
$ time git-write-tree-nowritetree --missing-ok

real    0m0.158s
user    0m0.052s
sys     0m0.008s
$ time git-write-tree-nowritetree --missing-ok

real    0m0.155s
user    0m0.057s
sys     0m0.003s
$ time git-write-tree-nowritetree --missing-ok 
real    0m0.065s
user    0m0.057s
sys     0m0.002s
$ time git-write-tree-nowritetree --missing-ok

real    0m0.159s
user    0m0.055s
sys     0m0.005s
$ time git-write-tree-nowritetree --missing-ok

real    0m0.151s
user    0m0.054s
sys     0m0.007s
$ time git-write-tree-nowritetree --missing-ok

real    0m0.154s
user    0m0.056s
sys     0m0.005s

$ time git-write-tree-nosha1write --missing-ok
0000000000000000000000000000000000000000

real    0m0.199s
user    0m0.091s
sys     0m0.008s
$ time git-write-tree-nosha1write --missing-ok
0000000000000000000000000000000000000000

real    0m0.195s
user    0m0.094s
sys     0m0.007s
$ time git-write-tree-nosha1write --missing-ok
0000000000000000000000000000000000000000

real    0m0.198s
user    0m0.092s
sys     0m0.009s

$ time git-write-tree --missing-ok
0ecfe3dbc2e65aa9638c62abf0cf05057c77f884

real    0m0.217s
user    0m0.113s
sys     0m0.012s

$ time git-write-tree
0ecfe3dbc2e65aa9638c62abf0cf05057c77f884

real    0m0.276s
user    0m0.169s
sys     0m0.008s

So at a quick inspection it looks to me like:
About .059s to perform to check for missing files.
About .019s to write the new tree.
About .155s in start up overhead, read_cache, and sanity checks.

So at a first glance it looks like librification to
allow the redundant work to be skipped, is where
the big speed win on my machine would be.

> Your patch looks ok from a quick read-through:

Thanks.

My import of 2.6.17-rc1-mm2 gives exactly the same
result as simply applying Andrews patch.  Which while
not definitive hits a lot of interesting cases.

> Acked-by: Linus Torvalds <torvalds@osdl.org>
>
> 		Linus
