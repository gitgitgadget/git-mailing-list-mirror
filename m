From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/8] wildmatch take 3
Date: Tue,  9 Oct 2012 10:08:59 +0700
Message-ID: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 05:09:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLQCE-0005yk-Ma
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 05:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab2JIDJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 23:09:16 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:49505 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab2JIDJP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 23:09:15 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1887286dak.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 20:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0vYT4Cf3kwqlU4DAW3VwP1Sgv3sJGu/NMUjGJHTAKFY=;
        b=J+wFdvyewM7MohmkvixolYTJSJzX1HOmInHsdAcssyGIcYD4LvvyTkpIABkEI2LnGP
         Q6rmL4ktfbrpvTMkmDawNNoUq2HwGza9IQxuc1xahuXwi6455+EA00hqlWb3VZnZDQ81
         AqRMfzvN20m/Vys21Idy20wpYb7P3KrtX6qEiJvQerPyFiFOnPzEfssQLjSdGWOPOWzg
         8SDThyUsRkAqso2VbTWHdxZXKnlInDymRztPd6pUkKEYUZXmlqZZyCP3KaHnH49vBF+l
         OUEZJDwSSGbtZTzHSETxUL4HI94+NaOdcadkAEEr6f3tG17wpGQRan8UTacp4EIGiPT6
         U9DQ==
Received: by 10.68.204.169 with SMTP id kz9mr59130605pbc.39.1349752154470;
        Mon, 08 Oct 2012 20:09:14 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id g1sm11807738paz.18.2012.10.08.20.09.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 20:09:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 09 Oct 2012 10:09:08 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207287>

Still experimental but the semantics is getting better, I think.
Please point out what you think still does not make sense. Quote from
the last patch:

  Two consecutive asterisks ("`**`") in patterns matched against
  full pathname may have special meaning:
 =20
   - A leading "`**`" followed by a slash means match in all
     directories. For example, "`**/foo`" matches file or directory
     "`foo`" anywhere, the same as pattern "`foo`". "**/foo/bar"
     matches file or directory "`bar`" anywhere that is directly
     under directory "`foo`".
 =20
   - A trailing "/**" matches everything inside. For example,
     "abc/**" is equivalent to "`/abc/`".
 =20
   - A slash followed by two consecutive asterisks then a slash
     matches zero or more directories. For example, "`a/**/b`"
     matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
 =20
   - Consecutive asterisks otherwise are treated like normal
     asterisk wildcards.

"abc/**" and "abc/*" are different in attr (the former matches all
files, the latter only files directly under abc) while they are the
same for ignore. I don't like these subtleties but I don't
think we have a choice unless we rework attr matching machinery.

Tests t3070.100 and .101 fail on some machine and not on other due to
(I guess) fnmatch behavior changes. Maybe we should fallback on
compat/fnmatch in such cases for consistent behavior.

There are problems with asciidoc and "`**/`" but that's not something
we need to care now.

On top of master (and a small conflict with nd/attr-match-optim-more)

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  Import wildmatch from rsync
  wildmatch: remove unnecessary functions
  Integrate wildmatch to git
  wildmatch: remove static variable force_lower_case
  wildmatch: fix case-insensitive matching
  wildmatch: adjust "**" behavior
  wildmatch: make /**/ match zero or more directories
  Support "**" wildcard in .gitignore and .gitattributes

 .gitignore                         |   1 +
 Documentation/gitignore.txt        |  19 +++
 Makefile                           |   3 +
 attr.c                             |   4 +-
 dir.c                              |   4 +-
 t/t0003-attributes.sh              |  38 ++++++
 t/t3001-ls-files-others-exclude.sh |  19 +++
 t/t3070-wildmatch.sh               | 184 ++++++++++++++++++++++++++++
 test-wildmatch.c                   |  14 +++
 wildmatch.c                        | 245 +++++++++++++++++++++++++++++=
++++++++
 wildmatch.h                        |   3 +
 11 files changed, 532 insertions(+), 2 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh
 create mode 100644 test-wildmatch.c
 create mode 100644 wildmatch.c
 create mode 100644 wildmatch.h

--=20
1.8.0.rc0.29.g1fdd78f
