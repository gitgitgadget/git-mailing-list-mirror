From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git files data formats documentation
Date: Fri, 04 Aug 2006 23:51:45 -0700
Message-ID: <7vac6jfzem.fsf@assigned-by-dhcp.cox.net>
References: <44D42F0D.3040707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 08:51:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9G0k-0007CN-N3
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 08:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161587AbWHEGvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 02:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161588AbWHEGvr
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 02:51:47 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42480 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161587AbWHEGvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 02:51:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805065146.KBOQ6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 02:51:46 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <44D42F0D.3040707@gmail.com> (A. Large Angry's message of "Fri,
	04 Aug 2006 22:39:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24890>

Good documentation, but some nitpicks are needed before it hits
Documentation/technical/ part of the source tree.

> <TREE_ENTRIES>
> 	# Tree entries are sorted by the byte sequence that comprises
> 	# the entry name.
> 	:	( <TREE_ENTRY> )*
> 	;

Not quite.  An entry for a subtree is sorted as if a '/' is
suffixed to its name.

        $ git ls-tree $T
        100644 blob 2398e9f8892812607f5eee6ed0d5712c2e3de197	a-
        100644 blob 7f07527a80bd8c2b1c5087d7ccfe61073b068374	a-b
        040000 tree 23fddf6a57ff3ba98aa93fb71431276c3f1a3c40	a
        100644 blob 2afe6dcc5466068b8dcc7263cece05d2adf044fe	a=
        100644 blob efc73add7dd868242a66faf2a59b145f2a60b834	a=b

This is, by the way, consistent with the order of cache entries
in the index file.

        $ git ls-files -s
        100644 2398e9f8892812607f5eee6ed0d5712c2e3de197 0	a-
        100644 7f07527a80bd8c2b1c5087d7ccfe61073b068374 0	a-b
        100644 0ee729686ab2a0074639c5f64930648571e7c4b2 0	a/b
        100644 2afe6dcc5466068b8dcc7263cece05d2adf044fe 0	a=
        100644 efc73add7dd868242a66faf2a59b145f2a60b834 0	a=b

> <TREE_ENTRY>
> 	# The type of the object referenced MUST be appropriate for
> 	# the mode. Regular files and symbolic links reference a BLOB
> 	# and directories reference a TREE.
> 	:	<OCTAL_MODE> <SP> <NAME> <NUL> <BINARY_OBJ_ID>
> 	;

As you correctly explain later, OCTAL_MODE must be minimal; "git
ls-tree" output says 040000 in the above example, but the actual
object records it as 40000.

> <TAG_CONTENTS>
> 	:	"object" <SP> <HEX_OBJ_ID> <LF>
> 		"type" <SP> <NONTAG_OBJ_TYPE> <LF>
> 		"tag" <SP> <TAG_NAME> <LF>
> 		<LF>
> 		<DATA>
> 	;

A tag can tag another tag (think of chain of trust), so what
follows "type" does not have to be NONTAG_OBJ_TYPE.

> <OCTAL_MODE>
> 	# Octal encoding, without prefix, of the file system object
> 	# type and permission bits. The bit layout is according to the
> 	# POSIX standard, with only regular files, directories, and
> 	# symbolic links permitted. The actual permission bits are
> 	# all zero except for regular files. The only permission bit
> 	# of any consequence to Git is the owner executable bit. By
> 	# default, the permission bits for files will be either 0644
> 	# or 0755, depending on the owner executable bit.
> 	;

It's not really "by default" -- more like "by definition", since
there is no way for the program to use something different.  We
used to record non-canonical modes in ancient versions of git,
but I think fsck-objects would warn on objects created that way.

> <NONTAG_OBJ_TYPE>
> 	:	"BLOB"
> 	|	"TREE"
> 	|	"COMMIT"
> 	;

Drop this definition, and make the literals part of <OBJ_TYPE>,
after lowercasing them ;-).

> <OBJ_TYPE>
> 	:	<NONTAG_OBJ_TYPE>
> 	|	"TAG"
> 	;

> PACK FILE
> ---------
> # The name of a pack file is "pack-${PACK_ID}.pack", where ${PACK_ID}
> # is the hexidecimal encoding (lower case) of the SHA-1 digest of the
> # sorted list of binary object IDs in the pack file without a separator
> # between the object IDs. Initially, the ${PACK_ID} for a pack was not
> # defined, making the value effectively random.

Although the really core level does not care, a PACK_ID is
required to be unique (within a object store and its alternates)
40-byte hexadecimal for http commit walker to work properly.

BTW, I still have a patch to tighten the check to enforce this
as part of the consistency check.

> <PACKED_OBJECT_DATA>
> 	:	_deflate_( <DATA> )
> 	|	<BINARY_OBJ_ID> _deflate_( <DELTA_DATA> )
> 	;

It might be cleaner to separate this definition into two.  That
is, one packed object is either non-delta-type base128 type-length
followed by deflated data, or delta-type base128 type-length
followed by base object id followed by deflated delta.

> PACK INDEX
> ----------
> # The name of a pack file index is "pack-${PACK_ID}.idx", where
> # ${PACK_ID} is the hexidecimal encoding (lower case) of the SHA-1
> # digest of the sorted list of binary object IDs in the pack file
> # without a separator between the object IDs. Initially, the ${PACK_ID}
> # for a pack was not defined, making the value effectively random.

I would not repeat ", where ${PACK_ID} is..." part, which was
done in the description of the pack file.  Rather, ", where
${PACK_ID} is same as the .pack file the .idx file corresponds
to", would be more appropriate.

> <INDEX_PARTIAL_COUNT>
> 	# 32 bit, network byte order, binary integer of the count of
> 	# objects in the pack file with the first byte of the object
> 	# ID less than or equal to the index of the count, starting
> 	# from zero.
> 	;

Linus and I call this part "fan-out".

> <ENTRY_NAME>
> 	# File system entity name. Path is normalized and relative to
> 	# the working directory.
> 	;

Did you mention that the index entries are sorted by name?

> <INDEX_EXTENSION_NAME>
> 	# 4 byte sequence identifying how the <INDEX_EXTENSION_DATA>
> 	# should be interpreted. The first byte having a value greater
> 	# than or equal to the ASCII character 'A' (0x41) and less than
> 	# or equal to the ASCII character 'Z' (0x5a).
> 	;

This is not true, but the code needs better comments.  The
intention is that an extended section whose name starts with a
capital letter (such as "cache-tree extension" whose name is
"TREE") is purely optional, and if a software of different
version does not understand it, it can still safely keep using
the rest of the index.  If somebody introduces a new extended
section that _must_ be interpreted in order to fully understand
what the index file records, such an extended section can signal
that by having a name that do not start with a capital.  A
version of the software that does understand such extended
sections would have a case arm that covers such a name in the
switch statement you took this 'A' .. 'Z' from.
