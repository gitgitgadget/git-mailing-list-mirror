From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH 0/3] Improving performance of git clean
Date: Mon,  6 Apr 2015 13:48:21 +0200
Message-ID: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 13:51:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf5WF-0003MF-VG
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 13:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbbDFLsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 07:48:38 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35789 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbbDFLsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 07:48:37 -0400
Received: by lbbuc2 with SMTP id uc2so14597125lbb.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=kiVpaOnDxHHHSXr0fHrcLsfbGF073v0ldf140Wp7pZg=;
        b=KAwGlxlZjmk1cnMMyIkcdszeCf7oir+Rtl/s/pGr3WRulMZqMri6sCP3s2+M6UYMZr
         df2eLNqleg6y10QqBtsLv4NqJAOYYAX1BAjLldnmZUseKOn/yovZ4DRSDpuvkEfLfcX/
         xv8slmTLq4prKnzoWsZu9Yd6dtzke1oXCg1ecIqDctBRSCYs+qf+qRdYCCVv0lyPR49y
         VrRk893bw+Iy8GZuIFttLEsOlP/uGnePOfHS6tCaZIesOIAgmLIxC25yMJO/xQl/xcav
         3EcPiIijWGaT9iaBtIGNt1oks6yYvVjjyPc5R5Kqfgi330lltJal2BDBLRgqU15ef+uY
         2gNA==
X-Received: by 10.152.37.202 with SMTP id a10mr13653288lak.0.1428320916416;
        Mon, 06 Apr 2015 04:48:36 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id pd1sm933083lbc.9.2015.04.06.04.48.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Apr 2015 04:48:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc0.37.ga3b75b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266839>

This series addresses a performance issue of git clean previously
discussed here:
http://thread.gmane.org/gmane.comp.version-control.git/265560/focus=3D2=
65560
and here:
http://thread.gmane.org/gmane.comp.version-control.git/266777/focus=3D2=
66777

The issue manifests when trying to clean a large number of untracked
directories. In my case this scenario triggered by a test suite
running in the repository creating a directory for each test resulting
in a build directory with ~100000 sub directories that needs to be
cleaned. For some extreme cases, clean times of more than 1h have been
observed.

With this series, the time to clean an untracked directory containing
100000 sub directories goes from 61s to 1.7s.

The main change is to switch the repository check in
clean.c:remove_dirs from using refs.c:resolve_gitlink_ref to
setup.c:is_git_directory.

One potential issue that is_git_directory contains the following check:

	if (getenv(DB_ENVIRONMENT)) {
		if (access(getenv(DB_ENVIRONMENT), X_OK))
			return 0;
	}

I'm not sure how this will affect this usecase (checking for some
other nested git repo). Please give some thought to this when
reviewing.

Jeff King also expressed concerns that we may have similar performance
issues in other commands and that it could be good to unify these "is
this a repo?"-checks. This series only attempts to solve the git-clean
case.

Erik Elfstr=C3=B6m (3):
  t7300: add tests to document behavior of clean and nested git
  p7300: added performance tests for clean
  clean: improve performance when removing lots of directories

 builtin/clean.c       | 23 ++++++++++++---
 t/perf/p7300-clean.sh | 37 +++++++++++++++++++++++
 t/t7300-clean.sh      | 82 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 138 insertions(+), 4 deletions(-)
 create mode 100755 t/perf/p7300-clean.sh

--=20
2.4.0.rc0.37.ga3b75b3
