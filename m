From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/32] rev-parse: add --shared-index-path to get shared index path
Date: Mon, 28 Apr 2014 17:55:48 +0700
Message-ID: <1398682553-11634-28-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:58:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejFz-0004hT-3S
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbaD1K5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:57:50 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:44024 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbaD1K45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:57 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2188268pdj.29
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=o7kDzqEeb2INA6NkvSzPL/lUbKTkS+S9XQ9HtaBJGig=;
        b=lchr83w2Wmc54rtUm53G2ygqyJ2GYfR5n+zEZTw0w9V8XzZRDgoNcbbBkYKwH4DxT8
         HTNv9BAdzeP0989v9THg6wp/8iVXYVPRw1fSBDaZrUi88Oa71ZE6tZcimgTU77GvEUwB
         6ux2SwSAG9YDfxwvkII3yDMdGzX/pVPs2lnMk+SrVdys0vrU4cGJ4xOql/jluvaajNrI
         oCOaTjiTeyidEjqPqsAAWUu7H1jNyNUFIPXLN6QytkjnMgYLCajBMc+C4Rz6KO5AWGWn
         GfGohXYF9C0/NLNRDPyMT/Le9azqWNp/3mESqk+CMF03IgIFkYOJMG8uIkq0Dzb1eEvp
         3YVA==
X-Received: by 10.66.250.161 with SMTP id zd1mr3085010pac.136.1398682616734;
        Mon, 28 Apr 2014 03:56:56 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id vo1sm89599682pab.32.2014.04.28.03.56.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:58:24 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247298>

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
