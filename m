From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH/RFC] fast-import: insert new object entries at start of
 hash bucket
Date: Tue, 23 Nov 2010 14:33:52 -0800
Message-ID: <AANLkTikqUjjjMRzWTcEOs+2PGu=-9VVbdn0YgpabFaDu@mail.gmail.com>
References: <20101123075348.GA10367@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Raja R Harinath <harinath@hurrynot.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 23:34:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL1RL-0001E0-Vn
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 23:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab0KWWeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 17:34:13 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:54012 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab0KWWeN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 17:34:13 -0500
Received: by pxi15 with SMTP id 15so2230867pxi.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 14:34:12 -0800 (PST)
Received: by 10.142.126.16 with SMTP id y16mr7497201wfc.345.1290551652617;
 Tue, 23 Nov 2010 14:34:12 -0800 (PST)
Received: by 10.143.165.15 with HTTP; Tue, 23 Nov 2010 14:33:52 -0800 (PST)
In-Reply-To: <20101123075348.GA10367@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162031>

On Mon, Nov 22, 2010 at 11:53 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> More often than not, find_object is called for recently inserted obje=
cts.
> Optimise for this case by inserting new entries at the start of the c=
hain.
> This doesn't affect the cost of new inserts but reduces the cost of f=
ind
> and insert for existing object entries.

This is a good change.  I totally agree with it.

> I would guess other workflows would display the same tendency if any;
> at least, the same blob is likely to come up repeatedly in a few revs
> and then not be mentioned for a while. =A0Though maybe there is some
> reason to make the opposite assumption that I have not thought of.
> Shawn?

The new entry was put onto the end of the hash chain because I wasn't
thinking when I wrote that code.  For some reason I assumed it made
sense to put it onto the end of the chain, because I had already
walked the chain to see if it already exists... and by the time I
reached the end, I had the tail, so I might as well put the new item
on to the tail.

Moving the new item to the head works because it is somewhat likely
that the new item will be asked for in the near future, and older
items are less likely to be asked for.  So I can see how this can
offer a small CPU time improvement for a very big import.

> A more dramatic improvement comes from increasing the size of the has=
h
> table; in particular, David noticed it allows the CPU usage to
> increase from ~60% to 100% of one core. =A0So presumably we should ma=
ke
> the size of the hash table dynamic.

Uhm.  Wait, the table isn't already dynamic?  I cheated that badly and
made the table fixed size?

I can tell you why its fixed size... when I wrote fast-import to
support the Mozilla repository import, we had an estimate on the
number of objects that we needed fast-import to handle in a given run.
 From that estimate we concluded that a table of 2^16 was sufficiently
large enough, as the hash chains would only be some small N long given
the total number of objects we needed to handle for Mozilla.  Doubling
that into 2^17 or larger wasn't useful, and using a smaller table like
2^14 produced too long of a chain.

Once this code was working, we moved on to other features, and never
reconsidered the table size.  This table should be growing if the
initial 2^16 isn't big enough.  Its just that nobody has ever noticed
that I hardcoded the size.  :-)

> Other aspects to investigate: choice of hash function;

Why?  SHA-1 is pretty uniform in its distribution.  The object_table
is taking the first 16 bits and using that to index the object, that's
the first 4 hex digits.  The Linux kernel uniquely identifies an
object with under 10 hex digits, or 40 leading bits.  The table just
needs to double or quadruple its size (and have the hash function
include that many more bits) when an arbitrary bucket's chain length
gets over some reasonable constant number (e.g. 16).  We probably do
need to cap the table size though, especially on 32 bit builds of Git.

> is it worth
> moving accessed entries to the front of hash chains when they already
> exist?

Maybe, maybe not?  It depends on what the front end is doing.

If the front end is feeding hex SHA-1s, and will frequently reuse the
same blobs, yes.  Otherwise, maybe not.  The only time we are looking
for an object in the object_table is when we are about to insert an
object and need to avoid a duplicate (that's the insert_object code
path), or when we have to page in a tree into the branch cache.

If the branch cache is spilling, you probably should be increasing its
size so that it doesn't spill as often.

The code within store_tree() is really inefficient.  It looks up the
old tree to find out how its stored... we could store that struct
object_entry* inside of the struct tree_content.  We also could avoid
calling store_object() if the tree hasn't been modified.  The way I
read this store_tree() code, every subdirectory is recursed into even
if no modifications were made inside of that subdirectory during the
current commit.  We just need to format the tree, and if the SHA-1 is
the same as the old SHA-1, skip back out without calling
store_object().  That should give you a pretty dramatic reduction on
the number of times the object_table is accessed during an import.

--=20
Shawn.
