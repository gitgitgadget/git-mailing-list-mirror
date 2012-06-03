From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: i18n: git-submodule message does not appear in git.pot
Date: Sun, 3 Jun 2012 16:05:24 +0800
Message-ID: <CANYiYbFrdNGpyTy3sVHPfm9R0bK-0S0Yh8BxxK4WkAbaaQRaNA@mail.gmail.com>
References: <4FC9FA97.7020908@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 10:06:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb5pT-00028r-Gr
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 10:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab2FCIFd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 04:05:33 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47044 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab2FCIF0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 04:05:26 -0400
Received: by obbtb18 with SMTP id tb18so5435106obb.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=omc5HH9mSXa/uzThtyFUQVdtJBE0BoWd3lMNvAny3sc=;
        b=FodWwPEECDCvAePTs3btM1fPOFgj9/6CVDdt7Y3k849SUwQRC59HJuFH0lqG7+Y7DF
         ail3uNxaJkQOfP0fhr83FQzwWr9sIsLsKZNY6jjawko7V4SVp8mRa427S37jboSLrZXP
         Hp/J1UPqWGdp8HvHND4E1DvsgfzWeezlgdX8CETho2ZARftGQFtKDw/XiHpk0a3rvACV
         twVeQP+J+ki1rcPK9GXEfZAziviKvvNppRPXCn6ZidjVNWGGPfVf3ii29PlhZW3TfPJo
         e3r9IumlHu0974eVoUFd+Hzm+3Yb6NP8uGtiZZpHoFJvpYL2P/wFNGti3u7roIOk5LDn
         ix0Q==
Received: by 10.50.159.202 with SMTP id xe10mr5312398igb.66.1338710724815;
 Sun, 03 Jun 2012 01:05:24 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Sun, 3 Jun 2012 01:05:24 -0700 (PDT)
In-Reply-To: <4FC9FA97.7020908@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199069>

2012/6/2 Vincent van Ravesteijn <vfr@lyx.org>:
> In commit b9b9c22f [1] the string "--cached cannot be used with --fil=
es" is
> translated using an extra "--" between "gettext" and the string. This=
 does
> not work because in the current git.pot file there is now:
>
> #: git-submodule.sh:713
> msgid "--"
> msgstr ""
>

It's really a trouble.

> Removing this exta "--" fixes the problem for me (GNU gettext v0.18.1=
)

You can not remove the extra '--', or gettext report error:

    $ gettext "--cached cannot be used with --files"
    gettext: unrecognized option '--cached cannot be used with --files'
    Try `gettext --help' for more information.

My fix is call gettextln in here instead of gettext, and in the gettext=
ln
function, we pass a extra '--' option between gettext and the message i=
d.

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 6a27f..dbabf 100644
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
@@ -68,10 +68,20 @@ poison)
 	;;
 *)
 	gettext () {
+		# Bypass options, such as '--'.
+		while test $# -gt 1
+		do
+			shift
+		done
 		printf "%s" "$1"
 	}

 	eval_gettext () {
+		# Bypass options, such as '--'.
+		while test $# -gt 1
+		do
+			shift
+		done
 		printf "%s" "$1" | (
 			export PATH $(git sh-i18n--envsubst --variables "$1");
 			git sh-i18n--envsubst "$1"
@@ -82,7 +92,7 @@ esac

 # Git-specific wrapper functions
 gettextln () {
-	gettext "$1"
+	gettext -- "$1"
 	echo
 }

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


>> [1] b9b9c22f; Aevar Arnfjord Bjarmason; Sat May 21 2011; i18n: git-s=
ubmodule
> "cached cannot be used" message.

In commit b9b9c22f, =C6var described this problem clearly.

commit b9b9c22f6db3e3c089098ba04fbc885e2cb4f4dd
Author: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
Date:   Sat May 21 18:44:03 2011 +0000

    i18n: git-submodule "cached cannot be used" message

    Gettextize the "--cached cannot be used with --files" message. Sinc=
e
    this message starts with "--" we have to pass "--" as the first
    argument. This works with both GNU gettext 0.18.1 (as expected), an=
d
    the gettext(1) on Solaris 10.

    Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


And I found another issue: since we have two extra gettext wrapper
gettextln and eval_gettextln, we should do somthing for xgettext in
Makefile, or messages marked by gettextln and eval_gettextln would
not extract to 'po/git.pot'.

diff --git a/Makefile b/Makefile
index 4592f..dc3fd 100644
--- a/Makefile
+++ b/Makefile
@@ -2333,7 +2333,8 @@ XGETTEXT_FLAGS =3D \
        --from-code=3DUTF-8
 XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=3DC \
        --keyword=3D_ --keyword=3DN_ --keyword=3D"Q_:1,2"
-XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShell
+XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShell \
+       --keyword=3Dgettextln --keyword=3Deval_gettextln
 XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --keyword=3D__ --language=3D=
Perl
 LOCALIZED_C :=3D $(C_OBJ:o=3Dc) $(LIB_H) $(XDIFF_H) $(VCSSVN_H) $(MISC=
_H)
 LOCALIZED_SH :=3D $(SCRIPT_SH)


--=20
Jiang Xin
