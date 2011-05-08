From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/4] git-sh-i18n.sh: add GIT_GETTEXT_POISON support
Date: Sun,  8 May 2011 12:10:58 +0000
Message-ID: <1304856659-10672-4-git-send-email-avarab@gmail.com>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:11:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2pq-0007jS-2w
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab1EHMLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:11:37 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44776 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab1EHMLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:11:36 -0400
Received: by eyx24 with SMTP id 24so1324709eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=dvpXbj2fWm5I8H8pYfKxnzUOm0brAOmV7yJhG2aqsk0=;
        b=azGfpyZyRTafI9AerP61Hk2J7K7WV2fhIF5zYP4QlgyCGS2X7Ss+14ugpaj3T85eQB
         z/I9Owc2U5gDU/IMlsM6j/yA2OqA2pizMkX1X1cYvJ/b8Krz/5hLdQ93t+1zOz7QdmZk
         45PBYybyP5sYRuoh66R5FpR2AXQ6PdF9gyg1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gSpYsUHabblKtF1k37i2JoY719tw7TLEbljy5gEOYT/IUimF+yW4eNyrxOs1eUa0xS
         m1IoYWvQbJ6C1qgcY1c8+mf2QmbEC22rI8ojGvCTcuBq4sA86pDgO2UNOB+1kk1HMyMR
         nXlpPr5zBURh1urX1ie8FNXjDx02exrXF1DPQ=
Received: by 10.213.22.73 with SMTP id m9mr1892799ebb.39.1304856695176;
        Sun, 08 May 2011 05:11:35 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id s62sm2713947eea.24.2011.05.08.05.11.34
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:11:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304856659-10672-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173101>

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
