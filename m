From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/10] Sparse checkout fixes and improvements
Date: Mon, 15 Nov 2010 17:36:40 +0700
Message-ID: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:38:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwS1-0001FT-1d
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab0KOKiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:38:11 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50556 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab0KOKiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:38:10 -0500
Received: by pwi9 with SMTP id 9so709809pwi.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=xGMkiJZbG4MirCA1lkVCMQYnHHFxEzuOE2elNrYDKRU=;
        b=qAv65g8pvUsP2mZHQAHDQC4X21uja8weXobobUlpmIsvpAyri7wJdoabEcIbxoeuGM
         ejBmID6NW9hbVIA9tNxDr95YWSKX2aqtdZzpbbymd2rikqQAxPkJfChBLU+H30Nh85lR
         VZF/frjHuz+0BUH8ZeGa0z6OEM1uX7yZEwAfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=m3MKykskfxYdwxC2ZbbRx63CWXp8sERDQunk5P8/WlXcdjiyLriwnXLUUGcFVpoHia
         qUW15cQqgeE/Jr0WqkoJ4sOT+z7OZCQWQolbSYSOjM/CiEpjUcbJEaZH99cdfYJrWPkr
         ooDC9wDBjKEtTAj6wRkt263h9DIPqenEOiwEo=
Received: by 10.142.161.11 with SMTP id j11mr4796575wfe.133.1289817489644;
        Mon, 15 Nov 2010 02:38:09 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id e14sm8574080wfg.20.2010.11.15.02.38.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:38:08 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:36:51 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161477>

The first part fixes the long standing t1011.7 and removes the
work around in excluded_from_list(). As a result, the
EXC_FLAG_MUSTBEDIR fix for sparse checkout [1] is no longer needed.

Another plus is that because the index is now traversed tree-alike,
when a directory is match, all its children does not need to be checked=
,
which could speed things up a bit.

[1] http://http://article.gmane.org/gmane.comp.version-control.git/1608=
92

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  add: do not rely on dtype being NULL behavior
  unpack-trees: move all skip-worktree check back to unpack_trees()
  unpack-trees: add function to update ce_flags based on sparse
    patterns
  unpack-trees: fix sparse checkout's "unable to match directories"
    fault


The second part is more experimental although I think it's good
change:

  unpack-trees: optimize full checkout case

The intention is that $GIT_DIR/info/sparse-checkout can be always-on.
But it should not impact performance when not really used.


  templates: add info/sparse-checkout

I should have done this long before. I did not notice it until recently=
=2E


  checkout: add -S to update sparse checkout
  checkout: add --full to fully populate working directory
  git-checkout.txt: mention of sparse checkout

These form a friendlier interface to update sparse checkout. Users need
not to dig deep in git-read-tree.txt just to use sparse checkout.
"git checkout -S" resembles "cleartool edcs", which makes sense to me.
Both edit a file (location "unknown" in clearcase case) and update
worktree after that.


  clean: support cleaning sparse checkout with -S

Sparse checkout does not prohibit you from checking out other parts of =
the
index. But you are pretty much left alone when doing so. This helps a b=
it.
Support "git clean -S -e" is possible with clear_ce_flags() from the fi=
rst
part of this series but I need to think a bit more.


 Documentation/git-checkout.txt       |   49 +++++++++
 Documentation/git-clean.txt          |    6 +-
 Documentation/git-read-tree.txt      |   18 +---
 builtin/add.c                        |    3 +-
 builtin/checkout.c                   |   59 +++++++++++-
 builtin/clean.c                      |   70 +++++++++++++
 cache.h                              |    1 +
 dir.c                                |    6 -
 t/t1011-read-tree-sparse-checkout.sh |   39 +++++++-
 t/t7301-clean-sparse.sh              |   92 +++++++++++++++++
 templates/info--sparse-checkout      |    4 +
 unpack-trees.c                       |  188 ++++++++++++++++++++++++++=
+++++---
 12 files changed, 490 insertions(+), 45 deletions(-)
 create mode 100755 t/t7301-clean-sparse.sh
 create mode 100644 templates/info--sparse-checkout

--=20
1.7.3.2.210.g045198
