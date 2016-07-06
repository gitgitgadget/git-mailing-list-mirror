Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703302070E
	for <e@80x24.org>; Wed,  6 Jul 2016 16:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbcGFQyL (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 12:54:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:50152 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813AbcGFQyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 12:54:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bKq5O-0007qJ-0R
	for git@vger.kernel.org; Wed, 06 Jul 2016 18:54:06 +0200
Received: from 65.222.173.206 ([65.222.173.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 18:54:05 +0200
Received: from peartben by 65.222.173.206 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 18:54:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v13 11/20] index-helper: use watchman to avoid refreshing index with lstat()
Date:	Wed, 6 Jul 2016 16:54:00 +0000 (UTC)
Message-ID: <loom.20160706T170547-355@post.gmane.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org> <1466914464-10358-11-git-send-email-novalis@novalis.org> <loom.20160630T192750-125@post.gmane.org> <CACsJy8DjYLQCBRc9CzFSWNqkVnhbAfnxd1mnQh4oEfJwKjPd1A@mail.gmail.com> <loom.20160701T013515-311@post.gmane.org> <CACsJy8DvZgj0w8z8LdeuY8HdTTcEu7ABPyFi_wnmEZOGsoMkDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.222.173.206 (Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds <at> gmail.com> writes:

> 
> First step would be enabling that because besides directory
> traversing, this code does a lot of string processing that's hopefully
> eliminated by untracked cache extension. I cut git-status' time in
> half with it. The side effect though, is that it creates a new flow of
> stat(), one per directory. It would be great if you could do some
> measurements with untracked cache on Windows and see if we get similar
> gain.
 
These numbers were captured with core.fscache and core.untrackedcache 
both set to true in the belief that it would produce the best 
performance.  If that is incorrect, I'm happy to capture numbers with 
other options set.  

If you drill the next step down into the call tree, the bulk of the cost
of read_directory is coming from mingw_stat (85.6%).  These numbers are 
inclusive in that they reflect the of the function plus any of its 
callees.  

If you look at the overall cost of functions exclusively (ie that only 
include the cost of the function and not it's children), 
kernelbase!CreateFileW, kernelbase!CloseHandle, and 
kernebase!GetFileInformationByHandle dominate (84.9% of the time).  
These functions form the basis of the stat emulation on Windows although
the fscache certainly has an impact on what is happening here as well.

While we can certainly work to speed these up, the biggest performance 
win will be eliminating as many of these calls as possible which is what
we are hoping to accomplish by using Watchman to limit the files that 
_need_ a stat call.

> > Given there were no dirty files, Watchman would have made a huge
> > improvement in the overall time but index helper would have had
> > relatively little impact.  We've noticed this same pattern in all our
> > repos which is what is driving our interest in the Watchman model and
> > also shows why index-helper is of less interest.
> 
> Assuming that untracked cache cuts git-status time by half on Windows
> as well, then index read time now takes a bigger percentage, 8%, where
> it starts to make sense to optimize it.
> 
> On a quiet repository, having watchman does not help so much because
> we already reduce the significant number of filesystem-related system
> calls. Yes there is lstat() and eliminating it may gain some more
> (with watchman) and it matters on a repo with lots of directories. You
> probably can just take these lstat out (I can help point out where)
> and see how much the gain is.

I don't understand why Watchman won't provide a _significant_ improvement
here.  My understanding is that it will minimize the stat calls to those
files that may have changed as well as limiting the untracked cache to
only scanning those directories that may have changes in them.  In this
particular scenario, _no_ files have changed so Watchman would return
an empty set thus eliminating virtually the stat calls and directory
enumerations.  I'd expect this to result in a >90% savings.  Am I 
missing something?

> Assuming (blindly again) that removing lstat helps like 10% of
> read_index(), we would need to profile untracked cache code and see
> where what we can do next. There are still a lot of directory
> traversing there (except that it traverses the cache instead of
> filesystem) and maybe we can do something. But I haven't gotten that
> far.
> 
> > While the current design hides watchman behind index-helper, if we were
> > to change that model so they were independent, we would be interested
> > in doing it in such a way that provided some abstraction so that it
> > could be replaced with another file watching daemon.
> 
> Frankly I'm not that interested in replacing another file watching
> daemon. My first attempt at this problem was "file-watcher" which was
> tied to Linux inotify system only and it would make sense to make it
> replaceable. But watchman supports OS X, Linux, FreeBSD and Windows
> now, not just Linux only as before, why another abstraction layer? You
> could even replace "watchman.exe" binary. As long as you produce the
> same json data, your new daemon should still work.

This is a simplification it would be nice to make as we have other code
already running that can report on all the changes happening.  It would
enable us to remove the additional complexity of the Watchman daemon. 
I'm sure we can make it work either way by emulating the Watchman 
interface and output.

> Tying index caching daemon and file watching daemon (let's avoid
> "watchman" for now) gives us a bonus. Because both git and the caching
> daemon know that they read the same index, we could answer the
> question "what files are dirty?" with "file number 1, 5, 9 in the
> index" instead of sending full paths and git has to make some more
> lookups to identify them. In this series we send it as a compressed
> bit map. Probably not a big deal in terms of real performance, but it
> feels nice to do lookups less.

Today, Watchman returns a list of files and directories and then creates
the compressed bitmap that index-helper uses.  The work of looking those
entries up in the index and then creating the bitmap still has to happen
so I suspect you are correct that it doesn't make much of a real 
performance difference.  It's just moving where that lookup and bitmap
creation happens.

I'm in the process of prototyping this, and currently skip much of the 
process of iterating through the list of changed files, looking up the 
entry in the index, creating the bitmap, passing that bitmap through the 
WAMA section to index-helper reading the WAMA section in git and then 
looping through the bitmap to set the CE_WATCHMAN_DIRTY bit on the 
corresponding index entries and updating the untracked cache.

Instead, I iterate through the list of changed files, look up the entry 
in the index and directly set the dirty bit all within read-cache.c.  
At this point, it's <100 lines of code.  I'll keep fleshing this out
and get some perf numbers once it's working.

While this saves several steps and reduces complexity (index-helper and 
the WAMA is section are no longer involved), it does mean that 
read-cache.c needs a platform independent way to query and receive the 
list of modified files and directories.  It also means we need a way to 
store the date/time string passed to the file watching daemon in the 
index.  Using the WAMA section just to store the date/time seems a bit 
heavy but it can work.

> The second reason is because watchman daemon alone does not provide
> enough information to reduce untracked cache's lstat() as much as
> possible. The current approach in this series is a naive one, which
> works for some cases, but not optimal (I'll get to that). We need a
> separate long-running daemon to maintain extra info to reduce lstat().
> Because our target is watchman, it does not make sense to add yet
> another daemon besides index-helper to do this.
> 
> OK the optimal lstat() reduction thing. Right now, if any file in a
> directory is updated, the directory is invalidated in untracked cache
> and we need to traverse it to collect excluded files again. But it
> does not have to be that way. We don't care if any file is _updated_
> because it will not change untracked cache output. We care about what
> files are _added_ or _deleted_. New files will need to be classified
> as either tracked, untracked or ignored. Deleted files may invalid
> either three file lists. Watchman cannot answer "what files are added
> or deleted since the point X in time" and I agree that it's not
> watchman's job (watchman issue 65). So we have to maintain some more
> info by ourselves, e.g. the list of files at any requested "clock".
> With that we can compare the file lists of two "clock"s and tell git
> what files are added or deleted.

This sounds like a nice optimization but right now I'm focused on how we
can scope the cost of status to be limited to the files and directories
that may have changes.  With large repos, this is a small subset of the
overall repo and will hopefully be enough to make the performance 
reasonable.


