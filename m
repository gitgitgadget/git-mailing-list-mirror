Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108F720988
	for <e@80x24.org>; Tue, 18 Oct 2016 21:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755578AbcJRVGa (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 17:06:30 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34294 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754743AbcJRVG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 17:06:27 -0400
Received: by mail-pf0-f177.google.com with SMTP id r16so2660925pfg.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QG3nMGiszzSdpUQERmnV+IwyE7zs2ilIlco++ZdMbTM=;
        b=PJGhFhTdHlRaEDXGhDWveUXs0EntWQc0lwy6otUKJvcalwD/e2jBT60eJW4h4QUfX8
         QS3+SHzJfAecfDzrpwP+0fVNLCRcGpIRW4TPvai+POl3Ajb9q+kQkOhp1GQhfj6+eMax
         gGQpFwIZBfSxIo0n6ilbg6GuZQIsq/KvL6s1ey+mkj9VN1rh5nD61Uz1rd2r6Be7g12u
         k9TgCoL5qsNrl1QZ8cjFlI1RAGnRndtYmpi85ew2OtJtr+kXq5nFGdMkX0Y/DN54FsbL
         K0iYRJhcHgDfxgsJJVQOA9hkCEXEto+AOnvdktGv/TX0+yd0OX14rmDsyQLxPyqS4++0
         hgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QG3nMGiszzSdpUQERmnV+IwyE7zs2ilIlco++ZdMbTM=;
        b=bwiuqOjv/hjN4pukXg/nFu/mLq0zjM+7ZmTVa4vLfQIGHzJmDmTn/OIK0iJ6XcRjWJ
         MDx/jtWYUZjrimNVpx3nBgAxyKpg9yxx7+PqWkr9FUBRFEvOOww3vrKnAYLeio9eyHf9
         MbSgbVY5vuSfnO8Mk3e5EvNifnN02RC6f1cDrtwlbREiNAIyJKIiniLpBQCBG69PFsK6
         0yr5fBCKe8f1Cvi2Y6RvxpcNrH4iUGfuGez8bw4JKr4matISfnMN5PFxBTukZeIDa6Jd
         FwF9W9ImyNKbfSCUTkydT4XH5xTj+rIIhbRyN9twingPNqF7aokopb0EF7VPoB2iPeag
         aUEg==
X-Gm-Message-State: AA6/9Rl5CvlE58R6KTwTQ8yza9aFJfUdjrYSiIUEWlEe1ok81qfQzp0HSCquGvPLgMNbyHs3
X-Received: by 10.99.100.132 with SMTP id y126mr3272478pgb.67.1476824786633;
        Tue, 18 Oct 2016 14:06:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:352c:25b6:cb52:1b0b])
        by smtp.gmail.com with ESMTPSA id z11sm43989476pfd.49.2016.10.18.14.06.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Oct 2016 14:06:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, j6t@kdbg.org, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, venv21@gmail.com, dennis@kaarsemaker.net,
        jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] submodule--helper: normalize funny urls
Date:   Tue, 18 Oct 2016 14:06:23 -0700
Message-Id: <20161018210623.32696-1-sbeller@google.com>
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
v3:
 * fixed the coding style.

v2:
 * reworded the commit message, taken from Junio, but added more explanation
   why we want to introduce this patch. 
 * added the length check
 * use an infinite loop with break instead of a variable
   to determine the ending condition.
   
 builtin/submodule--helper.c | 48 +++++++++++++++++++++++++++++++++------------
 t/t0060-path-utils.sh       | 11 +++++++----
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 260f46f..4f11082 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -76,6 +76,29 @@ static int chop_last_dir(char **remoteurl, int is_relative)
 	return 0;
 }
 
+static void strip_url_ending(char *url, size_t *len_)
+{
+	size_t len = len_ ? *len_ : strlen(url);
+
+	for (;;) {
+		if (len > 1 && is_dir_sep(url[len - 2]) && url[len - 1] == '.') {
+			url[len - 2] = '\0';
+			len -= 2;
+			continue;
+		}
+		if (len > 0 && is_dir_sep(url[len - 1])) {
+			url[len - 1] = '\0';
+			len--;
+			continue;
+		}
+
+		break;
+	}
+
+	if (len_)
+		*len_ = len;
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

