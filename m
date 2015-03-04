From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH] reset: allow "-" short hand for previous commit
Date: Wed,  4 Mar 2015 12:39:56 +0530
Message-ID: <1425452996-11682-1-git-send-email-sudshekhar02@gmail.com>
References: <CAODo60qimjiMfWY_FNuOcVaYc=JdbTv_4SJ3BROC-9Jo5qWkdA@mail.gmail.com>
Cc: Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 08:10:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT3Rz-0007CK-RR
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934355AbbCDHK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 02:10:29 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:44038 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933152AbbCDHK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 02:10:26 -0500
Received: by pdjz10 with SMTP id z10so4129125pdj.11
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 23:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P2/W17BETSA5vX+pb7wQYh3Az0/kmALcO0QdaCvGKIo=;
        b=LKEV+tTt35IU66vUPbOucHFIeEBXxREZpjx/M42C1ymXFwFMn/GRnqa5CjjKEncmju
         ye8SC8mb4yFq2VYKw1LzvIGo0yOUVD9INsmzWUYa9udqEJadAj8r1TNcADoLtuM5v882
         2fEfKHgMpkbxzOx/dDD7qYKFFtiaTjbUAdZryjRq3BordTgC1qEj8ihRjenik0USgKcL
         nxCu256XFpFz1Uke/ejl8v2enudFapTHD+2rzrqzY2WSYtTrasHD5LsZM2Do4yGSJyG/
         LWMfJD5TemcTVqg4sTH3dOUbpajpVe2kNZSa/8GFdHG5atrm8LQl0ttTnh5NmovJzVv6
         rrCw==
X-Received: by 10.68.171.68 with SMTP id as4mr4297872pbc.21.1425453026080;
        Tue, 03 Mar 2015 23:10:26 -0800 (PST)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id py5sm1578232pbc.81.2015.03.03.23.10.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2015 23:10:24 -0800 (PST)
X-Mailer: git-send-email 2.3.1.168.gfd4bc34.dirty
In-Reply-To: <CAODo60qimjiMfWY_FNuOcVaYc=JdbTv_4SJ3BROC-9Jo5qWkdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264724>

Teach reset the same shorthand as checkout and merge. "-" means the
"previous commit".

Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
---
 builtin/reset.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..9f8967d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -192,6 +192,7 @@ static void parse_args(struct pathspec *pathspec,
 {
 	const char *rev = "HEAD";
 	unsigned char unused[20];
+	int substituted_minus = 0;
 	/*
 	 * Possible arguments are:
 	 *
@@ -205,6 +206,10 @@ static void parse_args(struct pathspec *pathspec,
 	 */
 
 	if (argv[0]) {
+		if(!strcmp(argv[0], "-")) {
+			argv[0] = "@{-1}";
+			substituted_minus = 1;
+		}
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
@@ -225,12 +230,14 @@ static void parse_args(struct pathspec *pathspec,
 			verify_non_filename(prefix, argv[0]);
 			rev = *argv++;
 		} else {
+			/* We were treating "-" as a commit and not a file */
+			if(substituted_minus)
+				argv[0] = "-";
 			/* Otherwise we treat this as a filename */
 			verify_filename(prefix, argv[0], 1);
 		}
 	}
 	*rev_ret = rev;
-
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-- 
2.3.1.168.gfd4bc34.dirty
