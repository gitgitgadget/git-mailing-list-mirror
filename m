From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/8] Speed up cache loading time
Date: Tue, 13 May 2014 18:15:27 +0700
Message-ID: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:15:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAgQ-0007g5-AD
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760292AbaEMLPh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:15:37 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:41875 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760083AbaEMLPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:15:34 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so160879pbc.24
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SIDeQ2SWfeNcMeUZdYCo0DgaJJ0GE81HX0WOqtOeq8M=;
        b=vwn1Z54WyR1Cl9KOxHD0ccjPL3f4hxMfFyieH6q3684RsEBXdXL+SPYYstSUNLOSLP
         2fps4ifLXT5QPq5MZMa5r4smZozBrUrhJ3TbjOZ9hmmeT7q+QrYArqn6bmCLruaBA2qs
         YgIUQrygfuFdtz7JE/EzVwol5HWVFM0JSng+muAWnoTY3V0kfMKY9f+gyoOzKIGgrRI2
         bI/WsfOfbJXRsWQ3e6zanhGk0xoJ2Hdu+VLv+p02EV2Ow1ymH/IaDGT4FsZp7NqYapwt
         SLctiYSaY5EhdExuaIsI8GhhhNdFAr0mLUsdkYEjGsqs1/EOA6I029FrWNFkbQRQgCSl
         nOLg==
X-Received: by 10.68.192.193 with SMTP id hi1mr4470095pbc.108.1399979734162;
        Tue, 13 May 2014 04:15:34 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id iv2sm27747111pbc.19.2014.05.13.04.15.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:15:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:15:39 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248760>

On Fri, May 9, 2014 at 5:27 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> The below patch implements such a daemon to cache the index. It takes
> 91ms and 377ms to load a 25MB index with and without the daemon. I us=
e
> share memory instead of pipe, but the format is still "on disk" not
> "in memory" for simplicity. I think we're good even without in memory
> format.

Here is a better version (on top of split-index). I duplicated webkit
index 8 times to get its size to 199MB (version 2), close to what
=46acebook tried last time [1]. read_cache() on index v2, v4, with the
daemon caching v2 and v4 respectively is 2994.861ms (199MB index
file), 2245.113ms (118MB) and 663.399ms and 880.935ms. The best number
is 4.5 times better the worst.

That is clocked at 800 MHz. A repository at this size deserves a
better CPU. At 2.5 GHz we spend 183.228ms on loading the index. A
reasonable number to me. If we scale other parts of git-status as well
as this, we should be able to make "git status" within 1 or 2 seconds.

The tested index does not have fully populated cache-tree so real
world numbers could be a bit higher.

[1] http://thread.gmane.org/gmane.comp.version-control.git/189776/focus=
=3D190156

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  read-cache: allow to keep mmap'd memory after reading
  unix-socket: stub impl. for platforms with no unix socket support
  daemonize: set a flag before exiting the main process
  Add read-cache--daemon for caching index and related stuff
  read-cache: try index data from shared memory
  read-cache--daemon: do not read index from shared memory
  read-cache: skip verifying trailing SHA-1 on cached index
  read-cache: inform the daemon that the index has been updated

 .gitignore                                     |   1 +
 Documentation/config.txt                       |   4 +
 Documentation/git-read-cache--daemon.txt (new) |  27 ++++
 Makefile                                       |   8 +
 builtin/gc.c                                   |   2 +-
 cache.h                                        |   7 +-
 config.c                                       |  12 ++
 config.mak.uname                               |   1 +
 daemon.c                                       |   2 +-
 environment.c                                  |   1 +
 read-cache--daemon.c (new)                     | 208 +++++++++++++++++=
++++++++
 read-cache.c                                   | 116 +++++++++++++-
 setup.c                                        |   4 +-
 submodule.c                                    |   1 +
 unix-socket.h                                  |  18 +++
 wrapper.c                                      |  14 ++
 16 files changed, 414 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/git-read-cache--daemon.txt
 create mode 100644 read-cache--daemon.c

--=20
1.9.1.346.ga2b5940
