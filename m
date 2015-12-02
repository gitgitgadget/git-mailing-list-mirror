From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] Split .git/config in multiple worktree setup
Date: Wed,  2 Dec 2015 20:13:41 +0100
Message-ID: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:14:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4CrF-0003kL-4i
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbbLBTOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 14:14:06 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33530 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbbLBTOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 14:14:04 -0500
Received: by wmec201 with SMTP id c201so268589745wme.0
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 11:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=DH+tW5K+7kZHtE+6XrDwRjDU4yi7QuNtknevWztSVnE=;
        b=Hzk079ENj4Pb6P5E7WuEbe1b1iDyFFrSWhHnLgw/XuP5tK2Ej6fiOQEc3AMp1QiO7C
         OBKnqqh/vqvgQQK9EbnXPaVg/cf6WSx0V4lg0hg6VPOCYg2/V5aKvwTBqfeQjkX9kWkB
         6kR3B3AKOGDs23o1VZLuspb10wQP+KbwCq2cHxsbG3NE5bZYKkdVIrKNnlmKGxkmEq/j
         Wq3fFL3rb71cFk35fRY9Ksw9+TSJwyvxFzRaFAPRw3iRpjERpY5NXUM/VEMUwD7lZXW/
         5kao7M41qCvjjDUoFh4G0b5V3xHSe+q70YoAab0r/KF96xWAYIdJVB2BCpN1/FWJYBfQ
         M8Hg==
X-Received: by 10.28.140.136 with SMTP id o130mr46873176wmd.78.1449083642736;
        Wed, 02 Dec 2015 11:14:02 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id uz5sm4090822wjc.8.2015.12.02.11.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2015 11:14:01 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281906>

Let's restart this. From the last discussion [1], we need to make
core.worktree per-worktree for submodules to work. We also need
core.sparseCheckout per-worktree.

This series adds a pattern list, with .gitignore syntax mostly, that
split config var set into two sets, the per-worktree set will be
stored in .git/worktrees/*/config.worktree instead. The pattern list
consists of default patterns, built in git binary, and user ones in
=2Egit/info/config.worktree.

I have marked a few obvious config vars as per-worktree. There may be
more to mark, Max did go over them last time so I'll let him to add
more if submodule needs it.

[1] http://article.gmane.org/gmane.comp.version-control.git/266520

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  dir.c: clean the entire struct in clear_exclude_list()
  config.c: move worktree-specific variables to .git/worktrees/...
  setup.c: remove special case of core.worktree and core.bare
  worktree: make core.sparseCheckout and core.ignoreStat per-worktree
  git-worktree.txt: mention about the config file split

 Documentation/config.txt               |  13 ++-
 Documentation/git-worktree.txt         |  13 +++
 Documentation/gitrepository-layout.txt |  12 +++
 builtin/config.c                       |   9 ++
 cache.h                                |   2 +-
 config.c                               | 153 +++++++++++++++++++++++++=
++++++--
 dir.c                                  |   6 +-
 dir.h                                  |   1 +
 setup.c                                |  62 ++++++-------
 t/t2025-worktree-add.sh                |  26 ++++++
 10 files changed, 250 insertions(+), 47 deletions(-)

--=20
2.2.0.513.g477eb31
