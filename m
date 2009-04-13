From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/2] shorten_unambiguous_ref(): add strict mode
Date: Mon, 13 Apr 2009 12:25:46 +0200
Message-ID: <1239618347-17158-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 12:28:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtJOd-0001U2-0j
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 12:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628AbZDMKZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 06:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755549AbZDMKZx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 06:25:53 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:39281 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384AbZDMKZw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 06:25:52 -0400
Received: by bwz17 with SMTP id 17so1942849bwz.37
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=M215sLQmt9DKIxijq2opQtICC5C5n/iYKYjyuyIsVdk=;
        b=QbIk2h6sHPitqymO8QY9sTKPZvnqciSayy2XgWvTpLJt66CvBgOOLn0YrRfx6YzDmD
         gq8YwsRKn5LKJs+6S+6fvm/DFCv3++w757Esy7Yf2fPNZDoD5iVmLdPJe5laro6vPI2i
         hygRfaT85Jcb3T/gHu37XwPzYj5AhQ//82htU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aMBfr5p2wWovaoTsDuCor71u3XtbpGxYWVcHB5gGCyplmxSKrFIK8vyb6BpTFqTTv/
         kquwa7PqrTM+u6ECwTfuEw2o+MFymS3rpStbU3jlM08PVRDegq20SLmds5MPz5FSFxck
         qYhgNzn/1PQadpt8p+viaEhYnKnkw7OyaSAkY=
Received: by 10.86.68.1 with SMTP id q1mr976557fga.35.1239618349930;
        Mon, 13 Apr 2009 03:25:49 -0700 (PDT)
Received: from localhost (p5B0F4888.dip.t-dialin.net [91.15.72.136])
        by mx.google.com with ESMTPS id l19sm6985002fgb.21.2009.04.13.03.25.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 03:25:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.463.g124d4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116422>

Add the strict mode of abbreviation to shorten_unambiguous_ref(), i.e. the
resulting ref won't trigger the ambiguous ref warning.

All users of shorten_unambiguous_ref() still use the loose mode.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
Cc: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org

 builtin-branch.c       |    4 ++--
 builtin-for-each-ref.c |    2 +-
 refs.c                 |   18 +++++++++++++++---
 refs.h                 |    2 +-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3275821..91098ca 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -311,14 +311,14 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 		if (branch && branch->merge && branch->merge[0]->dst &&
 		    show_upstream_ref)
 			strbuf_addf(stat, "[%s] ",
-			    shorten_unambiguous_ref(branch->merge[0]->dst));
+			    shorten_unambiguous_ref(branch->merge[0]->dst, 0));
 		return;
 	}
 
 	strbuf_addch(stat, '[');
 	if (show_upstream_ref)
 		strbuf_addf(stat, "%s: ",
-			shorten_unambiguous_ref(branch->merge[0]->dst));
+			shorten_unambiguous_ref(branch->merge[0]->dst, 0));
 	if (!ours)
 		strbuf_addf(stat, "behind %d] ", theirs);
 	else if (!theirs)
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index c8114c8..cfff686 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -601,7 +601,7 @@ static void populate_value(struct refinfo *ref)
 		if (formatp) {
 			formatp++;
 			if (!strcmp(formatp, "short"))
-				refname = shorten_unambiguous_ref(refname);
+				refname = shorten_unambiguous_ref(refname, 0);
 			else
 				die("unknown %.*s format %s",
 				    (int)(formatp - name), name, formatp);
diff --git a/refs.c b/refs.c
index 82afb87..e65a3b4 100644
--- a/refs.c
+++ b/refs.c
@@ -1681,7 +1681,7 @@ static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
 	return;
 }
 
-char *shorten_unambiguous_ref(const char *ref)
+char *shorten_unambiguous_ref(const char *ref, int strict)
 {
 	int i;
 	static char **scanf_fmts;
@@ -1718,6 +1718,7 @@ char *shorten_unambiguous_ref(const char *ref)
 	/* skip first rule, it will always match */
 	for (i = nr_rules - 1; i > 0 ; --i) {
 		int j;
+		int rules_to_fail = i;
 		int short_name_len;
 
 		if (1 != sscanf(ref, scanf_fmts[i], short_name))
@@ -1726,14 +1727,25 @@ char *shorten_unambiguous_ref(const char *ref)
 		short_name_len = strlen(short_name);
 
 		/*
+		 * in strict mode, all (except the matched one) rules
+		 * must fail to resolve to a valid non-ambiguous ref
+		 */
+		if (strict)
+			rules_to_fail = nr_rules;
+
+		/*
 		 * check if the short name resolves to a valid ref,
 		 * but use only rules prior to the matched one
 		 */
-		for (j = 0; j < i; j++) {
+		for (j = 0; j < rules_to_fail; j++) {
 			const char *rule = ref_rev_parse_rules[j];
 			unsigned char short_objectname[20];
 			char refname[PATH_MAX];
 
+			/* skip matched rule */
+			if (i == j)
+				continue;
+
 			/*
 			 * the short name is ambiguous, if it resolves
 			 * (with this previous rule) to a valid ref
@@ -1749,7 +1761,7 @@ char *shorten_unambiguous_ref(const char *ref)
 		 * short name is non-ambiguous if all previous rules
 		 * haven't resolved to a valid ref
 		 */
-		if (j == i)
+		if (j == rules_to_fail)
 			return short_name;
 	}
 
diff --git a/refs.h b/refs.h
index 50abbbb..29d17a4 100644
--- a/refs.h
+++ b/refs.h
@@ -81,7 +81,7 @@ extern int for_each_reflog(each_ref_fn, void *);
 extern int check_ref_format(const char *target);
 
 extern const char *prettify_ref(const struct ref *ref);
-extern char *shorten_unambiguous_ref(const char *ref);
+extern char *shorten_unambiguous_ref(const char *ref, int strict);
 
 /** rename ref, return 0 on success **/
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
-- 
tg: (c965c02..) bw/short_ref-warnAmbiguousRefs (depends on: master)
