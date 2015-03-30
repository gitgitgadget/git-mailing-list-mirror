From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: [PATCH/RFC 1/4] Add "-" as @{-1} support for the rev-parse command
Date: Mon, 30 Mar 2015 13:41:52 -0400
Message-ID: <1427737315-7229-2-git-send-email-kenny.lee28@gmail.com>
References: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com>
Cc: gitster@pobox.com, Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 19:42:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycdhq-0002mt-45
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbbC3Rm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 13:42:28 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35357 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbbC3Rm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:42:26 -0400
Received: by igcau2 with SMTP id au2so82163896igc.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/qyDvZMk16KSpr2uZoMubI44dSJSu/I4QWeVSUOzEQg=;
        b=kW+laGqG18r+h/sCCTzdiQ03NJhnlN4aqvqOf+2yYxX/FfrRmNseHGCCUFetmZNYvD
         E+TnS20AbzMjSOe7M162qrm/ZpLoXimjxWbvggMmiHnYDlaQiZxVP93G/Na7XlnUgnx+
         Uu1Mu4AD+VegLpK8Ewq+H0M0RVUGGlnZybeC5ifQe5ULkXuXRqqhnFOTsKNTZsTH5s+G
         boJ5FmINhrOCDNkxBe0JXI4TUhJUCRUMtoPnnoueVhmA35WaIQvhbl9dgB62N9KYZ+o6
         vVYqlMp80EimuttaPvLZ7EUIEUTJu9WlagSBBBmaw24ka6sgniHLXJQS8ECreW/GGikJ
         TWoA==
X-Received: by 10.107.131.159 with SMTP id n31mr50542987ioi.66.1427737345902;
        Mon, 30 Mar 2015 10:42:25 -0700 (PDT)
Received: from fujitsu.wireless.concordia.ca ([132.205.236.26])
        by mx.google.com with ESMTPSA id x9sm8246356igl.2.2015.03.30.10.42.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Mar 2015 10:42:25 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.203.g8ffb468.dirty
In-Reply-To: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266462>

Allows the use of the "-" shorthand notation, including
use with revision ranges. If we plan to allow "-" as a stand in every
where a revision is allowed, then "-" would also need to be usable in
plumbing commands, for writing tests, for example.

Checks if the argument can be interpreted as a revision range first
before checking for flags. This saves us from having to check that
something that begins with "-" does not get checked as a possible flag.

Signed-off-by: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
---
 builtin/rev-parse.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 3626c61..8da95b5 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -553,6 +553,25 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		/* Not a flag argument */
+		if (try_difference(arg))
+			continue;
+		if (try_parent_shorthands(arg))
+			continue;
+		name = arg;
+		type = NORMAL;
+		if (*arg == '^') {
+			name++;
+			type = REVERSED;
+		}
+		if (!get_sha1_with_context(name, flags, sha1, &unused)) {
+			if (verify)
+				revs_count++;
+			else
+				show_rev(type, sha1, name);
+			continue;
+		}
+
 		if (*arg == '-') {
 			if (!strcmp(arg, "--")) {
 				as_is = 2;
@@ -810,24 +829,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		/* Not a flag argument */
-		if (try_difference(arg))
-			continue;
-		if (try_parent_shorthands(arg))
-			continue;
-		name = arg;
-		type = NORMAL;
-		if (*arg == '^') {
-			name++;
-			type = REVERSED;
-		}
-		if (!get_sha1_with_context(name, flags, sha1, &unused)) {
-			if (verify)
-				revs_count++;
-			else
-				show_rev(type, sha1, name);
-			continue;
-		}
 		if (verify)
 			die_no_single_rev(quiet);
 		if (has_dashdash)
-- 
2.3.3.203.g8ffb468.dirty
