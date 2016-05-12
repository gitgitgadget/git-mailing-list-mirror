From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 00/20] index-helper/watchman
Date: Thu, 12 May 2016 16:19:55 -0400
Message-ID: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6z-0005fv-CJ
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbcELUUZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 16:20:25 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36103 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbcELUUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:21 -0400
Received: by mail-io0-f169.google.com with SMTP id i75so103980452ioa.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKmvP/rVClZAu+/lGowc+RWsCo0luStFzUkD3FrLHZ8=;
        b=QU3DrZ0g3GmNuk3c3aYKCCdU1JXtCJDWTV0YsToTfaHKM+qfqAi55RINauHHw0xuUt
         66+Y3LTSoLhu0t+3E2q4t28LO0/4YvHbZPucSWQE6aFLh1qvD77su7CirS9LSFioKSjH
         7unxMwAE2NF/KTTc0eZ9iWqptj/P6d06jnFW/P/Qgr88zljdrUDFtvEngHHkGaq++DOh
         seYU4Hor1TdFf22OWMCvl2YUuOhCgrzeNcHmZHTL7HvQMyIG7hr49EJ2uUsjJ3SmSVX0
         dSIRgs9zQbkaJNY4rQ/m5i3HR/tMDd9RHGbzJQFDCHMCoW0gS+A4bg0rrKzjWxuIeEcu
         Toig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKmvP/rVClZAu+/lGowc+RWsCo0luStFzUkD3FrLHZ8=;
        b=dZRs2pudB5nAnWskPi1KQ8eGuhJAMowbm9cqqvrnjxd45iUq97uOWuUB0rxj5xkr4O
         ynCAAahQ7LST0Wg+PrzHIm/JTfiBZC9Hkj2vwrdKihECgqxQ9viTXSvAaUyN9UAANQjC
         ko0qoH+2iHaLX7rzpPUqWYhMiINpol9bvFVrs7ilYaDHOiJ/UJJOTWT0la9WbHl8mIcR
         yR71nLUABn8Q5odRKglRVqPPxjJXu3cSmIq4ffySscrpmFXs6KwlYjrlylYIZ7D9UETa
         ZqNO4WeA0lCtme1O7Q/1jl8gEalv93ApYzB9ed5Hs4CDwo8981xc4T/NHw+qoJt3/Wbt
         I+fA==
X-Gm-Message-State: AOPr4FUuxYK8AlFeKktcy7whjuaCjVqXRb3VXmXPekXC2BgCCqsmmvx7r6nWm9zxoXUPCw==
X-Received: by 10.107.159.84 with SMTP id i81mr8731196ioe.29.1463084420568;
        Thu, 12 May 2016 13:20:20 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294470>

packet_write was causing the sigpipes (by calling write_or_die, which
intentionally overrides the caller's preferences about signal handling)=
=2E

This version fixes that.  I didn't test on a virtual machine, but I did
test by adding a sleep().

David Turner (9):
  pkt-line: add gentle version of packet_write
  index-helper: log warnings
  unpack-trees: preserve index extensions
  watchman: add a config option to enable the extension
  index-helper: kill mode
  index-helper: don't run if already running
  index-helper: autorun mode
  index-helper: optionally automatically run
  untracked-cache: config option

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
  read-cache.c: fix constness of verify_hdr()
  read-cache: allow to keep mmap'd memory after reading
  index-helper: new daemon for caching index and related stuff
  index-helper: add --strict
  daemonize(): set a flag before exiting the main process
  index-helper: add --detach
  read-cache: add watchman 'WAMA' extension
  watchman: support watchman to reduce index refresh cost
  index-helper: use watchman to avoid refreshing index with lstat()
  update-index: enable/disable watchman support
  trace: measure where the time is spent in the index-heavy operations

 .gitignore                               |   2 +
 Documentation/config.txt                 |  12 +
 Documentation/git-index-helper.txt       |  81 +++++
 Documentation/git-update-index.txt       |   6 +
 Documentation/technical/index-format.txt |  22 ++
 Makefile                                 |  18 ++
 builtin/gc.c                             |   2 +-
 builtin/update-index.c                   |  16 +
 cache.h                                  |  25 +-
 config.c                                 |   5 +
 configure.ac                             |   8 +
 contrib/completion/git-completion.bash   |   1 +
 daemon.c                                 |   2 +-
 diff-lib.c                               |   4 +
 dir.c                                    |  25 +-
 dir.h                                    |   6 +
 environment.c                            |   3 +
 git-compat-util.h                        |   1 +
 index-helper.c                           | 486 +++++++++++++++++++++++=
+++++
 name-hash.c                              |   2 +
 pkt-line.c                               |  18 ++
 pkt-line.h                               |   2 +
 preload-index.c                          |   2 +
 read-cache.c                             | 536 +++++++++++++++++++++++=
+++++++-
 refs/files-backend.c                     |   2 +
 setup.c                                  |   4 +-
 t/t1701-watchman-extension.sh            |  37 +++
 t/t7063-status-untracked-cache.sh        |  22 ++
 t/t7900-index-helper.sh                  |  69 ++++
 t/test-lib-functions.sh                  |   4 +
 test-dump-watchman.c                     |  16 +
 unpack-trees.c                           |   1 +
 watchman-support.c                       | 135 ++++++++
 watchman-support.h                       |   7 +
 34 files changed, 1561 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100755 t/t1701-watchman-extension.sh
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 test-dump-watchman.c
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
