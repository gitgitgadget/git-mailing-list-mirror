From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Show diffs for changed files under a new or deleted directory.
Date: Sun, 17 Feb 2008 16:05:46 +0100
Message-ID: <200802171605.48250.robin.rosenberg@dewire.com>
References: <1203263746-2924-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Sun Feb 17 17:27:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQmMQ-0000f8-B4
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 17:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYBQQ0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2008 11:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYBQQ0u
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 11:26:50 -0500
Received: from [83.140.172.130] ([83.140.172.130]:17989 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbYBQQ0t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 11:26:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1A9F6802657;
	Sun, 17 Feb 2008 17:26:47 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MfHMwZ+GLg5s; Sun, 17 Feb 2008 17:26:46 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 9F2A5800680;
	Sun, 17 Feb 2008 17:26:45 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1203263746-2924-1-git-send-email-rogersoares@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74138>

s=C3=B6ndagen den 17 februari 2008 skrev du:
> When a directory is added or removed in a commit the files under it=20
> were not being shown in the structure compare viewer. This fixes it b=
y
> adding diff nodes for all the files under this directory.
>=20
> This patch also fixes some files showing as being removed in the
> structure compare when they were actually being added.
>=20
> Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
> ---
> Hi Robin,
>=20
> What is "TODO: Git ordering" supposed to change?

Should really read FIXME. It's a known bug that I forgot about at this =
place.

The git data structures has a nasty ordering of things that makes sense=
 in=20
the index but nowhere else. This is an example. say a.b and a=3Db is a =
file and=20
a is a tree, then the 'git' order is:

a.b
a
a=3Db

i.e. the tree 'a' is sorted as if there is a '/' at then end. For full =
path
names that is no problem and it is actually trivial, but when you order
things by partial names it is much messier and quite hard to test also.=
 There
is a bug in the IndexTreeWalker and probably the differenser and you fo=
und it.
It seems most likely you fixed it for that particular case, but it coul=
d still=20
be broken for another.

I'd love to see a unit test for your code since, even if it works, it i=
s very easy
to break again.

See also the topic "[EGIT Patches] Sort order from hell fixes". Unfortu=
nately
the patches did *not* fix the ordering, it just moved the problem to an=
other
set of input data. Patch 1/2 is ok, I think, but 2/2 is just bogus.

Here is one of the cases I'm struggling with now. I discovered it when =
trying
to commit things and the dialog shows allmost all files as modified. An=
other
user got no files listed. We probably should compute the DiffNode struc=
ture
using the IndexDiff too to make sure everyone does it right, once I (or=
 we)
make it work. That would also give us the missing Index/workdir vs HEAD=
 diff
feature too.

I've amended the existing tests since the original ones only tested the
"interesting" properties and missed some surprised so currently I'm try=
ing to
make these tests work. We need more tests than this though since these =
tests
pass with known bad code.

-- robin

/*
 *  Copyright (C) 2007 David Watson <dwatson@mimvista.com>
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License, version 2.1, as published by the Free Software Foundation.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  0211=
0-1301
 */

package org.spearce.jgit.lib;

import java.io.File;
import java.io.IOException;

public class IndexDiffTest extends RepositoryTestCase {
	public void testAdded() throws IOException {
		GitIndex index =3D new GitIndex(db);
		writeTrashFile("file1", "file1");
		writeTrashFile("dir/subfile", "dir/subfile");
		Tree tree =3D new Tree(db);

		index.add(trash, new File(trash, "file1"));
		index.add(trash, new File(trash, "dir/subfile"));
		IndexDiff diff =3D new IndexDiff(tree, index);
		diff.diff();
		assertEquals(2, diff.getAdded().size());
		assertTrue(diff.getAdded().contains("file1"));
		assertTrue(diff.getAdded().contains("dir/subfile"));
		assertEquals(0, diff.getChanged().size());
		assertEquals(0, diff.getModified().size());
		assertEquals(0, diff.getRemoved().size());
	}

	public void testRemoved() throws IOException {
		GitIndex index =3D new GitIndex(db);
		writeTrashFile("file2", "file2");
		writeTrashFile("dir/file3", "dir/file3");

		Tree tree =3D new Tree(db);
		tree.addFile("file2");
		tree.addFile("dir/file3");
		assertEquals(2, tree.memberCount());
		tree.findBlobMember("file2").setId(new ObjectId("30d67d4672d5c05833b7=
192cc77a79eaafb5c7ad"));
		Tree tree2 =3D (Tree) tree.findTreeMember("dir");
		tree2.findBlobMember("file3").setId(new ObjectId("873fb8d667d05436d72=
8c52b1d7a09528e6eb59b"));
		tree2.setId(new ObjectWriter(db).writeTree(tree2));
		tree.setId(new ObjectWriter(db).writeTree(tree));

		IndexDiff diff =3D new IndexDiff(tree, index);
		diff.diff();
		assertEquals(2, diff.getRemoved().size());
		assertTrue(diff.getRemoved().contains("file2"));
		assertTrue(diff.getRemoved().contains("dir/file3"));
		assertEquals(0, diff.getChanged().size());
		assertEquals(0, diff.getModified().size());
		assertEquals(0, diff.getAdded().size());
	}

	public void testModified() throws IOException {
		GitIndex index =3D new GitIndex(db);
	=09
	=09
		index.add(trash, writeTrashFile("file2", "file2"));
		index.add(trash, writeTrashFile("dir/file3", "dir/file3"));
	=09
		writeTrashFile("dir/file3", "changed");

		Tree tree =3D new Tree(db);
		tree.addFile("file2").setId(new ObjectId("012345678901234567890123456=
7890123456789"));
		tree.addFile("dir/file3").setId(new ObjectId("01234567890123456789012=
34567890123456789"));
		assertEquals(2, tree.memberCount());

		Tree tree2 =3D (Tree) tree.findTreeMember("dir");
		tree2.setId(new ObjectWriter(db).writeTree(tree2));
		tree.setId(new ObjectWriter(db).writeTree(tree));
		IndexDiff diff =3D new IndexDiff(tree, index);
		diff.diff();
		assertEquals(2, diff.getChanged().size());
		assertTrue(diff.getChanged().contains("file2"));
		assertTrue(diff.getChanged().contains("dir/file3"));
		assertEquals(1, diff.getModified().size());
		assertTrue(diff.getModified().contains("dir/file3"));
		assertEquals(0, diff.getAdded().size());
		assertEquals(0, diff.getRemoved().size());
		assertEquals(0, diff.getMissing().size());
	}

	public void testUnchangedSimple() throws IOException {
		GitIndex index =3D new GitIndex(db);

		index.add(trash, writeTrashFile("a.b", "a.b"));
		index.add(trash, writeTrashFile("a.c", "a.c"));
		index.add(trash, writeTrashFile("a=3Dc", "a=3Dc"));
		index.add(trash, writeTrashFile("a=3Dd", "a=3Dd"));

		Tree tree =3D new Tree(db);
		// got the hash id'd from the data using echo -n a.b|git hash-object =
-t blob --stdin
		tree.addFile("a.b").setId(new ObjectId("f6f28df96c2b40c951164286e08be=
7c38ec74851"));
		tree.addFile("a.c").setId(new ObjectId("6bc0e647512d2a0bef4f26111e484=
dc87df7f5ca"));
		tree.addFile("a=3Dc").setId(new ObjectId("06022365ddbd7fb126761319633=
bf73517770714"));
		tree.addFile("a=3Dd").setId(new ObjectId("fa6414df3da87840700e9eeb7fc=
261dd77ccd5c2"));

		tree.setId(new ObjectWriter(db).writeTree(tree));

		IndexDiff diff =3D new IndexDiff(tree, index);
		diff.diff();
		assertEquals(0, diff.getChanged().size());
		assertEquals(0, diff.getAdded().size());
		assertEquals(0, diff.getRemoved().size());
		assertEquals(0, diff.getMissing().size());
		assertEquals(0, diff.getModified().size());
	}

	/**
	 * This test has both files and directories that involve
	 * the tricky ordering used by Git.
	 *
	 * @throws IOException
	 */
	public void testUnchangedComplex() throws IOException {
		GitIndex index =3D new GitIndex(db);

		index.add(trash, writeTrashFile("a.b", "a.b"));
		index.add(trash, writeTrashFile("a.c", "a.c"));
		index.add(trash, writeTrashFile("a/b.b/b", "a/b.b/b"));
		index.add(trash, writeTrashFile("a/b", "a/b"));
		index.add(trash, writeTrashFile("a/c", "a/c"));
		index.add(trash, writeTrashFile("a=3Dc", "a=3Dc"));
		index.add(trash, writeTrashFile("a=3Dd", "a=3Dd"));

		Tree tree =3D new Tree(db);
		// got the hash id'd from the data using echo -n a.b|git hash-object =
-t blob --stdin
		tree.addFile("a.b").setId(new ObjectId("f6f28df96c2b40c951164286e08be=
7c38ec74851"));
		tree.addFile("a.c").setId(new ObjectId("6bc0e647512d2a0bef4f26111e484=
dc87df7f5ca"));
		tree.addFile("a/b.b/b").setId(new ObjectId("8d840bd4e2f3a48ff417c8e92=
7d94996849933fd"));
		tree.addFile("a/b").setId(new ObjectId("db89c972fc57862eae378f45b74ac=
a228037d415"));
		tree.addFile("a/c").setId(new ObjectId("52ad142a008aeb39694bafff8e8f1=
be75ed7f007"));
		tree.addFile("a=3Dc").setId(new ObjectId("06022365ddbd7fb126761319633=
bf73517770714"));
		tree.addFile("a=3Dd").setId(new ObjectId("fa6414df3da87840700e9eeb7fc=
261dd77ccd5c2"));

		Tree tree3 =3D (Tree) tree.findTreeMember("a/b.b");
		tree3.setId(new ObjectWriter(db).writeTree(tree3));
		Tree tree2 =3D (Tree) tree.findTreeMember("a");
		tree2.setId(new ObjectWriter(db).writeTree(tree2));
		tree.setId(new ObjectWriter(db).writeTree(tree));

		IndexDiff diff =3D new IndexDiff(tree, index);
		diff.diff();
		assertEquals(0, diff.getChanged().size());
		assertEquals(0, diff.getAdded().size());
		assertEquals(0, diff.getRemoved().size());
		assertEquals(0, diff.getMissing().size());
		assertEquals(0, diff.getModified().size());
	}
}
