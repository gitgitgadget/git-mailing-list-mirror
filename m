From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/8] Some object db protection when add_submodule_odb is used
Date: Tue, 30 Apr 2013 10:42:44 +0700
Message-ID: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 05:42:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1SI-0005bl-9v
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758576Ab3D3DmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 23:42:09 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:64301 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758543Ab3D3DmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:42:08 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so60209pde.9
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=GwfgU8qXLk/cyeWucq63VJR9uvIgZWJ1XlbknsGVKvo=;
        b=CS5ROdDan3E0+pcVF1GHJIDQrcxkkIIpjW+bvMKUk1sOozQEQybfdotPkKNajJxxmZ
         8xrZZPZzrJ654Pu5fc5I+Io/0DUedD2sn+Ei5jhZiAp+fX+xlCl4MY2mXl6XeYfAEoCd
         z0jI36PPPuU5+mqQw5Kk//T52NRSz7KZj5DZJuJYyQYa5exjC6T3X2Kq4wYBIqECWt58
         0ee6huTvdyJpTAaoENkmVoEbGkztTdjknbNGNdBd7z6zX6/Dwe9ziP/HTnYG+jE6afaS
         Rzk2/4aYXC7gU7cno9HlELCp74CzLnP2oJAcBlH6bmLO0YHhEYY5fcdxW+xaQwfMqcQh
         xkBg==
X-Received: by 10.66.7.138 with SMTP id j10mr49264287paa.221.1367293327689;
        Mon, 29 Apr 2013 20:42:07 -0700 (PDT)
Received: from lanh ([115.74.52.135])
        by mx.google.com with ESMTPSA id v5sm15106120pbz.4.2013.04.29.20.42.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 20:42:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 10:42:56 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222894>

The idea behind this series is, after add_submodule_odb, odb may have
new temporary objects that only appear after the call. These temporary
objects may lead to repo corruption (e.g. some new objects are created
and point to these temporary objects). This series attempts to catch
those cases. It would make it safer to dig deeper into submodule's odb,
e.g. to implement unified git-diff.

Previous approach [1] is record the odb source, then check if the
source is from submodule's odb. But that means we rely on the
lookup order in sha1_file.c. This approach instead allows the caller
to select what odb sources it wants to look up from.

The checks are also less drastic than before. Checks are now done at
higher level, e.g. commit_tree(), instead of at write_sha1_file,
because we do allow to write objects that point to nowhere.

Another new thing from previous round is I completely forbid the use
of add_submodule_odb in security sensitive commands like index-pack or
rev-list. We could loosen up later if we need to.

=46or fun, I set object_database_contaminated to 1 by default and ran
the test suite. It passed :)

[1] http://thread.gmane.org/gmane.comp.version-control.git/214412/focus=
=3D214417

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  sha1_file: allow to select pack origin when looking up an object
  sha1_file: keep track of alternate source of objects
  sha1_file: mark alt object database from add_submodule_odb()
  sha1_file: new object source for submodule's alt object database
  commit.c: refuse to write commits referring to external objects
  cache-tree.c: refuse to write trees referring to external objects
  mktag: refuse to write tags referring to external objects
  sha1_file: do write objects even if found in ODB_EXTALT database

 builtin/index-pack.c |   2 +-
 builtin/mktag.c      |   5 +-
 cache-tree.c         |   3 +-
 cache.h              |  38 +++++++--
 commit.c             |   9 ++
 environment.c        |   2 +
 fast-import.c        |   4 +-
 git.c                |  10 ++-
 pack-check.c         |   2 +-
 sha1_file.c          | 236 ++++++++++++++++++++++++++++++++++++-------=
--------
 streaming.c          |   4 +-
 submodule.c          |   5 +-
 12 files changed, 233 insertions(+), 87 deletions(-)

--=20
1.8.2.83.gc99314b
