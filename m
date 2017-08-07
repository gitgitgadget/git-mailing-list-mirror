Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B33620899
	for <e@80x24.org>; Mon,  7 Aug 2017 10:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbdHGKaP (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 06:30:15 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:63686 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbdHGKaO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 06:30:14 -0400
Received: from lindisfarne.localdomain ([92.22.15.146])
        by smtp.talktalk.net with SMTP
        id efIBdo93fAp17efIZdId4u; Mon, 07 Aug 2017 11:30:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1502101813; bh=V051Y2z59kgGcyBvlyG6XOWwVHD8X7OU4dxauIXhgA8=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=EsydT2f5C2mtozlhorl+BadWAMOm1E3l1KPEkCKQxbzhOeWFDeQm9/+jwa7I0WMEX
         eU5nmf112vSmcgO7WqRXL7eHDeMHwSvqHJKcLBWkMzskU1wizoTXsjBrf6AHHO3uF3
         mB5zykVHCMCc72fAin1wrbanbZoU6Dy/stZccQQw=
X-Originating-IP: [92.22.15.146]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=PRKyDR6jJsLBrgZYJ8A23w==:117
 a=PRKyDR6jJsLBrgZYJ8A23w==:17 a=evINK-nbAAAA:8 a=ybZZDoGAAAAA:8
 a=A1X0JdhQAAAA:8 a=4lHDZAM4FGC0cBypDCoA:9 a=0Y_R2qNLNvRRz-i9:21
 a=S3l24bddbgu4flBS:21 a=cssNWy7hh4kA:10 a=RfR_gqz1fSpA9VikTjo0:22
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1] am: fix signoff when other trailers are present
Date:   Mon,  7 Aug 2017 11:29:29 +0100
Message-Id: <20170807102929.25151-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfE5BQfcsD4oEXIRcg1lRZRM7LoPRsoS+H+9w8FMptBApUuUbWALhoVxNj3IGfNpsLFdyobYzV9g0IuFd/fgWC0pAC1PeDydoWQoGOeRLIb56heh6bVHk
 dm5SDNqq75GB/eH0ukJyjAMIMJfllZr1tcuYHxd2BMZ24aIt2sAaDNgVAI0rCSy0unGEt6+89O9ETbkWx+Oz73aIte+qcbdtv979458xPLOoRLEa6Dgaky2X
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there was no 'Signed-off-by:' trailer but another trailer such as
'Reported-by:' then 'git am --signoff' would add a blank line between
the existing trailers and the added 'Signed-off-by:' line. e.g.

    Rebase accepts '--rerere-autoupdate' as an option but only honors
    it if '-m' is also given. Fix it for a non-interactive rebase by
    passing on the option to 'git am' and 'git cherry-pick'.

    Reported-by: Junio C Hamano <gitster@pobox.com>

    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

Fix by using the code provided for this purpose in sequencer.c.
Change the tests so that they check the formatting of the
'Signed-off-by:' lines rather than just grepping for them.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
I'm not sure if this should be calling ignore_non_trailer() or not -
git commit does but git cherry-pick does not. This follows commit and
cherry-pick in ignoring the value of trailer.ifExists for the signoff.
I'm a bit surprised they do that - is it correct?

 builtin/am.c  | 26 +------------------
 t/t4150-am.sh | 83 +++++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 64 insertions(+), 45 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c973bd96dcb5d630d56e935733bfa4530ccd2872..f88d47c9d956f8e9d044cb1a4afa85c80f0c17cb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1181,34 +1181,10 @@ static void NORETURN die_user_resolve(const struct am_state *state)
  */
 static void am_append_signoff(struct am_state *state)
 {
-	char *cp;
-	struct strbuf mine = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
-
-	/* our sign-off */
-	strbuf_addf(&mine, "\n%s%s\n",
-		    sign_off_header,
-		    fmt_name(getenv("GIT_COMMITTER_NAME"),
-			     getenv("GIT_COMMITTER_EMAIL")));
-
-	/* Does sb end with it already? */
-	if (mine.len < sb.len &&
-	    !strcmp(mine.buf, sb.buf + sb.len - mine.len))
-		goto exit; /* no need to duplicate */
-
-	/* Does it have any Signed-off-by: in the text */
-	for (cp = sb.buf;
-	     cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
-	     cp = strchr(cp, '\n')) {
-		if (sb.buf == cp || cp[-1] == '\n')
-			break;
-	}
-
-	strbuf_addstr(&sb, mine.buf + !!cp);
-exit:
-	strbuf_release(&mine);
+	append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 44807e218d7016f58bd41b89af71104a37f31a8b..73b67b4280b99e0328e201e6b69c3d88b766ea84 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -40,6 +40,8 @@ test_expect_success 'setup: messages' '
 	dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio
 	dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te
 	feugait nulla facilisi.
+
+	Reported-by: A N Other <a.n.other@example.com>
 	EOF
 
 	cat >failmail <<-\EOF &&
@@ -93,7 +95,7 @@ test_expect_success setup '
 	echo world >>file &&
 	git add file &&
 	test_tick &&
-	git commit -s -F msg &&
+	git commit -F msg &&
 	git tag second &&
 
 	git format-patch --stdout first >patch1 &&
@@ -124,8 +126,6 @@ test_expect_success setup '
 		echo "Date: $GIT_AUTHOR_DATE" &&
 		echo &&
 		sed -e "1,2d" msg &&
-		echo &&
-		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
 		echo "---" &&
 		git diff-tree --no-commit-id --stat -p second
 	} >patch1-stgit.eml &&
@@ -144,8 +144,6 @@ test_expect_success setup '
 		echo "# Parent  $_z40" &&
 		cat msg &&
 		echo &&
-		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
-		echo &&
 		git diff-tree --no-commit-id -p second
 	} >patch1-hg.eml &&
 
@@ -470,13 +468,15 @@ test_expect_success 'am --signoff adds Signed-off-by: line' '
 	git reset --hard &&
 	git checkout -b master2 first &&
 	git am --signoff <patch2 &&
-	printf "%s\n" "$signoff" >expected &&
-	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >>expected &&
-	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
-	test_cmp expected actual &&
-	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
-	git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
-	test_cmp expected actual
+	{
+		printf "third\n\nSigned-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" &&
+		cat msg &&
+		printf "Signed-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL"
+	} >expected-log &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
 '
 
 test_expect_success 'am stays in branch' '
@@ -486,17 +486,60 @@ test_expect_success 'am stays in branch' '
 '
 
 test_expect_success 'am --signoff does not add Signed-off-by: line if already there' '
-	git format-patch --stdout HEAD^ >patch3 &&
-	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2] [foo," patch3 >patch4 &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout HEAD^ &&
-	git am --signoff patch4 &&
-	git cat-file commit HEAD >actual &&
-	test $(grep -c "^Signed-off-by:" actual) -eq 1
+	git format-patch --stdout first >patch3 &&
+	git reset --hard first &&
+	git am --signoff <patch3 &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
+'
+
+test_expect_success 'am --signoff adds Signed-off-by: if another author is preset' '
+	NAME="A N Other" &&
+	EMAIL="a.n.other@example.com" &&
+	{
+		printf "third\n\nSigned-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL" &&
+		cat msg &&
+		printf "Signed-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL"
+	} >expected-log &&
+	git reset --hard first &&
+	GIT_COMMITTER_NAME="$NAME" GIT_COMMITTER_EMAIL="$EMAIL" \
+		git am --signoff <patch3 &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
+'
+
+test_expect_success 'am --signoff duplicates Signed-off-by: if it is not the last one' '
+	NAME="A N Other" &&
+	EMAIL="a.n.other@example.com" &&
+	{
+		printf "third\n\nSigned-off-by: %s <%s>\n\
+Signed-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" &&
+		cat msg &&
+		printf "Signed-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\
+Signed-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL"
+	} >expected-log &&
+	git format-patch --stdout first >patch3 &&
+	git reset --hard first &&
+	git am --signoff <patch3 &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
 '
 
 test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
+	git format-patch --stdout HEAD^ >tmp &&
+	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2] [foo," tmp >patch4 &&
+	git reset --hard HEAD^ &&
+	git am <patch4 &&
 	git rev-parse HEAD >expected &&
 	git rev-parse master2 >actual &&
 	test_cmp expected actual
-- 
2.13.3

