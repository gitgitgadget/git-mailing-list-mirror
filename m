From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/6] Split .git/config in multiple worktree setup
Date: Sun, 27 Dec 2015 10:14:33 +0700
Message-ID: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, max@max630.net, Jens.Lehmann@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 04:14:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD1nM-0002ru-SK
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 04:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbbL0DOw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 22:14:52 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34887 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240AbbL0DOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 22:14:51 -0500
Received: by mail-pa0-f47.google.com with SMTP id jx14so150173517pad.2
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 19:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tGhiChVaFKHXR2H8sJyak0I1cSuiBtZjbvJzwattIkQ=;
        b=Azpi0DBoUX1tPJ4sx2uG1E7IueKxyDRQVlVPKiruifJUfDCmYryFwBAXX9fTCtewpg
         OaHlutMmJLPSHivqe1ixt1eODEK42pcL6dBw5C9r4DxNmnS33ffRydOrohr6mKiYesHe
         MQTcgtoJCtII3ZunrLOArPc+vCa0K7G1ZqczQowjd4iAanRmaz4S4fGsw0kvBlLeKAuG
         dL1oixY9zlZcQm+o1K58x940mCwRxbfWADcPHGk3eXq1q9IOdj+1rgVcdcKTp5NuaPem
         Ek7dzRXa2aICkOTw678e0hbw7/FSMcUm2sT5rVnJHWduTqfXip7UZos/5w5Xn05MFFw/
         p+Zw==
X-Received: by 10.66.251.226 with SMTP id zn2mr69285577pac.44.1451186091160;
        Sat, 26 Dec 2015 19:14:51 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id zu6sm55562065pac.8.2015.12.26.19.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 19:14:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 10:14:56 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New design. We now define multiworktree behavior with config var
extensions.worktree. Latest git must support all older behavior
versions. If config file says "version 1", even if latest version is
3, git must behave like version 1. This covers all aspects of
multi-worktree, not just config files.

With that foundation, we can now build version 1 (version 0 is what
is already released). Version 1 stores per-worktree config in
$GIT_DIR/worktrees/.../config. The list of config vars is hard coded.
New list requires new worktree version.

The hard coded list actually supports precise variable name matching,
or prefix matching (e.g. submodule.*). I don't suppose we need full
fnmatch to support submodules.

include.path is now extended a bit to give the user an opportunity to
change the config split. The user can turn a shared config into
per-worktree (but not the other way around). It's done by allowing env
expansion in include.path. So if you specify

    include.path =3D $GIT_DIR/abc

"abc" will always be per-worktree.

Upgrade support is manual (for now). When a new worktree is added, we
can bump from version 0 (i.e. extensions.worktree is missing) to 1.
But that's it. We can't safely bump 1 to 2 automatically.

The code in this series is not meant to be run (I didn't even test
it). It's just in case my C expresses my ideas better than my English.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  Define new repo extension to manage multiple worktree behaviors
  config.c: move worktree-specific variables to .git/worktrees/...
  setup.c: remove special case of core.worktree and core.bare
  worktree: make core.sparseCheckout and core.ignoreStat per-worktree
  config.c: allow to un-share certain config in multi-worktree setup
  worktree: bump worktree version to 1 on "worktree add"

 Documentation/config.txt                       |   4 +
 Documentation/git-worktree.txt                 |  12 ++
 Documentation/gitrepository-layout.txt         |   5 +
 Documentation/technical/repository-version.txt |   9 ++
 builtin/config.c                               |   9 ++
 builtin/worktree.c                             |  33 ++++++
 cache.h                                        |   4 +-
 config.c                                       | 151 +++++++++++++++++=
++++++--
 environment.c                                  |  14 +++
 setup.c                                        |  65 +++++------
 10 files changed, 264 insertions(+), 42 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
