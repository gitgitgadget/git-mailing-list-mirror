Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3702420988
	for <e@80x24.org>; Tue, 18 Oct 2016 17:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034144AbcJRRw5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 13:52:57 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33189 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbcJRRwz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 13:52:55 -0400
Received: by mail-pf0-f181.google.com with SMTP id 128so530227pfz.0
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vX2XPnjUp0Jza9gR8t0Up5wR2c+SjSx13k2dC0wqH/I=;
        b=iVPy1MArFh7zmzeRdoCEoflfJr8r3HJjHfn9g1U8KqnU0m6KlI4Ih1mydACZ7v6sVs
         GlFd1HQCoco+MJN9wEGs9LgMLkafdQ37U7rKuncISM6KyRbnQRd7CobdORrOVkvUgSfE
         YuP+qyeARp+Q2JMRUpm5HHxQZftg9apgPRnA9ZtIDTzVXfm1sQ4PUpV3ouQ8/TWJ3Dix
         WarHItpVga6omvaH/wQeoRg0VPAcQvlZZRwi7dxUWy8uYAp6wtqnQmiX34nalUMO3PYU
         VcTZVkjyb/jHjq9EAv4ZmRgWCFyX7KT0v8T3me3geMEwOK/j11MTEp0I7aSLg+faJocF
         jE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vX2XPnjUp0Jza9gR8t0Up5wR2c+SjSx13k2dC0wqH/I=;
        b=AvheACFe2UAtE/hZdTZ5s5jQO/+7Cj0WE8o4PJSi1ovoSRwkobxZpZ1z5OZieR9y9E
         35jG7R7Axod0vOV7K0MT06kynjM9jI2o0EmtVibvGlosgINNlw8lWmd/ck6woHdOcNfL
         bsRAkeII6tSBeI3AR3Ri3uRwAtN0vNm+IuRb40i288q8ybOXxRwlkv65sAb+aZRGeljT
         DvGZ2o8T7GRs3Y1Ajw+HCYJjB/YEg2cjJpk9zDeDwEfMP4gIH4S9OBNtepdHeEXloqht
         hXRsbAH1+LzPbus22VNWPhcLDF7UzHSfut42fnqmAZ2HWsIvImuK0JshSg2h+57OPK1v
         bWDw==
X-Gm-Message-State: AA6/9Rk1YB6r2esTJvLPVZcKnWlogmoYJoofrRMEMqdJBJKhqIxXuHvCxTBUv1x6B7iAO+sM
X-Received: by 10.98.88.130 with SMTP id m124mr2907648pfb.4.1476813174793;
        Tue, 18 Oct 2016 10:52:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:352c:25b6:cb52:1b0b])
        by smtp.gmail.com with ESMTPSA id l1sm17796918pai.14.2016.10.18.10.52.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Oct 2016 10:52:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, j6t@kdbg.org, Johannes.Schindelin@gmx.de,
        venv21@gmail.com, dennis@kaarsemaker.net, jrnieder@gmail.com,
        bmwill@google.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule--helper: normalize funny urls
Date:   Tue, 18 Oct 2016 10:52:47 -0700
Message-Id: <20161018175247.28326-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.480.g573bd76
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The remote URL for the submodule can be specified relative
to the URL of the superproject in .gitmodules.  A top-level
git://site.xz/toplevel.git can specify in its .gitmodules

        [submodule "sub"]
                url = ../submodule.git
                path = sub

to say that git://site.xz/submodule.git is where the
submodule bound at its "sub/" is found.

However, when the toplevel is cloned like this:

        git clone git://site.xz/toplevel.git/. top

i.e. the toplevel specifies its URL with trailing "/.", the
code set the URL to git://site.xz/toplevel.git/submodule.git
for the submodule, which is nonsense.  This was because the
logic failed to treat trailing "/." any differently from
trailing "/<anything-without-slash>" when resolving a
relative URL "../<something>" off of it.  Stripping "/." at
the end does *not* take you one level up, even though
stripping "/<anything-without-slash>" does!

Some users may rely on this by always cloning with '/.' and having
an additional '../' in the relative path for the submodule, and this
patch breaks them. So why introduce this patch?

The fix in c12922024 (submodule: ignore trailing slash on superproject
URL, 2016-10-10) and prior discussion revealed, that Git and Git
for Windows treat URLs differently, as currently Git for Windows
strips off a trailing dot from paths when calling a Git binary
unlike when running a shell. Which means Git for Windows is already
doing the right thing for the case mentioned above, but it would fail
our current tests, that test for the broken behavior and it would
confuse users working across platforms. So we'd rather fix it
in Git to ignore any of these trailing no ops in the path properly.

We never produce the URLs with a trailing '/.' in Git ourselves,
they come to us, because the user used it as the URL for cloning
a superproject. Normalize these paths.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 * reworded the commit message, taken from Junio, but added more explanation
   why we want to introduce this patch. 
 * added the length check
 * use an infinite loop with break instead of a variable
   to determine the ending condition.

 builtin/submodule--helper.c | 48 +++++++++++++++++++++++++++++++++------------
 t/t0060-path-utils.sh       | 11 +++++++----
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 260f46f..ac03cb3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -76,6 +76,29 @@ static int chop_last_dir(char **remoteurl, int is_relative)
 	return 0;
 }
 
+static void strip_url_ending(char *url, size_t *_len)
+{
+	size_t len = _len ? *_len : strlen(url);
+
+	for (;;) {
+		if (len > 1 && is_dir_sep(url[len-2]) && url[len-1] == '.') {
+			url[len-2] = '\0';
+			len -= 2;
+			continue;
+		}
+		if (len > 0 && is_dir_sep(url[len-1])) {
+			url[len-1] = '\0';
+			len --;
+			continue;
+		}
+
+		break;
+	}
+
+	if (_len)
+		*_len = len;
+}
+
 /*
  * The `url` argument is the URL that navigates to the submodule origin
  * repo. When relative, this URL is relative to the superproject origin
@@ -93,14 +116,16 @@ static int chop_last_dir(char **remoteurl, int is_relative)
  * the superproject working tree otherwise.
  *
  * NEEDSWORK: This works incorrectly on the domain and protocol part.
- * remote_url      url              outcome          expectation
- * http://a.com/b  ../c             http://a.com/c   as is
- * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
- *                                                   ignore trailing slash in url
- * http://a.com/b  ../../c          http://c         error out
- * http://a.com/b  ../../../c       http:/c          error out
- * http://a.com/b  ../../../../c    http:c           error out
- * http://a.com/b  ../../../../../c    .:c           error out
+ * remote_url       url              outcome          expectation
+ * http://a.com/b   ../c             http://a.com/c   as is
+ * http://a.com/b/  ../c             http://a.com/c   same as previous line, but
+ *                                                    ignore trailing '/' in url
+ * http://a.com/b/. ../c             http://a.com/c   same as previous line, but
+ *                                                    ignore trailing '/.' in url
+ * http://a.com/b   ../../c          http://c         error out
+ * http://a.com/b   ../../../c       http:/c          error out
+ * http://a.com/b   ../../../../c    http:c           error out
+ * http://a.com/b   ../../../../../c    .:c           error out
  * NEEDSWORK: Given how chop_last_dir() works, this function is broken
  * when a local part has a colon in its path component, too.
  */
@@ -115,8 +140,7 @@ static char *relative_url(const char *remote_url,
 	struct strbuf sb = STRBUF_INIT;
 	size_t len = strlen(remoteurl);
 
-	if (is_dir_sep(remoteurl[len-1]))
-		remoteurl[len-1] = '\0';
+	strip_url_ending(remoteurl, &len);
 
 	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
 		is_relative = 0;
@@ -149,10 +173,10 @@ static char *relative_url(const char *remote_url,
 	}
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
-	if (ends_with(url, "/"))
-		strbuf_setlen(&sb, sb.len - 1);
 	free(remoteurl);
 
+	strip_url_ending(sb.buf, &sb.len);
+
 	if (starts_with_dot_slash(sb.buf))
 		out = xstrdup(sb.buf + 2);
 	else
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 25b48e5..e154e5f 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -329,14 +329,17 @@ test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule"
 test_submodule_relative_url "(null)" "//somewhere else/repo" "../subrepo" "//somewhere else/subrepo"
 test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
 test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
-test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
-test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
+test_submodule_relative_url "(null)" "$PWD/sub/." "../." "$(pwd)"
+test_submodule_relative_url "(null)" "$PWD/sub/./." "../." "$(pwd)"
+test_submodule_relative_url "(null)" "$PWD/sub/.////././/./." "../." "$(pwd)"
+test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)"
 test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)/repo"
 test_submodule_relative_url "(null)" "$PWD" "./å äö" "$(pwd)/å äö"
-test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$PWD/sub" "../submodule" "$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$PWD/sub/." "../submodule" "$(pwd)/submodule"
 test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "$(pwd)/submodule"
 test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle1" "$(pwd)/home2/../bundle1"
-test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./." "$(pwd)/submodule_update_repo/."
+test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./." "$(pwd)/submodule_update_repo"
 test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo" "file:///tmp/subrepo"
 test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/submodule"
 test_submodule_relative_url "(null)" "foo" "../submodule" "submodule"
-- 
2.10.1.480.g573bd76

