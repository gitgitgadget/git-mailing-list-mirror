X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Thoughts about memory requirements in traversals [Was: Re: [RFC] Submodules in GIT]
Date: Sun, 3 Dec 2006 03:07:26 +0100
Message-ID: <200612030307.26429.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org> <Pine.LNX.4.64.0612021252380.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 02:07:58 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>, sf <sf-gmane@stephan-feder.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612021252380.3476@woody.osdl.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33082>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqgle-0008Ay-7t for gcvg-git@gmane.org; Sun, 03 Dec
 2006 03:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933420AbWLCCHb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 21:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936614AbWLCCHb
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 21:07:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:34231 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S933420AbWLCCHa (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 21:07:30 -0500
Received: (qmail invoked by alias); 03 Dec 2006 02:07:28 -0000
Received: from p5496BAA4.dip0.t-ipconnect.de (EHLO noname) [84.150.186.164]
 by mail.gmx.net (mp040) with SMTP; 03 Dec 2006 03:07:28 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 22:22, Linus Torvalds wrote:
> So operations like "git-rev-list --objects" (or, these days, more commonly 
> anything that just does the equivalent of that internally using the 
> library interfaces - ie "git pack-objects" and friends) VERY FUNDAMENTALLY 
> have to hold on to the object flags for the whole lifetime of the whole 
> operation.
>
> [...]
> 
> So this really isn't a memory management issue. You could somewhat work 
> around it by adding a "caching layer" on top of git, and allow that 
> caching layer to modify their cache of old objects (so that they can 
> contain back-pointers), but for 99% of all users that would actually make 
> performance MUCH WORSE, and it would also be a serious problem for 
> coherency issues (one of the things that immutable objects cause is that 
> there are basically never any race conditions, while a "caching layer" 
> like this would have some serious issues about serialization).

Thinking about this...
You have to make very sure to always update the caching layer containing
the backlinks on every addition of a further object. You can do this
because you always reached this new object by some other object, which
exactly is the backpointer.

Now let us suppose we are able to do this.
What does this give us?

Take a look at object traversal:
We have to store the flag "already visited" for objects we could reach
again in the traversal. But with the backlinks, we can see that most
of the objects can only be reached via one path, and therefore, there
is no need to store the flag, as it never will be queried in the
further traversal.
(Similar for objects with two paths: When you have visited the object
two times, you can throw away the flag, as it is not queried any more).

Regarding the caching layer and object traversal, it would have been
enough to only store "is this object reachable via more than 1 path?".
For this, the "cache" could be the set of objects reachable with
more than one path.
And such a set stored in a file should be quite managable, and be
quite small, relative to the size of the object database.

In fact, this "cache" can be created with a usual object traversal
(which has the original memory requirement), but as long as we do
not add objects to the database, further traversals would only need
a fraction of memory.

When only adding a small number of objects, it should be easy to
update the cache; while with big actions like fetching/pulling,
we simply should remove the file with the backlink information.

> problem. In fact, O(n) is pretty damn good, especially since the constant 
> is pretty small (basically 28 bytes per object - and 20 of those bytes 
> are the SHA1 that you simply cannot avoid).

Again only some thoughts...
Pack files are fully self-contained object stores, yes?
So in the scope of a single pack file, the offset of this object is enough
as object identification.
If we could make sure that in any given algorithm touching objects, like
commit traversal, we always have the offset available when we need to do
an object lookup, then, it should be enough to store object flags only
indexed by the offset of this object in the pack.
The translation SHA1 -> offset can be done with the pack index.
As you usually have multiple packs, a (pack number / offset) tuple should
be enough as object ID.

Thinking even one step further:
Would it make sense to define an encoding format for the content of
commit and tree objects inside of packs, where the SHA1 is replaced by the
offset of the object in this pack?
As exactly the SHA1 is the least compressable thing, this could promise
quite a benefit.
AFAIK, we currently only use these offsets for referencing objects in
delta chains.

More about the original topic of this thread (and off-topic to the
new subject):

> But it does mean that supermodules really should NOT be so seamless that 
> doing a "git clone" on a supermodule does one _large_ clone. Because it's 
> simply going to be better to:
> 
>  - when you clone the supermodule, track the commits you need on all 
>    submodules (this _may_ be a reason in itself for the "link" object, 
>    just so that you can traverse the supermodule object dependencies and 
>    know what subobject you are looking at even _without_ having to look at 
>    the path you got there from)
> 
>  - clone submodules one-by-one, using the list of objects you gathered.

Without submodule identities, we would have to clone path-by-path, as
we can not distinguish different submodules apart from there location.

