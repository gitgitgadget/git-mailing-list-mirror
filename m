Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2608C1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 16:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJWA5q (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 20:57:46 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58478 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJWA5p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 20:57:45 -0400
Received: from localhost.localdomain (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 4F387335CFD;
        Mon, 22 Oct 2018 16:38:31 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH 3/3] gpg-interface.c: Obtain primary key fingerprint as well
Date:   Mon, 22 Oct 2018 18:38:21 +0200
Message-Id: <20181022163821.23523-3-mgorny@gentoo.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022163821.23523-1-mgorny@gentoo.org>
References: <20181022163821.23523-1-mgorny@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Obtain the primary key fingerprint off VALIDSIG status message,
and expose it via %GP format.

Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 Documentation/pretty-formats.txt |  2 ++
 gpg-interface.c                  | 16 +++++++++++++++-
 gpg-interface.h                  |  1 +
 pretty.c                         |  4 ++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 8ab7d6dd1..417b638cd 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -154,6 +154,8 @@ endif::git-rev-list[]
 - '%GS': show the name of the signer for a signed commit
 - '%GK': show the key used to sign a signed commit
 - '%GF': show the fingerprint of the key used to sign a signed commit
+- '%GP': show the fingerprint of the primary key whose subkey was used
+  to sign a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}` or
   `refs/stash@{2 minutes ago`}; the format follows the rules described
   for the `-g` option. The portion before the `@` is the refname as
diff --git a/gpg-interface.c b/gpg-interface.c
index a406484e4..8ed274533 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -74,6 +74,7 @@ void signature_check_clear(struct signature_check *sigc)
 	FREE_AND_NULL(sigc->signer);
 	FREE_AND_NULL(sigc->key);
 	FREE_AND_NULL(sigc->fingerprint);
+	FREE_AND_NULL(sigc->primary_key_fingerprint);
 }
 
 /* An exclusive status -- only one of them can appear in output */
@@ -108,7 +109,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
 	const char *line, *next;
-	int i;
+	int i, j;
 	int seen_exclusive_status = 0;
 
 	/* Iterate over all lines */
@@ -147,6 +148,18 @@ static void parse_gpg_output(struct signature_check *sigc)
 					next = strchrnul(line, ' ');
 					free(sigc->fingerprint);
 					sigc->fingerprint = xmemdupz(line, next - line);
+
+					/* Skip interim fields */
+					for (j = 9; j > 0; j--) {
+						if (!*next)
+							break;
+						line = next + 1;
+						next = strchrnul(line, ' ');
+					}
+
+					next = strchrnul(line, '\n');
+					free(sigc->primary_key_fingerprint);
+					sigc->primary_key_fingerprint = xmemdupz(line, next - line);
 				}
 
 				break;
@@ -165,6 +178,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 	 */
 	sigc->result = 'E';
 	/* Clear partial data to avoid confusion */
+	FREE_AND_NULL(sigc->primary_key_fingerprint);
 	FREE_AND_NULL(sigc->fingerprint);
 	FREE_AND_NULL(sigc->signer);
 	FREE_AND_NULL(sigc->key);
diff --git a/gpg-interface.h b/gpg-interface.h
index 8ce614fc9..3e624ec28 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -24,6 +24,7 @@ struct signature_check {
 	char *signer;
 	char *key;
 	char *fingerprint;
+	char *primary_key_fingerprint;
 };
 
 void signature_check_clear(struct signature_check *sigc);
diff --git a/pretty.c b/pretty.c
index 4567b5321..b83a3ecd2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1260,6 +1260,10 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			if (c->signature_check.fingerprint)
 				strbuf_addstr(sb, c->signature_check.fingerprint);
 			break;
+		case 'P':
+			if (c->signature_check.primary_key_fingerprint)
+				strbuf_addstr(sb, c->signature_check.primary_key_fingerprint);
+			break;
 		default:
 			return 0;
 		}
-- 
2.19.1

