From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/9] Reduce index load time
Date: Sun,  1 Nov 2015 14:42:40 +0100
Message-ID: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:49:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zst0V-0004iL-E5
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbbKANtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:49:11 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35957 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbbKANtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:49:10 -0500
Received: by wmec75 with SMTP id c75so41733646wme.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ctW1I+k79uM+aaO40TiS/mpLcGXXOSZ1EuTSuSidGY8=;
        b=bSeKEJSxtimxbtlIXSTLQJ9E23+0mOEr+kDA5XTfg8xeTSmh8fz5pBPAObG8VESywk
         jLoCBBkPVj3tywddqrahKJsrGMVh2vVPs7UARRXllWC95kiR3gUP/JoS1fPPwf9VriaV
         uuKstF/E6Fx9wgvZhOkzJF/h8sYD9fNeFrd73SsLw9FwBEtWhqcSUpfv2joaQoaaOF0L
         cQv2kOPb/OzK8ftmjvGHt1MIQvbVWyZwQL0h9CSOhtQpNQVWUPV5qgGS/JtG3cvHpPKI
         0VnfPRVfOcnTl46d6yVWkVbmkAIuXWZ3uk6mztq0SYw0z28w47jgyRs5+Mw8ziEqwwpr
         SnTA==
X-Received: by 10.28.212.70 with SMTP id l67mr8673884wmg.66.1446385406947;
        Sun, 01 Nov 2015 05:43:26 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id gd10sm17058028wjb.47.2015.11.01.05.43.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:43:25 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280626>

This is the rebased version since last time [1] with
s/free_index_shm/release_index_shm/ as suggested by David Turner. It
introduces a daemon that can cache index data in memory so that
subsequent git processes can avoid reading (and more importantly,
verifying) the index from disk. Together with split-index it should
keep index I/O cost down to minimum. The series can also be found at
[2].

One of the factors that affected my design was Windows support. We
now have Dscho back, he can evaluate my approach for Windows.

This daemon is the foundation for watchman support later to reduce
refresh time. To be posted shortly after this.

[0] http://mid.gmane.org/1406548995-28549-1-git-send-email-pclouds@gmai=
l.com
[2] http://github.com/pclouds/git/commits/index-helper

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
 cache.h                                  |  12 +-
 config.mak.uname                         |   3 +
 daemon.c                                 |   2 +-
 git-compat-util.h                        |   1 +
 git.c                                    |   1 +
 index-helper.c (new)                     | 264 +++++++++++++++++++++++=
++++++++
 read-cache.c                             | 147 ++++++++++++++++-
 setup.c                                  |   4 +-
 sha1_file.c                              |  24 +++
 shm.c (new)                              | 163 +++++++++++++++++++
 shm.h (new)                              |  23 +++
 trace.c                                  |  16 ++
 trace.h                                  |   1 +
 18 files changed, 721 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h

--=20
2.2.0.513.g477eb31
