From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3] builtin/apply: handle parse_binary() failure
Date: Fri, 18 Mar 2016 13:30:41 +0100
Message-ID: <1458304241-537-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 13:33:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agtaV-0005Jq-1c
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 13:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbcCRMdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 08:33:03 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34818 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359AbcCRMdC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 08:33:02 -0400
Received: by mail-wm0-f45.google.com with SMTP id l68so29452551wml.0
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/CKRnIjhxI6oNPYUNqjqD+HPgoaGhYqriKCqbkw3gyk=;
        b=etb7RcIulgJaRiyzprjsRRDycchDBBWcYcOL3Hj6E+RxXKG9lwZlEva1NqkiJifvPs
         f/1lEA1cFpqgrfFONm83D0JQNPKMkONI/nJ6YTO8NAnqksswOCa4N6bmZJHXcFOTP5WW
         bHjkAv1YvfbJjloqVlTDgVbu1kW0FKuvhuiqAVZ9w/I0T1KopywE0n/Yz4PUUqhJBRY6
         p+YmovHBd7Edgds6NjFGbtN2O2YQ8pbmuZZA8ECqAQClMO1+kSCIfBdOtsvTWZP0u2f2
         MF+lP0YOWxDzNQQeWMLKFVP2K+HBxYNElRJRq8Hyn0+qbnP/iefC1Fln9TwBJRquiVAx
         fnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/CKRnIjhxI6oNPYUNqjqD+HPgoaGhYqriKCqbkw3gyk=;
        b=FelxNBYTM//g05b5W5qTtgTS8hBuTyPBynuTEVaaIkXpp9bVWV25+Yf62ZJ4DcVkUq
         rWJeP2c+NL4DuzTKL4lpf/0dWkE/gfOFmPl+ChpIod9x/P8bSUFVRRThSBOsxIlR49sL
         okUE3o1Nb4ZrB98/gQxnMSwFVjNkKqLpkaGdTBk2np2goIczkt0RqItczBBlY5E/JIwq
         xLgO1gVw3acND6Dc5zXftOrbO7gMLP1NizEBZDEHbAmTUpRRo3H/Ochv6xztLv+qPUnE
         hTBSGHMDf+M8aquB3woR8nV8Oj82EedHfKHiod5bpYFPOYBeHbBbRcb8B08lI59JEzoN
         jv/Q==
X-Gm-Message-State: AD7BkJL9Sx0g4OTyXlmz/N4m1V5mIhsHi5U4NxxuvjDCPnNkPflejUeJm7Xcv2EGwdeihg==
X-Received: by 10.194.121.194 with SMTP id lm2mr15763677wjb.71.1458304380498;
        Fri, 18 Mar 2016 05:33:00 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id i1sm12014268wjs.45.2016.03.18.05.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Mar 2016 05:32:59 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc2.56.gc9044db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289217>

In parse_binary() there is:

	forward = parse_binary_hunk(&buffer, &size, &status, &used);
	if (!forward && !status)
		/* there has to be one hunk (forward hunk) */
		return error(_("unrecognized binary patch at line %d"), linenr-1);

so parse_binary() can return -1, because that's what error() returns.

Also parse_binary_hunk() sets "status" to -1 in case of error and
parse_binary() does "if (status) return status;".

In this case parse_chunk() should not add -1 to the patchsize it computes.
It is better for future libification efforts to make it just return -1.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Only the title of the patch changed in this version compared to v2.

 builtin/apply.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 42c610e..c399c97 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1872,6 +1872,11 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	return NULL;
 }
 
+/*
+ * Returns:
+ *   -1 in case of error,
+ *   the length of the parsed binary patch otherwise
+ */
 static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 {
 	/*
@@ -2017,6 +2022,8 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 			linenr++;
 			used = parse_binary(buffer + hd + llen,
 					    size - hd - llen, patch);
+			if (used < 0)
+				return -1;
 			if (used)
 				patchsize = used + llen;
 			else
-- 
2.8.0.rc2.56.gc9044db
