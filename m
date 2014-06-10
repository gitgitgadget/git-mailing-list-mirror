From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/5] Speed up cache loading time
Date: Tue, 10 Jun 2014 20:24:20 +0700
Message-ID: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 15:26:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuM4G-00040v-5P
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 15:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaFJN0U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 09:26:20 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:37153 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbaFJN0T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 09:26:19 -0400
Received: by mail-pa0-f54.google.com with SMTP id rd3so711736pab.27
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=bIYmcH0VVqoZbKuAE5zgAH8HTUqwyhWsHTDHtl1Eeh4=;
        b=UzsX75F7L+mEF+t3yZhVNwofvDW13bYv/DqX6ynlVzd27CyI0hzm2PIsRk8rllJsjR
         wCiMz+nl9KrkA4CmC7WWnbZoj37PBNb4Ri69E7LD6oxH2gyP+yyOG2hpc6JuPWZ7iSz3
         yDCkhy0j++J/+XUDIBUikvQUnrftZ3PghRhyY6qncT76KtkTJg+AqwcclPc/pVcVUoSO
         EWNCaBPckghPqnRFODZ3fkdzYBIUIKnSQlu5nMSk6dfsQc9pf4mQRd6QyGzFpzoRQ9z+
         Z6CbRNV1RQbe+qHio29S//3nqP3iY1lDbctgHIh2qIilZvTkb1w4PjLpoIdCpDK40EC9
         hO/A==
X-Received: by 10.68.125.228 with SMTP id mt4mr11955211pbb.55.1402406779258;
        Tue, 10 Jun 2014 06:26:19 -0700 (PDT)
Received: from lanh ([115.73.243.79])
        by mx.google.com with ESMTPSA id pb7sm13262125pac.10.2014.06.10.06.26.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jun 2014 06:26:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 Jun 2014 20:26:13 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251186>

Compared to v1 [1], this is like a new series

 - git-read-cache--daemon is renamed to git-index-helper (easier to
   guess what it's for)
 - simplified locking mechanism on shared memory
 - UNIX signals are used for notification instead of UNIX sockets
 - Windows support (only tested with wine)

I think I'm getting closer to something that can finally have a chance
of merging. Still don't know how to write tests for this though.

[1] http://thread.gmane.org/gmane.comp.version-control.git/247268/focus=
=3D248760

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  read-cache: allow to keep mmap'd memory after reading
  index-helper: new daemon for caching index and related stuff
  index-helper: add Windows support
  daemonize(): set a flag before exiting the main process
  index-helper: add --detach

 .gitignore                               |   1 +
 Documentation/git-index-helper.txt (new) |  26 ++++
 Makefile                                 |   7 ++
 builtin/gc.c                             |   2 +-
 cache.h                                  |   6 +-
 config.mak.uname                         |   3 +
 daemon.c                                 |   2 +-
 git-compat-util.h                        |   1 +
 index-helper.c (new)                     | 198 +++++++++++++++++++++++=
++++++++
 read-cache.c                             |  97 +++++++++++++--
 setup.c                                  |   4 +-
 shm.c (new)                              | 163 +++++++++++++++++++++++=
++
 shm.h (new)                              |  23 ++++
 13 files changed, 521 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h

--=20
1.9.1.346.ga2b5940
