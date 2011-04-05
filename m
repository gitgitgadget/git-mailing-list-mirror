From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] config: support values longer than 1024 bytes
Date: Wed, 6 Apr 2011 01:38:57 +0200
Message-ID: <BANLkTimXEK-_qZrSbV_nBofyyDfa22YEbQ@mail.gmail.com>
References: <1302046203-4408-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jwa@urbancode.com, drew.northup@maine.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 01:39:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7FqG-00055h-K5
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 01:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab1DEXjU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 19:39:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45752 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab1DEXjS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 19:39:18 -0400
Received: by bwz15 with SMTP id 15so713854bwz.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ywZ68XF6s78KsNyRZkoLqp/+KBpXEZ23IS3XWp9afZo=;
        b=WNppI5PA9gMrSERl6iHlaFAq/6vYdpnpSWVlkBEToRacXGs1RnKU+kcPFDC4syOakf
         6NoVwsHGuPY2haOlYmfvnLlcuuQVSvH4VyvkbCy4ECAJ+lk7vYQC6jngXz5d4JbjMDUY
         uqVaJ6R5sLl/6M5We49SWLqr0TjSNsejVlcgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=nMIeyIUxoUqza8wgovR91LkrHfaGOUEBXg97vCWLq99QjPpF+7SguRU13J3yYEc3Qs
         o0sRGt4H7h/1WoWCa3UPh5mg7vrh2Uuhq4ZLlEE6360yP3bv/t7vsUw5x/tLg78Ut3zP
         ESjgX6uCQxpI/+nFf6kzZJYweMN+gfgz7wW0c=
Received: by 10.204.84.5 with SMTP id h5mr192546bkl.201.1302046757154; Tue, 05
 Apr 2011 16:39:17 -0700 (PDT)
Received: by 10.204.172.130 with HTTP; Tue, 5 Apr 2011 16:38:57 -0700 (PDT)
In-Reply-To: <1302046203-4408-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170942>

Ugh, I should learn not to send out patches way past my bed-time. This
should have been marked as RFC, and the subject should probably say
"1023 bytes", since one byte was needed for zero-termination.

Sorry for the noise.

On Wed, Apr 6, 2011 at 1:30 AM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
> parse_value in config.c has a static buffer of 1024 bytes that it
> parse the value into. This can sometimes be a problem when a
> config file contains very long values.
>
> It's particularly amusing that git-config already is able to write
> such files, so it should probably be able to read them as well.
>
> Fix this by using a strbuf instead of a static buffer.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> Here's a proper-ish submission with a commit message and all.
>
> The rather awkward return statement with strdup("") is because
> strbuf_detach returns NULL when there's nothing allocated. Even
> worse, it returns an uninitialized string if the string has been
> initialized with a non-zero 'hint'.
>
> Perhaps I should change it to return a heap-allocated, empty
> string in those cases instead of working around it here?
>
> =A0config.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 26 ++++++++++++++---=
---------
> =A0t/t1303-wacky-config.sh | =A0 =A02 +-
> =A02 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/config.c b/config.c
> index 0abcada..f882f7c 100644
> --- a/config.c
> +++ b/config.c
> @@ -133,23 +133,22 @@ static int get_next_char(void)
>
> =A0static char *parse_value(void)
> =A0{
> - =A0 =A0 =A0 static char value[1024];
> - =A0 =A0 =A0 int quote =3D 0, comment =3D 0, len =3D 0, space =3D 0;
> + =A0 =A0 =A0 struct strbuf value =3D STRBUF_INIT;
> + =A0 =A0 =A0 int quote =3D 0, comment =3D 0, space =3D 0;
>
> =A0 =A0 =A0 =A0for (;;) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int c =3D get_next_char();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len >=3D sizeof(value) - 1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (c =3D=3D '\n') {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (quote)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value[len] =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return value.len ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_detach(&=
value, NULL) :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strdup("");

Should have used xstrdup()...

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (comment)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (isspace(c) && !quote) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value.len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0space+=
+;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -160,7 +159,7 @@ static char *parse_value(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (; space; space--)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value[len++] =3D ' ';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addch(&value, ' =
');
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (c =3D=3D '\\') {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c =3D get_next_char();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (c) {
> @@ -180,16 +179,17 @@ static char *parse_value(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Reject unknown esca=
pe sequences */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_=
release(&value);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value[len++] =3D c;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addch(&value, c)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (c =3D=3D '"') {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0quote =3D 1-quote;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 value[len++] =3D c;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addch(&value, c);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -200,7 +200,7 @@ static inline int iskeychar(int c)
>
> =A0static int get_value(config_fn_t fn, void *data, char *name, unsig=
ned int len)
> =A0{
> - =A0 =A0 =A0 int c;
> + =A0 =A0 =A0 int c, ret;
> =A0 =A0 =A0 =A0char *value;
>
> =A0 =A0 =A0 =A0/* Get the full name */
> @@ -226,7 +226,9 @@ static int get_value(config_fn_t fn, void *data, =
char *name, unsigned int len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!value)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 return fn(name, value, data);
> + =A0 =A0 =A0 ret =3D fn(name, value, data);
> + =A0 =A0 =A0 free(value);
> + =A0 =A0 =A0 return ret;
> =A0}
>
> =A0static int get_extended_base_var(char *name, int baselen, int c)
> diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
> index 080117c..46103a1 100755
> --- a/t/t1303-wacky-config.sh
> +++ b/t/t1303-wacky-config.sh
> @@ -44,7 +44,7 @@ LONG_VALUE=3D$(printf "x%01021dx a" 7)
> =A0test_expect_success 'do not crash on special long config line' '
> =A0 =A0 =A0 =A0setup &&
> =A0 =A0 =A0 =A0git config section.key "$LONG_VALUE" &&
> - =A0 =A0 =A0 check section.key "fatal: bad config file line 2 in .gi=
t/config"
> + =A0 =A0 =A0 check section.key "$LONG_VALUE"
> =A0'
>
> =A0test_done
> --
> 1.7.4.msysgit.0.168.g33778
>
>
