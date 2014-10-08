From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 13/16] prune: keep objects reachable from recent objects
Date: Wed, 08 Oct 2014 12:37:47 +0200
Message-ID: <543513FB.5080403@alum.mit.edu>
References: <20141003202045.GA15205@peff.net> <20141003203931.GM16293@peff.net> <543414CC.9020104@alum.mit.edu> <20141008071934.GA25250@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 12:38:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbodD-0002iX-UK
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 12:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbaJHKh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 06:37:59 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:48441 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755759AbaJHKh4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Oct 2014 06:37:56 -0400
X-AuditID: 1207440c-f79036d000005e77-26-543513fd75c3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 36.D2.24183.DF315345; Wed,  8 Oct 2014 06:37:50 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C78.dip0.t-ipconnect.de [93.219.28.120])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s98Abl9S001967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 8 Oct 2014 06:37:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20141008071934.GA25250@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqPtP2DTE4G0Tk0XXlW4mix8tPcwO
	TB7PevcwenzeJBfAFMVtk5RYUhacmZ6nb5fAnfGh8Q1jwdWIikVXrzM3MN537WLk5JAQMJH4
	MXUJC4QtJnHh3no2EFtI4DKjxPELOV2MXED2OSaJT0/uMIEkeAW0Je6tv88KYrMIqEqc/nKC
	GcRmE9CVWNTTDFYjKhAg8aHzASNEvaDEyZlPwBaICMhKfD+8ESjOwcEsIC7R/w8sLCzgI/H2
	yg1GiL0TGSXu7ggDsTkF9CSWNH0Fq2EWUJf4M+8SM4QtL9G8dTbzBEaBWUg2zEJSNgtJ2QJG
	5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuoZ6uZkleqkppZsYIWHKs4Px2zqZQ4wCHIxKPLwG
	zSYhQqyJZcWVuYcYJTmYlER56wVMQ4T4kvJTKjMSizPii0pzUosPMUpwMCuJ8Fb/AirnTUms
	rEotyodJSXOwKInzqi5R9xMSSE8sSc1OTS1ILYLJynBwKEnw5gHjUUiwKDU9tSItM6cEIc3E
	wQkynEtKpDg1LyW1KLG0JCMeFKfxxcBIBUnxAO3VAGnnLS5IzAWKQrSeYtTlmLTxfS+TEEte
	fl6qlDgvI0iRAEhRRmke3ApYUnrFKA70sTAvC0gVDzChwU16BbSECWjJqn5jkCUliQgpqQZG
	qZjAd2pXTlpMPnxgfarC4ranr6ZNmbK81O9lUua2nPcH1DkF+QK95WN+lHy8cWtZ3nqB63Oa
	XZ+klty98fKz3cmUpM+zFXQsvI7zMe/h0Hdb9+avXPrzA0uLpB2cdn1pvihzMlgj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2014 09:19 AM, Jeff King wrote:
> On Tue, Oct 07, 2014 at 06:29:00PM +0200, Michael Haggerty wrote:
> 
>> I haven't read all of the old code, but if I understand correctly this
>> is your new algorithm:
>>
>> 1. Walk from all references etc., marking reachable objects.
>>
>> 2. Iterate over *all* objects, in no particular order, skipping the
>>    objects that are already known to be reachable. Use any unreachable
>>    object that has a recent mtime as a tip for a second traversal that
>>    marks all of its references as "to-keep".
>>
>> 3. Iterate over any objects that are not marked "to-keep". (I assume
>>    that this iteration is in no particular order.) For each object:
>>
>>    * [Presumably] verify that its mtime is still "old"
>>    * If so, prune the object
> 
> Yes, that's more or less accurate. The iteration is in readdir() order
> on the filesystem.
> 
> We do verify that the mtime is still "old" in the final iteration, but
> that is mostly because the existing check was left in. In theory any
> recent objects would have been caught in step 2 and marked as "to-keep"
> already. Anything we find in step 3 would have to have been racily
> created or freshened.

I *like* the mtime check in step 3 and think it should be kept.

>> I see some problems with this.
>>
>> * The one that you mentioned in your cover letter, namely that prune's
>>   final mtime check is not atomic with the object deletion. I agree
>>   that this race is so much shorter than the others that we can accept
>>   a solution that doesn't eliminate it, so let's forget about this one.
> 
> Right, I don't see an easy way around this.

I had an idea to mostly get around it; see below.

>> * If the final mtime check fails, then the object is recognized as new
>>   and not pruned. But does that prevent its referents from being pruned?
>>
>>   * When this situation is encountered, you would have to start another
>>     object traversal starting at the "renewed" object to mark its
>>     referents "to-keep". I don't see that you do this. Another, much
>>     less attractive alternative would be to abort the prune operation
>>     if this situation arises. But even if you do one of these...
>>
>>   * ...assuming the iteration in step 3 is in no defined order, a
>>     referent might *already* have been pruned before you notice the
>>     "renewed" object.
>>
>> So although your changes are a big improvement, it seems to me that they
>> still leave a race with a window approximately as long as the time it
>> takes to scan and prune the unreachable objects.
> 
> Correct. There is a delay between marking objects and deleting them.
> This goes for both the existing reachability checks and the new "recent
> reachability" check.
> 
> As noted above, if we see a fresh object in the final check, then we
> know that it was newly freshened (or created). We could then do an
> additional traversal with it as the tip, to get a slightly more accurate
> view of the world.
> 
> The obvious problem as you note is that we may already have deleted its
> referents. But let's leave that aside for a moment.
> 
> But even if we fix that problem, I don't think traversing again can
> eliminate the race. Another process may be freshening or creating
> objects after we have processed them (or their containing directories).

...then you would traverse again when you discovered an object freshened
by *that* process.

Please note that these would not be full traversals; you would only have
to traverse starting at the newly freshened object(s), and the traversal
could stop when it hit objects that are already known to be "to-keep".
So they should be quick. (But the length of the residual race wouldn't
depend on their being quick.)

> So you can catch _some_ cases by re-traversing, but there will always be
> cases where we delete an object that has just now become recent (or
> reachable, for that matter, if somebody updates the refs).
> 
> The obvious solution is to have some atomic view of the object and ref
> namespace (i.e., a global write lock that says "I'm pruning, nobody
> write"). But that sucks for obvious reasons. I feel like there must be
> some more clever solution, but it eludes me. Surely this is something
> database people solved 30 years ago. :)
> 
>> I think that the only way to get rid of that race is to delete objects
>> in parent-to-child order; in other words, *only prune an object after
>> all objects that refer to it have been pruned*. This could be done by
>> maintaining reference counts of the to-be-pruned objects and only
>> deleting an object once its reference count is zero.
> 
> Yes, if you are going to traverse again, you would want to delete in
> parent-child order. I'm not convinced that traversing again is worth it;
> it's trying to shorten the window, but it can't eliminate it. And my
> goal here was never to eliminate the race. It was to keep races to
> "simultaneous reference and prune is a problem", and not "ongoing
> unbounded operations and simultaneous prune are a problem". And I do not
> claim to eliminate the possibility of referents going missing; only to
> try to close some obvious and easy holes where it happens.
> 
>> Let's take the simpler case first. Suppose I run the following command
>> between steps 1 and 3:
>>
>>     git update-ref refs/heads/newbranch $COMMIT
>>
>> , where $COMMIT is a previously-unreachable object. This doesn't affect
>> the mtime of $COMMIT, does it? So how does prune know that it shouldn't
>> delete $COMMIT?
>>
>> -> So ISTM that updating a reference (or any other traversal starting
>> point, like the index) must freshen the mtime of any object newly
>> referred to.
> 
> _If_ the deletion of the object and the checking of its mtime were
> atomic, that would be useful to do. But it's not. Before my patch, you
> have one way of "saving" the object (and its referents): making it
> reachable from a ref. After my patch, you have the additional option of
> updating its mtime.
> 
> But why bother with the mtime? You can just make it reachable by
> updating the ref. Both are racy, but we cannot help that, so one is as
> good as the other.

Yes, but the race between the time prune starts reading the references
and the time that it scans all objects to find the ones that were not
marked reachable can be quite long--many seconds for a big repo. During
this whole time, if somebody creates a new reference that refers to a
previously-unreachable object, then prune will corrupt the repository.

On the other hand, if creating a new reference freshens the referent,
then the only race window is the one between prune's final check of the
object's mtime and its deletion of the file, which is only the time for
two consecutive system calls.

This is an enormous difference, and one is definitely not as good as the
other unless perfection is considered the only metric of success.

>> A more complicated case: suppose I create a new $COMMIT referring to an
>> old $TREE during step 2, *after* prune has scanned the directory that
>> now contains $COMMIT. (I.e., the scan in step 2 never notices $COMMIT.)
>> Then I create a new reference pointing at $COMMIT. (I.e., the scan in
>> step 1 never noticed that the reference exists.) None of this affects
>> the mtime of $TREE, does it? So how does prune know that it mustn't
>> prune $TREE?
> 
> It doesn't, and you are screwed. :)
> 
> You could freshen the referents here, but you are still racy. Just as
> you might miss the creation of $COMMIT, you might miss the freshening of
> $TREE and delete it.

But again, the race window for missing the freshening of $TREE would
only be the time of two consecutive system calls.

> Making the mtimes race-free requires an atomic check-timestamp-and-delete.
> And without that, I'm not sure that shortening the race from 50 system
> calls to 3 system calls is worth the additional complexity. If we had
> such an atomic operation, even on only a subset of systems, it might
> be worth it. But I do not know of any filesystem or system call that can
> do so.

It it were only 50 consecutive system calls, that would be one thing.
But can't the full object traversal take many seconds on a large repo?
That still seems like a pretty big race to me.


I think I found a way to make the final check-timestamp-and-delete safe,
albeit leaving open the possibility that the object is briefly moved to
a different filename. I don't think it's *necessary*, but I think it's
*possible*:

Any process that wants to create a new reference to an existing object
freshens the corresponding file as follows:

1. Write the file (if necessary)

2. Update the file's mtime.

   * If the mtime update succeeds, your object is safe against being
     pruned (though it might be renamed for a moment; see below)

   * If the mtime update fails, treat it as if the object had never
     been there (e.g., report an error or write a new copy of the
     object). This is the same situation as if the object had been
     pruned just before you sought it.

Prune, when it is pretty sure that it wants to delete a file in step 3,
does the following:

1. Check mtime to make sure the file is still stale (this is not
   strictly necessary, but prevents an object that has been freshened
   since the traversal in step 2 from being temporarily renamed).

2. Rename the file to "<filename>.to-be-deleted" (or, possibly, using
   the filename "<filename>.lock" would have good side-effects).

3. Check the mtime again to make sure the file is still stale.

   * If yes, then delete the object permanently

   * If no, then rename it back to its original name

4. If either of the staleness checks failed, then do an object
   traversal to mark this object and any of its (direct or indirect)
   referents "to-keep".

I think that this procedure, along with a change to deleting objects in
referrer-then-referent order, would guarantee that prune can never
permanently delete any object that is still be in use, though it might
move such a file to a different filename for a moment.

I'm not sure that this scheme would work on Windows (I seem to recall
that renaming a file on Windows changes its mtime). But nobody in their
right mind would run a Git server on a Windows computer anyway...

Also, to be really super anal about things, there should be a procedure
to reinstate any "<filename>.to-be-deleted" files if the program dies or
if the computer crashes during the final, FINAL mtime check. But that is
almost certainly overkill.

>> I hope I understood that all correctly...
> 
> I think your analysis is all correct. The open question is whether it's
> worth trying to shrink the last bits of raciness or not (or even whether
> there is a clever way of eliminating them that I haven't considered).

To be clear, I think your changes are a big improvement, and my ideas
here should not be seen as blockers to your patch series getting
accepted. But I think your changes still leave races that are big enough
that they will be observed on busy Git servers.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
