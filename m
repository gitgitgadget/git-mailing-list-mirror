From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/21] "struct pathspec" conversion
Date: Sun,  6 Jan 2013 13:20:47 +0700
Message-ID: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:21:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjbn-0007ID-JZ
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab3AFGVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:21:03 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:49712 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab3AFGVB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:21:01 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so8202965dak.28
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=hhXRwLVqDlIDNnPbxWK+NaNH8Hew/Z5W0TdmBVqJuI0=;
        b=UsPwu6CHbJBMy0tBxTYn/11nao8JFgJLTqV1AwYbV5sXkfaBd2hKpu0OB6SIPQc/Jq
         LPvOj9Smdzs42GUrUInrVC91zLSeRER9KZpyASXmrdAAMwuRqieo9PhU4+6Pql+B1jyF
         zTDMAsVNzy7+hxUzw/q5CNYuKtpMMgVP+uImXFzVb2t8240YofLjHvuA9nzS+q50QBEs
         o+Db5n4ptZGSkU7g76cOtIRIyhlDU/oul3B5LbCjAOWe6vwzRbTtHKHqz4Tyew/ptnmc
         AhMXuwMj6I8wnkS6sqXil8LHSkUGQJBvE0VwLRWvHl26T21FrgnQoyuhA7vP+ZBacyPV
         hW+w==
X-Received: by 10.68.238.106 with SMTP id vj10mr179237325pbc.40.1357453260909;
        Sat, 05 Jan 2013 22:21:00 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id qt3sm35290677pbb.32.2013.01.05.22.20.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:20:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:21:09 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212754>

This is another step towards the pathspec unification. This series
introduces a get_pathspec() alternative: parse_pathspec(). The new
function intializes struct pathspec directly. Many builtin commands
(except mv) are converted to use this function. As a result, struct
pathspec is used from the start for many commands.

The next step would be dealing with pathspec manipulation code blocks
that use "raw" field, init_pathspec or get_pathspec(). add.c, dir.c,
rm.c and mv.c are hot places. And perhaps move pathspec code from
dir.c and setup.c to pathspec.c after as/check-ignore enters "master".

This series shares a patch (the first one) with nd/pathspec-wildcard. I
put the patch in the series to avoid dependency.

This series also disables wildcards in the prefix part, but it's only
effective in combination with nd/pathspec-wildcard. And of course it's
not fully effective until all "raw" use is eliminated.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (21):
  pathspec: save the non-wildcard length part
  Add parse_pathspec() that converts cmdline args to struct pathspec
  pathspec: make sure the prefix part is wildcard-clean
  Export parse_pathspec() and convert some get_pathspec() calls
  clean: convert to use parse_pathspec
  commit: convert to use parse_pathspec
  status: convert to use parse_pathspec
  rerere: convert to use parse_pathspec
  checkout: convert to use parse_pathspec
  rm: convert to use parse_pathspec
  ls-files: convert to use parse_pathspec
  archive: convert to use parse_pathspec
  add: convert to use parse_pathspec
  Convert read_cache_preload() to take struct pathspec
  Convert unmerge_cache to take struct pathspec
  checkout: convert read_tree_some to take struct pathspec
  Convert report_path_error to take struct pathspec
  Convert refresh_index to take struct pathspec
  Convert {read,fill}_directory to take struct pathspec
  Convert add_files_to_cache to take struct pathspec
  Convert more init_pathspec() to parse_pathspec()

 archive.c              |  12 +++---
 archive.h              |   2 +-
 builtin/add.c          |  75 ++++++++++++++++++------------------
 builtin/checkout.c     |  37 ++++++++----------
 builtin/clean.c        |  20 +++++-----
 builtin/commit.c       |  35 +++++++++--------
 builtin/diff-files.c   |   2 +-
 builtin/diff-index.c   |   2 +-
 builtin/diff.c         |   4 +-
 builtin/grep.c         |   6 +--
 builtin/log.c          |   2 +-
 builtin/ls-files.c     |  64 +++++++++++--------------------
 builtin/ls-tree.c      |   4 +-
 builtin/rerere.c       |   6 +--
 builtin/rm.c           |  16 ++++----
 builtin/update-index.c |   3 +-
 cache.h                |  19 +++++++---
 diff-lib.c             |   2 +-
 dir.c                  |  38 ++++++++++++++-----
 dir.h                  |   5 ++-
 merge-recursive.c      |   2 +-
 preload-index.c        |  20 +++++-----
 read-cache.c           |   5 ++-
 rerere.c               |   6 +--
 rerere.h               |   4 +-
 resolve-undo.c         |   4 +-
 resolve-undo.h         |   2 +-
 revision.c             |   4 +-
 setup.c                | 101 +++++++++++++++++++++++++++++++++++++----=
--------
 tree-walk.c            |   4 +-
 tree.c                 |   4 +-
 tree.h                 |   2 +-
 wt-status.c            |  17 ++++-----
 wt-status.h            |   2 +-
 34 files changed, 291 insertions(+), 240 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df
