From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH WIP 0/3] top-level gitignore considered less harmful
Date: Sat, 26 May 2012 19:31:11 +0700
Message-ID: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 14:35:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYGDP-0002uN-6l
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 14:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957Ab2EZMfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 08:35:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51511 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab2EZMfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 08:35:18 -0400
Received: by pbbrp8 with SMTP id rp8so2821580pbb.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=35OMk1/MYjccIFc4P8OP476Kw2FYAm2sKpl9Tq/qHgs=;
        b=YknDBr8kVVKhsHzzL3/nE6h7bqTsaCsrVSyKO2qNcEPSTvKNZr5zYB/bGlNeTPhH9V
         4jK6Vox5yAKFnQfz37xZ310l7HBmlddQNTFSsWCqT2owC4wsubXDNwA9mBFYfBSIDx3e
         h2kI0b7aZGZKTbgxyT5dc2aazQCx1wJ3lWauHCySHsezxpS/KhdghXtQKoEaarPcqHLX
         TNhtMHVMVvvmVdrtcQ8ajlJBubuJR+cZsYCHsaWym4U0mMTYkAHSEbp8cBxufEmJl9bo
         txIThc4V0Wi0JDS7gtXqim6o5GBM4VM+sJZtHvmRl5k9mMbxkR93b3iLValg9rELa3et
         AgPw==
Received: by 10.68.200.193 with SMTP id ju1mr6928531pbc.90.1338035717681;
        Sat, 26 May 2012 05:35:17 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.50.33])
        by mx.google.com with ESMTPS id ql3sm12409900pbc.72.2012.05.26.05.35.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 May 2012 05:35:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 26 May 2012 19:31:15 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198553>

While my mind is still fresh on exclude stuff, let's do something
to improve the big top-level gitignore situation [1].

The last patch is the real meat, where it assumes caller calls it on a
series of pathnames of the same dirname. It'll cache strcmp result of
the dirname part so we only pay the cost once per pattern for all
entries in the same directory.

The result is not so impressive (i'm on -O0 though). Old webkit.git,
before:

real    0m6.418s
user    0m5.561s
sys     0m0.827s

after:

real    0m5.262s
user    0m4.407s
sys     0m0.850s

We could approach the problem a different way instead: push back as
much dirname as possible back to "(struct exclude*)->base", but I'm
afraid that may mess thing up with all the pushing/popping in
prep_exclude.

Also about that, we should not need to call prep_exclude() on every
pathname, at least when the caller is {fill,read}_directory().

There's another optimaztion we could do to pay even less. If users
sort the exclude patterns, if we check dirname of one pattern and the
next pattern shares the same dirname, skip comparing what we have
compared again.

The same can be done on "base" (even easier because we can just
compare base pointer to know if they are the same) but "base" is for
non-top-level gitignore.

[1] http://thread.gmane.org/gmane.comp.version-control.git/194294

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  Unindent excluded_from_list()
  exclude: do strcmp as much as possible before fnmatch
  exclude: reduce computation cost on checking dirname in patterns

 dir.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++------------=
--------
 dir.h |   5 +-
 2 files changed, 120 insertions(+), 51 deletions(-)

--=20
1.7.10.2.549.g9354186
