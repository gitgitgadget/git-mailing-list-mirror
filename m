From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 13/16] prune: keep objects reachable from recent objects
Date: Tue, 07 Oct 2014 18:29:00 +0200
Message-ID: <543414CC.9020104@alum.mit.edu>
References: <20141003202045.GA15205@peff.net> <20141003203931.GM16293@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 18:29:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbXda-0008EO-Qg
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 18:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbaJGQ3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 12:29:09 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43156 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754073AbaJGQ3H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2014 12:29:07 -0400
X-AuditID: 1207440c-f79036d000005e77-12-543414ce8a99
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.57.24183.EC414345; Tue,  7 Oct 2014 12:29:02 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C4D.dip0.t-ipconnect.de [93.219.28.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s97GT0Z3019443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 7 Oct 2014 12:29:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20141003203931.GM16293@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1D0nYhJi8Hwrv0XXlW4mix8tPcwO
	TB7PevcwenzeJBfAFMVtk5RYUhacmZ6nb5fAnfHryn2WgtfaFb+3ejcw7lXqYuTkkBAwkXjT
	cY0FwhaTuHBvPRuILSRwmVFi6rbsLkYuIPssk8S+r58ZQRK8AtoS9z7fBmtgEVCVOHG7lxXE
	ZhPQlVjU08wEYosKBEh86HwAVS8ocXLmE7B6EQEjiRsfvoEtEBbwkXh75QYjxDJ/iXeXD4P1
	cgroSXQ9eARWzyygLvFn3iVmCFteonnrbOYJjPyzkIydhaRsFpKyBYzMqxjlEnNKc3VzEzNz
	ilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCwpFnB+O3dTKHGAU4GJV4eFdoGYcIsSaWFVfmHmKU
	5GBSEuVV4TQJEeJLyk+pzEgszogvKs1JLT7EKMHBrCTCOxUkx5uSWFmVWpQPk5LmYFES51Vd
	ou4nJJCeWJKanZpakFoEk5Xh4FCS4F0uDNQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRY
	WpIRD4rH+GJgRIKkeID2rgVp5y0uSMwFikK0nmLU5Zi08X0vkxBLXn5eqpQ470whoCIBkKKM
	0jy4FbDk84pRHOhjYd4ukFE8wMQFN+kV0BImoCWr+o1BlpQkIqSkGhhbvm/Q3ukxM+Pwhrs7
	DXnuTlyj4lE0I2bSqY76gKpZMWdPbNx76cncl/WvrgRZ6r6pdSwrDlw6TzSr8+NVW/EF5p9q
	pqvfFgmazOQ+rSNQV53h1NoNx4rq25qEIyM3H7Ofndcc33z008NN9evUxP60rSq4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257930>

On 10/03/2014 10:39 PM, Jeff King wrote:
> [...]
> Instead, this patch pushes the extra work onto prune, which
> runs less frequently (and has to look at the whole object
> graph anyway). It creates a new category of objects: objects
> which are not recent, but which are reachable from a recent
> object. We do not prune these objects, just like the
> reachable and recent ones.
> 
> This lets us avoid the recursive check above, because if we
> have an object, even if it is unreachable, we should have
> its referent:
> 
>   - if we are creating new objects, then we cannot create
>     the parent object without having the child
> 
>   - and if we are pruning objects, will not prune the child
>     if we are keeping the parent
> 
> The big exception would be if one were to write the object
> in a way that avoided referential integrity (e.g., using
> hash-object). But if you are in the habit of doing that, you
> deserve what you get.
> 
> Naively, the simplest way to implement this would be to add
> all recent objects as tips to the reachability traversal.
> However, this does not perform well. In a recently-packed
> repository, all reachable objects will also be recent, and
> therefore we have to consider each object twice (both as a
> tip, and when we reach it in the traversal). I tested this,
> and it added about 10s to a 30s prune on linux.git. This
> patch instead performs the normal reachability traversal
> first, then follows up with a second traversal for recent
> objects, skipping any that have already been marked.

I haven't read all of the old code, but if I understand correctly this
is your new algorithm:

1. Walk from all references etc., marking reachable objects.

2. Iterate over *all* objects, in no particular order, skipping the
   objects that are already known to be reachable. Use any unreachable
   object that has a recent mtime as a tip for a second traversal that
   marks all of its references as "to-keep".

3. Iterate over any objects that are not marked "to-keep". (I assume
   that this iteration is in no particular order.) For each object:

   * [Presumably] verify that its mtime is still "old"
   * If so, prune the object

I see some problems with this.

* The one that you mentioned in your cover letter, namely that prune's
  final mtime check is not atomic with the object deletion. I agree
  that this race is so much shorter than the others that we can accept
  a solution that doesn't eliminate it, so let's forget about this one.

* If the final mtime check fails, then the object is recognized as new
  and not pruned. But does that prevent its referents from being pruned?

  * When this situation is encountered, you would have to start another
    object traversal starting at the "renewed" object to mark its
    referents "to-keep". I don't see that you do this. Another, much
    less attractive alternative would be to abort the prune operation
    if this situation arises. But even if you do one of these...

  * ...assuming the iteration in step 3 is in no defined order, a
    referent might *already* have been pruned before you notice the
    "renewed" object.

So although your changes are a big improvement, it seems to me that they
still leave a race with a window approximately as long as the time it
takes to scan and prune the unreachable objects.

I think that the only way to get rid of that race is to delete objects
in parent-to-child order; in other words, *only prune an object after
all objects that refer to it have been pruned*. This could be done by
maintaining reference counts of the to-be-pruned objects and only
deleting an object once its reference count is zero.


The next point that I'm confused by is what happens when a new object or
reference is created while prune is running, and the new object or
reference refers to old objects. I think when we discussed this
privately I claimed that the following freshenings would not be
necessary, but now I think that they are (sorry about that!).


Let's take the simpler case first. Suppose I run the following command
between steps 1 and 3:

    git update-ref refs/heads/newbranch $COMMIT

, where $COMMIT is a previously-unreachable object. This doesn't affect
the mtime of $COMMIT, does it? So how does prune know that it shouldn't
delete $COMMIT?

-> So ISTM that updating a reference (or any other traversal starting
point, like the index) must freshen the mtime of any object newly
referred to.


A more complicated case: suppose I create a new $COMMIT referring to an
old $TREE during step 2, *after* prune has scanned the directory that
now contains $COMMIT. (I.e., the scan in step 2 never notices $COMMIT.)
Then I create a new reference pointing at $COMMIT. (I.e., the scan in
step 1 never noticed that the reference exists.) None of this affects
the mtime of $TREE, does it? So how does prune know that it mustn't
prune $TREE?

-> It seems to me that the creation of $COMMIT has to freshen the mtime
of $TREE, so that the final mtime check in step 3 realizes that it
shouldn't prune $TREE. Or to generalize, whenever a new object is
created which refers to existing objects, the direct referents of the
new object have to have their mtimes freshened. However, when an attempt
to write a new object accidentally coincides with an object that already
exists, *that* object needs to be freshened but *its* referents do *not*.


I hope I understood that all correctly...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
