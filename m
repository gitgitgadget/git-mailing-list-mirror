From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Wed, 23 May 2007 16:55:27 -0700
Message-ID: <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com>
References: <46528A48.9050903@gmail.com>
	 <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 01:55:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr0g3-0004xt-6h
	for gcvg-git@gmane.org; Thu, 24 May 2007 01:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756892AbXEWXzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 19:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756722AbXEWXza
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 19:55:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:32522 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892AbXEWXz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 19:55:29 -0400
Received: by ug-out-1314.google.com with SMTP id j3so725487ugf
        for <git@vger.kernel.org>; Wed, 23 May 2007 16:55:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f/Lvhh/zgzkjwYS++jRFB4D2z5djw2wOcoDU4bMpw6ySclgNKwnemcHNz4eSr1tPz0I1cZR2sRpn013Sv4qB0tj63McXeLQudxgLtBTWYrOrLdrrR2DQYDRv1KeiylRTHZyayIoXVkfLSnxrNcg61Z2g6qWf22j9VXdar+ZPA/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fgMbpBogJjeU9oXn/BeUl1UAYjhtJhrDa/3vDkaVbPi+FL09afkGzfSLmWfB6m8XVui43XBQ9DNVEMX5SI9zDQaTXyrS047URB8ZhM3SJwLEsCtIgCcwPL7q38OU2iMu2X8aj4E8s8MUmvfvtlGiftHYpVZBUgyN8dlUL4ysBR4=
Received: by 10.78.81.20 with SMTP id e20mr328431hub.1179964527574;
        Wed, 23 May 2007 16:55:27 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Wed, 23 May 2007 16:55:27 -0700 (PDT)
In-Reply-To: <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48211>

On 5/23/07, Junio C Hamano <junkio@cox.net> wrote:
> Dana How <danahow@gmail.com> writes:
> > This patch implements the following:
> > 1. git pack-objects takes a new --max-blob-size=N flag,
> >    with the effect that only blobs less than N KB are written
> >    to the packfiles(s).  If a blob was in a pack but violates
> >    this limit (perhaps the packs were created by fast-import
> >    or max-blob-size was reduced),  then a new loose object
> >    is written out if needed so the data is not lost.
>
> Why?
>
> I really do not like that "write a new loose object" part
> without proper justification.  From your description, I thought
> the most natural way to do this is to pretend you did not hear
> about large objects at all, by rejecting them early, perhaps
> inside add_object_entry() or inside get_object_details() --
> either case you would do sha1_object_info() early instead of
> doing it in check_object().
>
> By the way, is there fundamental reason that this needs to be
> "blob size" limit?  Wouldn't "max-object-size" be more clean in
> theory, and work the same way in practice?

I agree with your sentiments.  Some nasty details pushed
me to implement it this way.  Let me explain them and perhaps
you can come up with a different combination of solutions.

Each object to be packed can be in one of 4 states:
{loose or packed} X {small or too big}.
Regardless of the {loose or packed} selection,
a "small" object can always be placed in the pack.
A loose object which is too big does not require
any special action either -- if we drop it from the pack,
we don't lose anything since it already exists in objects/xx .

The packed X too big combination is the problem.  As the
commit message says,  this could happen if the packs
came from fast-import,  or if the max-blob-size were reduced.
We have three options in this case:
(1) Drop the object (do not put it in the new pack(s)).
(2) Pass the object into the new pack(s).
(3) Write out the object as a new loose object.

Option (1) is unacceptable.  When you call git-repack -a,
it blindly deletes all the non-kept packs at the end.  So
the megablobs would be lost.

Let's suppose we always used Option (2),  and Option (3)
were never available. Then once a large object got into
a pack,  the only way to get it out would be to explode
the pack using git-unpack-objects -- but hey,  that doesn't
work because they all already exist in this repository packed.
So we make a temporary repository to explode the pack,
then copy over the loose objects,  then delete the pack,
then repack with the correct/updated max-blob-size specification.
I would claim this is even more ugly,  and more importantly,
more error-prone than supporting Option (3) in at least some cases.

The way large objects get into a pack is that you realize after
the fact that you need a max-blob-size,  or that you need to
decrease it since your pack files have become unwieldy.

I think I've shown we need Option (3) in at least some cases.
To better address _which_ cases,  let's move on to your
second point:: why did I implement --max-blob-size instead
of --max-object-size?  I take this to mean that I should use
the blob size if undeltified, and the delta size if previously deltified?
That's actually what I do internally,  but the total effect
over many repackings is what one would expect from --max-blob-size.

In normal use on a personal repository starting from scratch,
all blobs are first packed from loose objects.  When I am
deciding if I want to include the loose object or not,  I want
to use the object's direct size,  not its deltified size.  If I use
the latter,  then I have to deltify all the megablobs to see
if their deltas are small enough.  This takes a long time
and is one of the things this patch aims to eliminate.
So I take the list of loose objects,  throw out the megablobs,
try to deltify the rest,  and write out the pack.

When I repack,  any deltas are smaller than the original
objects,  so in any sequence of packings from loose
objects and repackings of packs,  in which all packs
were created with a max-blob-size limit which stayed the
same or increased over time,  there is no difference
between max-blob-size or max-object-size: checking loose
object size or in-pack size gives the same pack contents.

Now let's say you decrease max-blob-size and repack,
or repack from some packs that had no max-blob-size
(e.g. from fast-import).  Now there is some difficulty in
a clean definition when you follow Option (3).  You might
have a base object B in an old pack,  and a deltified object
D based on it,  where B is now larger than the newly-decreased
max-blob-size while D's deltified size is still smaller.
So you write out B,  but D can no longer be stored deltified
and may become bigger as well.

But in this case you should do the following:
Since you are going to decrease max-blob-size when you decide
your repository packs have become "gunked up" with megablobs,
I would propose git-repack -a -f (git-pack-objects --no-object-reuse)
be used.  This means all deltas are recomputed
from the new,  smaller universe of blobs,  which makes sense,
and since no deltas are reused,  all blob-size limits can only
be based on the actual blob size by the arguments 3 paragraphs back.
(Note: I made sure the current patch loses no data if you decrease
 max-blob-size and forget to specify -f -- you just get a few large
 packed objects resulting from "lost" deltifications.)

In actuality,  the object_entry.size field is checked,  so objects
_are_ being filtered by delta size if deltified.  But I went through
the (suggested) usage scenarios above to show that the *result* is that
you get a pack limited in raw object size.  --max-object-size
is what I implemented because it's easier,  but in use it acts
like --max-blob-size so I named it that.

Now,  concerning Option (2) vs Option (3):  I need to write
out loose objects in *some* cases.  Right now I always write
out a large object as a loose one.  It would be reasonable to
change this so that it only happens with --no-object-reuse
(i.e. git-repack -f).  This is what you should specify when you're
decreasing max-blob-size.  Shall I change it so that large objects
are passed to the result pack without --no-object-reuse,
and written out as loose objects with --no-object-reuse?
I did not do this because it's a strange interaction --
just look how long it took me to build up to explaining it!

> > 2. git repack inspects repack.maxblobsize .  If set,  its
> >    value is passed to git pack-objects on the command line.
> >    The user should change repack.maxblobsize ,  NOT specify
> >    --max-blob-size=N .
> Why not?
Well,  indeed.  That's why [PATCH *v2*] lets you specify
--max-blob-size to git-repack,  and gives an example of
why you might want to do that [I don't].

> > This patch is on top of the earlier max-pack-size patch,
> > because I thought I needed some behavior it supplied,
> > but could be rebased on master if desired.
>
> Your earlier "split according to max-pack-size" will hopefully be
> on master shortly.
Thanks!

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
