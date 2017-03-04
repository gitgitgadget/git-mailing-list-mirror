Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A252023D
	for <e@80x24.org>; Sat,  4 Mar 2017 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbdCDTf6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 14:35:58 -0500
Received: from dalaran.tastycake.net ([212.13.201.165]:51146 "EHLO
        dalaran.tastycake.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdCDTf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 14:35:57 -0500
X-Greylist: delayed 1004 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Mar 2017 14:35:56 EST
Received: from [176.27.107.90] (helo=localhost.localdomain)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <markbt@efaref.net>)
        id 1ckFCu-0001xc-E4; Sat, 04 Mar 2017 19:19:08 +0000
From:   Mark Thomas <markbt@efaref.net>
To:     git@vger.kernel.org
Cc:     Mark Thomas <markbt@efaref.net>
Subject: [RFC 0/4] Shallow clones with on-demand fetch
Date:   Sat,  4 Mar 2017 19:18:57 +0000
Message-Id: <20170304191901.9622-1-markbt@efaref.net>
X-Mailer: git-send-email 2.12.0.193.g9dc7f06
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

This is an RFC for an enhancement to shallow repositories to make them
behave more like full clones.

I was inspired a bit by Microsoft's announcement of their Git VFS.  I
saw that people have talked in the past about making git fetch objects
from remotes as they are needed, and decided to give it a try.

The patch series adds a "--on-demand" option to git clone, which, when
used in conjunction with the existing shallow clone operations, clones
the full history of the repository's commits, but only the files that
would be included in the shallow clone.

When a file that is missing is required, git requests the file on-demand
from the remote, via a new 'upload-file' service.

Public git servers are unlikely to want to enable this, due to the
addition load it may cause, but within an organization's own network, it
will allow full access to the repository history without needing a full
initial clone.

The patch set is in four parts:
  1:
    Adds the "upload-file" command, which starts a new protocol
    conversation with the client allowing it to request file info and
    file contents.  The connection is kept open so that the client
    can make as many requests as it likes.  The client terminates the
    connection by sending a packet containing "end".
  2:
    Adds the ability for file info and content to be requested from
    the remote if the file cannot be found in any pack, or loose in
    the repository.  Currently this only looks at the default remote,
    but the intention is this would be configurable.
  3:
    Adds the "on-demand" capability to "upload-pack".  When a client
    requests this capability, "upload-pack" includes in the pack
    all commits, even those that would normally be dropped by the
    shallow clone.
  4:
    Adds the "--on-demand" option to clone, to request a shallow
    clone.

This is a proof-of-concept, so it is in no way complete.  It contains a
few hacks to make it work, but these can be ironed out with a bit more
work.  What I have so far is sufficient to try out the idea.  I'd like
to get people's opinions on it before I spend any more time working on
it, plus also I'm not very familiar with the git codebase, so some help
would be appreciated.

As an example, the Linux repository currently stands at 2.0GB of packed
data.  A "git clone --shallow-since=2016-01-01 --on-demand" is only
561MB, and yet remains fully functional.  A git blame on the Makefile,
for example, shows all changes to the file, right back to Linus's
original commit in 2005.

Still to do:

 - Fix up the hacks and make everything work correctly.
 - Make fetching of further updates work correctly.
 - Store the retrieved files in an LRU cache, possibly with the option
   of storing them in the main repo data, too.
 - Add a gc/enshallow operation to make the repo shallower by forgetting
   old files, or moving them to the LRU cache.
 - Add configurable remote to fetch from.
 - Documentation.
 - Much more.

Please let me know what you think, and if an experienced git developer
would like to help out with finishing this, that would be even better.

Mark Thomas (4):
  upload-file: Add upload-file command
  on-demand: Fetch missing files from remote
  upload-pack: Send all commits if client requests on-demand
  clone: Request on-demand shallow clones

 .gitignore             |   1 +
 Makefile               |   3 +
 builtin/clone.c        |   7 +-
 builtin/pack-objects.c |  26 ++++++-
 cache-tree.c           |   2 +-
 cache.h                |   3 +-
 daemon.c               |   6 ++
 fetch-pack.c           |   3 +
 fetch-pack.h           |   1 +
 list-objects.c         |  12 ++--
 list-objects.h         |  13 +++-
 object.h               |   1 +
 on_demand.c            | 183 +++++++++++++++++++++++++++++++++++++++++++++++++
 on_demand.h            |  12 ++++
 sha1_file.c            |   8 ++-
 shallow.c              |   2 +-
 transport.c            |   3 +
 transport.h            |   4 ++
 upload-file.c          |  87 +++++++++++++++++++++++
 upload-pack.c          |   8 ++-
 20 files changed, 370 insertions(+), 15 deletions(-)
 create mode 100644 on_demand.c
 create mode 100644 on_demand.h
 create mode 100644 upload-file.c

-- 
2.7.4

