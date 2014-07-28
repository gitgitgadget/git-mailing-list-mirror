From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/9] Speed up cache loading time
Date: Mon, 28 Jul 2014 19:03:06 +0700
Message-ID: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 14:03:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjei-0002om-LR
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 14:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbaG1MDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 08:03:49 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:57356 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaG1MDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 08:03:48 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so10278796pad.23
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Cews5/xlqytB+7mgmCFNyCTDngIqjdkLJZEtU2w22p8=;
        b=ejWqi9V7hFSqt4Djtl2VMZAYJayAC9oCasgITnVIZ/O63+j8D60RilKQYXQK306pVw
         9hqbZecawsplROfrilHa55bnNqi4bjTpnzGOudwV2UHpNgXYojnt9IwSUp5iHvje8UOD
         TgcwfzfcUPzEQ+d9bkcQ2ofOiDzALY1m8NjXvEfJQiZ+OgfU7CLNUzgncIrWU5jw7XYY
         1/vKRy3c4uNud2lUpOqWENBOnAYz+x5qViYkVpwxgobED2mb3S3/jef5Vezim8igCZgg
         YFmr6TlLqk9NFEf9a0ZiWzwCnpyO+jCTxZlAkXpS64NedhWJsyumkJz27amURzRRGmcW
         5Hbg==
X-Received: by 10.66.100.170 with SMTP id ez10mr2696893pab.12.1406549027567;
        Mon, 28 Jul 2014 05:03:47 -0700 (PDT)
Received: from lanh ([115.73.211.176])
        by mx.google.com with ESMTPSA id y1sm17457831pbw.87.2014.07.28.05.03.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 05:03:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Jul 2014 19:03:49 +0700
X-Mailer: git-send-email 2.1.0.rc0.66.gb9187ad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254314>

This is the polished version of v2 [1], rebased on master (now that
split-index has graduated). I wanted to add some tests, but can't
think of any way to do it (at least it won't work on Windows).
Although with --strict turned on by default, it's less likely that
bugs in index-helper could propagate far.

[1] http://article.gmane.org/gmane.comp.version-control.git/251186

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  trace.c: add GIT_TRACE_PACK_STATS for pack usage statistics
  read-cache.c: fix constness of verify_hdr()
  read-cache: allow to keep mmap'd memory after reading
  index-helper: new daemon for caching index and related stuff
  trace.c: add GIT_TRACE_INDEX_STATS for index  statistics
  index-helper: add --strict
  daemonize(): set a flag before exiting the main process
  index-helper: add --detach
  index-helper: add Windows support

 .gitignore                               |   1 +
 Documentation/git-index-helper.txt (new) |  56 +++++++
 Documentation/git.txt                    |   4 +
 Makefile                                 |   9 ++
 builtin/gc.c                             |   2 +-
 cache.h                                  |  11 +-
 config.mak.uname                         |   3 +
 daemon.c                                 |   2 +-
 git-compat-util.h                        |   1 +
 git.c                                    |   1 +
 index-helper.c (new)                     | 258 +++++++++++++++++++++++=
++++++++
 read-cache.c                             | 119 +++++++++++++-
 setup.c                                  |   4 +-
 sha1_file.c                              |  24 +++
 shm.c (new)                              | 163 +++++++++++++++++++
 shm.h (new)                              |  23 +++
 trace.c                                  |  16 ++
 trace.h                                  |   1 +
 18 files changed, 686 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h

--=20
2.1.0.rc0.66.gb9187ad
