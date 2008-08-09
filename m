From: Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>
Subject: [RFC] Plumbing-only support for storing object metadata
Date: Sat, 9 Aug 2008 14:07:33 -0700
Message-ID: <20080809210733.GA6637@oh.minilop.net>
Reply-To: Jamey Sharp <jamey@minilop.net>,
	  Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 09 23:39:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRw9Y-00068a-2d
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 23:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbYHIViI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 17:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbYHIViH
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 17:38:07 -0400
Received: from svcs.cs.pdx.edu ([131.252.214.11]:49589 "EHLO svcs.cs.pdx.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbYHIViF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 17:38:05 -0400
X-Greylist: delayed 1831 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Aug 2008 17:38:05 EDT
Received: from jamey by svcs.cs.pdx.edu with local (Exim 4.63)
	(envelope-from <jamey@svcs.cs.pdx.edu>)
	id 1KRvev-0005XW-O6; Sat, 09 Aug 2008 14:07:34 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91783>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached test illustrates a proposal for minimal plumbing support
usable to store permissions, ownership, and other metadata in git
repositories. This proposal is fully compatible with existing
repositories when the new functionality is not in use. Similar to the
introduction of subprojects, we have not yet specified the porcelain. We
believe that the plumbing will provide sufficient functionality for many
uses, and these uses will help determine the appropriate porcelain.

We would have included an implementation along with the test, but we
need help with a detail of git internals. More on that at the end. We'd
also appreciate feedback on the proposal.

We propose representing objects with metadata using a new "inode"
object. An inode object contains the hash of the real object and the
hash of a "props" (properties) object. A props object contains a set of
name-value pairs. Tree objects can reference inode objects in addition
to the current possibilities of blobs, trees, and subproject commits; we
propose using the currently invalid type 110000 (S_IFREG | S_IFIFO) for
inode objects. We primarily see a use case for inodes referencing blobs
and trees, though as defined they support any object type.

By separating property objects from inodes, objects with the same
properties can share the same property object; we expect, for instance,
that repositories reflecting /etc will have many references to the
"root:root 644" and "root:root 755" properties.

Both object types have a unique representation: equivalent inodes and
props objects will have the same hash. The exact format of an inode
looks like:
	<object_type> SP <object_sha1> LF
	props SP <props_sha1> LF
A property object looks like a sorted list of one or more of:
	<key> SP <value> LF
The same key is allowed to appear more than once, in which case the
lines will be sorted by the bytes of the values. Allowing duplicate keys
will make it easier to retrieve a set of similar properties such as
acls.

This format implies certain constraints on property names and values. We
propose limiting both names and values to printable ASCII (\x20-\x7E),
and disallowing spaces in keys. If some use case requires property names
or values with binary data, that property could use a printable encoding
such as base64.

We believe this proposal provides a sensible approach to storing
metadata in Git repositories; however, we're happy with any reasonable
solution that provides equivalent functionality. Some alternatives we
considered:

  - We could allow UTF-8 property names or values, rather than strictly
    ASCII. Our proposal is conservative in this regard, allowing an
    extension to UTF-8 later while remaining compatible with existing
    repositories.

  - We could allow arbitrary property names or values, by changing the
    props format to store lengths rather than using delimiters. This
    would not be a compatible change, so it needs to be decided early.

  - Tree objects already store mode bits, but we believe that it would
    prove simpler to store complete modes in properties rather than
    adjusting Git internals to preserve arbitrary mode bits in trees.
    Even if new versions of Git preserved the full mode, existing
    versions of Git might silently give incorrect results. Furthermore,
    mode bits other than executability seem of limited value without
    ownership information.

  - inode objects could directly store properties, rather than
    referencing a separate props object. This would eliminate one
    indirection needed to access properties. However, it would also
    reduce sharing of data for objects with the same properties.
    Furthermore, we expect that the indirection will have negligible
    cost when accessing objects from packs, given appropriately sorted
    packs. Shared props objects also suggest caching at various layers.

  - We could have called them "meta" objects instead of "props", but
    then we couldn't make "mad props" jokes.

We began trying to implement this proposal, but we found this enum
definition in cache.h, which made us think there's only room for one
more kind of object:

	enum object_type {
		OBJ_BAD = -1,
		OBJ_NONE = 0,
		OBJ_COMMIT = 1,
		OBJ_TREE = 2,
		OBJ_BLOB = 3,
		OBJ_TAG = 4,
		/* 5 for future expansion */
		OBJ_OFS_DELTA = 6,
		OBJ_REF_DELTA = 7,
		OBJ_ANY,
		OBJ_MAX,
	};

Do these object_type values appear in any on-disk structure, or does any
other reason exist why this set of values cannot change? Can we add
additional object types for inodes and props? If not, what would you
recommend instead?

- Jamey Sharp and Josh Triplett

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="t1008-inodes.sh"

#!/bin/sh
#
# Copyright (c) 2008 Josh Triplett and Jamey Sharp
#

test_description="Test inode plumbing"

. ./test-lib.sh

cat > shadow <<EOF
root:*:13943:0:99999:7:::
EOF
shadow_sha1=`git hash-object -t blob -w shadow`

cat > props <<EOF
group shadow
mode 640
owner root
EOF
props_sha1=FIXME

cat > inode <<EOF
blob $shadow_sha1
props $props_sha1
EOF
inode_sha1=FIXME

cat > tree <<EOF
110644 inode $inode_sha1	shadow
EOF
tree_sha1=FIXME

test_expect_success 'hash a props' '
	test $props_sha1 = "`git hash-object -t props -w props`"
'

test_expect_success 'cat-file a props' '
	git cat-file props $props_sha1 | cmp -s - props
'

test_expect_success 'hash an inode' '
	test $inode_sha1 = "`git hash-object -t inode -w inode`"
'

test_expect_success 'cat-file an inode' '
	git cat-file inode $inode_sha1 | cmp -s - inode
'

test_expect_success 'tree with inode' '
	test $tree_sha1 = "`git mktree < tree`"
'

test_expect_success 'ls-tree of tree with inode' '
	git ls-tree $tree_sha1 | cmp -s - tree
'

test_expect_success 'check type with cat-file' '
	test inode = "`git cat-file -t $tree_sha1:shadow`"
'

test_expect_success 'cat-file inode tree:inode' '
	git cat-file inode $tree_sha1:shadow | cmp -s - inode
'

test_expect_success 'cat-file blob tree:inode' '
	git cat-file blob $tree_sha1:shadow | cmp -s - shadow
'

test_expect_success 'cat-file props tree:inode' '
	git cat-file props $tree_sha1:shadow | cmp -s - props
'

test_expect_success 'read-tree' '
	git read-tree $tree_sha1
'

test_expect_success 'ls-files shows no modified files' '
	test -z "`git ls-files -m || echo fail`"
'

test_expect_success 'write-tree' '
	test $tree_sha1 = "`git write-tree`"
'

test_expect_success 'commit-tree' '
	COMMIT=`echo Commit with an inode | git commit-tree $tree_sha1` &&
	git update-ref HEAD $COMMIT
'

cat >shadow <<EOF
root:*:13943:0:99999:7:::
jamey:*:13943:0:99999:7:::
josh:*:13943:0:99999:7:::
EOF
shadow_sha1=FIXME

test_expect_success 'ls-files shows modified file' '
	test "shadow" = "`git ls-files -m`"
'

test_expect_success 'add modified file to index' '
	git add shadow
'

test_expect_success 'commit modification' '
	git commit -m "Modify shadow"
'

test_expect_success 'ls-files shows no modified files' '
	test -z "`git ls-files -m || echo fail`"
'

test_expect_success 'check type with cat-file, after modification' '
	test inode = "`git cat-file -t HEAD:shadow`"
'

cat > inode <<EOF
blob $shadow_sha1
props $props_sha1
EOF
inode_sha1=FIXME

test_expect_success 'cat-file inode HEAD:inode, after modification' '
	git cat-file inode HEAD:shadow | cmp -s - inode
'

test_expect_success 'cat-file blob HEAD:inode, after modification' '
	git cat-file blob HEAD:shadow | cmp -s - shadow
'

test_expect_success 'cat-file props HEAD:inode, after modification' '
	git cat-file props HEAD:shadow | cmp -s - props
'

test_done

--EeQfGwPcQSOJBaQU--
