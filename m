From: Elijah Newren <newren@gmail.com>
Subject: =?UTF-8?q?=5BRFC=20PATCH=2000/15=5D=20Sparse=20clones?=
Date: Sat,  4 Sep 2010 18:13:52 -0600
Message-ID: <1283645647-1891-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2r7-00089a-7W
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab0IEAMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 20:12:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57812 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab0IEAMs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:12:48 -0400
Received: by pzk9 with SMTP id 9so971230pzk.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=J0ZrpKzTR5SQa1NsHNcruAq8/00CZAz7gdYZB4mfuzg=;
        b=dRjzjYBXKlIYvcYQY5aPGDK8lF32umUB3R0DHIQcK/O1b4KlY8tLyMcij5AB4wPRQX
         TyuE4sKnTqN8eUTxMdf+AnSMz7ZNA/Z4jMQw9r30v9kgd+WyXqWEacAsI8vH0XGSb6CC
         nywtlIKFya6xseJzHmEI6eQY1hOdZEnFA4Fk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=tKa2VXdbds6qHElTMJh8DPs+ZvDTvvsXYwVFJh7KchaTeE+CyC0ZRF2fzB/sFVz1FS
         3Em07XGGcBwVXjx70/nbUHdOez9i7zsU0tCk0i+/THrEYUwWHslJ0nzUoEtMQsUr7MPd
         CuqtIOgF9dQ/xVme799rzyZHKokPuXHuADKZA=
Received: by 10.114.132.18 with SMTP id f18mr1509722wad.30.1283645568322;
        Sat, 04 Sep 2010 17:12:48 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.12.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:12:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155389>

This patch series implements some basics for sparse clones, which I
define as a clone where not all blob, tree, or commit objects are
downloaded.  The idea is to include sparseness both relative to span
of files/directories and depth of history, though currently I've only
put effort into span of paths.

This patch is built on pu, because it requires
en/object-list-with-pathspec.

What works:
  * all operations on non-sparse clones (full testsuite passes)
  * clone
  * read-tree
  * ls-files
  * cat-file
  * ls-tree
  * checkout
  * diff
  * status
  * log
  * add (except for not giving errors for paths outside the sparse limi=
ts)
  * commit
What doesn't work, yet:
  * Probably everything not tested in the new t572*.sh tests  :-)
  Notable examples of things missing from t572*.sh tests:
  * fetch
  * push
  * merge
  * rebase
  * thin packs (need to modify pack-objects to only delta against
    objects within the sparse limits)
  * densify command (to make a sparse repository non-sparse)
  * "missing" commits (see README file in PATCH1)

Cursory comparison with Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy's sub=
tree clone (he's probably
made progress since his last submission, so this may be outdated):
  * His series supports fetch, mine doesn't (yet).
  * His series supports push,  mine doesn't (yet).
  * His series supports merge, mine doesn't (yet).
  * His handling of subtree request over clone/fetch via capabilities
    is probably the right way; I'm pretty sure my adding of sparse
    limits are extra arguments to upload-pack would break backward
    compatibility and be bad.
  * He supports just one selected subtree (though he mentioned he's
    working on extending that); I support arbitrary number of subtrees
    or subfiles.
  * He modifies index format (bumping to header version 4); I don't.
    Perhaps it's necessary for merge handling as I haven't implemented
    that, but at an early glance I don't think it's necessary.
  * While there are some similarities in the low-level details of how
    we've modified the git to avoid missing objects, there are many
    differences as well.  I'm hoping to provoke some good discussion.

Elijah Newren (15):

  P1- README-sparse-clone: Add a basic writeup of my ideas for sparse c=
lones

Just a big old write-up.  Not everything in it is implemented yet, but =
it
gives you the high-level picture.

  P2- Add tests for client handling in a sparse repository

Tests!  Yaay!

  P3- Read sparse limiting args from $GIT_DIR/sparse-limit

When a sparse clone is created, limiting paths will be stored.

  P4- When unpacking in a sparse repository, avoid traversing missing
    trees/blobs
  P5- read_tree_recursive: Avoid missing blobs and trees in a sparse
    repository
  P6- Automatically reuse sparse limiting arguments in revision walking
  P7- cache_tree_update(): Capability to handle tree entries missing fr=
om
    index
  P8- cache_tree_update(): Require relevant tree to be passed

Avoiding missing trees/blobs. =20

  P9- Add tests for communication dealing with sparse repositories

Tests for clone/fetch/push/etc.  Just clone so far.

  P10- sparse-repo: Provide a function to record sparse limiting argume=
nts

Can't just read from $GIT_DIR/sparse-limit; gotta write to it too.

  P11- builtin-clone: Accept paths for sparse clone
  P12- Pass extra (rev-list) args on, at least in some cases
  P13- upload-pack: Handle extra rev-list arguments being passed
  P14- EVIL COMMIT: Include all commits
  P15- clone: Ensure sparse limiting arguments are used in subsequent
    operations

I like the changes to how clone accepts additional rev-list arguments
to limit what is downloaded, but I'm not too happy with how these
patches pass those rev-list arguments on to upload-pack.  So don't
bother looking too closely at these.


 Makefile                                   |    2 +
 README-sparse-clone                        |  284 ++++++++++++++++++++=
++++++++
 builtin/archive.c                          |    2 +-
 builtin/checkout.c                         |    2 +-
 builtin/clone.c                            |   39 +++-
 builtin/commit.c                           |   15 +-
 builtin/fetch-pack.c                       |    3 +-
 builtin/merge.c                            |   19 +-
 builtin/revert.c                           |    7 +-
 builtin/send-pack.c                        |    3 +-
 builtin/write-tree.c                       |    6 +-
 cache-tree.c                               |   92 +++++++++-
 cache-tree.h                               |    4 +-
 cache.h                                    |    5 +-
 connect.c                                  |    9 +-
 diff.h                                     |    1 -
 environment.c                              |    2 +
 merge-recursive.c                          |    6 +-
 merge-recursive.h                          |    2 +-
 revision.c                                 |   21 ++-
 revision.h                                 |    3 +-
 setup.c                                    |    2 +
 sparse-repo.c                              |   84 ++++++++
 sparse-repo.h                              |    4 +
 t/sparse-lib.sh                            |   38 ++++
 t/t5601-clone.sh                           |   14 --
 t/t5720-sparse-repository-basics.sh        |  130 +++++++++++++
 t/t5721-sparse-repository-communication.sh |  106 +++++++++++
 test-dump-cache-tree.c                     |    3 +-
 transport-helper.c                         |    5 +-
 transport.c                                |   13 +-
 transport.h                                |    9 +-
 tree-diff.c                                |    4 +-
 tree-walk.c                                |   48 ++++-
 tree-walk.h                                |    3 +
 tree.c                                     |    5 +
 upload-pack.c                              |   45 +++--
 37 files changed, 952 insertions(+), 88 deletions(-)
 create mode 100644 README-sparse-clone
 create mode 100644 sparse-repo.c
 create mode 100644 sparse-repo.h
 create mode 100644 t/sparse-lib.sh
 create mode 100755 t/t5720-sparse-repository-basics.sh
 create mode 100755 t/t5721-sparse-repository-communication.sh

--=20
1.7.2.3.541.g94cc33
