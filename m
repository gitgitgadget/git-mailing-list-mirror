From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/32] rev-parse: add --shared-index-path to get shared index path
Date: Fri, 13 Jun 2014 19:19:46 +0700
Message-ID: <1402661991-14977-28-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:22:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQVI-0004h7-Tt
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbaFMMWl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:22:41 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:50622 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbaFMMWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:22:40 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so2100915pab.30
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=o7kDzqEeb2INA6NkvSzPL/lUbKTkS+S9XQ9HtaBJGig=;
        b=oXmACzcelK6S7oNpsGacTjkOI0pWbyV+JBWdDgfeLPJtaPloPQYuUZj7smV/0k5ogl
         5ko1/yrTzgNI/YgAT4rAOiis4irSSKnzHWY75pXdxgS39b9I9jnECFQ9/ZTx5fNBQHxw
         CQS5MAv6TY90EoU2gNTD+Xra6nhBBVPWiNSTfqAz8GNaRfxOvH7EzFyTd5WrP2Ogl0x8
         3TJfGdLGGS1Yo1kNRFnSX4YAJJZAeU6ZLt7NNqUtZD6IfzwD4K203HMabV2b25qcZ1kP
         HGytFlgNQIGkoKWZQMQ+0gcr5//DxheTNGz0mHY3DACeWkgMkn1iom46VyVRjT3OLI1L
         H8IQ==
X-Received: by 10.69.19.139 with SMTP id gu11mr3001754pbd.36.1402662159848;
        Fri, 13 Jun 2014 05:22:39 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id vc5sm20772409pac.19.2014.06.13.05.22.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:22:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:22:39 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251583>

Normally scripts do not have to be aware about split indexes because
all shared indexes are in $GIT_DIR. A simple "mv $tmp_index
$GIT_DIR/somewhere" is enough. Scripts that generate temporary indexes
and move them across repos must be aware about split index and copy
the shared file as well. This option enables that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-rev-parse.txt |  4 ++++
 builtin/rev-parse.c             | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 987395d..9bd76a5 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -245,6 +245,10 @@ print a message to stderr and exit with nonzero st=
atus.
 --show-toplevel::
 	Show the absolute path of the top-level directory.
=20
+--shared-index-path::
+	Show the path to the shared index file in split index mode, or
+	empty if not in split-index mode.
+
 Other Options
 ~~~~~~~~~~~~~
=20
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 1a6122d..8102aaa 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -11,6 +11,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
+#include "split-index.h"
=20
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -775,6 +776,15 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 						: "false");
 				continue;
 			}
+			if (!strcmp(arg, "--shared-index-path")) {
+				if (read_cache() < 0)
+					die(_("Could not read the index"));
+				if (the_index.split_index) {
+					const unsigned char *sha1 =3D the_index.split_index->base_sha1;
+					puts(git_path("sharedindex.%s", sha1_to_hex(sha1)));
+				}
+				continue;
+			}
 			if (starts_with(arg, "--since=3D")) {
 				show_datestring("--max-age=3D", arg+8);
 				continue;
--=20
1.9.1.346.ga2b5940
