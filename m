From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 3/6] for-each-ref: introduce %(HEAD) asterisk marker
Date: Mon, 18 Nov 2013 23:09:10 +0530
Message-ID: <1384796353-18701-4-git-send-email-artagnon@gmail.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSwN-0004Az-NO
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338Ab3KRRsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:48:43 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:60266 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab3KRRsi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:48:38 -0500
Received: by mail-pa0-f54.google.com with SMTP id rd3so1285673pab.41
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b/0n+gQCMcsinIxinn+AKdg3po2Y4uW5E4SJKfjQZZE=;
        b=dgrsNPmeneqdlfzgYP7fg7oaMepKh+AjB/WFaSAHy8PnWiehQsbUzppHNUUM6Qajgx
         /dOZyesSOe3kvi/oHjbPTVB8aCj4ZBCca/x2r4qkYhwFWjlxgtX6CKCR5Mxo1Cy5bQGQ
         S4nCAOyBUDQEgiAePKvs78WoPjAVNoK4HPeW2ZA9oQijSAqUByqeaklzJqAniAY6tWEh
         CstVNzwkvKqc5MeE22nG3Gsc/Q/S+Gg+FMMLph0qYLcAm6gv6TUJlBMqpqEf/7ogH20w
         txTIz430loEUH7uanNGGJVQrxQPqOmT2f5ed6kVodOuyuwXTl09j1KPX0OV+IghE2xh8
         jQIA==
X-Received: by 10.66.7.68 with SMTP id h4mr22799255paa.0.1384796918056;
        Mon, 18 Nov 2013 09:48:38 -0800 (PST)
Received: from localhost.localdomain ([122.164.173.226])
        by mx.google.com with ESMTPSA id hu10sm24836183pbc.11.2013.11.18.09.48.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 09:48:37 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.5.g70ebc73.dirty
In-Reply-To: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237998>

'git branch' shows which branch you are currently on with an '*', but
'git for-each-ref' misses this feature.  So, extend its format with
%(HEAD) for the same effect.

Now you can use the following format in for-each-ref:

  %(HEAD) %(refname:short)

to display an asterisk next to the current ref.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/for-each-ref.c             | 13 +++++++++++--
 t/t6300-for-each-ref.sh            |  2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f2e08d1..8f87c9a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -93,6 +93,10 @@ upstream::
 	from the displayed ref. Respects `:short` in the same way as
 	`refname` above.
 
+HEAD::
+	'*' if HEAD matches current ref (the checked out branch), ' '
+	otherwise.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 1d4083c..5f1842f 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -75,6 +75,7 @@ static struct {
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
+	{ "HEAD" },
 };
 
 /*
@@ -675,8 +676,16 @@ static void populate_value(struct refinfo *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		}
-		else
+		} else if (!strcmp(name, "HEAD")) {
+			const char *head;
+			unsigned char sha1[20];
+			head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			if (!strcmp(ref->refname, head))
+				v->s = "*";
+			else
+				v->s = " ";
+			continue;
+		} else
 			continue;
 
 		formatp = strchr(name, ':');
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 675c2a2..1d998f8 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -77,6 +77,7 @@ test_atom head contents:body ''
 test_atom head contents:signature ''
 test_atom head contents 'Initial
 '
+test_atom head HEAD '*'
 
 test_atom tag refname refs/tags/testtag
 test_atom tag upstream ''
@@ -110,6 +111,7 @@ test_atom tag contents:body ''
 test_atom tag contents:signature ''
 test_atom tag contents 'Tagging at 1151939927
 '
+test_atom tag HEAD ' '
 
 test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
-- 
1.8.5.rc0.5.g70ebc73.dirty
