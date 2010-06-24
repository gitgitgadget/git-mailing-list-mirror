From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] fetch: don't output non-errors on stderr
Date: Thu, 24 Jun 2010 22:34:41 +0000
Message-ID: <1277418881-11286-1-git-send-email-avarab@gmail.com>
References: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 25 00:35:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORv15-00030N-Il
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 00:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734Ab0FXWfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 18:35:20 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:38509 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab0FXWfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 18:35:18 -0400
Received: by wwi17 with SMTP id 17so644455wwi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=L7RwX4HCsXoCy+oIuZO9MKB0yMxeqO6RYaLHgT9JbE0=;
        b=JjmaUsyuxWQK2zu8FXcSyPFT4B7JUYDiArPlxcJG7t44/z4tUjga5mrewqTJsNTRWF
         w0nC1Fzmm8i8hiSEo+aZKs2ss/Y44K3l33F8xDLi4BNlY9JNMFp3DHsMokV/a5v1J77V
         8zPsF/SGg8E9+AYbdAcLsDNohVt24bMlNJqo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xgET+wU0frAgsFqOxFdmDLUPsFOI5LRfSsf73G0WD0NXWIhyqVJIougWV8YuT89LfB
         OldsCvQv2Ok/RvFf5hjktlXFSA4slAOBDCeeRmduwEMkg2S8AtPbu2vp0Y8IaT4zLgmQ
         btYjwIGNlcnpS9IctF0ElXnXjkt+MQuVIZ1vs=
Received: by 10.216.184.3 with SMTP id r3mr4406672wem.55.1277418915840;
        Thu, 24 Jun 2010 15:35:15 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id s47sm1187134wec.13.2010.06.24.15.35.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 15:35:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149656>

Change git-fetch to only print to stderr if it has encountered an
error.

A normal branch update (like "* branch HEAD -> FETCH_HEAD") is no
longer output to stderr but on stdout. Genuine errors (like
"[rejected]" messages) still go to stderr.

With this change I can run a cron script I've been developing
(http://github.com/avar/github-backup) without redirecting stderr to
/dev/null.

Before the change error messages were drowned out by git-fetch's
non-error update notices, which didn't need my attention.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Sat, Jun 12, 2010 at 16:52, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

> Shouldn't that fprintf() be called as:
>
> =C2=A0 =C2=A0fprintf((rc ? stderr : stdout), ...)

To answer my own question: Yes it should. This patch fixes git-fetch
so that it doesn't taint stderr with non-error messages.

The small changes to the test suite that this requires is a testiment
to how bad our test coverage is in this area. As far as I can see the
error messages that update_local_ref can emit aren't being tested
for. Fixing that is outside the scope of this patch, however.

 builtin/fetch.c         |    5 +++--
 t/t5521-pull-options.sh |   12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5cb369c..116b322 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -397,13 +397,14 @@ static int store_updated_refs(const char *raw_url=
, const char *remote_name,
 				TRANSPORT_SUMMARY_WIDTH, *kind ? kind : "branch",
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
+			FILE *fout =3D rc ? stderr : stdout;
 			if (verbosity >=3D 0 && !shown_url) {
-				fprintf(stderr, "From %.*s\n",
+				fprintf(fout, "From %.*s\n",
 						url_len, url);
 				shown_url =3D 1;
 			}
 			if (verbosity >=3D 0)
-				fprintf(stderr, " %s\n", note);
+				fprintf(fout, " %s\n", note);
 		}
 	}
 	free(url);
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 1b06691..7ec36e7 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -23,16 +23,16 @@ test_expect_success 'git pull' '
 	mkdir cloned &&
 	(cd cloned && git init &&
 	git pull "../parent" >out 2>err &&
-	test -s err &&
-	test ! -s out)
+	test ! -s err &&
+	test -s out)
 '
=20
 test_expect_success 'git pull -v' '
 	mkdir clonedv &&
 	(cd clonedv && git init &&
 	git pull -v "../parent" >out 2>err &&
-	test -s err &&
-	test ! -s out)
+	test ! -s err &&
+	test -s out)
 '
=20
 test_expect_success 'git pull -v -q' '
@@ -47,8 +47,8 @@ test_expect_success 'git pull -q -v' '
 	mkdir clonedqv &&
 	(cd clonedqv && git init &&
 	git pull -q -v "../parent" >out 2>err &&
-	test ! -s out &&
-	test -s err)
+	test ! -s err &&
+	test -s out)
 '
=20
 test_expect_success 'git pull --force' '
--=20
1.7.1.251.g92a7
