From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/6] Make 'git var GIT_PAGER' always print the configured
 pager
Date: Sun, 14 Feb 2010 05:59:59 -0600
Message-ID: <20100214115959.GB3499@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:00:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngd92-0000Zb-5t
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 13:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab0BNMAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 07:00:05 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:62013 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0BNMAC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 07:00:02 -0500
Received: by iwn39 with SMTP id 39so1361970iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 04:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0u5vSDWm2lQ11EO9jYVdL6GcX9fR+Iq3V97t39fw+y4=;
        b=As8SLPdTRri8ZJYsTGBAJF4sTrBzrGNJ9Wm1gTUzQ1Qw+71C217EWyXcV9kql6l4T7
         bK+9/bXhXdbVFlRvN6QM2pZT1KInmgS0mhmq/rvofW3D5wJSLvO2ZI2LhJp6kn89Kf/r
         IL6yDL4mz2jujjrE7ENBmyeBL/VuL/ewsH7vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Vlweq0AUnqGgjgpXyhzA2/6EzYbA5g8Zdr1LDgtXVDycIOlKIQGLI1mAIQXxOHXTZP
         8QU2nltUbSDGSEI3RIBE4hWop/kjrKZgxZ11mJHyt60yC0Jq/IYS7JFK4zzyfLayLZrG
         oS3Sxs5YqW9R7DJYoe0NIeklg3m2rrkm+LvrY=
Received: by 10.231.145.74 with SMTP id c10mr2690091ibv.51.1266148801680;
        Sun, 14 Feb 2010 04:00:01 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm5160550iwn.7.2010.02.14.04.00.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 04:00:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100214115430.GA1849@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139902>

Scripted commands that want to use git=E2=80=99s configured pager know =
better
than =E2=80=98git var=E2=80=99 does whether stdout is going to be a tty=
 at the
appropriate time.  Checking isatty(1) as git_pager() does now won=E2=80=
=99t
cut it, since the output of git var itself is almost never a terminal.
The symptom is that when used by humans, =E2=80=98git var GIT_PAGER=E2=80=
=99 behaves
as it should, but when used by scripts, it always returns =E2=80=98cat=E2=
=80=99!

So avoid tricks with isatty() and just always print the configured
pager.

This does not fix the callers to check isatty(1) themselves yet.
Nevertheless, this patch alone is enough to fix 'am --interactive'.

Thanks to Sebastian Celis for the report and Jeff King for the
analysis.

Reported-by: Sebastian Celis <sebastian@sebastiancelis.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-var.c |    2 +-
 cache.h       |    2 +-
 pager.c       |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-var.c b/builtin-var.c
index e6ee7bc..70fdb4d 100644
--- a/builtin-var.c
+++ b/builtin-var.c
@@ -20,7 +20,7 @@ static const char *editor(int flag)
=20
 static const char *pager(int flag)
 {
-	const char *pgm =3D git_pager();
+	const char *pgm =3D git_pager(1);
=20
 	if (!pgm)
 		pgm =3D "cat";
diff --git a/cache.h b/cache.h
index d478eff..d454b7e 100644
--- a/cache.h
+++ b/cache.h
@@ -775,7 +775,7 @@ extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, cons=
t char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
 extern const char *git_editor(void);
-extern const char *git_pager(void);
+extern const char *git_pager(int stdout_is_tty);
=20
 struct checkout {
 	const char *base_dir;
diff --git a/pager.c b/pager.c
index 2c7e8ec..dac358f 100644
--- a/pager.c
+++ b/pager.c
@@ -48,11 +48,11 @@ static void wait_for_pager_signal(int signo)
 	raise(signo);
 }
=20
-const char *git_pager(void)
+const char *git_pager(int stdout_is_tty)
 {
 	const char *pager;
=20
-	if (!isatty(1))
+	if (!stdout_is_tty)
 		return NULL;
=20
 	pager =3D getenv("GIT_PAGER");
@@ -73,7 +73,7 @@ const char *git_pager(void)
=20
 void setup_pager(void)
 {
-	const char *pager =3D git_pager();
+	const char *pager =3D git_pager(isatty(1));
=20
 	if (!pager)
 		return;
--=20
1.7.0
