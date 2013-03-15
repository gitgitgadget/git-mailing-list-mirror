From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 43/45] pathspec: make --literal-pathspecs disable pathspec magic
Date: Fri, 15 Mar 2013 13:06:58 +0700
Message-ID: <1363327620-29017-44-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:29:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO8v-00009q-9k
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab3COG3C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:29:02 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:45093 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab3COG3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:29:00 -0400
Received: by mail-ie0-f171.google.com with SMTP id 10so3996883ied.2
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KZUJb0R1rFTgWcS+Ft0zHzS6oDgrAYelUwy9c3/Y3yU=;
        b=RnznKqtIfB61fnG3k+B1+f3pSHe4fNUCysJgO+Gjdp9/RYEmi53GdZc48/+CV9jcwf
         cy0Tqv6wjK6NkgrWNePHoQ68pJP3Pv3XZixAafvDN/VBmLM+mwsHGx/3GK6ARR4aZVZt
         GPAk9iiudxf5Upoap3SFIedQFwEWRE936fEhSKXh9DwXKl6LnnkO4o7BrLqZnHyOVcWf
         I2jxLXGAyPJ3HG+BUbPEv+JNRGzsEvpAEvK209U6pVl4G5fy/4A6Tq3pisbBpzZboWmc
         Z6HXd5L1XZ/X30/DJF2KTx4O/HjA3E+rLPWcnhbwnYfichSMvxVjnP4KujSNmmWC80hu
         lvTg==
X-Received: by 10.43.88.134 with SMTP id ba6mr3911688icc.18.1363328940367;
        Thu, 14 Mar 2013 23:29:00 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id dy5sm762693igc.1.2013.03.14.23.28.56
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:28:59 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:12:01 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218230>

--literal-pathspecs and its equivalent environment variable are
probably used for scripting. In that setting, pathspec magic may be
unwanted. Disabling globbing in individual pathspec can be done via
:(literal) magic.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt | 4 ++--
 pathspec.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7efaa59..3bbbbdc 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -439,8 +439,8 @@ help ...`.
 	linkgit:git-replace[1] for more information.
=20
 --literal-pathspecs::
-	Treat pathspecs literally, rather than as glob patterns. This is
-	equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
+	Treat pathspecs literally (i.e. no globbing, no pathspec magic).
+	This is equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
 	variable to `1`.
=20
=20
diff --git a/pathspec.c b/pathspec.c
index e57196d..61a47b8 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -103,7 +103,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	if (literal_global)
 		global_magic |=3D PATHSPEC_LITERAL;
=20
-	if (elt[0] !=3D ':') {
+	if (elt[0] !=3D ':' || literal_global) {
 		; /* nothing to do */
 	} else if (elt[1] =3D=3D '(') {
 		/* longhand */
--=20
1.8.0.rc0.19.g7bbb31d
