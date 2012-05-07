From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 0/3] Support ignore rule "**" using wildmatch from rsync
Date: Mon,  7 May 2012 20:01:54 +0700
Message-ID: <1336395717-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 15:05:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRNdH-00088r-Up
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 15:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592Ab2EGNFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 09:05:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59871 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab2EGNFh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 09:05:37 -0400
Received: by dady13 with SMTP id y13so1231253dad.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=753ytHUkAfR//qjPXCiXMkG+EY7Z7+DV1wTELo5bC1c=;
        b=QmVjwY96ssH9f/NGjWadTRpRQJ9j0S6E6skPqVBAOiUYeJqNEcvJsGhcKFUVFc2zXV
         tvueho0S5txCZRDGrRINvD3DUCJ1sqx+qQi7UycD4o+RbVkYdmN0+hjr3AhurbaXjAYA
         boWz7ri8iLZ31oIaAb31ekYhw0LSmF0kKBYzc1PcXpKKnFRSWnyB/DU3mIEIcdHliH9q
         PeTUdI5ntCoIExaOnXHl7/dbRRBU8s5tqnrs8GFryY7U6Y95qXlVZG/K3x6wY8K/yBOC
         yftAMZ7iKvKac6rxM2tNJ4L/rZUcXJoTdk0jKcgX+TQQWgMIftczV1Zs16kNz4ViNOnX
         qbXg==
Received: by 10.68.134.228 with SMTP id pn4mr38015456pbb.78.1336395936785;
        Mon, 07 May 2012 06:05:36 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id kc7sm801080pbc.9.2012.05.07.06.05.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 06:05:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 07 May 2012 20:01:58 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197265>

I've been looking for something like this. Bash 4 has a similar
feature, but it's GPL-3. rsync is also GPL-3. Luckily this feature was
availble before the license change.

I'm not sure if we should import wildmatch just to support "**". It see=
ms
a nice and often requested feature. And the code looks more readable th=
an
compat/fnmatch, which is good since I don't think we can cherry pick
from (gpl3) upstream.

We would need to add case folding support or convert "abc" to
"[aA][bB][cC]". Performance vs fnmatch is another question but we
could switch to wildmatch only in the presence of "**" if wildmatch
perf sucks. Even pathspec may make use of this, thanks to pathspec
magic.

I have not looked carefully at it and this series is more like a proof
of concept than a candidate for 'pu'. Any comments in favor or oppose
this?

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  Import wildmatch from rsync
  Integrate wildmatch to git
  gitignore: support "**" with wildmatch()

 Makefile                       |    3 +
 compat/wildmatch.c             |  356 ++++++++++++++++++++++++++++++++=
++++++++
 compat/wildmatch.h             |    6 +
 dir.c                          |   20 ++-
 dir.h                          |    1 +
 t/t3070-wildmatch.sh           |   27 +++
 t/t3070-wildmatch/wildtest.txt |  165 +++++++++++++++++++
 test-wildmatch.c               |  162 ++++++++++++++++++
 8 files changed, 736 insertions(+), 4 deletions(-)
 create mode 100644 compat/wildmatch.c
 create mode 100644 compat/wildmatch.h
 create mode 100755 t/t3070-wildmatch.sh
 create mode 100644 t/t3070-wildmatch/wildtest.txt
 create mode 100644 test-wildmatch.c

--=20
1.7.8.36.g69ee2
