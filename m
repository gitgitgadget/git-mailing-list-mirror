Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82F21FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 00:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdBNAMK (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 19:12:10 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:34824 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdBNAMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 19:12:09 -0500
Received: by mail-it0-f44.google.com with SMTP id 203so10367148ith.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 16:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bEJHPUqpzNHbz8KVhD1v8h/bUNMjDmedX0THOM34TH0=;
        b=ssb9rLN45DSNx47XuaT4kcyDU4AtN1zL3Ofw2d/+XgwsAnRgunHLJXRBVSKdpJjXpo
         SPIcdsjubMIiIJ7EsLTq/aBoo7FEdYGpUGl/7pPalKbe8MZ7Ck0fvAs9kTV6C1SAQ0f+
         0WlgZCVmUWUSSp3JQh0DjXrm9Wr7mi9gRNgUdlifRqUhV+bPyKnf29ZqJ9IpL4sjL+U5
         HCIQEz2r5fNrmrDFRcao4GhyoLMLGWqdVeUpGWLLLkyAu8uBh4HiZri6gHjy4CSOPbwI
         yRh8IXZaRr6BQVOb4p+KFB5MDAXTREMYkxJwbAOWN1J37H7h00y8ZZ5AIE1DBJu2mwPl
         0nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bEJHPUqpzNHbz8KVhD1v8h/bUNMjDmedX0THOM34TH0=;
        b=pHW5nXciH9kqPulYGNmhvbK276jsWBRpqitMSEN67t34iQl7M8GgdAgl0c3SA3VrON
         k0cD3l2CzZBTl+Uv4yAFCluo/XBCxthz3aNIiZguY/VKRjgKgj3lS9IgACw/JAiQuAeq
         GjbDec6PREeM6vCjgbv1QjSAt3rIfU2ihGfT0rNC5oEU87TpMkP4vOvuAshbjQHK6wUM
         T1XfeJpYzCUza8C0AjKso34l/Zx5l5sh1hEXRCKz39IAIGdcQ+3+f8hAeV03JHtClzpN
         /0xQlhNbDHBHY2FwbxFOF0//07kurb0LC8m5avxvyjLd5dI2m1WIk2yMJkjM2PrQxXG8
         ZoWg==
X-Gm-Message-State: AMke39lK4qMooAXZ8KDRShbYkBksOcl0/3Cqr50vAN5zvKZ8gVR8KRBZHsapwpur1b0AtDU1
X-Received: by 10.98.194.22 with SMTP id l22mr28549610pfg.178.1487031128285;
        Mon, 13 Feb 2017 16:12:08 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id 75sm22901751pfp.80.2017.02.13.16.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 16:12:07 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH for NEXT] grep: do not unnecessarily query repo for "--"
Date:   Mon, 13 Feb 2017 16:11:59 -0800
Message-Id: <20170214001159.19079-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running a command of the form

  git grep --no-index pattern -- path

in the absence of a Git repository, an error message will be printed:

  fatal: BUG: setup_git_env called without repository

This is because "git grep" tries to interpret "--" as a rev. "git grep"
has always tried to first interpret "--" as a rev for at least a few
years, but this issue was upgraded from a pessimization to a bug in
commit 59332d1 ("Resurrect "git grep --no-index"", 2010-02-06), which
calls get_sha1 regardless of whether --no-index was specified. This bug
appeared to be benign until commit b1ef400 ("setup_git_env: avoid blind
fall-back to ".git"", 2016-10-20) when Git was taught to die in this
situation.  (This "git grep" bug appears to be one of the bugs that
commit b1ef400 is meant to flush out.)

Therefore, always interpret "--" as signaling the end of options,
instead of trying to interpret it as a rev first.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

There is probably a similar bug for commands of the form:

  git grep --no-index pattern foo

If there is a repo and "foo" is a rev, the "--no-index or --untracked
cannot be used with revs." error would occur. If there is a repo and
"foo" is not a rev, this command would proceed as usual. If there is no
repo, the "setup_git_env called without repository" error would occur.
(This is my understanding from reading the code - I haven't tested it
out.)

This patch does not fix this similar bug, but I decided to send it out
anyway because it still fixes a bug and unlocks the ability to
specify paths with "git grep --no-index".

 builtin/grep.c  |  9 +++++----
 t/t7810-grep.sh | 12 ++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2c727ef49..1b68d1638 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1154,6 +1154,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		unsigned char sha1[20];
 		struct object_context oc;
+		if (!strcmp(arg, "--")) {
+			i++;
+			seen_dashdash = 1;
+			break;
+		}
 		/* Is it a rev? */
 		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
 			struct object *object = parse_object_or_die(sha1, arg);
@@ -1162,10 +1167,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
 			continue;
 		}
-		if (!strcmp(arg, "--")) {
-			i++;
-			seen_dashdash = 1;
-		}
 		break;
 	}
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 19f0108f8..29202f0e7 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -982,6 +982,18 @@ test_expect_success 'grep -e -- -- path' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep --no-index pattern -- path' '
+	rm -fr non &&
+	mkdir -p non/git &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		echo hello >hello &&
+		git grep --no-index o -- .
+	)
+'
+
 cat >expected <<EOF
 hello.c:int main(int argc, const char **argv)
 hello.c:	printf("Hello world.\n");
-- 
2.11.0.483.g087da7b7c-goog

