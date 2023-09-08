Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F30BEEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbjIHXGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjIHXGa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:06:30 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B29C1FCA
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:06:25 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38042)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekYR-006MTt-J5; Fri, 08 Sep 2023 17:06:23 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:58880 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekYQ-009tbT-BP; Fri, 08 Sep 2023 17:06:23 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Date:   Fri, 08 Sep 2023 18:05:52 -0500
Message-ID: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qekYQ-009tbT-BP;;;mid=<87sf7ol0z3.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+Xzm+uJR+UxGrozFPkesZMR//ranMOsbc=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 0/32] SHA256 and SHA1 interoperability
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I would like to see the SHA256 transition happen so I started playing
with the k2204-transition-interop branch of brian m. carlson's tree.

Before I go farther I need to some other folks to look at this and see
if this is a general direction that the git project can stand.

This patchset is not complete it does not implement converting a
received pack of the compatibility hash into the hash function of the
repository, nor have I written any automated tests.  Both need to happen
before this is finalized.

That said I think I have working implementations of all of the
interesting cases.  In particular I have "git index-pack" computing the
compatibility hash of every object in a pack file, and I can tell you
the sha256 of every sha1 in the git://git.kernel.org/pub/scm/git/git.git

To get there I have tweaked the transition plan a little.

So far I have just aimed for code that works, so there is doubtless
room for improvement.  My hope is that I have implemented enough
that people can play with this, and that people can see all of the
weird little details that need to be taken care of to make this work.

What do everyone else think?  Does this direction look plausible?

Eric W. Biederman (24):
      doc hash-file-transition: A map file for mapping between sha1 and sha256
      doc hash-function-transition: Replace compatObjectFormat with compatMap
      object-file-convert:  Stubs for converting from one object format to another
      object-name: Initial support for ^{sha1} and ^{sha256}
      repository: add a compatibility hash algorithm
      loose: Compatibilty short name support
      object-file: Update the loose object map when writing loose objects
      bulk-checkin: Only accept blobs
      pack: Communicate the compat_oid through struct pack_idx_entry
      object-file: Add a compat_oid_in parameter to write_object_file_flags
      object: Factor out parse_mode out of fast-import and tree-walk into in object.h
      builtin/cat-file:  Let the oid determine the output algorithm
      tree-walk: init_tree_desc take an oid to get the hash algorithm
      object-file: Handle compat objects in check_object_signature
      builtin/ls-tree: Let the oid determine the output algorithm
      builtin/pack-objects:  Communicate the compatibility hash through struct pack_idx_entry
      pack-compat-map:  Add support for .compat files of a packfile
      object-file-convert: Implement convert_object_file_{begin,step,end}
      builtin/fast-import: compute compatibility hashs for imported objects
      builtin/index-pack:  Add a simple oid index
      builtin/index-pack:  Compute the compatibility hash
      builtin/index-pack: Make the stack in compute_compat_oid explicit
      unpack-objects: Update to compute and write the compatibility hashes
      object-file-convert: Implement repo_submodule_oid_to_algop

brian m. carlson (8):
      repository: Implement core.compatMap
      loose: add a mapping between SHA-1 and SHA-256 for loose objects
      bulk-checkin: hash object with compatibility algorithm
      commit: write commits for both hashes
      cache: add a function to read an OID of a specific algorithm
      object-file-convert: add a function to convert trees between algorithms
      object-file-convert: convert commit objects when writing
      object-file-convert: convert tag commits when writing


 Documentation/config/core.txt                      |   6 +
 .../technical/hash-function-transition.txt         |  56 ++-
 Makefile                                           |   4 +
 archive.c                                          |   3 +-
 builtin.h                                          |   1 +
 builtin/am.c                                       |   6 +-
 builtin/cat-file.c                                 |   8 +-
 builtin/checkout.c                                 |   8 +-
 builtin/clone.c                                    |   2 +-
 builtin/commit.c                                   |   2 +-
 builtin/fast-import.c                              | 110 +++--
 builtin/grep.c                                     |   8 +-
 builtin/index-pack.c                               | 441 ++++++++++++++++++++-
 builtin/ls-tree.c                                  |   5 +-
 builtin/merge.c                                    |   3 +-
 builtin/pack-objects.c                             |  13 +-
 builtin/read-tree.c                                |   2 +-
 builtin/show-compat-map.c                          | 139 +++++++
 builtin/stash.c                                    |   5 +-
 builtin/unpack-objects.c                           |  14 +-
 bulk-checkin.c                                     |  55 ++-
 bulk-checkin.h                                     |   6 +-
 cache-tree.c                                       |   4 +-
 commit.c                                           | 176 +++++---
 commit.h                                           |   1 +
 delta-islands.c                                    |   2 +-
 diff-lib.c                                         |   2 +-
 fsck.c                                             |   6 +-
 git.c                                              |   1 +
 hash-ll.h                                          |   3 +
 hash.h                                             |   9 +-
 http-push.c                                        |   2 +-
 list-objects.c                                     |   2 +-
 loose.c                                            | 256 ++++++++++++
 loose.h                                            |  20 +
 match-trees.c                                      |   4 +-
 merge-ort.c                                        |  11 +-
 merge-recursive.c                                  |   2 +-
 merge.c                                            |   3 +-
 object-file-convert.c                              | 366 +++++++++++++++++
 object-file-convert.h                              |  50 +++
 object-file.c                                      | 197 +++++++--
 object-name.c                                      |  77 +++-
 object-store-ll.h                                  |  13 +-
 object.c                                           |   2 +
 object.h                                           |  18 +
 pack-bitmap-write.c                                |   2 +-
 pack-compat-map.c                                  | 334 ++++++++++++++++
 pack-compat-map.h                                  |  27 ++
 pack-write.c                                       | 158 ++++++++
 pack.h                                             |   1 +
 packfile.c                                         |  15 +-
 reflog.c                                           |   2 +-
 repository.c                                       |  17 +
 repository.h                                       |   4 +
 revision.c                                         |   4 +-
 setup.c                                            |   5 +
 setup.h                                            |   1 +
 tree-walk.c                                        |  58 ++-
 tree-walk.h                                        |   7 +-
 tree.c                                             |   2 +-
 walker.c                                           |   2 +-
 62 files changed, 2525 insertions(+), 238 deletions(-)

Eric
