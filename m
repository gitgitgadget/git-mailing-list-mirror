From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 3/4] git-sh-i18n.sh: add GIT_GETTEXT_POISON support
Date: Sat, 14 May 2011 13:47:44 +0000
Message-ID: <1305380865-21339-4-git-send-email-avarab@gmail.com>
References: <1305380865-21339-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 15:48:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLFCU-0007GJ-Sh
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 15:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757859Ab1ENNsF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 09:48:05 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52890 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757616Ab1ENNsA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 09:48:00 -0400
Received: by eyx24 with SMTP id 24so916703eyx.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=dvpXbj2fWm5I8H8pYfKxnzUOm0brAOmV7yJhG2aqsk0=;
        b=nXWimX2Se2C4kJkH5gcEj6lI/0LAnDLijK0wEfpTs0nPxTtc6wCu1lqJkBFkSteWzh
         JZ6Ikw2NNkD0mawgFILRKD+wH4axUwyI4n8Yt2j8hGRlN34UYyJ3b1gHHbkpiOdLM9zu
         sWrRLDDwSPkUi3jynjYgSfj/afwe1/DM9MM00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GlnJXr2akB6cohNXSzZSgA8tLs3LbyMhjgJVgvlcBlVcJ54WltyF0KZ9am4zFAafTn
         NRPWmBMWwst9Vcl9OCWQ2mnGAxzGQV9CyrCa07bCs0WHvCIdFA49CXz/2/vMGDnHbz1g
         C3zeEEjAdmu+nmvlicJoziaDJr6Ynio1g4t34=
Received: by 10.14.2.67 with SMTP id 43mr1015581eee.74.1305380879052;
        Sat, 14 May 2011 06:47:59 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y9sm2110298eeh.8.2011.05.14.06.47.58
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 06:47:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1305380865-21339-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173588>

Change git-sh-i18n.sh to support the GIT_GETTEXT_POISON environment
variable like gettext.c does, this ensures that tests that use
git-sh-i18n.sh will fail under GETTEXT_POISON=3DYesPlease if they rely
on Git's C locale messages without declaring that they do.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-sh-i18n.sh |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index ea05e16..32ca59d 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -5,13 +5,25 @@
 # This is a skeleton no-op implementation of gettext for Git. It'll be
 # replaced by something that uses gettext.sh in a future patch series.
=20
-gettext () {
-	printf "%s" "$1"
-}
+if test -z "$GIT_GETTEXT_POISON"
+then
+	gettext () {
+		printf "%s" "$1"
+	}
+
+	eval_gettext () {
+		printf "%s" "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
+	}
+else
+	gettext () {
+		printf "%s" "# GETTEXT POISON #"
+	}
+
+	eval_gettext () {
+		printf "%s" "# GETTEXT POISON #"
+	}
+fi
=20
-eval_gettext () {
-	printf "%s" "$1" | (
-		export PATH $(git sh-i18n--envsubst --variables "$1");
-		git sh-i18n--envsubst "$1"
-	)
-}
--=20
1.7.4.4
