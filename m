From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/8] fnmatch replacement step 1
Date: Sat, 22 Dec 2012 14:57:00 +0700
Message-ID: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 08:58:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmJy9-0008UB-Ll
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 08:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab2LVH5U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2012 02:57:20 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:32795 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab2LVH5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 02:57:19 -0500
Received: by mail-pb0-f43.google.com with SMTP id um15so3144342pbc.2
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 23:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=XqlbjYpugO4Mbqwjvivjza3uPlzyCx/PB5PH1m9Q2/U=;
        b=uXS/tHQIkZXIIf/UKQQbVqp3ERNQp1cG3hhmP64SvDjKadiUflKC1FYxjcNio5Jsv0
         13GY1ZvpfVZZBNJv0Vefas/P7eWzO3quhuLE4hlVhWUNNYUo8QSiu/8WKAJ3peP/V0Q5
         p0sB2k0gbvi2iqVu4BjZKEgJf/CU3ShF0lWexbXuDze9WygoJjeJb2c4kqDr34tAx0rZ
         nDfff+JrrQ8bX5kFbNq26m+dMZpwkYxb37o9MsUeZJfEjCbMh3FezG1mfpGoBXBhWE4x
         fvVTTOKcQ0WSKkiJyT+epQUb0Ol2ccQhp+C32il7StlkzJ55iltPGB987iwjTNu8OCfy
         q4Fg==
X-Received: by 10.68.137.234 with SMTP id ql10mr46543570pbb.158.1356163036474;
        Fri, 21 Dec 2012 23:57:16 -0800 (PST)
Received: from lanh ([115.74.46.73])
        by mx.google.com with ESMTPS id gq10sm8420817pbc.54.2012.12.21.23.57.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 23:57:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Dec 2012 14:57:11 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212028>

This series makes wildmatch compatible with fnmatch, at least for
=46NM_CASEFOLD and FNM_PATHNAME. This makes it possible to use wildmatc=
h
as a fnmatch replacement. The replacement is optional and turned on via
USE_WILDMATCH.

Step 2 would be turn USE_WILDMATCH by default and remove
compat/fnmatch. We can leave it for now until we are certain we don't
introduce any kind of regressions.

Measurement is performed to see how wildmatch compete with
fnmatch(es). I was surprised that my glibc version is even slower than
compat/fnmatch. For more details, see 5/8. wildmatch is faster (about
20%) in most cases. It is slower in '*/*/*' tests both with and without
=46NM_PATHNAME. 7/8 and 8/8 fix that, making wildmatch fastest in all
(tested) cases.

I'd appreciate if people test it with more patterns (both weird and
commonly used) against different fnmatch versions and turn on
USE_WILDMATCH to see if we need to fix something else, both correctness
and performance. So far I'm convinced that the replacement is a good
thing to do.

The series requires nd/wildmatch, obviously.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  compat/fnmatch: respect NO_FNMATCH* even on glibc
  wildmatch: rename constants and update prototype
  wildmatch: make dowild() take arbitrary flags
  wildmatch: support "no FNM_PATHNAME" mode
  test-wildmatch: add "perf" command to compare wildmatch and fnmatch
  Makefile: add USE_WILDMATCH to use wildmatch as fnmatch
  wildmatch: make a special case for "*/" with FNM_PATHNAME
  wildmatch: advance faster in <asterisk> + <literal> patterns

 Makefile                 |   6 +++
 compat/fnmatch/fnmatch.c |   3 +-
 dir.c                    |   3 +-
 git-compat-util.h        |  13 +++++
 t/t3070-wildmatch.sh     |  27 ++++++++++
 test-wildmatch.c         |  82 +++++++++++++++++++++++++++-
 wildmatch.c              | 137 +++++++++++++++++++++++++++++----------=
--------
 wildmatch.h              |  23 +++++---
 8 files changed, 232 insertions(+), 62 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df
