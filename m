From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 07/17] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Sun, 15 May 2016 16:15:23 +0530
Message-ID: <1463309133-14503-8-git-send-email-Karthik.188@gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 12:46:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tYr-0003l3-I6
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbcEOKqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:46:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34894 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbcEOKp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:45:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id b66so5171454pfb.2
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WlzktF9D+8kckfbc2MNTPd6xodeFrVrPIw0NSq85gRY=;
        b=SN7zrUhFBuQzVRbjjk/s1ZoHCE4tbXkbFqLEcR6B2mztLDvKJZs69/RNPJTk37gz/M
         Lm8wVYb8aSdABJrKOpAQ11GDFB9HJ5BUsG/pHZVznlSH+hQCUGOjdcvDUcHOy93ner4E
         gRNb9FtJswYjG09HbFtT3G9MdnrHz2ERr6Np8WYkwZE8Mc+rsWdGSLjobKc0T4RyXIjB
         IDFvSK8bub0LK7lv42OnlMMaDbP2xR+lS+/7PSGe2K9YiDKgYhPTaahNBjmDgn8hIOHO
         zY4cIcorGjnENO39iBYopF9smRU8GCJ5LfSgGYWe2+jLdCnuAdoBM2fP5SKZFqueaH2U
         iagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WlzktF9D+8kckfbc2MNTPd6xodeFrVrPIw0NSq85gRY=;
        b=Dv64dp9FWZgmySeAylwQ5hQ9sMjhB47eOfingLO+lvWW6Y64UWLFLgAjwPUVguTyKj
         Avp6msix7VIjHH8XYX72umG4/RKJoB6PaeMCmbhJlSYg9issBfy5ZFy1ug/+VceTkzd/
         1o2HRma5v0xL0kk+5hIgxZZjt80U7cXm0trqLt9Znn+iRI+uvITc2b/vLtHQxTUAXfDY
         /1exUFlw/kN80nBPelhwYcGPQ+axLn3BZaCbuH6WHv/Db/lHMbJ/hXQ2TWXQK5G3qhEZ
         Lns1il3Ww3JNjf906FnYZFPsGmp1FVoodReZCIceh2lZCBhAAYE76RbtoLGTUsJae7Ey
         B6Iw==
X-Gm-Message-State: AOPr4FU9atvu4j2P0EwFAgFx6cCofO6VLpe7ZTh78ThMyg5ZGFrZwxgts7iCp3jkTXYDbA==
X-Received: by 10.98.21.131 with SMTP id 125mr36793708pfv.92.1463309156394;
        Sun, 15 May 2016 03:45:56 -0700 (PDT)
Received: from ashley.localdomain ([106.51.133.65])
        by smtp.gmail.com with ESMTPSA id 71sm39866747pfy.32.2016.05.15.03.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 03:45:55 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294661>

Borrowing from branch.c's implementation print "[gone]" whenever an
unknown upstream ref is encountered instead of just ignoring it.

This makes sure that when branch.c is ported over to using ref-filter
APIs for printing, this feature is not lost.

Make changes to t/t6300-for-each-ref.sh and
Documentation/git-for-each-ref.txt to reflect this change.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by : Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 ref-filter.c                       | 4 +++-
 t/t6300-for-each-ref.sh            | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index da547c4..ba27809 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -119,7 +119,8 @@ upstream::
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
 	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	tracking information associated with it. `:track` also prints
+	"[gone]" whenever unknown upstream ref is encountered.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index da2b9ee..3bb6923 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1049,8 +1049,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->u.remote_ref == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL))
+				       &num_theirs, NULL)) {
+			*s = "[gone]";
 			return;
+		}
 
 		if (!num_ours && !num_theirs)
 			*s = "";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2be0a3f..a92b36f 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -382,7 +382,7 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 
 test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	cat >expected <<-\EOF &&
-
+	[gone]
 
 	EOF
 	test_when_finished "git config branch.master.merge refs/heads/master" &&
-- 
2.8.2
