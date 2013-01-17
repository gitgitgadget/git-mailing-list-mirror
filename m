From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 4/8] git_remote_helpers: use 2to3 if building with Python 3
Date: Thu, 17 Jan 2013 18:53:57 +0000
Message-ID: <bcef80fb913ca829bd2d08284e364ebd55b7297e.1358448207.git.john@keeping.me.uk>
References: <cover.1358448207.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:56:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvudh-0004yl-3a
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 19:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab3AQS4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 13:56:16 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:56440 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3AQS4P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 13:56:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 48E68CDA56C;
	Thu, 17 Jan 2013 18:56:15 +0000 (GMT)
X-Quarantine-ID: <3uxXwJGnUUO9>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3uxXwJGnUUO9; Thu, 17 Jan 2013 18:56:09 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by jackal.aluminati.org (Postfix) with ESMTP id 9AA13CDA5BC;
	Thu, 17 Jan 2013 18:56:09 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 78D95276DFE;
	Thu, 17 Jan 2013 18:56:09 +0000 (GMT)
X-Quarantine-ID: <GODg7WKDl09K>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GODg7WKDl09K; Thu, 17 Jan 2013 18:56:09 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 168EA276DFB;
	Thu, 17 Jan 2013 18:55:54 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213866>

Using the approach detailed on the Python wiki[1], run 2to3 on the code
as part of the build if building with Python 3.

The code itself requires no changes to convert cleanly.

[1] http://wiki.python.org/moin/PortingPythonToPy3k

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git_remote_helpers/setup.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git_remote_helpers/setup.py b/git_remote_helpers/setup.py
index 4d434b6..6de41de 100644
--- a/git_remote_helpers/setup.py
+++ b/git_remote_helpers/setup.py
@@ -4,6 +4,15 @@
 
 from distutils.core import setup
 
+# If building under Python3 we need to run 2to3 on the code, do this by
+# trying to import distutils' 2to3 builder, which is only available in
+# Python3.
+try:
+    from distutils.command.build_py import build_py_2to3 as build_py
+except ImportError:
+    # 2.x
+    from distutils.command.build_py import build_py
+
 setup(
     name = 'git_remote_helpers',
     version = '0.1.0',
@@ -14,4 +23,5 @@ setup(
     url = 'http://www.git-scm.com/',
     package_dir = {'git_remote_helpers': ''},
     packages = ['git_remote_helpers', 'git_remote_helpers.git'],
+    cmdclass = {'build_py': build_py},
 )
-- 
1.8.1.1.260.g99b33f4.dirty
