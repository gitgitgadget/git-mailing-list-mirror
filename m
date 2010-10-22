From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/7] commit/status -h: show usage even with broken
 configuration
Date: Fri, 22 Oct 2010 01:45:47 -0500
Message-ID: <20101022064547.GD6081@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:49:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9BRb-0003fm-55
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab0JVGte convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 02:49:34 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42659 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab0JVGtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:49:33 -0400
Received: by ywk9 with SMTP id 9so401104ywk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 23:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QHkjc10V6PJ9Bo936cZifeC+ElVYt7IhhRFwc9/vj0c=;
        b=xxyGyHlS76lb9JvoaStK81nczNqw7lmHV3/G/RGF9viAYwctWBCiYOVji+Bt/b/LuX
         I8ERTQyPo7IqmPWgvzO2DL0zZT1BEY6HvvuYL73U7ZH8c3VMqcJcr7L+Pkj8D4xmIJJ9
         5KdzBTppxJyAmhR6u1aGvk4qpE6jrZYSKvMSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=se5yl1vUaOdI4eX7FADpE1aCDLwlZAA1MSCn5sKAa1vzRqkJlfekaCWtqHbHbWmnko
         Eqb6yFlfx+1GS+S4fWPu0cvbDn02AXYf4Hm2xdJNEJIc8FNPwjF8gUXpEkLGtSUbYBvQ
         nMrNr9WiKhiuYuORZjHmSsuihnmXTw8EOvFxI=
Received: by 10.90.100.9 with SMTP id x9mr533202agb.64.1287730172961;
        Thu, 21 Oct 2010 23:49:32 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 43sm2094513yhl.37.2010.10.21.23.49.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 23:49:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101022063837.GA6081@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159653>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

"git status" and "git commit" read .git/config and .gitmodules before
parsing options, but there is no reason to access a repository at all
when the caller just wanted to know what arguments are accepted.

[jn: rewrote the log message and added test]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c  |    6 ++++++
 t/t7508-status.sh |   24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..0abb430 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1070,6 +1070,9 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		OPT_END(),
 	};
=20
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_status_usage, builtin_status_options);
+
 	if (null_termination && status_format =3D=3D STATUS_FORMAT_LONG)
 		status_format =3D STATUS_FORMAT_PORCELAIN;
=20
@@ -1255,6 +1258,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	int allow_fast_forward =3D 1;
 	struct wt_status s;
=20
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_commit_usage, builtin_commit_options);
+
 	wt_status_prepare(&s);
 	git_config(git_commit_config, &s);
 	in_merge =3D file_exists(git_path("MERGE_HEAD"));
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c9300f3..beaae94 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -7,6 +7,30 @@ test_description=3D'git status'
=20
 . ./test-lib.sh
=20
+test_expect_success 'status -h in broken repository' '
+	mkdir broken &&
+	test_when_finished "rm -fr broken" &&
+	(
+		cd broken &&
+		git init &&
+		echo "[status] showuntrackedfiles =3D CORRUPT" >>.git/config &&
+		test_expect_code 129 git status -h >usage 2>&1
+	) &&
+	grep "[Uu]sage" broken/usage
+'
+
+test_expect_success 'commit -h in broken repository' '
+	mkdir broken &&
+	test_when_finished "rm -fr broken" &&
+	(
+		cd broken &&
+		git init &&
+		echo "[status] showuntrackedfiles =3D CORRUPT" >>.git/config &&
+		test_expect_code 129 git commit -h >usage 2>&1
+	) &&
+	grep "[Uu]sage" broken/usage
+'
+
 test_expect_success 'setup' '
 	: >tracked &&
 	: >modified &&
--=20
1.7.2.3
