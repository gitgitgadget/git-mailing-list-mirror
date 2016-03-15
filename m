From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Port `git submodule init` from shell to C
Date: Mon, 14 Mar 2016 17:15:50 -0700
Message-ID: <1458000952-4043-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, jrnieder@gmail.com, j6t@kdbg.org,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 01:16:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afcen-0001jE-7P
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 01:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbcCOAQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2016 20:16:13 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33506 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbcCOAQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 20:16:11 -0400
Received: by mail-pf0-f181.google.com with SMTP id 124so2342578pfg.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 17:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKLqWPpffsvk+t2jrOQD27bVXy/ueb4oWmWbYpKzYgc=;
        b=fs2Bs6LRkZl45YO5CuaBhSmiqCXfPnDmhDhk/3jEQfjmCM4SWQWczBFM+GO7goTiHT
         1YClRHbTfxOXa7zmj5+d+eiP4C9gehVS/GGmibfrGYXZm/v8iftBnsaTqjS/BmaFBX1A
         QAu6KDg0kkOvxPb6r6IHVxa+3SsPau1r/g+rDoi9uETBSsvMUVuzYVLsVgY3TpeTzcTw
         VfnAGYpSAYBRtNzEpJcCw21vvTPY7f1PZ2wJc2F4ZZs99PZhD8fa0gFDluW16ITbRyx6
         c7aMS4mnFczxzTkzH8+5G3nB6pyytJ8TRz3q45+9YQ35TvSng7S0vT/ENtwSmJgxqgrj
         2mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKLqWPpffsvk+t2jrOQD27bVXy/ueb4oWmWbYpKzYgc=;
        b=Jp/+1a2vZkB0J0XGwuxSVjDBdaWw7w6G39LqLus/w7+eOFadH64XIABF1DjPZ0h0Ys
         9Dw+kz4FVwLz7qPKrNQNW7vpsxCBdzzLYYnM3X/KDpo4ffYfJQhxiSgY6BpYuWFuiRXA
         y8AXZjPwV/sJSgNrfIO2DXBK/DBjcB2HA2No1e7rJVYEjUC0trx8lNI5mTffo3Kd9vYO
         VwRHRH60M/l5nApXZB89Ic0kXTkn7O/2DkL8tpqsZVgTEWBlML5PVO53F9Xj0MbDaiAL
         sUUbi0a02w8wwtXA/Gj+ozmcu7N57WKB/tRsji/5si/stzcUWSGUSnGOXiKHIIXDaQ++
         LIfQ==
X-Gm-Message-State: AD7BkJKhU2J4tuiCtjfyHp5kfHlUWQ1Lnljk7F7LQoENFfR5iSyUw0aFAkQtszRJ3byE+BPN
X-Received: by 10.66.102.70 with SMTP id fm6mr41709701pab.98.1458000970134;
        Mon, 14 Mar 2016 17:16:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:cd15:2957:d1ba:58])
        by smtp.gmail.com with ESMTPSA id e6sm34706804pfj.71.2016.03.14.17.16.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Mar 2016 17:16:08 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.46.g8f16ed4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288824>

This applies on top of origin/sb/submodule-parallel-update.
By having the `init` functionality in C, we can reference it easier
from other parts in the code.

Thanks for the reviews a long time ago!

Junio,
  I fixed the NEEDSWORK comment for relative_url
  and thought about the memory allocation
Duy,
  I fixed the i18n issues introduced.
Johannes,
  I took $PWD instead of absolute paths. According to your last message=
, this
  may still break on Windows for=20
test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle1=
" "$PWD/home2/../bundle1"

There are however no further tests starting with /.

Thanks,
Stefan

Stefan Beller (2):
  submodule: port resolve_relative_url from shell to C
  submodule: port init from shell to C

 builtin/submodule--helper.c | 317 ++++++++++++++++++++++++++++++++++++=
+++++++-
 git-submodule.sh            | 118 +----------------
 submodule.c                 |  21 +++
 submodule.h                 |   1 +
 t/t0060-path-utils.sh       |  43 ++++++
 5 files changed, 385 insertions(+), 115 deletions(-)

Diff to origin/sb/submodule-init:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 213af2e..d942463 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -22,7 +22,7 @@ static char *get_default_remote(void)
 	const char *refname =3D resolve_ref_unsafe("HEAD", 0, sha1, &flag);
=20
 	if (!refname)
-		die("No such ref: HEAD");
+		die(_("No such ref: %s"), "HEAD");
=20
 	/* detached HEAD */
 	if (!strcmp(refname, "HEAD"))
@@ -94,12 +94,14 @@ static int chop_last_dir(char **remoteurl, int is_r=
elative)
  * the superproject working tree otherwise.
  *
  * NEEDSWORK: This works incorrectly on the domain and protocol part.
- * remote_url      url              outcome          correct
- * http://a.com/b  ../c             http://a.com/c   yes
- * http://a.com/b  ../../c          http://c         no (domain should=
 be kept)
- * http://a.com/b  ../../../c       http:/c          no
- * http://a.com/b  ../../../../c    http:c           no
- * http://a.com/b  ../../../../../c    .:c           no
+ * remote_url      url              outcome          expectation
+ * http://a.com/b  ../c             http://a.com/c   as is
+ * http://a.com/b  ../../c          http://c         error out
+ * http://a.com/b  ../../../c       http:/c          error out
+ * http://a.com/b  ../../../../c    http:c           error out
+ * http://a.com/b  ../../../../../c    .:c           error out
+ * NEEDSWORK: Given how chop_last_dir() works, this function is broken
+ * when a local part has a colon in its path component, too.
  */
 static char *relative_url(const char *remote_url,
 				const char *url,
@@ -146,6 +148,7 @@ static char *relative_url(const char *remote_url,
 	}
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
+	free(remoteurl);
=20
 	if (starts_with_dot_slash(sb.buf))
 		out =3D xstrdup(sb.buf + 2);
@@ -153,7 +156,6 @@ static char *relative_url(const char *remote_url,
 		out =3D xstrdup(sb.buf);
 	strbuf_reset(&sb);
=20
-	free(remoteurl);
 	if (!up_path || !is_relative)
 		return out;
=20
@@ -299,7 +301,7 @@ static int module_init(int argc, const char **argv,=
 const char *prefix)
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("alternative anchor for relative paths")),
-		OPT__QUIET(&quiet, "Suppress output for initialzing a submodule"),
+		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule"=
)),
 		OPT_END()
 	};
=20
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 8a1579c..579c1fa 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -293,35 +293,36 @@ test_git_path GIT_COMMON_DIR=3Dbar config        =
           bar/config
 test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/packed=
-refs
 test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/shallo=
w
=20
-test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../f=
oo/sub/a/b/c"
+test_submodule_relative_url "../" "../foo" "../submodule" "../../submo=
dule"
+test_submodule_relative_url "../" "../foo/bar" "../submodule" "../../f=
oo/submodule"
+test_submodule_relative_url "../" "../foo/submodule" "../submodule" ".=
=2E/../foo/submodule"
+test_submodule_relative_url "../" "./foo" "../submodule" "../submodule=
"
+test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo/s=
ubmodule"
 test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" ".=
=2E/../../../foo/sub/a/b/c"
+test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$PWD/repo"
+test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/sub=
module"
+test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
+
+test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../f=
oo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "../f=
oo/submodule"
-test_submodule_relative_url "../" "../foo/bar" "../submodule" "../../f=
oo/submodule"
 test_submodule_relative_url "(null)" "../foo/submodule" "../submodule"=
 "../foo/submodule"
-test_submodule_relative_url "../" "../foo/submodule" "../submodule" ".=
=2E/../foo/submodule"
 test_submodule_relative_url "(null)" "../foo" "../submodule" "../submo=
dule"
-test_submodule_relative_url "../" "../foo" "../submodule" "../../submo=
dule"
 test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo/s=
ubmodule"
-test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo/s=
ubmodule"
 test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule=
"
-test_submodule_relative_url "../" "./foo" "../submodule" "../submodule=
"
 test_submodule_relative_url "(null)" "//somewhere else/repo" "../subre=
po" "//somewhere else/subrepo"
-test_submodule_relative_url "(null)" "/u//trash directory.t7406-submod=
ule-update/subsuper_update_r" "../subsubsuper_update_r" "/u//trash dire=
ctory.t7406-submodule-update/subsubsuper_update_r"
-test_submodule_relative_url "(null)" "/u//trash directory.t7406-submod=
ule-update/super_update_r2" "../subsuper_update_r" "/u//trash directory=
=2Et7406-submodule-update/subsuper_update_r"
-test_submodule_relative_url "(null)" "/u/trash directory.t3600-rm/." "=
=2E./." "/u/trash directory.t3600-rm/."
-test_submodule_relative_url "(null)" "/u/trash directory.t3600-rm" "./=
=2E" "/u/trash directory.t3600-rm/."
-test_submodule_relative_url "(null)" "/u/trash directory.t7400-submodu=
le-basic/addtest" "../repo" "/u/trash directory.t7400-submodule-basic/r=
epo"
-test_submodule_relative_url "../" "/u/trash directory.t7400-submodule-=
basic/addtest" "../repo" "/u/trash directory.t7400-submodule-basic/repo=
"
-test_submodule_relative_url "(null)" "/u/trash directory.t7400-submodu=
le-basic" "./=C3=A5 =C3=A4=C3=B6" "/u/trash directory.t7400-submodule-b=
asic/=C3=A5 =C3=A4=C3=B6"
-test_submodule_relative_url "(null)" "/u/trash directory.t7403-submodu=
le-sync/." "../submodule" "/u/trash directory.t7403-submodule-sync/subm=
odule"
-test_submodule_relative_url "(null)" "/u/trash directory.t7407-submodu=
le-foreach/submodule" "../submodule" "/u/trash directory.t7407-submodul=
e-foreach/submodule"
-test_submodule_relative_url "(null)" "/u/trash directory.t7409-submodu=
le-detached-worktree/home2/../remote" "../bundle1" "/u/trash directory.=
t7409-submodule-detached-worktree/home2/../bundle1"
-test_submodule_relative_url "(null)" "/u/trash directory.t7613-merge-s=
ubmodule/submodule_update_repo" "./." "/u/trash directory.t7613-merge-s=
ubmodule/submodule_update_repo/."
+test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subs=
ubsuper_update_r" "$PWD/subsubsuper_update_r"
+test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsup=
er_update_r" "$PWD/subsuper_update_r"
+test_submodule_relative_url "(null)" "$PWD/." "../." "$PWD/."
+test_submodule_relative_url "(null)" "$PWD" "./." "$PWD/."
+test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$PWD/re=
po"
+test_submodule_relative_url "(null)" "$PWD" "./=C3=A5 =C3=A4=C3=B6" "$=
PWD/=C3=A5 =C3=A4=C3=B6"
+test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$PWD/sub=
module"
+test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "=
$PWD/submodule"
+test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle=
1" "$PWD/home2/../bundle1"
+test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./.=
" "$PWD/submodule_update_repo/."
 test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo" "=
file:///tmp/subrepo"
 test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/sub=
module"
-test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/sub=
module"
 test_submodule_relative_url "(null)" "foo" "../submodule" "submodule"
-test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
 test_submodule_relative_url "(null)" "helper:://hostname/repo" "../sub=
repo" "helper:://hostname/subrepo"
 test_submodule_relative_url "(null)" "ssh://hostname/repo" "../subrepo=
" "ssh://hostname/subrepo"
 test_submodule_relative_url "(null)" "ssh://hostname:22/repo" "../subr=
epo" "ssh://hostname:22/subrepo"


--=20
2.7.0.rc0.46.g8f16ed4.dirty
