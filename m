From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] config.mak.uname: Darwin: define HAVE_GETDELIM for modern OS X releases
Date: Tue,  2 Jun 2015 14:18:57 -0400
Message-ID: <1433269138-10890-2-git-send-email-sunshine@sunshineco.com>
References: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 20:20:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzqnE-00063g-TX
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759223AbbFBST5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:19:57 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33785 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbbFBSTx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:19:53 -0400
Received: by iebgx4 with SMTP id gx4so139080803ieb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XPbHDfg3nq4r3eIva9h7EbtudKzJpdbvg0wNVyz35yo=;
        b=o4u4z4GaoJs1j4rk/ckATFlhBtyS0XGDVFDh5YyDSRly2RPs4ORQdbIoh9bcB37fxh
         AIOU1CrVDX2rEziCbFKYBnn0B35WdAaCjFB2oxxkBttCzqeJ2hVPBq0P7m5z1Rx3BNUB
         oDkiafpeJFF68E344xQGCYKajw3m5Cci8mTJVZjzao7trrw3c0DfBBym2rUTEVPNY3s4
         cBW5vFTdYxk1NFe4d/+OqqQJSbO+Yk8MklD9StukQCyyNhEqVlmxikt0vGeaPHtYEseD
         Pn7i3S/G8iMA7RDZvIbAZdXwQMESofPkgjjXhEDB6ObnzdrxPSlgO6DdiYiyhtRn7iCo
         7q/g==
X-Received: by 10.107.156.71 with SMTP id f68mr34431761ioe.36.1433269193342;
        Tue, 02 Jun 2015 11:19:53 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id v14sm10451458igd.12.2015.06.02.11.19.52
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 11:19:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.674.gb037150
In-Reply-To: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270575>

On Mac OS X, getdelim() first became available with Xcode 4.1[1], which
was released the same day as OS X 10.7 "Lion", so assume getdelim()
availability from 10.7 onward. (As of this writing, OS X is at 10.10
"Yosemite".)

According to Wikipedia[2], 4.1 was also available for download by paying
developers on OS X 10.6 "Snow Leopard", so it's possible that some 10.6
machines may have getdelim(). However, as strbuf's use of getdelim() is
purely an optimization, let's be conservative and assume 10.6 and
earlier lack getdelim().

[1]: Or, possibly with Xcode 4.0, but that version is no longer
     available for download, or not available to non-paying developers,
     so testing is not possible.

[2]: http://en.wikipedia.org/wiki/Xcode

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Tested on OS X 10.10.3 "Yosemite" with Xcode 6.3.2 and OS X 10.5.8
"Leopard" with Xcode 3.1.

The use of 'expr' in this new test is decidedly different from existing
instances which merely check if `uname -R` matches a particular single
digit and a period. If the new test took the same approach, it would
have to match either one digit (in a particular range) plus a period, or
two digits with the first being "1", plus a period. The resulting 'expr'
expression quickly becomes ugly and quite difficult to decipher. Hence,
the new test instead takes advantage of expr's relational operator '>='
to keep things simple and make the test easy to understand at a glance
("if version >= 11" where 11 is the Darwin major version number of OS X
10.7).

 config.mak.uname | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index d26665f..46a415c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -102,6 +102,9 @@ ifeq ($(uname_S),Darwin)
 	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
 		NO_STRLCPY = YesPlease
 	endif
+	ifeq ($(shell expr $(shell expr "$(uname_R)" : '\([0-9][0-9]*\)\.') '>=' 11),1)
+		HAVE_GETDELIM = YesPlease
+	endif
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
-- 
2.4.2.598.gb4379f4
