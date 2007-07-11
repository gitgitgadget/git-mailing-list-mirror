From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What happened with git-note?
Date: Wed, 11 Jul 2007 02:17:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707110153280.4047@racer.site>
References: <20070710231735.GZ1813@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: Alberto Bertogli <albertito@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 03:25:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Qwn-0000Yr-4n
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 03:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXGKBYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 21:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbXGKBYt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 21:24:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:42942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751020AbXGKBYs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 21:24:48 -0400
Received: (qmail invoked by alias); 11 Jul 2007 01:24:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 11 Jul 2007 03:24:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19v1eEpCtRv/WvU8Daj0b4jIrfliym1R7wlTaDVK6
	g/frs0Qpefzrp7
X-X-Sender: gene099@racer.site
In-Reply-To: <20070710231735.GZ1813@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52122>

Hi,

[Johan, I Cc'ed you, since you were the person pushing for git-notes 
originally. Junio, I Cc'ed you, because you correctly pointed out the 
flaws in my approach.]

On Tue, 10 Jul 2007, Alberto Bertogli wrote:

> There was a very long thread about a proposed feature, git-note 
> (http://thread.gmane.org/gmane.comp.version-control.git/46770/focus=48540), 
> around May this year.
> 
> I was wondering what happened to it, because some issues were brought up
> but then everything seem to have stalled.
> 
> Is someone working on it? Is there a clear list of the pending issues
> somewhere?

Okay, I seem to be at fault for the stalling.  So I better speak up about 
what my proof-of-concept did:

It creates a new ref, "refs/notes/commits", which had a tree object in it. 
The tree entries were actually fan-out directories a la .git/objects/??/. 
So if you added a not to commit abcdef01234..., it created a "file" named 
refs/notes/commits:ab/cdef01234...

The advantages of this approach, as compared to an external list, or even 
SQLite database were, amongst others:

- you can use most of the existing framework (storage, pruning, etc.),

- there is an obvious way how to fetch the notes from someone else,

- there is an obvious way how to deal with conflicts when merging notes
  from someone else,

- it is conceptually trivial.

However, the biggest disadvantage was pointed out by Junio:

The tree objects under refs/notes/commits:??/ can get pretty large, in 
theory.  Suppose you have a rate of a couple of hundred commits a day, and 
you want to use the notes framework, amongst others, to be able to add 
Acked-by's all over the place.  Pretty soon we are in the hundreds of 
entries in the tree objects.

I thought that this is not a problem, since the names all have the same 
length.  Alas, Git is general purpose, so it does not, and cannot, assume 
a certain filename format.  Git might be considered a stupid content 
tracker, but it is not quite that stupid.

Since the tree objects just contain lists of tree entries, and each tree 
entry is variable length, you have to look through half of the entries on 
average, before you find the one you look for.

Possible solutions I can come up with:

There was a lot of talk, and quite a few good ideas, in the packv4 side 
branch, which was undertaken by Nico and Shawn.  The basic idea, IIUC, is 
to store objects differently, by having nice things like a filename table 
containing the most common names, sorted, which are then not only 
addressed much more efficiently (by a 16-bit index), but reverse indexing 
is also much more efficient, since you do not have to expand and compare 
the full filenames, but instead compare 16-bin numbers.

This format would help with the approach I presented above.

Another idea which just crossed my mind, is to add indexes which are 
generated locally, but not transmitted when fetching, much like the pack 
indices, which are generated from the pack while fetching it.

There are a couple of possible technical ways to do that efficiently, such 
as mmap()ed rbtrees, or hashtables.  Of course, Git's own history suggests 
to prefer hashtables over other data structures, when your keys are 
already pretty good hashes, which they are.  However, I have not thought 
it through, what with the issue of growing the data structure, or 
thrashing the I/O caches.

Of course, one does not have to go with the approach of storing the things 
as blobs.  There might well be a genius coming along, reading this mail, 
and proposing the uber-solution.  But dammit, I am pretty sure that we 
have a real good framework, and that a proper solution is just a stone's 
throw away.

Ciao,
Dscho
