From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 00/14] inotify support
Date: Fri, 17 Jan 2014 16:47:26 +0700
Message-ID: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:48:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4629-0001sS-1y
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbaAQJsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:48:09 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:63567 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaAQJsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:48:05 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so3882610pbc.12
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ekesxc2Y1dTOAzgMIKK6ZhwPiQzv41HmZYYU/pZxjXA=;
        b=V4VdF7197kR3Q2tyDRi7AAyB+0xexGh7iAEMxEr081PUdE/bFD0iSxiU6rWn2Ru2KD
         l4mOdQVXLTvznCcKCXOH1StSd2BMY41WL56iXcXUoEHKH3R9tUtQnnQK7Qia9uBgpSZX
         851VU07k06U1qS+iftrHclfe0WxiquaOuZKZKSSKsJMS6zhlAxnbOVvGZJ//C7msGo1M
         225IHci7dhu6t6q1UHeRD7CfhOeMV/7j2jA060w3Xx/Tud2wdcy4pz3AETgaEvyYGl0R
         uS4BH6dDXPMwAWz9iXcIs541OBwuil+0/I/LD/osLA3v5p55ukOFuDOQ+bZK73KuJ0p9
         vrGQ==
X-Received: by 10.68.88.161 with SMTP id bh1mr1005103pbb.49.1389952084426;
        Fri, 17 Jan 2014 01:48:04 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id j3sm21311661pbh.38.2014.01.17.01.48.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:48:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:47:58 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240581>

This is getting in better shape. Still wondering if the design is
right, so documentation, tests and some error cases are still
neglected. I have not addressed Jonathan's and Jeff's comments in this
reroll, but I haven't forgotten them yet. The test suite seems to be
fine when file-watcher is forced on with GIT_TEST_FORCE_WATCHER set..

Thomas, you were a proponent of per-user daemon last time. I agree
that is a better solution when you need to support submodules. So if
you have time, have a look and see if anything I did may prevent
per-user daemon changes later (hint, I have a few unfriendly exit() in
file-watcher.c). You also worked with inotify before maybe you can
help spot some mishandling too as I'm totally new to inotify.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (14):
  read-cache: save trailing sha-1
  read-cache: new extension to mark what file is watched
  read-cache: connect to file watcher
  read-cache: ask file watcher to watch files
  read-cache: put some limits on file watching
  read-cache: get modified file list from file watcher
  read-cache: add config to start file watcher automatically
  read-cache: add GIT_TEST_FORCE_WATCHER for testing
  file-watcher: add --shutdown and --log options
  file-watcher: automatically quit
  file-watcher: support inotify
  file-watcher: exit when cwd is gone
  pkt-line.c: increase buffer size to 8192
  t1301: exclude sockets from file permission check

 .gitignore               |   1 +
 Documentation/config.txt |  14 ++
 Makefile                 |   2 +
 cache.h                  |   8 +
 config.mak.uname         |   1 +
 file-watcher-lib.c (new) | 109 +++++++++++
 file-watcher-lib.h (new) |   9 +
 file-watcher.c (new)     | 483 +++++++++++++++++++++++++++++++++++++++=
++++++++
 git-compat-util.h        |   3 +
 pkt-line.c               |   4 +-
 pkt-line.h               |   2 +
 read-cache.c             | 338 ++++++++++++++++++++++++++++++++-
 t/t1301-shared-repo.sh   |   3 +-
 trace.c                  |   3 +-
 14 files changed, 969 insertions(+), 11 deletions(-)
 create mode 100644 file-watcher-lib.c
 create mode 100644 file-watcher-lib.h
 create mode 100644 file-watcher.c

--=20
1.8.5.1.208.g05b12ea
