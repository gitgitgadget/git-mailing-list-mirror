From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 00/26] Git setup cleanup series
Date: Tue, 16 Feb 2010 23:04:51 +0700
Message-ID: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:38:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQQy-0002ZT-I4
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050Ab0BPQhu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:37:50 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:55172 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932578Ab0BPQhr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:37:47 -0500
Received: by gxk27 with SMTP id 27so119067gxk.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=wVi0aphgQgaWmB46LXp4U2+BXJLGe4Zdei9Fbwwtk/o=;
        b=rnkxTEgS4CHCpAOOAtSyFlgrnXOCnud1YiDBYhGV9skHw39KsBQEc76kU4ygmx5Rle
         rS5gciht5z63WuRwyJw/IT3/R+h3EpO9q/mVKjrHBBl793ZuRm/pSU7voOWuyazTwXWT
         OBMTCP17lKVk/E5rH5s9XWZi4GZ0H2DIPnS9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=vhTacaz01mOQcSLKOzrgU7j6Gy1Tg4KRIVUZoognsJoH06mapgnFMK3x+E0hWWTRr9
         fg297iO2rYUBdiWOOvOsXSU3vwXRLHJnRYm8z/drJnyVYRWvq4dPOwuo5bVO0Hdj7USP
         mI3RZ60pocr52wWl6SCYB8eR+ktNYUwkzj3tY=
Received: by 10.150.46.30 with SMTP id t30mr9379464ybt.286.1266336481517;
        Tue, 16 Feb 2010 08:08:01 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 22sm2869948ywh.30.2010.02.16.08.07.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:08:00 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:05:18 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140131>

This is the result of my "Remove .git auto detection from setup_git_env=
()"
patch [1]. Basically I make git behave differently (and correctly) when
GIT_HARDENED_SETUP=3D1 to smooth out the migration from the current mes=
sy setup
to a less messy setup. Eventually GIT_HARDENED_SETUP should be enabled =
by
default and the obsolete code removed, but we're far away from that.

Summary of changes:

 - startup_info struct is added to help move up setup_git_directory_gen=
tly()
   to run_builtin(), which reduces lots of headache.
 - GIT_HARDENED_SETUP=3D1 will make git die() whenever setup_git_env() =
is called
   from anywhere but setup_git_dir*. It also creates lots of segfault b=
ecause
   get_git_dir() and friends now can return NULL.
 - gitattr, gitexcludes will not access repository if there is no repos=
itory
 - enter_repo() will use setup_git_dir* to do the setup
 - because non-builtin commands do not have startup_info, they will beh=
ave
   just like before. I'll need to look at them.

Tests are lacking. But you can just try "GIT_HARDENED_SETUP=3D1 make te=
st"
after 04/26, then again at the end of the series to see the difference.
It'd be great if people see new failing tests. I'm not sure I have caug=
ht
them all.

[1] http://mid.gmane.org/1265370468-6147-1-git-send-email-pclouds@gmail=
=2Ecom

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (26):
  rev-parse --git-dir: print relative gitdir correctly
  setup_git_directory*: Explicitly set git dir
  Save setup_git_dir* info globally for later use
  Add GIT_HARDENED_SETUP to detect gitdir/worktree related mis-setup er=
rors
  enter_repo(): use setup_git_directory_gently internally
  Tweak init/clone to work properly with GIT_HARDENED_SETUP=3D1
  Support running setup_git_dir_gently() from the beginning for builtin=
 commands
  config: move up gitdir setup to run_builtin()
  hash-object: move gitdir setup to run_builtin()
  shortlog: move up gitdir setup to run_builtin()
  Do not look for .git/info/exclude when gitdir is not set up
  grep: move up gitdir setup to run_builtin()
  USE_PAGER should not be used without RUN_SETUP*
  Do not try to read $GIT_DIR/info/attributes if there is no repository
  archive: move up gitdir setup to run_builtin()
  mailinfo: move up gitdir setup to run_builtin()
  check-ref-format: setup gitdir gently
  verify-pack: set up gitdir gently
  apply: move up gitdir setup to run_builtin()
  bundle: move up gitdir setup to run_builtin()
  diff: move up gitdir setup to run_builtin()
  help: move up gitdir setup to run_builtin()
  ls-remote: move up gitdir setup to run_builtin()
  var: move up gitdir setup to run_builtin()
  merge-file: move up gitdir setup to run_builtin()
  Turn on GIT_HARDENED_SETUP for the whole test suite

 attr.c                  |    5 ++-
 builtin-apply.c         |   13 +++----
 builtin-archive.c       |    2 +-
 builtin-bundle.c        |    6 +--
 builtin-config.c        |   12 +++---
 builtin-diff.c          |    6 +--
 builtin-grep.c          |    9 ++---
 builtin-hash-object.c   |    9 +++--
 builtin-help.c          |    2 -
 builtin-init-db.c       |    4 ++
 builtin-ls-remote.c     |    3 --
 builtin-mailinfo.c      |    3 --
 builtin-merge-file.c    |    4 +--
 builtin-rev-parse.c     |    8 ++++
 builtin-shortlog.c      |    4 +--
 builtin-var.c           |    2 -
 cache.h                 |    8 ++++
 config.c                |   17 ++++++---
 dir.c                   |    8 +++--
 environment.c           |   43 +++++++++++++++++-----
 git.c                   |   88 +++++++++++++++++++++++++++++++--------=
--------
 path.c                  |    8 ++---
 setup.c                 |   48 ++++++++++++++++++++------
 t/t0024-crlf-archive.sh |    1 +
 t/t1302-repo-version.sh |    2 +-
 t/test-lib.sh           |    3 ++
 26 files changed, 204 insertions(+), 114 deletions(-)
