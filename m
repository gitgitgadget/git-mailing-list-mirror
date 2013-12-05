From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 00/28] First class shallow clone
Date: Thu,  5 Dec 2013 20:02:27 +0700
Message-ID: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:58:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYVb-000186-V3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab3LEM6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:58:19 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48816 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab3LEM6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:58:18 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so25708473pbc.40
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IQBA/IMpMq7/TzYlisDens5fYJGRVNnFSC87vRgA+eo=;
        b=aW6lfZWbOLaydDtpvteqmqaljSJRIqlvmLYrHyWxPAPdG988PhkTtGBq9PZf+8kImM
         Fgnnj2N+ZAoI6CxeE4pYuByO/cAu/JoFaNke3BeYSHY6M3XfPfdoFG/kyQJVg4nGBYUw
         Z0cr3W6hzLu5rJmhTvsFnuHtZHq2k+CNdWFQLVrzk/dcIz0YYmrrQR+XtOPe4zX9Vr9Q
         hLWwe31PVA0c73xmoDAB4H6C7fSflLt92RYb6RfZNizTw/axFfXMytkHKu0cE4X6PSHM
         dTEkoQxYC0P0u12OuLrzb6a8IRHMypd65k6ahS7xYqPNwkPI1Xf4m4eahwls+0aA/liS
         aBzQ==
X-Received: by 10.66.254.200 with SMTP id ak8mr31711331pad.24.1386248296609;
        Thu, 05 Dec 2013 04:58:16 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id at4sm144594134pbc.30.2013.12.05.04.58.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:58:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:03:00 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238856>

This reroll should fix all comments I have received in v3. I reordered
the shallow checks a bit so in common case it should be as cheap as
a normal fetch or push. See 08/28 and 20/28 for the big picture. I'm no=
t
entirely happy with the hook issue in 20/28, but it looks good enough
for me. There are a few XXXes for further improvement, but I'll keep
them until this lands.

To recap, this series allows you to clone from a shallow repo, push to
or fetch from any shallow repo. Normally it will reject new refs
that introduce new shallow boundaries to your repository, so if you're
in a full clone, it will always stay a full clone. Use "fetch
--update-shallow" or set receive.shallowupdate to accept those refs.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (28):
  transport.h: remove send_pack prototype, already defined in send-pack=
=2Eh
  Replace struct extra_have_objects with struct sha1_array
  send-pack: forbid pushing from a shallow repository
  clone: prevent --reference to a shallow repository
  Make the sender advertise shallow commits to the receiver
  connect.c: teach get_remote_heads to parse "shallow" lines
  shallow.c: extend setup_*_shallow() to accept extra shallow commits
  shallow.c: the 8 steps to select new commits for .git/shallow
  shallow.c: steps 6 and 7 to select new commits for .git/shallow
  fetch-pack.c: move shallow update code out of fetch_pack()
  fetch-pack.h: one statement per bitfield declaration
  clone: support remote shallow repository
  fetch: support fetching from a shallow repository
  upload-pack: make sure deepening preserves shallow roots
  fetch: add --update-shallow to accept refs that update .git/shallow
  receive-pack: reorder some code in unpack()
  receive/send-pack: support pushing from a shallow clone
  New var GIT_SHALLOW_FILE to propagate --shallow-file to subprocesses
  connected.c: add new variant that runs with --shallow-file
  receive-pack: allow pushes that update .git/shallow
  send-pack: support pushing to a shallow clone
  remote-curl: pass ref SHA-1 to fetch-pack as well
  Support shallow fetch/clone over smart-http
  receive-pack: support pushing to a shallow clone via http
  send-pack: support pushing from a shallow clone via http
  clone: use git protocol for cloning shallow repo locally
  prune: clean .git/shallow after pruning objects
  git-clone.txt: remove shallow clone limitations

 Documentation/config.txt                  |   4 +
 Documentation/fetch-options.txt           |  14 +-
 Documentation/git-clone.txt               |   7 +-
 Documentation/git-prune.txt               |   2 +
 Documentation/gitremote-helpers.txt       |   7 +
 Documentation/technical/pack-protocol.txt |   7 +-
 builtin/clone.c                           |  18 +-
 builtin/fetch-pack.c                      |  23 +-
 builtin/fetch.c                           |  15 +-
 builtin/gc.c                              |   1 +
 builtin/prune.c                           |   4 +
 builtin/receive-pack.c                    | 314 +++++++++++++++----
 builtin/send-pack.c                       |   9 +-
 cache.h                                   |   3 +
 commit.h                                  |  39 ++-
 connect.c                                 |  22 +-
 connected.c                               |  42 ++-
 connected.h                               |   2 +
 environment.c                             |   6 +
 fetch-pack.c                              | 132 +++++++-
 fetch-pack.h                              |  29 +-
 git.c                                     |   2 +-
 remote-curl.c                             |  34 ++-
 remote.h                                  |   9 +-
 send-pack.c                               |  27 +-
 send-pack.h                               |   2 +-
 shallow.c                                 | 486 ++++++++++++++++++++++=
+++++++-
 t/t5304-prune.sh                          |  10 +
 t/t5536-fetch-shallow.sh (new +x)         | 203 +++++++++++++
 t/t5537-push-shallow.sh (new +x)          | 183 +++++++++++
 t/t5601-clone.sh                          |   7 +
 trace.c                                   |   2 +-
 transport-helper.c                        |   6 +
 transport.c                               |  25 +-
 transport.h                               |  16 +-
 upload-pack.c                             |   8 +-
 36 files changed, 1555 insertions(+), 165 deletions(-)
 create mode 100755 t/t5536-fetch-shallow.sh
 create mode 100755 t/t5537-push-shallow.sh

--=20
1.8.5.1.25.g8667982
