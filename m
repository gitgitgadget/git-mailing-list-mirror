From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/6] inotify support
Date: Sun, 12 Jan 2014 18:03:36 +0700
Message-ID: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 12 11:58:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2Ike-0006ZV-Hh
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 11:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbaALK62 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jan 2014 05:58:28 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43599 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaALK60 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 05:58:26 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so6305134pdj.25
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 02:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=tVxZerUVHewymjqbGkV10wXOgCuLoQQSZx0MD+us8DM=;
        b=k3tAK+j9a9F1RHkWavRpwI/P5r3FLzjFyZxqJdqzlrTs+yeHiSV+6bhHwYrv/wRCTC
         PN51fwoTNxMyfXCgNlFvmOtzQCwmPymn8YNL0hDseSZ7V1Zm5V1vD6s4bX9tsyDnOMnh
         rPKufpEwnfLo+96Rr2uzM5nxrTTO5H2ehDo3XZJtSrH++xkbIAcbvoApT6+qcLPj9QIu
         ChPrrUgIqy+nLWnjpGDRjonLGA6kYkedCRzarKhfBpp71JM9XfHBY+QJDJqoDIwZcQRC
         dHotLPUjEyqpX8eIl5nMEHnu2xJBA9RygY4qz3U9uweio/tZvtTo4q317fv9C3feqUam
         eSMw==
X-Received: by 10.68.139.228 with SMTP id rb4mr22759444pbb.15.1389524306445;
        Sun, 12 Jan 2014 02:58:26 -0800 (PST)
Received: from lanh ([115.73.194.184])
        by mx.google.com with ESMTPSA id yd4sm30196738pbc.13.2014.01.12.02.58.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 Jan 2014 02:58:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 12 Jan 2014 18:03:43 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240339>

It's been 37 weeks since Robert Zeh's attempt to bring inotify support
to Git [1] and unless I missed some mails, no updates since. So here's
another attempt with my preferred approach (can't help it, playing
with your own ideas is more fun than improving other people's code)

To compare to Robert's approach:

- This one uses UNIX datagram socket. If I read its man page right,
  unix socket respects the containing directory's permission. Which
  means on normal repos, only the user process can access. On shared
  repos, multiple users can access it. This should work on Mac.
  Windows will need a different transport.

- The daemon is dumb. It passes the paths around and that's it.
  lstat() is done by git. If I design it right, there's should not be
  any race conditions that make git miss file updates.

- CE_VALID is reused to avoid mass changes (granted there's other
  neat ways as well). I quite like the idea of machine-controlled
  CE_VALID.

inotify support has the potential of reducing syscalls in
read_directory() as well. I wrote about using lstat() to reduce
readdir() a while back, if that's implemented then inotify will fit in
nicely.

This is just a proof of concept. I'm sure I haven't handled all error
cases very well. The first five patches show the protocol and git
side's changes. The last one fills inotify in.

[1] http://thread.gmane.org/gmane.comp.version-control.git/215820/focus=
=3D222278

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  read-cache: save trailing sha-1
  read-cache: new extension to mark what file is watched
  read-cache: connect to file watcher
  read-cache: get "updated" path list from file watcher
  read-cache: ask file watcher to watch files
  file-watcher: support inotify

 .gitignore           |   1 +
 Makefile             |   1 +
 cache.h              |   4 +
 config.mak.uname     |   1 +
 file-watcher.c (new) | 329 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 git-compat-util.h    |   5 +
 pkt-line.c           |   2 +-
 pkt-line.h           |   2 +
 read-cache.c         | 280 ++++++++++++++++++++++++++++++++++++++++++-
 wrapper.c            |  27 +++++
 10 files changed, 645 insertions(+), 7 deletions(-)
 create mode 100644 file-watcher.c

--=20
1.8.5.2.240.g8478abd
