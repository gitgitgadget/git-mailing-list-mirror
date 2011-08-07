From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 1/5] gettext: add gettextln, eval_gettextln to encode common idiom
Date: Sun,  7 Aug 2011 21:58:13 +1000
Message-ID: <1312718297-10999-2-git-send-email-jon.seymour@gmail.com>
References: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: avarab@gmail.com, Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 13:58:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq20E-0007uK-NT
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 13:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab1HGL6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Aug 2011 07:58:34 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53879 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab1HGL6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 07:58:32 -0400
Received: by pzk37 with SMTP id 37so6636287pzk.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WpEQdSP/97GtHLOq7Y+EnW0CUO2nEiJnGl2AG+YB6/U=;
        b=E/gAk5xvmcBNqpadurgaXIy18I2YMm5vZyFojNSy4M0BqaNYjO5Ir7FdFjj+6iVjRX
         3jnZj8/W9IyQoql+hOrOS4QHnoeLnqgpT7VekMf3h40Dp1u0H7B7wfTbBgiGfdSKztWj
         //iS8uqnk9ion3gbbdXIQgmN4idry7Oemkg1k=
Received: by 10.142.2.38 with SMTP id 38mr2524534wfb.374.1312718312394;
        Sun, 07 Aug 2011 04:58:32 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id s7sm2183465pbj.5.2011.08.07.04.58.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 04:58:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.363.g9b380.dirty
In-Reply-To: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178904>

Currently, if you want to use gettext or eval_gettext to format a messa=
ge
you may have to add a separate echo statement and a surrounding subshel=
l
in order to interpolate the required trailing new line.

This patch introduces two new helper functions, gettextln and eval_gett=
extln
which append a trailing newline to the gettext output.

This allows constructions of the form:

	if test -s "$GIT_DIR/BISECT_START"
	then
		(
			gettext "You need to give me at least one good and one bad revisions=
=2E
(You can use \"git bisect bad\" and \"git bisect good\" for that.)" &&
			echo
		) >&2
	else
	...

to be expressed more concisely as:

	if test -s "$GIT_DIR/BISECT_START"
	then
		gettextln "You need to give me at least one good and one bad revision=
s.
(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
	else
	...

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-sh-i18n.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 32ca59d..e672366 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -11,19 +11,38 @@ then
 		printf "%s" "$1"
 	}
=20
+	gettextln() {
+		printf "%s\n" "$1"
+	}
+
 	eval_gettext () {
 		printf "%s" "$1" | (
 			export PATH $(git sh-i18n--envsubst --variables "$1");
 			git sh-i18n--envsubst "$1"
 		)
 	}
+
+	eval_gettextln () {
+		printf "%s\n" "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
+	}
 else
 	gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
=20
+	gettextln () {
+		printf "%s\n" "# GETTEXT POISON #"
+	}
+
 	eval_gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
+
+	eval_gettextln () {
+		printf "%s\n" "# GETTEXT POISON #"
+	}
 fi
=20
--=20
1.7.6.363.g9b380.dirty
