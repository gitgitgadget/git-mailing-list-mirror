From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/4] compat/basename: make basename() conform to POSIX
Date: Mon, 11 Jan 2016 19:29:54 +0100 (CET)
Message-ID: <00c89c7a9fdadbc1631715af7f84b38448fdd315.1452536924.git.johannes.schindelin@gmx.de>
References: <cover.1452270051.git.johannes.schindelin@gmx.de> <cover.1452536924.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:30:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIhEM-00087p-OT
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933346AbcAKSaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:30:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:54682 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933244AbcAKSaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:30:06 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MAyZg-1aSYa01URg-009wxZ; Mon, 11 Jan 2016 19:29:56
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452536924.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:2cA7HLKO9XdR0+QDxKGJvRqen/dX3Q6KuhoUfhcf3jCzUcGDhgF
 CVmsCvdYBQjYgzNOlNjB48GmGXtXqBTDIll3BIXijO9arYRaoOiVmfQM7IDizBT2PE+JN7A
 OzAffOGf2E+QGYpC0ZlIPxLcl+Gj0R/lrSgvrw+yNY2OlhPZu55apz+AJNFEUroqKjSL6DO
 4a2WK5NQYaQXXXZMhzywg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fACWI3Ixysw=:THs5tQt7q+nIYjllOk61An
 0nXvH0Qc/gRC/5+kl2j/O9I+87SPolcV/ztBfCIPuInDv03UiD58Se88lOEDBNXpnbCvaVXPi
 5Nzqp5YHDZ8HTQm3Nhpds6Z7Kg4MzIF7qjnABBx1SW5HBUtiYXyjoXteKa/10sFdHiL2nS2At
 d8y77WZ6/MTRTP9VlaPo/xlHEmUCtcBc5f1K/KDiFp1XvbjhxXiisNNgX9ZJrnXB8znwTU4oD
 uBNlxh4QMGeCCmcCZ2MPUT29IDq3Rfbp3DQW3DdOb8rQbVEBXVg7qjDFtpVBHdHFtj6kEb4yv
 LOjV3DkMk/j4eIbQStkcFS8vn08Gdg6cImmaurst70EmbG4Y/CtbZv0H+RgXtoZPS8wpaPyc1
 8zK28oz2l4w/pIRZMWaMp+3Shjr66Ijac/Lt6Gk3f0M027YEOja1JxMk5lpQIITAGm+9jXSGR
 mG9LafesuHpBwP3gB8LtXQhKl/oRuNI/rqQB7OOLATF8aDPldfteKWAoCt5bd5PGjNz4pLGhE
 MMSpxAlsDoutQaBgvsDg6ljWCtDWfnMLlwofBH+59f3igWKlMf9PceCsrydv3y5/Y3KPVwhEn
 nYCbo9adTmJDU3AtAtEoOpNRWhVqFYwdnCo5bNiz2IGtq9ZXpTcpbsWrR4iA46nzTOwNytAv2
 NlFSoWKIb6TXj1xDRX1zHYbQYa8uDXSi4WHkE6QSZCXpVheTzpYAgc0Ygw/aVKcw5bt4urvd/
 IGE/8JxyYmXF4TV9ICGkObz2CiOoM6lUoRVI/4VY6LGvk+gZ9lbw+G1spTdhFqrP0fWGFdom 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283691>

According to POSIX, basename("/path/") should return "path", not
"path/". Likewise, basename(NULL) and basename("") should both
return "." to conform.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/basename.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/compat/basename.c b/compat/basename.c
index 9f00421..0f1b0b0 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -4,10 +4,24 @@
 char *gitbasename (char *path)
 {
 	const char *base;
-	skip_dos_drive_prefix(&path);
+
+	if (path)
+		skip_dos_drive_prefix(&path);
+
+	if (!path || !*path)
+		return ".";
+
 	for (base = path; *path; path++) {
-		if (is_dir_sep(*path))
-			base = path + 1;
+		if (!is_dir_sep(*path))
+			continue;
+		do {
+			path++;
+		} while (is_dir_sep(*path));
+		if (*path)
+			base = path;
+		else
+			while (--path != base && is_dir_sep(*path))
+				*path = '\0';
 	}
 	return (char *)base;
 }
-- 
2.6.3.windows.1.300.g1c25e49
