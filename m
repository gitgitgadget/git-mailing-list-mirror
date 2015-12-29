From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/20] More flexibility in making shallow clones
Date: Tue, 29 Dec 2015 19:10:23 +0700
Message-ID: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt7H-0005td-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbbL2MLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:11:00 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34657 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbL2MK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:10:58 -0500
Received: by mail-pf0-f174.google.com with SMTP id e65so74274748pfe.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=9UVd7aeJjUcnp8RHpYFQLcr1mXcyk0UJtOmYRpSa7+o=;
        b=EH6G4IYboj3t1C91RyJWUMrj7hNUA+mTvSatxw0C1KfgIZ9LrPDd0K8p5gN9S4MgHG
         xsD2U1fAORKmdr0YSlSe/gJ4L+X28EoljB2bczyhs/M8/VFHHAkFQfdLN5mBC3SpJzNQ
         oUQRX6ByC10RKZZHD0aZdzl8TjtbcJQvcnCuOlicU4Pr9SR2A9L2i8uefTFfi9tGHGH7
         +yMl83VxsAX8x94MqoOZjH0fcYuI4GA9jStjMHKId/NI6IUrHoWzP2BXNHYSOZDgrj+H
         kik5sYUOLSSWnpU0hjKia52fE+iUZCFXV5c/o++ZkXc9FrlykWfZ3bIvuj552Mme0cwd
         Vqlg==
X-Received: by 10.98.44.209 with SMTP id s200mr77581449pfs.2.1451391057552;
        Tue, 29 Dec 2015 04:10:57 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id p80sm58245031pfi.12.2015.12.29.04.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:10:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:10:52 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283110>

This series brings three new options to shallow clone/fetch. --since
lets you specify cut point by time. --not cuts by excluding specified
refs. And --deepen=3D<N> extends shallow boundary in a more predictable
way. Some of these were requested in the past.

An important point of this series is it starts to use rev-list behind
the scene to define shallow boundary, which opens doors to even more
ways of cutting a repository.

The series is good enough to look at but I don't think I have stared
long enough to spot all the bugs. This mail is mostly about checking
if the design (at both code and protocol levels) and the UI make
sense. I'm thinking --since and --not may be too generic, but I don't
see any better names, for example.

Refactor/cleanup patches are sprinkled throughout (bad?). The meat is
in 05, 09, 12, 13, 16, 17, 18 and 20.

HTTP support is not in this series (and I don't intend to do soon).
The amount of filler code just to pass some info from UI down to the
protocol seems too much, and it's even more so when HTTP support is
added. But I don't see anyway around it. Maybe we can share some code
between git-clone, git-fetch and git-fetch-pack, at least the argument
parsing..

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (20):
  upload-pack: move shallow deepen code out of receive_needs()
  upload-pack: move "shallow" sending code out of deepen()
  upload-pack: remove unused variable "backup"
  upload-pack: move "unshallow" sending code out of deepen()
  shallow.c: implement a generic shallow boundary finder based on rev-l=
ist
  upload-pack: glue code to use get_shallow_commits_by_rev_list
  upload-pack: use skip_prefix() instead of starts_with() when possible
  upload-pack: tighten number parsing at "deepen" lines
  upload-pack: add deepen-since to cut shallow repos based on time
  fetch-pack: use a common function for verbose printing
  fetch-pack: use a separate flag for fetch in deepening mode
  fetch: define shallow boundary with --since
  clone: define shallow clone boundary based on time with --since
  Add test_repo_expect_success for running tests in a new repository
  t5500: test for shallow depth since a specific date
  upload-pack: support define shallow boundary by excluding revisions
  fetch: define shallow boundary with --not
  clone: define shallow clone boundary with --not
  t5500: test for shallow depth excluding a ref
  fetch: add --deepen=3D<N> to extend shallow boundary by <N> commits

 Documentation/fetch-options.txt                   |  14 ++
 Documentation/git-clone.txt                       |   8 +
 Documentation/technical/pack-protocol.txt         |   4 +-
 Documentation/technical/protocol-capabilities.txt |  25 +++
 builtin/clone.c                                   |  32 +++-
 builtin/fetch.c                                   |  44 ++++-
 commit.h                                          |   2 +
 fetch-pack.c                                      | 128 ++++++++------
 fetch-pack.h                                      |   4 +
 shallow.c                                         |  92 ++++++++++
 t/README                                          |  15 ++
 t/t5500-fetch-pack.sh                             |  36 ++++
 t/t5510-fetch.sh                                  |  12 ++
 t/test-lib-functions.sh                           |  20 +++
 transport.c                                       |  11 ++
 transport.h                                       |  14 ++
 upload-pack.c                                     | 206 ++++++++++++++=
++------
 17 files changed, 550 insertions(+), 117 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
