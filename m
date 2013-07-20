From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/16] config: add core.noshallow to prevent turning a repo into a shallow one
Date: Sat, 20 Jul 2013 16:58:09 +0700
Message-ID: <1374314290-5976-16-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:59:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Twu-0001l6-R2
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753Ab3GTJ7d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:59:33 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:41276 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab3GTJ7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:59:32 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so10982339ief.26
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Af9rJNJtIbHYYdCzTUe5rcgBn2eVadLiyYJKhuz7lts=;
        b=onoc3pCH+Pdgey92o53sEsIUrGq9TPEdGXP4UMTQQoNWrMCatxNmn57mtpd8cWf1nU
         9YCe4ScsQbXiY4XTLxX7rA25Mm57aP1ev19XmdcxUnGIrtJWgM1vbOak9knTWYG2vXO2
         egK3VfthY3Itx1qMf0UDVNRCmbtlgVHNzWIQ6f7ll0hGpDRsm4c7A7km0VFqO6+H9LeE
         5U3i5cyWttDbG1Py/tpfrUPZAzA7+jJN2ZFLuJezL5oXDoIh1aTBcm16/M7YS0ZyZXbn
         2YYmqWLhwjrU7T07oGOOY5Mb87zk1Pv/sN/alWN4F91qf/fuX052AJ/a59X9jMb+y938
         ze+g==
X-Received: by 10.42.228.1 with SMTP id jc1mr13480097icb.92.1374314371677;
        Sat, 20 Jul 2013 02:59:31 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id fu2sm21107216igb.3.2013.07.20.02.59.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:59:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:59:50 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230893>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 5 +++++
 builtin/receive-pack.c   | 9 ++++++++-
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 1 +
 fetch-pack.c             | 9 ++++++++-
 t/t5536-fetch-shallow.sh | 9 +++++++++
 t/t5537-push-shallow.sh  | 6 ++++++
 8 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 81856dd..e811180 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -655,6 +655,11 @@ core.abbrev::
 	for abbreviated object names to stay unique for sufficiently long
 	time.
=20
+core.noshallow::
+	If true, reject any pushes or fetches that may turn the
+	repository into a shallow one. This setting is ignored if the
+	repository is already shallow.
+
 add.ignore-errors::
 add.ignoreErrors::
 	Tells 'git add' to continue adding files when some files cannot be
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 54bf6b2..95ea481 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -936,7 +936,14 @@ static const char *unpack(int err_fd)
 					&shallow,
 					WRITE_SHALLOW_NO_CUT |
 					WRITE_SHALLOW_REWRITE);
-		commit_lock_file(&shallow_lock);
+		if (*alternate_shallow_file =3D=3D '\0') {
+			unlink_or_warn(git_path("shallow"));
+			rollback_lock_file(&shallow_lock);
+		} else {
+			if (!is_repository_shallow() && cannot_be_shallow)
+				die("not allowed to turn this repository into a shallow one");
+			commit_lock_file(&shallow_lock);
+		}
 	}
 	return NULL;
 }
diff --git a/cache.h b/cache.h
index 7f17228..3a52b08 100644
--- a/cache.h
+++ b/cache.h
@@ -592,6 +592,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
+extern int cannot_be_shallow;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/config.c b/config.c
index d04e815..31f5a57 100644
--- a/config.c
+++ b/config.c
@@ -784,6 +784,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.noshallow")) {
+		cannot_be_shallow =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 0cb67b2..14c8005 100644
--- a/environment.c
+++ b/environment.c
@@ -61,6 +61,7 @@ int merge_log_config =3D -1;
 int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition=
() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
+int cannot_be_shallow;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/fetch-pack.c b/fetch-pack.c
index f337526..40e7aa2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -960,7 +960,14 @@ struct ref *fetch_pack(struct fetch_pack_args *arg=
s,
 							WRITE_SHALLOW_NO_CUT |
 							WRITE_SHALLOW_REWRITE);
 			}
-			commit_lock_file(&shallow_lock);
+			if (*alternate_shallow_file =3D=3D '\0') {
+				unlink_or_warn(git_path("shallow"));
+				rollback_lock_file(&shallow_lock);
+			} else {
+				if (!is_repository_shallow() && cannot_be_shallow)
+					die("not allowed to turn this repository into a shallow one");
+				commit_lock_file(&shallow_lock);
+			}
 		}
 	}
=20
diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
index 6ea6347..b7f89b1 100755
--- a/t/t5536-fetch-shallow.sh
+++ b/t/t5536-fetch-shallow.sh
@@ -102,6 +102,15 @@ EOF
=20
 '
=20
+test_expect_success 'core.noshallow' '
+	git init clean &&
+	(
+	cd clean &&
+	git config core.noshallow true &&
+	test_must_fail git fetch ../shallow/.git
+	)
+'
+
 if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
 	say 'skipping remaining tests, git built without http support'
 	test_done
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
index 8bea496..0edd51f 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -108,6 +108,12 @@ EOF
 	)
 '
=20
+test_expect_success 'core.noshallow' '
+	git init clean &&
+	git --git-dir=3Dclean/.git config core.noshallow true &&
+	test_must_fail git --git-dir=3Dshallow/.git push clean master:refs/re=
motes/shallow/master
+'
+
 if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
 	say 'skipping remaining tests, git built without http support'
 	test_done
--=20
1.8.2.83.gc99314b
