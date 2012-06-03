From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 2/2] i18n: Add extra -- to seperate gettext and message
Date: Mon,  4 Jun 2012 07:09:27 +0800
Message-ID: <1338764967-30103-2-git-send-email-worldhello.net@gmail.com>
References: <1338764967-30103-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 01:09:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbJvl-0006lE-DI
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 01:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab2FCXJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 19:09:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53328 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab2FCXJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 19:09:44 -0400
Received: by pbbrp8 with SMTP id rp8so5211795pbb.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 16:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tQmaz5CVHnhHl8MheqhVPG8c09gQjwKSXdBlA3TO5OE=;
        b=MqGcg8lhYUb403JGw3fICWb9EeQzyi/GiXrKMaIo1zA7P1EibL5R43QE/QXbfNOIso
         lLxjoeDLByO/KpIstbyhgwvnMFcKsj6er/PRfgFDF/ulRChMz9CEDKFseNgehv57N2Kj
         g52cFmzqvFFLudBoSS8ArkSDVL9BpTIVdt0bjiDd65qL2xfujfIb1lFj4z7MGGMKs/tp
         Z/x9YaTuHzk86WXRjS/m1/nfFIRFkmc/1h8wBS1AK2bwthn/SIcZYK3GyXbGALlsOw5S
         oNlF6s5+5G5cZjJl2udS66jsfCAFjR1Y5UYNtGcn+BaoykVuULBUMQ8lrEXxqvnvg9kL
         Iv+g==
Received: by 10.68.138.161 with SMTP id qr1mr27692405pbb.37.1338764984446;
        Sun, 03 Jun 2012 16:09:44 -0700 (PDT)
Received: from localhost.localdomain (li381-10.members.linode.com. [106.187.38.10])
        by mx.google.com with ESMTPS id ph1sm11041070pbb.45.2012.06.03.16.09.41
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Jun 2012 16:09:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.559.g0ba0f00
In-Reply-To: <1338764967-30103-1-git-send-email-worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199113>

In commit b9b9c22, =C3=86var addressed a issue when gettextized a messa=
ge
started with "--", such as "--cached cannot be used with --files", the
first word in the message would be treated as an option of gettext, and
might raise a bad option error.

The solution =C3=86var provided is to add a extra "--" option between g=
ettext
and the message. But Vincent fount out later that the extra "--" was
extracted as gettext message by xgettext instead of the real message.
See:

 * http://thread.gmane.org/gmane.comp.version-control.git/199042

In order to fix this dilemma, we move the extra "--" option from gettex=
t
to gettext wrapper (gettextln, and eval_gettext), and gettextize the
message using the wrapper function instead of gettext itself.

But for system with libintl's gettext.sh, eval_gettext and
eval_gettextln won't have this fix.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 git-sh-i18n.sh   | 8 ++++++--
 git-submodule.sh | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 6a27f..1c61e4 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -49,7 +49,7 @@ gnu)
 gettext_without_eval_gettext)
 	# Solaris has a gettext(1) but no eval_gettext(1)
 	eval_gettext () {
-		gettext "$1" | (
+		gettext -- "$1" | (
 			export PATH $(git sh-i18n--envsubst --variables "$1");
 			git sh-i18n--envsubst "$1"
 		)
@@ -68,10 +68,14 @@ poison)
 	;;
 *)
 	gettext () {
+		# Bypass options, such as '--'.
+		shift $(($# - 1))
 		printf "%s" "$1"
 	}
=20
 	eval_gettext () {
+		# Bypass options, such as '--'.
+		shift $(($# - 1))
 		printf "%s" "$1" | (
 			export PATH $(git sh-i18n--envsubst --variables "$1");
 			git sh-i18n--envsubst "$1"
@@ -82,7 +86,7 @@ esac
=20
 # Git-specific wrapper functions
 gettextln () {
-	gettext "$1"
+	gettext -- "$1"
 	echo
 }
=20
diff --git a/git-submodule.sh b/git-submodule.sh
index 5c61a..bb9f6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -710,7 +710,7 @@ cmd_summary() {
 	if [ -n "$files" ]
 	then
 		test -n "$cached" &&
-		die "$(gettext -- "--cached cannot be used with --files")"
+		die "$(gettextln "--cached cannot be used with --files")"
 		diff_cmd=3Ddiff-files
 		head=3D
 	fi
--=20
1.7.10.2.559.g0ba0f00
