From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 06/16] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Sat, 23 Apr 2016 00:33:57 +0530
Message-ID: <1461351847-22903-7-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:04:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgNq-00088a-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbcDVTEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:04:48 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35178 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbcDVTEq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:04:46 -0400
Received: by mail-pa0-f66.google.com with SMTP id zy2so10919104pac.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YfkFV0buJSDBstmPB64pwDH8ZXsDyruHpiqRgOYj0rc=;
        b=Ko1XPwVr5sfSEs/z21clmQQ04rdpJ3D9zV8zTzdEwMd1S+i1r4avkiRAt0W3WOdyf1
         4NCAfBCk2QqmzTiXukubdvfXugRcU4K4JrMwAWIKe4cuA5TsPHZsjVLAvyXpPq+I0iX0
         Sa+RAqfZcGA/TmFMaYXrz+pQx3hOM/e2gS8XRfXP7yOOe4GEWwCeMrMQw9Rnh4PAF2dk
         xWr+Mu8BX4no+uU8Gp7R7nvuCyR2Y+FsaRHU8Jmfsd21x2N2uPbqjufcmwrEZObGvFyG
         EYGJIAsbSlSeUJKzhZ+IN0FJgsrhKjZmPSZ/CC+HtEkrlYlnsItFmIJ3VM9XUUCVYU2e
         gXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YfkFV0buJSDBstmPB64pwDH8ZXsDyruHpiqRgOYj0rc=;
        b=X3ptCoQpoD8QlsEmJrmyICKDZlhXJOzwNcn6B5O4jKae1quyTbnBLEoy9wka/P9r+L
         +rRSc3FQzMiDP9NR2ft3UQ2YhUFKpQ1HihWl2DFvQjPpesupzEkM1HGxhkWpbSh4Tu4t
         fGZ9JMm+xQqPo4bO9VrLb5yGdMJeo+oyLW6ZOrlHeNArJN/bPYovhbNCwjZIOz+8QR3K
         6XoL2Pm7aeQGulL2ujB/LamzNWkdexFgLvIz+6Pc416sLlwp6GX79kxvzBRjEhXUA32A
         fQwicILIPgUjnXywtof49sbsWUiPp31l71pZ2AxKoI2LIFEDj3t+pqApbeqDfG4ABBj9
         umLQ==
X-Gm-Message-State: AOPr4FVgDl3zu9CcGuGDRfMvw2lHv69tHUXQElSoKqCeMNp8dDnBjzaelrhw3Zf0TC05RQ==
X-Received: by 10.66.218.161 with SMTP id ph1mr30491280pac.83.1461351886029;
        Fri, 22 Apr 2016 12:04:46 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:04:45 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292251>

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
index 5370fe5..f1e46a7 100644
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
2.8.0
