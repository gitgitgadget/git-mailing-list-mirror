From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/6] transport-helper: clarify *:* refspec
Date: Wed, 17 Apr 2013 19:05:19 -0500
Message-ID: <1366243524-18202-2-git-send-email-felipe.contreras@gmail.com>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 02:06:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UScNC-0006vl-K4
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 02:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935137Ab3DRAGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 20:06:39 -0400
Received: from mail-gh0-f169.google.com ([209.85.160.169]:59025 "EHLO
	mail-gh0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3DRAGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 20:06:38 -0400
Received: by mail-gh0-f169.google.com with SMTP id r18so159215ghr.28
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dr+B1t/6uW5tN6JjQM7kBPaUtLY7WT5VdgKfyRA+QNk=;
        b=jmpKXW7OHoHajqyHY/l/MSjeXDzeKAkIZlfDevpFx12zNLY9DO2CTrZOe2c/kFrk9C
         dpFNjtT3xUVOx7kLAT9XCNWpOI3l2EgKpM/5oKm0PaJklXjQZ9uBgPV8n+kE+akCLaZP
         vD9g9bO6iOiRM6dxBcrFK7wWKyGZ2pm1i01LDy5GAmYauwPhTJXlduWyGXCB/SwMSqSg
         Nuc59GrEMPDXH9Df9UBkkoXWOySfTDCOqVV4ceBWNJbxH1/QRp4HDMW24v1CVC92Vuei
         CjUTFYdicifgPVRv0n7T0MVONhvLmB8lwJJpDmYH/WjegG5cNCv0RnwgHj5RrNxGHVSJ
         BDbw==
X-Received: by 10.236.116.164 with SMTP id g24mr5711773yhh.178.1366243597851;
        Wed, 17 Apr 2013 17:06:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u33sm13082327yhn.7.2013.04.17.17.06.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 17:06:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221588>

The *:* refspec doesn't work, and never has, clarify the code and
documentation to reflect that. This in effect reverts commit 9e7673e
(gitremote-helpers(1): clarify refspec behaviour).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/gitremote-helpers.txt |  4 ++--
 t/t5801-remote-helpers.sh           | 15 ---------------
 transport-helper.c                  |  2 +-
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index f506031..0c91aba 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -174,8 +174,8 @@ ref.
 This capability can be advertised multiple times.  The first
 applicable refspec takes precedence.  The left-hand of refspecs
 advertised with this capability must cover all refs reported by
-the list command.  If a helper does not need a specific 'refspec'
-capability then it should advertise `refspec *:*`.
+the list command.  If no 'refspec' capability is advertised,
+there is an implied `refspec *:*`.
 
 'bidi-import'::
 	This modifies the 'import' capability.
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index f387027..cd1873c 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -120,21 +120,6 @@ test_expect_failure 'pushing without refspecs' '
 	compare_refs local2 HEAD server HEAD
 '
 
-test_expect_success 'pulling with straight refspec' '
-	(cd local2 &&
-	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
-	compare_refs local2 HEAD server HEAD
-'
-
-test_expect_failure 'pushing with straight refspec' '
-	test_when_finished "(cd local2 && git reset --hard origin)" &&
-	(cd local2 &&
-	echo content >>file &&
-	git commit -a -m eleven &&
-	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git push) &&
-	compare_refs local2 HEAD server HEAD
-'
-
 test_expect_success 'pulling without marks' '
 	(cd local2 &&
 	GIT_REMOTE_TESTGIT_NO_MARKS=1 git pull) &&
diff --git a/transport-helper.c b/transport-helper.c
index dcd8d97..cea787c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -469,7 +469,7 @@ static int fetch_with_import(struct transport *transport,
 	 * were fetching.
 	 *
 	 * (If no "refspec" capability was specified, for historical
-	 * reasons we default to *:*.)
+	 * reasons we default to the equivalent of *:*.)
 	 *
 	 * Store the result in to_fetch[i].old_sha1.  Callers such
 	 * as "git fetch" can use the value to write feedback to the
-- 
1.8.2.1.679.g509521a
