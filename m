From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Value size limits on git config files
Date: Tue, 5 Apr 2011 19:01:27 +0200
Message-ID: <BANLkTimLxPdr=mGJfxmdKkeq0zouxz05Uw@mail.gmail.com>
References: <BANLkTikknAiYr4y-it3+qZ3dnXE56dQBoQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff Adamson <jwa@urbancode.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 19:02:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q79dn-0002F1-Tp
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 19:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab1DERCG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 13:02:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36599 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468Ab1DERCE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 13:02:04 -0400
Received: by pzk9 with SMTP id 9so218438pzk.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5GH9EvQ1VtsVrk9R4Roi149bw7WbXk8fz5e4z+OUvvE=;
        b=KYzNmXskf9Bo0P+iPlMPE7f8tmg254h4qhkUHRf6G3fZ95285rIKXohmleJlfO7811
         kB7GZ8UhOgN0vjCFdTm02HBx6LJnsRoDbV2kIhul8UBzpKvrQcMK+h66QECEsC6pM52U
         YH3QJA/vUrDu3woSrlNyMFHRHQ+5iWcV9WugE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=cAijzVpDoiCmmd/AoMuNe4uOvlJ+HI7SlDXQwAl3LaErcIBDw9bc5q2Z8XISN80Z+U
         0ACGBcbaq2tCwaDgmAY39JJZTIan7lOSzkBsjtt+3v9uatheLVQczGil+7eCyXRb+UZr
         wbDsiff/QO97YtJPo0dBmKsA7yCiM0arPn2s4=
Received: by 10.142.192.9 with SMTP id p9mr1352003wff.421.1302022924208; Tue,
 05 Apr 2011 10:02:04 -0700 (PDT)
Received: by 10.68.50.198 with HTTP; Tue, 5 Apr 2011 10:01:27 -0700 (PDT)
In-Reply-To: <BANLkTikknAiYr4y-it3+qZ3dnXE56dQBoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170888>

On Tue, Apr 5, 2011 at 6:29 PM, Jeff Adamson <jwa@urbancode.com> wrote:
> When trying to=A0incorporate=A0large aliases into my ~/.gitconfig fil=
e via
> `git config --global "!$(cat myscript)"`, I determined that there
> appears to be a limit to the size of a value. =A0When exceeded, git
> prints out "fatal: bad config file line 82 in ~/.gitconfig". =A0I was
> able to strip enough comments and such from myscript that it then no
> longer invalidated the config once the value was less than 1024 chars=
=2E
> =A0(Minor aside, I am doing this as a small experiment to potentially
> aid in=A0synchronizing=A0all my git=A0behaviors=A0across machines by =
inlining
> them into the config file. =A0Whether this is a good path to explore =
or
> not is a separate issue.)
>
> My questions are:
> =A0 =A0Is this 1024 char limit on config file values documented somew=
here?
> =A0 =A0Should it be considered a bug that git config can write out co=
nfig
> files which it can not then read (e.g. it should be changed to either
> enforce the value-length limit during writing, or the parser updated
> to handle large values)?
>

It's due to use of a fixed-size buffer. This patch fixes it for me:

diff --git a/config.c b/config.c
index 0abcada..bc6ea49 100644
--- a/config.c
+++ b/config.c
@@ -133,23 +133,20 @@ static int get_next_char(void)

 static char *parse_value(void)
 {
-	static char value[1024];
-	int quote =3D 0, comment =3D 0, len =3D 0, space =3D 0;
+	struct strbuf value =3D STRBUF_INIT;
+	int quote =3D 0, comment =3D 0, space =3D 0;

 	for (;;) {
 		int c =3D get_next_char();
-		if (len >=3D sizeof(value) - 1)
-			return NULL;
 		if (c =3D=3D '\n') {
 			if (quote)
 				return NULL;
-			value[len] =3D 0;
-			return value;
+			return strbuf_detach(&value, NULL);
 		}
 		if (comment)
 			continue;
 		if (isspace(c) && !quote) {
-			if (len)
+			if (value.len)
 				space++;
 			continue;
 		}
@@ -160,7 +157,7 @@ static char *parse_value(void)
 			}
 		}
 		for (; space; space--)
-			value[len++] =3D ' ';
+			strbuf_addch(&value, ' ');
 		if (c =3D=3D '\\') {
 			c =3D get_next_char();
 			switch (c) {
@@ -180,16 +177,17 @@ static char *parse_value(void)
 				break;
 			/* Reject unknown escape sequences */
 			default:
+				strbuf_release(&value);
 				return NULL;
 			}
-			value[len++] =3D c;
+			strbuf_addch(&value, c);
 			continue;
 		}
 		if (c =3D=3D '"') {
 			quote =3D 1-quote;
 			continue;
 		}
-		value[len++] =3D c;
+		strbuf_addch(&value, c);
 	}
 }

@@ -200,7 +198,7 @@ static inline int iskeychar(int c)

 static int get_value(config_fn_t fn, void *data, char *name, unsigned =
int len)
 {
-	int c;
+	int c, ret;
 	char *value;

 	/* Get the full name */
@@ -226,7 +224,9 @@ static int get_value(config_fn_t fn, void *data,
char *name, unsigned int len)
 		if (!value)
 			return -1;
 	}
-	return fn(name, value, data);
+	ret =3D fn(name, value, data);
+	free(value);
+	return ret;
 }

 static int get_extended_base_var(char *name, int baselen, int c)
