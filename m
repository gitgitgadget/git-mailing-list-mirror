From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/6] Gettext poison rework
Date: Fri, 24 Aug 2012 12:43:00 +0700
Message-ID: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 07:43:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4mgN-0008RN-6q
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 07:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab2HXFnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 01:43:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39005 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab2HXFnh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 01:43:37 -0400
Received: by pbbrr13 with SMTP id rr13so2795592pbb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 22:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=eMZSxwRGWvJHqFjXhek0VRTZdb3ufB/2meYG9b1DBgE=;
        b=m/2W5RAD+OJ5zFD/JxrKR+6W9BucRfUhr3V3oZahrPBmeJhV/+2XVoVoh4HVbeoF5w
         GNfFK4zRWWRpo3WVvoWzY9/i9j/CsL/0yMqR9CN/eD/0ffNRzDzwPlWZihrkFXhne5Ql
         +l6YawF9RdHpE7Xxs+HuMupaeQP3Y7kTISMXcRRSzQx+09R4yku7HJgw/CRIkLRDpSFv
         ZJwzsgTUuQm/WL/BjTJ0d2TttPzjJ0Q1z5BTDA5GbcrfHvN42CoHOVab3HKsEtTJj6od
         a8gcc4MycnyZ7+D88606YXW8BqpcPTmcbX6p/Qbj/c0+XU8H1OPwwXPl25NEP7sAAv5W
         WElQ==
Received: by 10.68.240.236 with SMTP id wd12mr10273405pbc.83.1345787015875;
        Thu, 23 Aug 2012 22:43:35 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id wh7sm7578935pbc.33.2012.08.23.22.43.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2012 22:43:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Aug 2012 12:43:15 +0700
X-Mailer: git-send-email 1.7.12.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204181>

Still WIP but I'm getting closer. I dropped test-poisongen and started
to use podebug [2] instead. Less code in git. podebug does not preserve
shell variables yet. I'll follow that up at upstream [1].

With this series, if you have translation toolkit installed, you could
do

    make pseudo-locale L=3D<your language code>
    make GETTEXT_POISON=3D$LANG test

podebug supports a few way of rewriting translations. Currently
"unicode" is used but you can change it via PODEBUG_OPTS

t9001 is not happy with $LANG !=3D C though. May need to add some
prereq there.

[1] http://bugs.locamotion.org/show_bug.cgi?id=3D2450
[2] http://translate.sourceforge.net/wiki/toolkit/podebug

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  Makefile: do not mark strings for l10n from test programs
  Makefile: recreate git.pot if *.sh or *.perl changes
  Replace gettext poison implementation with pseudotranslation
    generation
  Initialize gettext for test programs that may use it
  Support logging unmarked strings
  test-parse-options: mark parseopt help strings for pseudotranslation

 .gitignore                |  1 +
 Makefile                  | 48 +++++++++++++++++++++---------------
 gettext.c                 | 10 --------
 gettext.h                 | 10 +-------
 git-sh-i18n.sh            | 14 -----------
 po/.gitignore             |  1 +
 po/README                 | 15 +++++------
 t/.gitignore              |  1 +
 t/lib-gettext.sh          |  7 +++++-
 t/t0200-gettext-basic.sh  |  1 +
 t/t0205-gettext-poison.sh | 36 ---------------------------
 t/test-lib.sh             |  2 +-
 test-date.c               |  1 +
 test-delta.c              |  1 +
 test-dump-cache-tree.c    |  5 +++-
 test-index-version.c      |  1 +
 test-match-trees.c        |  1 +
 test-mergesort.c          |  1 +
 test-parse-options.c      | 63 ++++++++++++++++++++++++---------------=
--------
 test-path-utils.c         |  1 +
 test-revision-walking.c   |  1 +
 test-scrap-cache-tree.c   |  4 ++-
 test-sha1.c               |  1 +
 test-subprocess.c         |  1 +
 wrap-for-bin.sh           | 16 +++++++++++-
 25 files changed, 111 insertions(+), 132 deletions(-)
 delete mode 100755 t/t0205-gettext-poison.sh

--=20
1.7.12.rc2
