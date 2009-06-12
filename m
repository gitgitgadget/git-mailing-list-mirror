From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Mercurial on BigTable
Date: Thu, 11 Jun 2009 21:14:28 -0700
Message-ID: <20090612041428.GP16497@spearce.org>
References: <d411cc4a0906101215t313b2037k713aa1ce974c30cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 06:14:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEyA0-0003wG-NO
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 06:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbZFLEO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 00:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbZFLEO1
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 00:14:27 -0400
Received: from george.spearce.org ([209.20.77.23]:39722 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbZFLEO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 00:14:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D8F2B381FD; Fri, 12 Jun 2009 04:14:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <d411cc4a0906101215t313b2037k713aa1ce974c30cc@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121388>

Scott Chacon <schacon@gmail.com> wrote:
> Has anyone watched this yet?
> 
> http://code.google.com/events/io/sessions/MercurialBigTable.html

I hadn't seen that yet, thanks.
 
> It's kind of interesting - a Googler talks about getting Mercurial
> running on BigTable.  What fascinates me is that if I'm not horribly
> mistaken, it seems like they just threw out the revlog format entirely
> and just store the data in a key-value store as sort of a Git-like
> content addressable filesystem.

Almost... but not quite.  If you look at the way they store files
they embed the file path as part of the BigTable key.  This makes it
cheap to return all revisions between X and Y for any given file, as
its just a range scan over the keys.  Git doesn't do this normally.

In Hg, and in their implementation of it on BigTable, if a file
content is copied between two paths (same blob in git terms) they
actually duplicate the data, once under each path.  We could do
something like that in Git... and just pay the price on copy, and
then you can get a storage layout like they do, and have it scale
well onto a larger system.  But... pack size will suffer in what
the client receives, it will be bigger.

> Does anyone know how they do the graph walking efficiently with this
> structure?  He mentioned it was about half as fast as native Hg, but
> that seemed to be acceptable.  Curious if anyone had any thoughts or
> information on this.  Shawn, are there technical reasons why this
> works well the way they're doing it for Hg but would not for Git (like
> in the repo MINA based server)?  It looks like the data structure and
> protocol exchange are incredibly similar after they threw away all the
> revlog stuff.

I think they also added more pointers and data caches that don't
exist in Hg normally, but exist in their BigTable backend.  Like
precomputing pointers from a commit to the most recent ancestor
that is a merge, i think that was mentioned in the talk.

The JGit/MINA based servers run git "well enough", but that's off
local disk, and we do pay a good price compared to C Git.  E.g.
we really need a revcache to accelerate the object enumeration phase,
that takes ages in JGit.  And indexing a pushed pack is rather slow
compared to C Git, a large push could take up to a minute or two
to fully index and fsck.

> Or is it just that they're fine with the speed loss and
> the Android project would not be?

What does Android have to do with Hg?  Android went with Git for
a lot of reasons, none of them having to do with the performance
or availability of Hg on code.google.com.  All of them had to do
with Git being a really solid DVCS that has a very bright future.

-- 
Shawn.
