From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 08:53:39 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr>    =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07071?=
	=?ISO-8859-1?Q?81004330.=04=0427353?= =?ISO-8859-1?Q?@woody.linux-fou?=
	=?ISO-8859-1?Q?ndation.org>?=
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <851wf2bcqy.fsf@lola.goethe.zz>    =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07072=04?=
	=?ISO-8859-1?Q?02135450.27249@w?= =?ISO-8859-1?Q?oody.linux-found?=
	=?ISO-8859-1?Q?ation.org>?=
 <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
 <85odi69vgt.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICHHl-00061j-Dd
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 17:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758684AbXGUPyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 11:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759438AbXGUPyV
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 11:54:21 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41723 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758300AbXGUPyU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 11:54:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6LFrj4J018825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 08:53:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6LFrd4r024153;
	Sat, 21 Jul 2007 08:53:40 -0700
In-Reply-To: <85odi69vgt.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.212 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53170>



On Sat, 21 Jul 2007, David Kastrup wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Of course, it seldom matters, but basically, you should test a directory 
> > structure that has the files
> >
> > 	dir.c
> > 	dir/test
> >
> > in it, and the "dir" directory should always sort _after_ "dir.c".
> >
> > And yes, having the index entry with a '/' at the end would handle
> > that automatically.
> 
> You completely lost me here.  I guess I'll be able to pick this up
> only after investing considerable more time into the data structures.

So the basic issue is that not only does git obviously think that only 
content matters, but it describes it with a single SHA1. 

That's not an issue at all for a single file, but if you want to describe 
*multiple* files with a single SHA1 (which git obviously very much wants 
to do), the way you generate the SHA1 matters a lot.

In particular, the order.

So git is very very strict about the ordering of tree structures. A tree 
structure is not just a random list of

	<ASCII mode> + <space> + <filename> + <NUL> + <SHA1>

it's very much an _ordered_ list of those things, because we want the SHA1 
of the tree to be well-specified by the contents, and that means that the 
contents of a tree object has have absolutely _zero_ ambiguity.

This means, for example, that git is very fundamentally case sensitive. 
There's no sane way *not* to be, because if you're case insensitive in any 
way at all, you'll end up having two trees that are "the same", but end up 
having different SHA1's.

It also means that git objects have absolutely zero "localization". There 
is no locale at all, and there very fundamnetally *must*not* be. Again, 
for the same reason: if you can describe the same filename with two 
different encodings, you'd have two different SHA1's for the same content.

So git filenames are very much a "stream of bytes", not anything else. And 
they need to sort 100% reliably, always the same way, and never with any 
localized meaning.

And, partly because it seemed most natural, and partly for historical 
reasons, the way git sorts filenames is by sorting by *pathname*. So if 
you have three files named

	a.c
	a/c
	abc

then they sort in that exact order, and no other! They sort as a "memcmp" 
in the full pathname, and that's really nice when you see whole 
collections of files, and you know the list is globally sorted.

So that "global pathname sorting" has nice properties, and it seems 
"obvious", but it means that because git actually *encodes* those three 
files hierarchically as two different trees (because there's a 
subdirectory there), the tree objects themselves sort a bit oddly. The 
tree obejcts themselves will look like

 top-level tree:
	100644 a.c -> blob1
	040000 a   -> tree2
	100644 abc -> blob3

 sub-tree:
	100644 c    -> blob2

and notice how the *tree* is not sorted alphabetically at all. It has a 
subtly different sort, where the entry "a" sorts *after* the entry "a.c", 
because we know that it's a tree entry, and thus will (in the *global* 
order) sort as if it had a "/" at the end!

Traditionally, when we have the index, the index sorting has been very 
simple: you just sort the names as memcmp() would sort them. But note how 
that changes, if "a" is an empty directory. Now the index needs to sort as

	file a.c
	dir  a
	file abc

because when we create the tree entry, it needs to be sorted the same way 
all tree entries are always sorted - as if "a" had a slash at the end!

[ Yeah, yeah, we could make a special case and just say "the empty tree 
  sorts differently", but that actually results in huge problems when 
  doing a "diff" between two trees: our diff machinery very much depends 
  on the fact that the index and the trees always sort the same way, and 
  if we sorted the "a" entry (when it is an empty directory) differently 
  from the "a" entry (when it has entries in it), that would just be 
  insane and cause no end of trouble for comparing two trees - one with an 
  empty directory and one with content added to that directory.

  So the sorting is doubly important: it's what makes "one content" always 
  have the same SHA1, but it is also much easier and efficient to compare 
  directories when we know they are sorted the same way. ]

In other words, introducing tree entries in the index ended up also 
introducing all the issues that we already had with the tree objects since 
they got split up hierarchically, but that the code didn't use to have to 
care about.

The easiest way to solve this really does seem to be to add the rule that 
the index entry for an empty directory has to have the "/" at the end of 
the name - then the "sort mindlessly by name" will just continue to work.

But that was what I said was broken: my patches I sent out didn't actually 
do that.

It's *probably* just a few lines of code, and it actually would result in 
some nice changes ("git ls-files" would show a '/' at the end of an empty 
directory entry, for example), so this is not a big deal, but it's an 
example of how subtly different a directory is from a file when it comes 
to git.

			Linus
