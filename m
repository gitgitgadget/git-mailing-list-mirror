From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/28] First class shallow clone
Date: Mon, 25 Nov 2013 10:55:26 +0700
Message-ID: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:51:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDB-0001bA-7t
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352Ab3KYDva convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:51:30 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:62023 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab3KYDv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:51:29 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so4817122pbc.12
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=QgQRJhishLcHKCL6D5oARIZwCURnhMtd4v/5FSzp1ns=;
        b=kiIXfUM2ID8eHw3SpTSwdagepJ+ZIn5gK/LbTJ2NYPZp+c2tLEg5CZwx49dCellywX
         ACCEf+xMpYCBL9JbSVpNfm19iQjTzPaQ6YIDWgz3nrXq4MUqPmwoNS2oBg7rN4YbdzmT
         ZeSvvUSzlzMjuSk/0xpfuETdm9g3XdGLNOh0tllpeGutNpAiOly1ffW7SOq83nL7uxoL
         KUGYDbYU3Mg8UTzMnMD3llEMdsj20pPVxmhP+DtaYJyKz1Wkvv/jIoYUtQubgHHHulF3
         xgmmVwQbDXEQfyTTsQS/mGtNeTPYIVoqAk99usFLsjtcnWxbzN5blMahC9OYLLkIJWH0
         ESCA==
X-Received: by 10.66.119.136 with SMTP id ku8mr5734019pab.121.1385351488898;
        Sun, 24 Nov 2013 19:51:28 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id bl8sm69035787pad.17.2013.11.24.19.51.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:51:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:56:01 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238272>

Compared to v2 [1], v3 grows a bit. The biggest difference is
=2Egit/shallow is not updated by default (except when you clone from
a shallow repository). When you send something, the "safe" refs that
do not need new shallow roots are accepted at the receiver end, the
others rejected.

To accept those other refs, either use "fetch --update-shallow" or
enable receive.shallowupdate on the receiver side of a push.

=46iltering "safe" refs requires walking through some commits, so
it'll be more expensive than normal full clones. This is especially
true for the receiver of a push (see 07/28 and 17/28). I envision
shallow repos are used as upstream to archive old history, so this is
not a good news. Commit cache (or pack v4) might help. We might even
be able to move some work from receive-pack to send-pack to reduce
server load..

[1] http://mid.gmane.org/1374314290-5976-1-git-send-email-pclouds@gmail=
=2Ecom

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (28):
  transport.h: remove send_pack prototype, already defined in send-pack=
=2Eh
  send-pack: forbid pushing from a shallow repository
  clone: prevent --reference to a shallow repository
  update-server-info: do not publish shallow clones

   This part is just cleanup.

  Advertise shallow graft information on the server end
  connect.c: teach get_remote_heads to parse "shallow" lines
  shallow.c: add remove_reachable_shallow_points()
  shallow.c: add mark_new_shallow_refs()
  shallow.c: extend setup_*_shallow() to accept extra shallow points
  fetch-pack.c: move shallow update code out of fetch_pack()
  fetch-pack.h: one statement per bitfield declaration
  clone: support remote shallow repository
  fetch: support fetching from a shallow repository
  upload-pack: make sure deepening preserves shallow roots
  fetch: add --update-shallow to get refs that require updating .git/sh=
allow

   Basic shallow fetch/clone support on git protocol

  receive-pack: reorder some code in unpack()
  Support pushing from a shallow clone
  New var GIT_SHALLOW_FILE to propagate --shallow-file to subprocesses
  connected.c: add new variant that runs with --shallow-file
  receive-pack: allow pushing with new shallow roots
  send-pack: support pushing to a shallow clone
  remote-curl: pass ref SHA-1 to fetch-pack as well
 =20
   Push support

  Support fetch/clone over http
  receive-pack: support pushing to a shallow clone via http
  send-pack: support pushing from a shallow clone via http

   smart-http support

  git-clone.txt: remove shallow clone limitations
  clone: use git protocol for cloning shallow repo locally
  prune: clean .git/shallow after pruning objects

   miscellaneous

 Documentation/config.txt                  |   4 +
 Documentation/fetch-options.txt           |  14 +-
 Documentation/git-clone.txt               |   7 +-
 Documentation/gitremote-helpers.txt       |   7 +
 Documentation/technical/pack-protocol.txt |   7 +-
 builtin/clone.c                           |  18 +-
 builtin/fetch-pack.c                      |  23 +-
 builtin/fetch.c                           |  15 +-
 builtin/gc.c                              |   1 +
 builtin/prune.c                           |   4 +
 builtin/receive-pack.c                    | 248 +++++++++++++++++----
 builtin/send-pack.c                       |   5 +-
 cache.h                                   |   1 +
 commit.h                                  |  19 +-
 connect.c                                 |  14 +-
 connected.c                               |  42 +++-
 connected.h                               |   2 +
 environment.c                             |   6 +
 fetch-pack.c                              | 132 ++++++++++--
 fetch-pack.h                              |  29 +--
 git.c                                     |   2 +-
 remote-curl.c                             |  33 ++-
 remote.h                                  |   5 +-
 send-pack.c                               |  20 +-
 server-info.c                             |   9 +
 shallow.c                                 | 348 ++++++++++++++++++++++=
+++++++-
 t/t5536-fetch-shallow.sh (new +x)         | 193 +++++++++++++++++
 t/t5537-push-shallow.sh (new +x)          | 184 ++++++++++++++++
 t/t5601-clone.sh                          |   7 +
 transport-helper.c                        |   6 +
 transport.c                               |  22 +-
 transport.h                               |  16 +-
 upload-pack.c                             |   8 +-
 33 files changed, 1323 insertions(+), 128 deletions(-)
 create mode 100755 t/t5536-fetch-shallow.sh
 create mode 100755 t/t5537-push-shallow.sh

--=20
1.8.2.83.gc99314b
