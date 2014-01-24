From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/9] About the trailing slashes
Date: Fri, 24 Jan 2014 20:40:27 +0700
Message-ID: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pawel.sikora@agmk.net,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 14:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6gug-0004ss-5R
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 14:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbaAXNfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 08:35:07 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:37579 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaAXNfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 08:35:05 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so3268354pab.16
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RsHkUZkWko+lMI8oLI/hUMzoNz1py2DlU3FBAHOtoOk=;
        b=Rjgpwt4JgfR3mD2W6YojJgvtoaGRDD3lyZh3Wg4K6IqTveCGpV+hftxaMZMr+YPGYr
         LnbKwKK3zToE9QeOuCLGl2PlI8yOWmCTkNRx8CWHBvfRGjjRZnvOIcUPfETXN9Gi7WT7
         5nBjF95gbYlNWwYy7FXO+UdVrTH0Zx9/wEs4uURbyPGgaFozgUAfe7r9QEQ5LbcUYHty
         yQWI1FVZTsnfvtzTghoI93kUWEpZdWduLU/sc0BHNgaW1vfxxTbLOiMdXsxyeqax3XLw
         qJAxxFKSx5oBDsePAqCtoEWIymPNO2vvXwz/MpCLwc7nHQ6NdyhTfriGHsJ3ILnaaKd8
         cENQ==
X-Received: by 10.68.171.67 with SMTP id as3mr14158149pbc.105.1390570504468;
        Fri, 24 Jan 2014 05:35:04 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id tu3sm7749310pab.1.2014.01.24.05.35.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 05:35:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:40:38 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240999>

So this is the reroll that makes

  git diff HEAD submodule
  git diff HEAD submodule/

and

  git diff HEAD HEAD^ submodule
  git diff HEAD HEAD^ submodule/

behave the same way. The main patches are 04/09 and 09/09. The rest is
just refactoring and cleaning up.

While looking at this, I found a funny behavior of fill_directory.

  $ git init
  $ mkdir b
  $ >b/c
  $ >b/d
  $ git status b
  Untracked files:
          b/
  $ git status b/
  Untracked files:
          b/c b/d

Notice how the trailing slash produces different untracked listing.
This is because of common_prefix_len(). In the "b" case,
common_prefix_len() returns empty prefix, so read_directory reads top
directory, traverses through, reaches "b" and eventually calls
treat_directory() on it, which results in "b/" in the output.

In the "b/" case, common_prefix_len() found the prefix "b", so
read_directory() starts at "b" instead of b's parent.
treat_directory() is never called on "b" itself, which results in
"b/c" and "b/d".

I'm tempted to make it consistent, favoring "b/" output. But that
involves extra lstat, or reordering the complex read_directory() code.
This is probably very unusual case to pay attention to anyway.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  Convert some match_pathspec_depth() to ce_path_match()
  Convert some match_pathspec_depth() to dir_path_match()
  Rename match_pathspec_depth() to match_pathspec()
  dir.c: prepare match_pathspec_item for taking more flags
  match_pathspec: match pathspec "foo/" against directory "foo"
  Pass directory indicator to match_pathspec_item()
  clean: replace match_pathspec() with dir_path_match()
  clean: use cache_name_is_other()
  tree-walk.c: ignore trailing slash on submodule in
    tree_entry_interesting()

 builtin/add.c             |  3 +--
 builtin/checkout.c        |  3 +--
 builtin/clean.c           | 24 +++---------------------
 builtin/commit.c          |  2 +-
 builtin/grep.c            |  6 ++----
 builtin/ls-files.c        |  9 ++++++---
 builtin/ls-tree.c         |  2 +-
 builtin/rm.c              |  2 +-
 builtin/update-index.c    |  3 ++-
 cache.h                   |  2 --
 diff-lib.c                |  5 +++--
 dir.c                     | 40 ++++++++++++++++++++++++++-------------=
-
 dir.h                     | 24 +++++++++++++++++++++---
 pathspec.c                |  2 +-
 preload-index.c           |  3 ++-
 read-cache.c              |  8 +-------
 rerere.c                  |  4 ++--
 resolve-undo.c            |  2 +-
 revision.c                |  3 ++-
 t/t4010-diff-pathspec.sh  | 23 +++++++++++++++++++++++
 t/t6131-pathspec-icase.sh |  6 +++---
 tree-walk.c               |  2 +-
 wt-status.c               |  6 +++---
 23 files changed, 107 insertions(+), 77 deletions(-)

--=20
1.8.5.2.240.g8478abd
