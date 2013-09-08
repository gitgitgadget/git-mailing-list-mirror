From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/11] pack v4 support in pack-objects
Date: Sun,  8 Sep 2013 22:04:09 +0700
Message-ID: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:01:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgUZ-00033p-Qb
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab3IHPBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:01:23 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:42734 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab3IHPBX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:01:23 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so5085484pbb.20
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P2/mKczg2omtekgXph2qlIkdQV5b4o2knvVA9TDbBE4=;
        b=Geftr6E+sqbYjXT1bqzMEpvhLwmxTZXH436dHzOL6IVs9YE8AuVcEY0VUDGJ0bqqrv
         zhhSweBDkTvMgdd4+TNCvKAwgawKPS7u6tPHE8oGT3rBGgkFftBLBgQFaGBMRz9h2cmV
         MsOLw3LaQLTMyq9NSBpsJpI8VxrPGWYcwor2APjzzEAGp8SBtg5G6p7U/1a8rm3CIVRA
         1GzzI8UQR1LRqR1YqFIPy4adtGOrOK+1oNVOuWjOOATx/R2eHN2WVXBgEvwq6B/kameU
         8JRdAW71sCsNaVUzztGcd2fzqWRyYJ0mugomBTRQfAKLqHPs6VWpA4H7mALESD1hYdlT
         +z9A==
X-Received: by 10.68.130.104 with SMTP id od8mr14022671pbb.29.1378652482642;
        Sun, 08 Sep 2013 08:01:22 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id lm2sm11472807pab.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:01:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:04:30 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234239>

I can produce pack v4 on git.git with this and verify it with
index-pack. I'm not familiar with pack-objects code and not really
confident with my changes. Suggestions are welcome.

Also I chose to keep packv4-create.c in libgit.a and move test code
out to test-packv4.c. Not sure if it's good decision. The other option
is to copy necessary code to pack-objects.c, then delete
packv4-create.c in the end. Either way we have the same amount of code
move.

Thin pack support is not there yet, but it should be simple on
pack-objects' end. Like the compatibility layer you added to
sha1_file.c, this code does not take advantage of v4 as source packs
(performance regressions entail) A lot of rooms for improvements.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
  pack v4: allocate dicts from the beginning
  pack v4: stop using static/global variables in packv4-create.c
  pack v4: move packv4-create.c to libgit.a
  pack v4: add version argument to write_pack_header
  pack-write.c: add pv4_encode_in_pack_object_header
  pack-objects: add --version to specify written pack version
  list-objects.c: add show_tree_entry callback to traverse_commit_list
  pack-objects: create pack v4 tables
  pack-objects: do not cache delta for v4 trees
  pack-objects: exclude commits out of delta objects in v4
  pack-objects: support writing pack v4

 Makefile               |   4 +-
 builtin/pack-objects.c | 187 +++++++++++++++--
 builtin/rev-list.c     |   4 +-
 bulk-checkin.c         |   2 +-
 list-objects.c         |   9 +-
 list-objects.h         |   3 +-
 pack-write.c           |  36 +++-
 pack.h                 |   6 +-
 packv4-create.c        | 534 ++++-------------------------------------=
--------
 packv4-create.h (new)  |  50 +++++
 test-packv4.c (new)    | 476 +++++++++++++++++++++++++++++++++++++++++=
++
 upload-pack.c          |   2 +-
 12 files changed, 789 insertions(+), 524 deletions(-)
 create mode 100644 packv4-create.h
 create mode 100644 test-packv4.c

--=20
1.8.2.83.gc99314b
