From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] Use watchman to reduce index refresh time
Date: Sun,  1 Nov 2015 14:55:41 +0100
Message-ID: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:56:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zst7A-0002CE-FG
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbbKAN4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:56:04 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34315 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbbKAN4B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:56:01 -0500
Received: by wmff134 with SMTP id f134so40704772wmf.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=4g+Olpdwk4ZIbcR5wbNYsqTmCMvEyo3n0JaAganQPMU=;
        b=OYHSZBcikWFZarhxoHOjR0z1/WXIi6fiQZRDqFvOFQsqfBAbgdbQ/wIHqY+eHhaKf+
         Uyd6rTQ4pbZiPnDiKbylUGA1j7gwkg5bIwAoSgK5ZM0mSIZtLiXB74kx5crR+4X6EvMz
         CrVkpSbgQpsRJn6pidmWji+k79zwA/SVLFsYmRbDQx1X7CYZVxhVKjM2Jid1U0UuegmE
         R+lO3jNm+vgsO9lwXuvrQSpF1KnBzltFvtOvtf0i6EK0KvTCaO9ieCGtLTKKvW1Voqkv
         pNzcij2s50Rd+Nx5enZyHvEySoLykcYD+/wJaG0FnVZ0p/VofvHng3QF/u1ILXkorgor
         IgQg==
X-Received: by 10.28.87.15 with SMTP id l15mr8721063wmb.66.1446386160339;
        Sun, 01 Nov 2015 05:56:00 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id bk2sm17185525wjc.3.2015.11.01.05.55.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:55:59 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280628>

This series builds on top of the index-helper series I just sent and
uses watchman to keep track of file changes in order to avoid lstat()
at refresh time. The series can also be found at [1]

When I started this work, watchman did not support Windows yet. It
does now, even if still experimental [2]. So Windows people, please
try it out if you have time.

To put all pieces so far together, we have split-index to reduce index
write time, untracked cache to reduce I/O as well as computation for
=2Egitignore, index-helper for index read time and this series for
lstat() at refresh time. The remaining piece is killing lstat() from
untracked cache, but right now it's just some idea and incomplete
code.

[1] https://github.com/pclouds/git/commits/refresh-with-watchman
[2] https://github.com/facebook/watchman/issues/19

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  read-cache: add watchman 'WAMA' extension
  Add watchman support to reduce index refresh cost
  read-cache: allow index-helper to prepare shm before git reads it
  index-helper: use watchman to avoid refreshing index with lstat()
  update-index: enable/disable watchman support

 Makefile                 |  12 +++++
 builtin/update-index.c   |  11 +++++
 cache.h                  |   7 +++
 config.c                 |   5 ++
 configure.ac             |   8 +++
 environment.c            |   3 ++
 index-helper.c           |  84 +++++++++++++++++++++++++++++--
 read-cache.c             | 126 +++++++++++++++++++++++++++++++++++++++=
+++++---
 watchman-support.c (new) | 108 +++++++++++++++++++++++++++++++++++++++=
+
 watchman-support.h (new) |   7 +++
 10 files changed, 361 insertions(+), 10 deletions(-)
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.2.0.513.g477eb31
