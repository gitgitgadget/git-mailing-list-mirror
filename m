From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [bug] generic issue with git_config handlers
Date: Tue, 5 Feb 2008 00:13:20 +0100
Message-ID: <200802050013.20335.chriscool@tuxfamily.org>
References: <20080131091627.GB24403@artemis.madism.org> <200802040727.44522.chriscool@tuxfamily.org> <47A74503.4090201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git ML <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 00:08:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMAPz-0000bV-Pg
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 00:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757093AbYBDXHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2008 18:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756604AbYBDXHW
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 18:07:22 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:56007 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756279AbYBDXHU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 18:07:20 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5EC031AB2AA;
	Tue,  5 Feb 2008 00:07:19 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2413D1AB2A9;
	Tue,  5 Feb 2008 00:07:19 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <47A74503.4090201@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72589>

Le lundi 4 f=E9vrier 2008, Johannes Sixt a =E9crit :
> Christian Couder schrieb:
> >                         return -1;
> >         }
> > -       return fn(name, value);
> > +       return fn(name, value ? value : "");
> >  }
>
> You can't. The reason is that get_config_bool() treats value =3D=3D N=
ULL and
> *value =3D=3D '\0' differently. *That's* the most unfortunate part of=
 it. :-(

You are right. We have this (in config.c:299):

int git_config_bool(const char *name, const char *value)
{
	if (!value)
		return 1;
	if (!*value)
		return 0;
	if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
		return 1;
	if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
		return 0;
	return git_config_int(name, value) !=3D 0;
}

Very unfortunate.

I finally had the following patch that passed all tests (it changed onl=
y one=20
test), in case someone wants to suggest that we change git_config_bool,=
=20
hint, hint!

Thanks,
Christian.

---8<---
diff --git a/builtin-config.c b/builtin-config.c
index e4a12e3..b92cf4b 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -20,7 +20,7 @@ static enum { T_RAW, T_INT, T_BOOL } type =3D T_RAW;

 static int show_all_config(const char *key_, const char *value_)
 {
-       if (value_)
+       if (value_ && *value_)
                printf("%s%c%s%c", key_, delim, value_, term);
        else
                printf("%s%c", key_, term);
@@ -42,7 +42,7 @@ static int show_config(const char* key_, const char*=20
value_)
                return 0;

        if (show_keys) {
-               if (value_)
+               if (value_ && *value_)
                        printf("%s%c", key_, key_delim);
                else
                        printf("%s", key_);
diff --git a/config.c b/config.c
index 526a3f4..a2c7214 100644
--- a/config.c
+++ b/config.c
@@ -131,7 +131,7 @@ static int get_value(config_fn_t fn, char *name,=20
unsigned in
        while (c =3D=3D ' ' || c =3D=3D '\t')
                c =3D get_next_char();

-       value =3D NULL;
+       value =3D "";
        if (c !=3D '\n') {
                if (c !=3D '=3D')
                        return -1;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index a786c5c..deb11dc 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -611,8 +611,7 @@ foo
 barQsection.sub=3Dsection.val3


-Qsection.sub=3Dsection.val4
-Qsection.sub=3Dsection.val5Q
+Qsection.sub=3Dsection.val4Qsection.sub=3Dsection.val5Q
 EOF

 git config --null --list | tr '\000' 'Q' > result
---8<---
