From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 00/11] read_directory() rewrite to support struct pathspec
Date: Mon, 24 Oct 2011 17:36:05 +1100
Message-ID: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:38:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIEAn-0000VD-5H
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab1JXGiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:38:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59080 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab1JXGiH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:38:07 -0400
Received: by ywm3 with SMTP id 3so1171021ywm.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=caGQ/w6gaOy09yud2hkUpK/k1+6PCQiMp3Mw7YcWSi8=;
        b=CtV1wTjZ1IAGaiDcudJ5xNIp262HUmVxvupG6vgZWYH2bq0NwWGIWqe/SbJnKvKZIO
         6YUTDjNOSsIwebClcCdijp/plj2LIMXwlig/uRDkj0IWB7jZgCo6NoCdOigPdYfTmY0R
         g+o1nOU+9VmqD8Pl7BVL34+jZstFgErloOA5k=
Received: by 10.236.77.131 with SMTP id d3mr31617485yhe.124.1319438286138;
        Sun, 23 Oct 2011 23:38:06 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id j25sm31196602yhm.12.2011.10.23.23.38.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:38:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:36:16 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184153>

This is the first time "make test" fully passes (*) for me, so it's
probably good enough for human eyes. Just heads up where this might
go.

A few points:

 - "git add --ignore-missing" is killed because I could not find an
   easy way to incorporate it to the new read_directory(). It looks
   like a hack to me, to expose .gitignore matching. Luckily no one
   except submodule seems to use it.

 - I chose to use tree_entry_interesting() instead of
   match_pathspec(). The former has more optimizations but requires a
   tree-based structure. So I have to read the whole directory in,
   re-construct a temporary tree object to make t_e_i() happy. I
   _think_ it does not impact performance with reasonable dir size.

 - there'll be more work to get rid of match_pathspec() calls after
   read_directory()/fill_directory(). I haven't got finished this part
   yet.

 - I really like to kill match_pathspec() so we only have one pathspec
   implementation instead of two now, but that may be real hard
   because of staged entries in index.

(*) t7012.7 fails but I think that's the test's fault.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
  Introduce "check-attr --excluded" as a replacement for "add --ignore-=
missing"
  notes-merge: use opendir/readdir instead of using read_directory()
  t5403: avoid doing "git add foo/bar" where foo/.git exists
  tree-walk.c: do not leak internal structure in tree_entry_len()
  symbolize return values of tree_entry_interesting()
  read_directory_recursive: reduce one indentation level
  tree_entry_interesting: make use of local pointer "item"
  tree-walk: mark useful pathspecs
  tree_entry_interesting: differentiate partial vs full match
  read-dir: stop using path_simplify code in favor of tree_entry_intere=
sting()
  dir.c: remove dead code after read_directory() rewrite

 Documentation/git-check-attr.txt |    4 +
 builtin/add.c                    |   36 ++--
 builtin/check-attr.c             |   26 +++
 builtin/grep.c                   |   11 +-
 builtin/pack-objects.c           |    2 +-
 cache.h                          |    1 +
 dir.c                            |  428 +++++++++++++++++++-----------=
--------
 dir.h                            |    8 +-
 git-submodule.sh                 |    2 +-
 list-objects.c                   |    9 +-
 notes-merge.c                    |   45 +++--
 t/t3700-add.sh                   |   19 --
 t/t5403-post-checkout-hook.sh    |   17 +-
 tree-diff.c                      |   19 +-
 tree-walk.c                      |   85 ++++----
 tree-walk.h                      |   19 ++-
 tree.c                           |   11 +-
 unpack-trees.c                   |    6 +-
 18 files changed, 394 insertions(+), 354 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
