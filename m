From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: another packed-refs race
Date: Mon, 06 May 2013 14:03:40 +0200
Message-ID: <51879C1C.5000407@alum.mit.edu>
References: <20130503083847.GA16542@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 06 14:03:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZK8z-000438-Kb
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 14:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab3EFMDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 08:03:45 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:64260 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752463Ab3EFMDo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 May 2013 08:03:44 -0400
X-AuditID: 12074412-b7f216d0000008d4-e5-51879c1f3955
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.F9.02260.F1C97815; Mon,  6 May 2013 08:03:43 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r46C3f6O005190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 May 2013 08:03:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130503083847.GA16542@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqCs/pz3Q4OVbRYuuK91MFvPu7mKy
	+NHSw+zA7HHp5Xc2j2e9exg9Pm+SC2CO4rZJSiwpC85Mz9O3S+DOuLNuFnPBRsOKczNmsjYw
	Nql3MXJySAiYSLTtmc4IYYtJXLi3nq2LkYtDSOAyo8SSja8YIZxjTBLv9s1kBaniFdCWWNyy
	jQ3EZhFQlbj27wILiM0moCuxqKeZCcQWFQiTWLV+GTNEvaDEyZlPwGpEBGQlvh/eCLaNWcBK
	YtWVNrCZwkBzJi6bwA5iCwHFX0w/BWRzcHAKWEvM2CgPYjILqEusnycE0Skvsf3tHOYJjAKz
	kCyYhVA1C0nVAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxghgSu0g3H9
	SblDjAIcjEo8vIVP2gKFWBPLiitzDzFKcjApifIqTW8PFOJLyk+pzEgszogvKs1JLT7EKMHB
	rCTC67MXqJw3JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYL3wyygoYJF
	qempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgKI0vBsYpSIoHaC/fbKB23uKCxFygKETr
	KUZdjpVXnrxmFGLJy89LlRLnnQWyQwCkKKM0D24FLE29YhQH+liYlxFkFA8wxcFNegW0hAlo
	SQIf2JKSRISUVAPjnBvCn2uC/PO0/rvWf8qfFPKz5gT7gjd8Ms8S2J5/TTjzJzVlWtWdWTPr
	OB2z7mfdMheTX8enwL0mQllIqn6DxK2C1aZ/rmltLsyQf3rvFrfWZA33vN8ickfv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223442>

On 05/03/2013 10:38 AM, Jeff King wrote:
> I found another race related to the packed-refs code. Consider for a
> moment what happens when we are looking at refs and another process does
> a simultaneous "git pack-refs --all --prune", updating packed-refs and
> deleting the loose refs.
> 
> If we are resolving a single ref, then we will either find its loose
> form or not. If we do, we're done. If not, we can fall back on what was
> in the packed-refs file. If we read the packed-refs file at that point,
> we're OK. If the loose ref existed before but was pruned before we could
> read it, then we know the packed-refs file is already in place, because
> pack-refs would not have deleted the loose ref until it had finished
> writing the new file. But imagine that we already loaded the packed-refs
> file into memory earlier. We may be looking at an _old_ version of it
> that has an irrelevant sha1 from the older packed-refs file. Or it might
> not even exist in the packed-refs file at all, and we think the ref does
> not resolve.
>
> We could fix this by making sure our packed-refs file is up to date

s/file/cache/

> before using it. E.g., resolving a ref with the following sequence:
> 
>   1. Look for loose ref. If found, OK.
> 
>   2. Compare inode/size/mtime/etc of on-disk packed-refs to their values
>      from the last time we loaded it. If they're not the same, reload
>      packed-refs from disk. Otherwise, continue.
> 
>   3. Look for ref in in-memory packed-refs.
> 
> Not too bad. We introduce one extra stat() for a ref that has been
> packed, and the scheme isn't very complicated.

Let me think out loud alongside your analysis...

By this mechanism the reader can ensure that it never uses a version of
the packed-refs file that is older than its information that the
corresponding loose ref is absent from the filesystem.

This is all assuming that the filesystem accesses have a defined order;
how is that guaranteed?  pack_refs() and commit_ref() both rely on
commit_lock_file(), which calls

    close(fd) on the lockfile
    rename(lk->filename, result_file)

prune_ref() locks the ref, verifies that its SHA-1 is unchanged, then
calls unlink(), then rollback_lock_file().

The atomicity of rename() guarantees that a reader sees either the old
or the new version of the file in question.  But what guarantees are
there about accesses across two files?  Suppose we start with ref "foo"
that exists only as a loose ref, and we have a pack-refs process doing

    write packed-refs with "foo"
    commit_lock_file() for packed-refs
    read loose ref "foo" and verify that its SHA-1 is unchanged
    unlink() loose ref "foo"

while another process is trying to read the reference:

    look for loose ref "foo"
    read packed-refs

Is there any guarantee that the second process can't see the loose ref
"foo" as being missing but nevertheless read the old version of
packed-refs?  I'm not strong enough on filesystem semantics to answer
that question.

> But what about enumerating refs via for_each_ref? It's possible to have
> the same problem there, and the packed-refs file may be moved into place
> midway through the process of enumerating the loose refs. So we may see
> refs/heads/master, but when we get to refs/remotes/origin/master, it has
> now been packed and pruned.

Yes.

> I _think_ we can get by with:
> 
>   1. Generate the complete sorted list of loose refs.
> 
>   2. Check that packed-refs is stat-clean, and reload if necessary, as
>      above.
> 
>   3. Merge the sorted loose and packed lists, letting loose override
>      packed (so even if we get repacked halfway through our loose
>      traversal and get half of the refs there, it's OK to see duplicates
>      in packed-refs, which we will ignore).
> 
> This is not very far off of what we do now. Obviously we don't do the
> stat-clean check in step 2. But we also don't generate the complete list
> of loose refs before hitting the packed-refs file. Instead we lazily
> load the loose directories as needed. And of course we cache that
> information in memory, even though it may go out of date. I think the
> best we could do is keep a stat() for each individual directory we see,
> and check it before using the in-memory contents. That may be a lot of
> stats, but it's still better than actually opening each loose ref
> separately.

The loose refs cache is only used by the for_each_ref() functions, not
for looking up individual references.  Another approach would be to
change the top-level for_each_ref() functions to re-stat() all of the
loose references within the namespace that interests it, *then* verify
that the packed-ref cache is not stale, *then* start the iteration.
Then there would be no need to re-stat() files during the iteration.
(This would mean that we have to prohibit a second reference iteration
from being started while one is already in progress.)

Of course, clearing (part of) the loose reference cache invalidates any
pointers that other callers might have retained to refnames in the old
version of the cache.  I've never really investigated what callers might
hold onto such pointers under the assumption that they will live to the
end of the process.

Given all of this trouble, there is an obvious question: why do we have
a loose reference cache in the first place?  I think there are a few
reasons:

1. In case one git process has to iterate through the same part of the
reference namespace more than once.  (Does this frequently happen?)

2. Reading a bunch of loose references at the same time is more
efficient than reading them one by one interleaved with other file
reads.  (I think this is a significant win.)

3. Keeping references in a cache means that their refnames have a longer
life, which callers can take advantage of to avoid making their own
copies.  I haven't checked which callers might make this assumption, and
nowhere is the lifetime of such a refname documented so it is not even
clear what callers are *allowed* to assume.  (In my changes I've tried
to stay on the safe side by not reducing any lifetimes.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
