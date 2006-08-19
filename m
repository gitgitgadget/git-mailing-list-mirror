From: linux@horizon.com
Subject: Re: [RFC] adding support for md5
Date: 18 Aug 2006 23:19:31 -0400
Message-ID: <20060819031931.486.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 05:19:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEHN7-0005Td-9Y
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 05:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWHSDTd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 23:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHSDTd
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 23:19:33 -0400
Received: from science.horizon.com ([192.35.100.1]:11576 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751377AbWHSDTd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 23:19:33 -0400
Received: (qmail 487 invoked by uid 1000); 18 Aug 2006 23:19:31 -0400
To: rientjes@google.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25706>

This is a Very Dumb Idea.

I normally try to be polite, but this concept is particularly
deserving of scorn.

The idea that more choice is a good thing is sometimes seductive, but when
it comes to standards, that's not a good idea.  It's like the famous joke
told about the dumb inhabitants of your favorite ethnic region: they're
going to try driving on the other side of the road.  Starting next month,
all the cars will drive on the other side.  If that goes well, the month
after they'll add trucks and buses.

If some disaster arose that required Git to change hash functions,
it would be possible to build a conversion utility, although all the
signatures in tag objects would break; you'd have to regenerate them, too.

But this is an all-or-nothing change.  Trying to support *multiple*
simultaneous hash functions is a mess.

Git depends very fundamentally on identical objects having identical
hashes.  The in-memory merge depends on it.  The network protocol
depends on it.  Various kludges can be imagined to handle blob objects
with multiple names, but tree objects quickly become unworkable.


Let's break down the solutions.  There are basically four classes,
depending on 
1) whether objects are stored in the database indexed by both hashes,
   or just one, and
2) Whether pointers to objects include both hashes, or just one.

If you include both hashes everywhere, then you've just built
a larger hash function that's the concatenation of SHA-1 and MD5,
and while it works sanely, it just makes the object IDs even
bigger, and there are obviously no speed benefts.  But this is
the most reasonable alternative.

If pointers include both hashes, but objects are indexed by only one,
then to find an object by pointer requires two lookups, and you still
need to hash every blob twice when committing get the values to
put in the tree objects.  So obviosuly no faster than the first option.

Okay, so pointers are only one hash.  If they were always the same hash,
the second hash would be utterly pointless, so we're assuming the
database contains a mix.

If objects are indexed by both hashes, then you can hash new blobs once
to check to see if they're already in the database, but if they're not,
you have to hash again with the another algorithm.

On the other hand, if you index by only one, then every object being
checked to see if it's already in the database needs to be hashed twice
so it can be looked up twice.  What were the claimed speed gains?

But more to the point, any system which stores one arbitrary hash as
a pointer makes the the tree object created to describe a directory no
longer unique, which results in its hash being fundamentally non-unique,
which cascades all the way up to the commit object.

So you can get silly things like the need for a merge commit to
record the merge of trees that are actually identical.


Just a big mess.
