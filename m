From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Understanding version 4 packs
Date: Sun, 25 Mar 2007 10:35:30 +0200
Message-ID: <20070325083530.GA25523@bohr.gbar.dtu.dk>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk> <alpine.LFD.0.83.0703241913110.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Mar 25 10:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVOCN-0004ir-Cn
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 10:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933256AbXCYIfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 04:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933262AbXCYIfc
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 04:35:32 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:34389 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933256AbXCYIfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 04:35:31 -0400
Received: (qmail 3130 invoked by uid 5842); 25 Mar 2007 10:35:30 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.83.0703241913110.18328@xanadu.home>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43040>

On Sat, Mar 24, 2007 at 07:24:17PM -0400, Nicolas Pitre wrote:
> On Sat, 24 Mar 2007, Peter Eriksen wrote:
> 
> > There is a new tree type called OBJ_DICT_TREE, which looks something
> > like the following:
> > 
> > +-----------------+------------------------------------------------+----
> > |  Table offset   |  SHA-1 of the blob corresponding to the path.  | ...
> > +-----------------+------------------------------------------------+----
> >       6 bytes                     20 bytes
> 
> Actually it is a 2-byte index in the path table, and a 4-byte index in a 
> common SHA1 table.  So each tree entry is 6 bytes total.

What happens to the paths, that do not have a correponding entry in the
path name table, because they are not among the 65535 most frequent
paths in the pack?

> > The index (.idx) files are extended to have a 4 byte pointer to the
> > offset of this file name table in the pack file for easy lookup.
> 
> Right.  And it will lose the SHA1 entries since they are already 
> available in the pack.

Does this mean, that the current index format will change from:

  - The header is followed by sorted 24-byte entries, one entry
    per object in the pack.  Each entry is:

    4-byte network byte order integer, recording where the
    object is stored in the packfile as the offset from the
    beginning.

to just 4-byte entries, and are the SHA-1 entries in that extra table
of SHA-1's referenced by OBJ_DICT_TREE objects in the pack file?

Regards,

Peter

P.S. I have updated my description of the pack format. Any comments are
welcome.

On disk format of version 4 packs (v0.1)
=================================

There is a file name table, EXT_OBJ_FILENAME_TABLE, which is placed
anywhere in the pack file, but before any OBJ_DICT_TREE objects, which
are referencing the table, so that the pack can be easily streamed. It
is using the format:

+-------------------------------+
|  Compressed file name table   |
+-------------------------------+

The uncompressed file name table contains NR_ENTRIES entries,
and looks like this:

+------------+------+--------------+------+--------------------+----
| NR_ENTRIES | MODE |  Full path 1 | MODE | Full path 2        | ...
+------------+------+--------------+------+--------------------+----
   4 bytes    2 bytes   n1 bytes    2 bytes     n2 bytes     

MODE is a network-byte-order integer representing the mode of the path,
and the path is a variable length, null-terminated string.

The table is sorted by path then mode for easy binary lookup, and so
that pointers into this table can be compared directly instead of
comparing the corresponding paths and modes. This table contains the
65535 most used paths in the entire pack.

There is a new tree type called OBJ_DICT_TREE, which looks like the
following:

+--------+----------------+----
| P offs |   SHA-1 offs   | ...
+--------+----------------+----
  2 bytes      4 bytes

That is, each entry contains a 2-byte index into the path table, and a
corresponding 4-byte index into a SHA-1 table.

These new tree objects will remain uncompressed in the pack file, but
sorted with, and deltaed against other tree objects. All normal tree
objects are converted to OBJ_DICT_TREE when packing, and are converted
back on the fly to callers who need an ordinary OBJ_TREE.

The index (.idx) files are extended to have a 4 byte pointer to the
offset of this file name table in the pack file for easy lookup.

There is something similar with a table, EXT_OBJ_IDENT_TABLE of common
strings in commit objects (e.g. author and timezone), and a new object
OBJ_DICT_COMMIT, but I have not understood that quite yet.
