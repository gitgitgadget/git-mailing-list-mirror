From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 0/8] Convert git-rebase.sh to C
Date: Wed, 18 Mar 2015 16:55:39 +0700
Message-ID: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 10:56:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAi8-0002e3-A7
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933180AbbCRJ4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2015 05:56:10 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36460 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933177AbbCRJ4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:56:07 -0400
Received: by padcy3 with SMTP id cy3so37895797pad.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=nSlTGWIYpPrccmzl8CAVV4BEat3uNmjxXI/cgrcIZZ4=;
        b=KFhfOMSf00U7y1qi+asdiy2rWRlESq61kHM9sJPws6GX3agKxpnVOn84NqoxqlOflh
         R9rk5Q5PxntxlkEdC2USWWZpe61Co7Kz+J2FH6ktte5Y2udo3znPglAnZlwaYkZhFTk1
         9FpQfQ2Vs2Tn2VPDHcyeLkDMoKi9FBVLMOOUo0og/nsMchv8X13BgbSYbSFmRSPRzNqU
         0Kin3ujcm2HURJk9L+7doWLe3Z/JTlYgpaXNMIsv4mduTpgjNwBencLVSBAsIvlR6Gfm
         qCn+FItGGvLVKK6E61704w8QnzCQTQajP1PMU0id4AZw4M18K64IEllO5zhOVkLjMAwP
         CObQ==
X-Received: by 10.70.94.101 with SMTP id db5mr4949571pdb.62.1426672565752;
        Wed, 18 Mar 2015 02:56:05 -0700 (PDT)
Received: from lanh ([115.73.252.85])
        by mx.google.com with ESMTPSA id q4sm26641726pdj.2.2015.03.18.02.56.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 02:56:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Mar 2015 16:56:01 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265702>

In the spirit of sharing code proactively [1], despite my embarrassment=
,
this is what I got for converting git-rebase.sh to C. Note that this
is only about git-rebase.sh, not git-rebase--*.sh. Some changes in
git-rebase.sh are pushed back to git-rebase--*.sh. The idea is we
convert git-rebase.sh first, then the rest later.

Anybody who wants to base their work on this code, feel free to
--reset-author (and take all the bugs with you, I'm sure there are
lots of them). This work is from 2013. git-rebase.sh has received lots
of updates since then, so there's still lots of work to do.

[1] http://article.gmane.org/gmane.comp.version-control.git/265699

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  strbuf: add and use strbuf_read_file_or_die()
  Move reset_tree from builtin/checkout.c to unpack-trees.c
  rebase: turn rebase--am into a separate program
  rebase: turn rebase--merge into a separate program
  rebase: turn rebase--interactive into a separate program
  rebase: remove unused function
  rebase: move resolvemsg to rebase--* scripts
  Build in rebase

 Makefile                                |   8 +-
 builtin.h                               |   1 +
 builtin/blame.c                         |   4 +-
 builtin/checkout.c                      |  40 +-
 builtin/commit.c                        |  16 +-
 builtin/merge.c                         |  32 +-
 builtin/notes.c                         |   4 +-
 builtin/rebase.c (new)                  | 752 ++++++++++++++++++++++++=
++++++++
 builtin/tag.c                           |   7 +-
 commit.c                                |   4 +-
 commit.h                                |   4 +-
 contrib/examples/git-rebase.sh (new +x) | 532 ++++++++++++++++++++++
 git-rebase--am.sh (mode +x)             |  39 ++
 git-rebase--interactive.sh (mode +x)    |  41 +-
 git-rebase--merge.sh (mode +x)          |  39 ++
 git-rebase.sh (gone)                    | 544 -----------------------
 git.c                                   |   1 +
 strbuf.c                                |   8 +
 strbuf.h                                |   1 +
 unpack-trees.c                          |  33 ++
 unpack-trees.h                          |   4 +
 21 files changed, 1480 insertions(+), 634 deletions(-)
 create mode 100644 builtin/rebase.c
 create mode 100755 contrib/examples/git-rebase.sh
 mode change 100644 =3D> 100755 git-rebase--am.sh
 mode change 100644 =3D> 100755 git-rebase--interactive.sh
 mode change 100644 =3D> 100755 git-rebase--merge.sh
 delete mode 100755 git-rebase.sh

--=20
2.3.0.rc1.137.g477eb31
