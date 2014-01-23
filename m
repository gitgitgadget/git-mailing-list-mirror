From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] t4010: match_pathspec_depth() and trailing slash after submodule
Date: Thu, 23 Jan 2014 20:22:06 +0700
Message-ID: <1390483326-32258-2-git-send-email-pclouds@gmail.com>
References: <2550653.GHkhBQDSTk@localhost.localdomain>
 <1390483326-32258-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pawel.sikora@agmk.net, Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 23 14:16:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6K9O-0005dW-Nh
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 14:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbaAWNQo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jan 2014 08:16:44 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:49220 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbaAWNQn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 08:16:43 -0500
Received: by mail-pa0-f53.google.com with SMTP id lj1so1838251pab.12
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 05:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fe1azAWGeR9h4PwN0w7tIjjGKO/LPIwxWSNE9vDlBlk=;
        b=zZtH0I+6iArS4Rn+SI587Ygdsur5fmK+Fd6WO4Snwt2ew2L0WcPgx22YLlADNmOgI7
         zExLVNdFYcPTvCO4eSzOaGtBN2/dw50X1TFDXeC4wy0WZ0rfalpeRfv95JS9DMvgypBm
         wpamnI0etgshJbykKcjd378htjBmJbezZP99hiVNRVD4wCNhJOMgyLqM4+YunSiuUf7a
         SFDkPYzw+r9napsBEl62R0r4iwn9hyuUbWSKB9CkI85JPFKGH6Hk0YQJpxA6emsqb4UT
         U7GCMZFw4TEL38s39aJcoIDTAojj02v4H3co0GwUajOQhQvgIgwdO5sYUuFhcMMk9WMI
         JnJA==
X-Received: by 10.66.190.198 with SMTP id gs6mr8076162pac.49.1390483002787;
        Thu, 23 Jan 2014 05:16:42 -0800 (PST)
Received: from lanh ([115.73.226.163])
        by mx.google.com with ESMTPSA id qz9sm36426370pbc.3.2014.01.23.05.16.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 05:16:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 23 Jan 2014 20:22:16 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240912>

When you do "git diff HEAD submodule/", "submodule" from the index is
picked out and match_pathspec_depth() in charge of matching it with
the pathspec "submodule/".

Unlike tree_entry_interesting(), match_pathspec_depth() has no
knowledge about entry mode to realize "submodule" is a directory and
treat the trailing slash specially. And it does not have too, mostly,
because the index only contains files, not directories (not until
submodules come)

I have no solutions for it (no, stripping '/' at pathspec
preprocessing phase seems like a workaround than a solution). So let's
mark it. Maybe I or somebody else could revisit it later.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4010-diff-pathspec.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 15a4912..b54251a 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -127,4 +127,10 @@ test_expect_success 'diff-tree ignores trailing sl=
ash on submodule path' '
 	test_cmp expect actual
 '
=20
+test_expect_failure 'diff-cache ignores trailing slash on submodule pa=
th' '
+	git diff --name-only HEAD^ submod >expect &&
+	git diff --name-only HEAD^ submod/ >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.8.5.2.240.g8478abd
