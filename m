Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6820E2035B
	for <e@80x24.org>; Tue, 11 Jul 2017 01:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754277AbdGKBGr (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 21:06:47 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:32833 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbdGKBGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 21:06:47 -0400
Received: by mail-pg0-f48.google.com with SMTP id k14so57991439pgr.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 18:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cYlhbB+edTAhrkfdvxeJWHS+nVonJw+VbIKXINPlB6E=;
        b=EQXRamH4Qot+JOL0Bg+/F5K/oriUQsybxVVJJFrpnN+CURyTyg/1No6O0zMoZiQdFD
         Z+FgMbR1/YccgnyJfjljJa9xaXL0+MzYW+7D9rMrm+o/LXpoghVV4CChPXcloh33GD2o
         8TkpAOJllcL33AwGONESvn2/PG/cb9TRTLYRQv7iPwSfDqlCMDCrU8AHKwSB1iCHg7Mu
         lZieEP5+i8idwhuXSx6XpUyMMep+ZvsJrFYcKQWwVvfmYOEuNh4oX6GpWRo1EBalzAmj
         L9i0c8CyZ/aSJti4BoKT/TmLdCxNPOAR/WEnhNRVl67OFz93lPDawqnFra68xeOE5c5g
         dN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cYlhbB+edTAhrkfdvxeJWHS+nVonJw+VbIKXINPlB6E=;
        b=mhhLeoHH3TirnxSFfvxpxYwQgaEmULnNG6n/SuJ2dfBrz/UPpWMXX9jd8oBOSp+tvK
         3TirsUjAJDFPNVPBSa0jUrxJ5dVuENbarwt8vlaVI556VA/zYyQ39nRbuhvgin6nQYfb
         hLrQ3fGU9+WOuQYU6NpQedFosUEq3DAn/uIxPyMjbBaAgn8hr9qDJcqoHSQa2KD3hO9n
         rzOZbsqPIcT0/WJ3f54bSIGv4UKRh31I2RNee07F/juVzmSnAVpvB/cuMuQ3XrxK68rJ
         w4XT/7MOfkVw86Uxb8UwzE0lYL5UswyFrWSRtAAQq9RKsuK/96+CYvNiui8gyPubDl+A
         LvqQ==
X-Gm-Message-State: AIVw1138FaWW+ragC26qNvdGOcZfENIrlv7xNLNhwJpXiVe3IWK+Y/yq
        GLUtHLnPK0nMlibtWkm6og==
X-Received: by 10.84.224.134 with SMTP id s6mr20645188plj.263.1499735205929;
        Mon, 10 Jul 2017 18:06:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc2a:f1e8:36c9:e743])
        by smtp.gmail.com with ESMTPSA id q29sm34636231pfg.11.2017.07.10.18.06.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 18:06:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] RFC: A new type of symbolic refs
Date:   Mon, 10 Jul 2017 18:06:39 -0700
Message-Id: <20170711010639.31398-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.2.695.g117ddefdb4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A symbolic ref can currently only point at (another symbolic) ref.
However are use cases for symbolic refs to point at other things
representing a commit-ish, such as gitlink entries in other
repositories.  In this use case we can use such a symbolic link
to strengthen the relationship between a submodule and a superproject.
Examples:

1) It makes it easier to explain when we recurse into submodules and
   to which sha1 the submodule is updated.

   Currently a submodule (or any repo) is either on a branch (i.e.
   HEAD is a symbolic ref) or is in 'detached HEAD' state (HEAD is
   a direct ref).
   For submodules it is wrong to be on its own branch if it wants to be
   controlled by the superproject as being on its own branch signals that
   the submodule is independent and can move the HEAD freely.
   Being in 'detached HEAD' state is the alternative to that and was
   chosen when git-submodule was implemented, but it is equally wrong;
   the lesser of two evils.

   Semantically the correct way to state a submodule is part of the
   superproject is by pointing its HEAD to the superproject.

   We do have "reset/checkout --recurse-submodules" now, but it is
   hard to explain what actually happens there (Which submodules are
   updated? All of them! -- But I want a subset only!)

   With this new mode of symbolic refs, any submodule that tracks the
   superproject, would 'automatically follow' the superproject as the
   submodules HEAD moves when the superproject changes.

2) "git -C submodule commit" would behave the same as it would on branch
   nowadays: It would make the commit in the submodule and then change
   the target of the symbolic ref which would be the index of the
   superproject! That implies that you do not need to 'git add' the
   submodule to the superproject, but have it done automatically.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h              |  2 ++
 refs/files-backend.c | 10 ++++++++++
 submodule.c          | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/cache.h b/cache.h
index 71fe092644..4f79d23202 100644
--- a/cache.h
+++ b/cache.h
@@ -2029,4 +2029,6 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
 
+extern int read_external_symref(struct strbuf *from, struct strbuf *out);
+
 #endif /* CACHE_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0404f2c233..f56f7b87ce 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -713,6 +713,16 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
+	if (starts_with(buf, "repo:")) {
+		if (read_external_symref(&sb_contents, referent)) {
+			*type |= REF_ISBROKEN;
+			ret = -1;
+			goto out;
+		}
+		*type |= REF_ISSYMREF;
+		ret = 0;
+	}
+
 	/*
 	 * Please note that FETCH_HEAD has additional
 	 * data after the sha.
diff --git a/submodule.c b/submodule.c
index da2b484879..7297f90485 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2037,3 +2037,43 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 cleanup:
 	return ret;
 }
+
+int read_external_symref(struct strbuf *from, struct strbuf *out)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *repo, *gitlink;
+	int hint, code;
+	struct strbuf **split = strbuf_split(from, 0);
+	struct strbuf cmd_out = STRBUF_INIT;
+
+	if (!split[0] || !split[1])
+		return -1;
+
+	repo = split[0]->buf + 5; /* skip 'repo:' */
+	gitlink = split[1]->buf;
+
+	argv_array_pushl(&cp.args,
+			"ignored-first-arg",
+			"-C", repo,
+			"ls-tree", "-z", "HEAD", "--", gitlink, NULL);
+
+	/*
+	 * 17 accounts for '160000 commit ',
+	 * the \t before path and trailing \0.
+	 */
+	hint = 17 + GIT_SHA1_HEXSZ + split[1]->len;
+	code = capture_command(&cp, &cmd_out, hint);
+
+	strbuf_release(split[0]);
+	strbuf_release(split[1]);
+
+	if (!code) {
+		strbuf_reset(out);
+		strbuf_add(out, cmd_out.buf + strlen("160000 commit "),
+			   GIT_SHA1_HEXSZ);
+	} else
+		return -1;
+
+	return 0;
+}
+
-- 
2.13.2.695.g117ddefdb4

