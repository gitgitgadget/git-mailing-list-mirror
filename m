From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs: do not use cached refs in repack_without_ref
Date: Wed, 26 Dec 2012 09:24:39 +0100
Message-ID: <50DAB447.8000101@alum.mit.edu>
References: <20121221080449.GA21741@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 26 09:25:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnmIU-00083P-NV
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 09:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab2LZIYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 03:24:48 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:60675 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753885Ab2LZIYr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Dec 2012 03:24:47 -0500
X-AuditID: 12074413-b7f786d0000008bb-f8-50dab44b4d69
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 21.22.02235.B44BAD05; Wed, 26 Dec 2012 03:24:43 -0500 (EST)
Received: from [192.168.69.140] (p57A256D8.dip.t-dialin.net [87.162.86.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qBQ8OdSV019492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Dec 2012 03:24:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121221080449.GA21741@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqOu95VaAwYV2c4uuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bk/WpIK7jtXfDvazNzAuMKk
	i5GTQ0LAROLrqyZWCFtM4sK99WxdjFwcQgKXGSUeX93HBOGcYZLY82MjM0gVr4C2xPy2n4wg
	NouAqsSMWQvA4mwCuhKLepqZQGxRgQCJxUvOsUPUC0qcnPmEBcQWEZCV+H54I1gvs4C1xO4+
	iLiwgLvEo3n3gTZzAC2zkth/Ox0kzAlU8mp6AytImFlAXWL9PCGITnmJ7W/nME9gFJiFZMEs
	hKpZSKoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJWuEdjLtOyh1i
	FOBgVOLh3fT9ZoAQa2JZcWXuIUZJDiYlUd6j624FCPEl5adUZiQWZ8QXleakFh9ilOBgVhLh
	VVgFlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAu2gTUKFiUmp5a
	kZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K0fhiYJSCpHiA9s7aCLK3uCAxFygK0XqKUZfj
	VsPNp4xCLHn5ealS4rx2m4GKBECKMkrz4FbAUtQrRnGgj4V5P4NcwgNMb3CTXgEtYQJaEst3
	A2RJSSJCSqqBsTiyd5rcS3kdGQ/WRLXcpSnSwi92tEYJPXLoyVVc3/PMrbhmZtDdGmu9uep2
	BbyHEtXEJp+N8NwqX/lYlOMOl4iI4ub2I+4NUdtTblrfdpRTlfodW36Xbz/HeRf9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212131>

On 12/21/2012 09:04 AM, Jeff King wrote:
> When we delete a ref that is packed, we rewrite the whole
> packed-refs file and simply omit the ref that no longer
> exists. However, we base the rewrite on whatever happens to
> be in our refs cache, not what is necessarily on disk. That
> opens us up to a race condition if another process is
> simultaneously packing the refs, as we will overwrite their
> newly-made pack-refs file with our potentially stale data,
> losing commits.
> [...]
> 
> There are a few other interesting races in this code that this does not
> fix:
> 
>   1. We check to see whether the ref is packed based on the cached data.
>      That means that in the following sequence:
> 
>        a. receive-pack starts, caches packed refs; master is not packed
> 
>        b. meanwhile, pack-refs runs and packs master
> 
>        c. receive-pack deletes the loose ref for master (which might be
>           a no-op if the pack-refs from (b) got there first). It checks
>           its cached packed-refs and sees that there is nothing to
>           delete.
> 
>      We end up leaving the entry in packed-refs. In other words, the
>      deletion does not actually delete anything, but it still returns
>      success.
> 
>      We could fix this by scanning the list of packed refs only after
>      we've acquired the lock. The downside is that this would increase
>      lock contention on packed-refs.lock. Right now, two deletions may
>      conflict if they are deletions of packed refs. With this change,
>      any two deletions might conflict, packed or not.
> 
>      If we work under the assumption that deletions are relatively rare,
>      this is probably OK. And if you tend to keep your refs packed, it
>      would not make any difference. It would have an impact on repos
>      which do not pack refs, and which have frequent simultaneous
>      deletions.
> 
>   2. The delete_ref function first deletes the loose ref, then rewrites
>      the packed-refs file. This means that for a moment, the ref may
>      appear to have rewound to whatever was in the packed-refs file, and
>      the reader has no way of knowing.
> 
>      This is not a huge deal, but I think it could be fixed by swapping
>      the ordering. However, I think that would open us up to the reverse
>      race from above: we delete from packed-refs, then before we delete
>      the loose ref, a pack-refs process repacks it. Our deletion looks
>      successful, but the ref remains afterwards.

I'm sorry to take so long to respond to this patch.  Thank you for
tracking down this bug and for your careful analysis.

I think your patch is correct and should fix the first race condition
that you described.  But I think the continued existence of the other
race conditions is an indication of a fundamental problem with the
reference locking policy--independent of the in-RAM reference cache.

The tacit assumption of the current locking policy is that changes to
the packed-refs file are not critical for correctness, because loose
references take precedence over it anyway.  This is true for adding and
modifying references.  But it is not true for deleting references,
because there is no way for a deletion to be represented as a loose
reference in a way that takes precedence over the packed-refs file
(i.e., there is no way for a loose reference to say "I am deleted,
regardless of what packed-refs says").  Thus the race conditions for
deleting references, whether via delete_ref() or via pack_refs() with
--prune.

The current algorithms for deleting references are:

* Delete reference foo:

  1. Acquire the lock $GIT_DIR/refs/heads/foo.lock

  2. Unlink $GIT_DIR/refs/heads/foo

  3. repack_without_ref():

     a. Acquire the lock $GIT_DIR/packed-refs.lock

     b. Write the packed-refs without the "foo" reference to
        $GIT_DIR/packed-refs.lock

     c. Rename $GIT_DIR/packed-refs.lock to $GIT_DIR/packed-refs

  4. Release lock $GIT_DIR/refs/heads/foo.lock

* Pack references:

  1. Acquire lock $GIT_DIR/packed-refs.lock

  2. for_each_ref() call handle_one_ref():

     a. Write ref and its SHA1 to $GIT_DIR/packed-refs.lock

     b. Possibly record ref and its SHA1 in the refs_to_prune list.

  3. Commit $GIT_DIR/packed-refs

  4. prune_refs(): for each ref in the ref_to_prune list, call
     prune_ref():

     a. Lock the reference using lock_ref_sha1(), verifying that the
        recorded SHA1 is still valid.  If it is, unlink the loose
        reference file then free the lock; otherwise leave the loose
        reference file untouched.

There is a problem if two processes try to delete a reference at the
same time, or if one process tries to delete a reference at the same
time as another process is trying to pack the references.  The reason is
that there is no "transaction" that spans both the rewriting of the
packed-refs file and also the deletion of the loose-ref files, and
therefore it is possible for conflicting changes to be made in the two
locations.

I think that all of the problems would be fixed if a lock would be held
on the packed-refs file during the whole process of deleting any
reference; i.e., change the algorithms to:

* Delete reference foo:

  1. Acquire the lock $GIT_DIR/packed-refs.lock (regardless of whether
     "foo" is a packed ref)

  2. Write to $GIT_DIR/packed-refs.new a version of the packed-refs
     file that omits "foo"

  3. Atomically replace $GIT_DIR/packed-refs with
     $GIT_DIR/packed-refs.new (but without relinquishing the lock
     $GIT_DIR/packed-refs.lock)

  4. Delete loose ref for "foo":

     a. Acquire the lock $GIT_DIR/refs/heads/foo.lock

     b. Unlink $GIT_DIR/refs/heads/foo if it is unchanged.  If it is
        changed, leave it untouched.  If it is deleted, that is OK too.

     c. Release lock $GIT_DIR/refs/heads/foo.lock

  5. Release lock $GIT_DIR/packed-refs.lock (without changing
     $GIT_DIR/packed-refs again)

* Pack references:

  1. Acquire lock $GIT_DIR/packed-refs.lock

  2. for_each_ref() call handle_one_ref():

     a. Write ref and its SHA1 to $GIT_DIR/packed-refs.new

     b. Possibly record ref and its SHA1 in the refs_to_prune list.

  3. Atomically replace $GIT_DIR/packed-refs with
     $GIT_DIR/packed-refs.new (but without relinquishing the lock
     $GIT_DIR/packed-refs.lock)

  4. prune_refs(): for each ref in the ref_to_prune list, call
     prune_ref():

     a. Lock the loose reference using lock_ref_sha1(), verifying that
        the recorded SHA1 is still valid

     b. If it is, unlink the loose reference file (otherwise, leave
        it untouched)

     c. Release the lock on the loose reference

  5. Release lock $GIT_DIR/packed-refs.lock (without changing
     $GIT_DIR/packed-refs again)

It is important that after step (3) in either of the above algorithms,
the new packed-refs file has been switched "live" even though there is
no way to guarantee that it holds the correct values for all references.
 This is OK, because (a) references that have been added or changed will
be represented by loose references that take precedence over the stale
references in the packed-refs file; (b) no references can have been
deleted while the packed-refs file was being rewritten, because
reference deletion is serialized via the lock on the packed-refs file.
If one of the later steps fails, it is OK to leave this version of the
packed-refs file active.

The proposed algorithms will have to hold the lock on packed-refs for
much longer; in the case of packed-refs, the lock has to be held for the
whole time that all of the loose references are being deleted.
Effectively it is being used to prevent other processes from deleting
references while it is working because that would make the just-written
packed-refs file invalid.

I would appreciate a critique of my analysis.  Even if you agree, I
think it would be OK to apply Peff's patch to fix up the most pressing
problem, then implement the more complete solution later.

By the way, this is something that I would be happy to add to my to-do
list, but it could take a while for me to get to it because of a lack of
time and because I'm still busy with two other biggish git-related
projects (git-multimail [1] and a git merging helper [2]).

Michael

[1] https://github.com/mhagger/git-multimail

[2] A fun project that I haven't yet mentioned on the list

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
