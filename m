From: linux@horizon.com
Subject: Re: A look at some alternative PACK file encodings
Date: 7 Sep 2006 09:34:56 -0400
Message-ID: <20060907133456.24226.qmail@science.horizon.com>
References: <9e4733910609070557jd8cfc57nd4f7a8973b69f6ed@mail.gmail.com>
Cc: git@vger.kernel.org, gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 07 15:36:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLK22-000697-1N
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 15:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWIGNe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 09:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWIGNe6
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 09:34:58 -0400
Received: from science.horizon.com ([192.35.100.1]:15437 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932111AbWIGNe5
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 09:34:57 -0400
Received: (qmail 24227 invoked by uid 1000); 7 Sep 2006 09:34:56 -0400
To: jonsmirl@gmail.com, linux@horizon.com
In-Reply-To: <9e4733910609070557jd8cfc57nd4f7a8973b69f6ed@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26638>

>> An alternative would be to create a small "placeholder" object that
>> just gives an ID, then refer to it by offset.
>>
>> That would avoid the need for an id/offset bit with every offset,
>> and possibly save more space if the same object was referenced
>> multiple times.
>>
>> And it just seems simpler.

> There are 2 million objects in the Mozilla pack. This table would take:
> 2M *  (20b (sha)  + 10b(object index/overhead) = 60MB
> This 60MB is pretty much incompressible and increases download time.
> 
> Much better if storage of the sha1s can be totally eliminated and
> replaced by something smaller. Alternatively this map could be
> stripped for transmission and rebuilt locally.

Um, I think I wasn't clear.  Objects in a "thin" pack (for network
updating of a different pack) that are referred to but not included
would have stand-ins containing just the object ID.  Objects that *are*
present would simply be present and referred to by offset as usual.

Imagine you have a "thin" pack containing a delta to an object that the
recipient has, so isn't in the pack.  The delta has to specify the
base object somehow.  If the base object is in the pack, you can
specify it by offset.  If it's not, you can either:

- Generalize the base object pointer to allow an object ID option, or
- Provide a pointer to a magic kind of "external reference" pointer
  object.

I was proposing the latter.

For regular packs, such objects wouldn't even be present, because
all base objects are in the pack itself.

And, of course, you'd only create such objects if you needed to,
if there was at least one pointer to them.

Compared to putting the object ID directly in the pointer, it has
Cost:	An extra offset pointer and object header.
	Extra time follwoing the indirection resolving the pointer.
Benefit: Non-indirect object pointers are a bit smaller.
	The code is simpler.
	Second and later references to the same external object are
	another offset, not another 20 bytes.
