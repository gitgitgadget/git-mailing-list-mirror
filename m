From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/4] rev-parse: exit with non-zero status if ref@{n} is not valid.
Date: Sat, 21 Aug 2010 11:43:39 +1000
Message-ID: <1282355022-17795-2-git-send-email-jon.seymour@gmail.com>
References: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 03:44:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omd8J-00056H-B3
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 03:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209Ab0HUBo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 21:44:27 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50220 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab0HUBoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 21:44:16 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1444133pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 18:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=J7ZPSdTy+ocKtjPYqzscF1C6VLgxrYCQmHgSG/lf+RU=;
        b=NjSneAbQP3CANfMyRey2mR+KLY082mB0MZtjoPIn4YwMG3tfvUurEJArceFfqm6Yji
         hBTQce6lktcWOvBgxOc29Y5i4+YBCqIHKfLfsb0OUHUsYR9e6KkM+Ys5sR37xyJk1VSu
         XdQbJuKuyVI8ZXmMJ3+LiscVhOZrxXWdB/BIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GrNYoRxXN2tBUfJBTJfWCuK2FBZqfVelrcm/kgnTmfYReBcUgvcXeZU0jb8B2GHMSg
         tmEJHFJRXFXtgYh5VS9ySfpXjSiFYduRur//ZVdv/lVn2DwUsBhtSy/oytEIxHQvqRUX
         OuyKOu/UeZZ4wf4oDkTuH2hgM3Zoj5drQdb1Y=
Received: by 10.114.124.18 with SMTP id w18mr2431210wac.6.1282355055820;
        Fri, 20 Aug 2010 18:44:15 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id d38sm6038069wam.8.2010.08.20.18.44.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 18:44:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.156.gf148c
In-Reply-To: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154089>

>From Junio's e-mail:

"The current behaviour of ref@{...} syntax parser is suboptimal:

    $ git rev-parse --verify jch@{99999}; echo $?
    warning: Log for 'jch' only has 1368 entries.
    cfb88e9a8d4926b0011ae2dd67e1f57a98f4b768
    0

It even knows that it is running off the cut-off point; it should just
cause the caller to notice that fact.  I don't think changing it to error
out should cause any harm to existing callers."

This commit is based on a patch suggested by Junio.

Note that the error message reporting the bad log reference
is printed twice if --verify is not specified because
the function is called from two different paths. This is
fixed in subsequent commits.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 sha1_name.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4af94fa..82ad0f9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -342,7 +342,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
-	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
+	static const char *warn_msg = "warning: refname '%.*s' is ambiguous.";
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len;
@@ -390,7 +390,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		return -1;
 
 	if (warn_ambiguous_refs && refs_found > 1)
-		fprintf(stderr, warning, len, str);
+		fprintf(stderr, warn_msg, len, str);
 
 	if (reflog_len) {
 		int nth, i;
@@ -426,14 +426,17 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (at_time)
-				fprintf(stderr,
-					"warning: Log for '%.*s' only goes "
-					"back to %s.\n", len, str,
+				warning("Log for '%.*s' only goes "
+					"back to %s.", len, str,
 					show_date(co_time, co_tz, DATE_RFC2822));
-			else
-				fprintf(stderr,
-					"warning: Log for '%.*s' only has "
-					"%d entries.\n", len, str, co_cnt);
+			else {
+				error("Log for '%.*s' only has %d entries.",
+					len,
+					str,
+					co_cnt);
+				free(real_ref);
+				return -1;
+			}
 		}
 	}
 
-- 
1.7.2.1.156.gf148c
