From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] Support environment variables in config file
Date: Mon, 4 Jun 2007 00:37:27 +0200
Message-ID: <20070603223727.GA16637@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 00:37:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from pat.uio.no ([129.240.10.15])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huyhi-0001Lf-Hk
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:37:42 +0200
Received: from mail-mx2.uio.no ([129.240.10.30])
	by pat.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Huyhi-0001x9-El
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:37:42 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx2.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Huyhe-0007Kt-SX
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbXFCWhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 18:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXFCWhb
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 18:37:31 -0400
Received: from mail.admingilde.org ([213.95.32.147]:54011 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbXFCWhb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 18:37:31 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HuyhU-0005PJ-Sh
	for git@vger.kernel.org; Mon, 04 Jun 2007 00:37:29 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.0, required=12.0, autolearn=disabled, UIO_VGER=-3)
X-UiO-Scanned: F2E24FE0C8E22CF552716FCD4C96B9300E3D63BC
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -29 maxlevel 200 minaction 2 bait 0 mail/h: 48 total 266766 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49044>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Environment variables (e.g. $HOME) can be helpful for the GIT configuration.
With this change you can use them with the normal shell "$" syntax.
If you want to insert a plain "$" in a variable, it can be escaped as \$
or put inside quotes (").

Signed-off-by: Martin Waitz <tali@admingilde.org>
---

I found this particularly useful to be able to specify my own global
gitignore list via core.excludesfile.

 Documentation/config.txt |   23 +++++++++++++++--------
 config.c                 |   23 +++++++++++++++++++++--
 t/t1300-repo-config.sh   |   13 +++++++++++++
 3 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5868d58..042a354 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -65,17 +65,24 @@ a string, an integer, or a boolean.  Boolean values may=
 be given as yes/no,
 converting value to the canonical form using '--bool' type specifier;
 `git-config` will ensure that the output is "true" or "false".
=20
+You can use the $VARIABLE shell syntax to use environment variables
+in the configuration file.  All alpha-numeric characters after the
+leading '`$`' will be interpreted as name of an environment variable
+and the value of this variable will be used instead.
+If the variable does not exist it will be treated as an empty string.
+
 String values may be entirely or partially enclosed in double quotes.
 You need to enclose variable value in double quotes if you want to
 preserve leading or trailing whitespace, or if variable value contains
-beginning of comment characters (if it contains '#' or ';').
-Double quote '`"`' and backslash '`\`' characters in variable value must
-be escaped: use '`\"`' for '`"`' and '`\\`' for '`\`'.
-
-The following escape sequences (beside '`\"`' and '`\\`') are recognized:
-'`\n`' for newline character (NL), '`\t`' for horizontal tabulation (HT, T=
AB)
-and '`\b`' for backspace (BS).  No other char escape sequence, nor octal
-char sequences are valid.
+beginning of comment characters (if it contains '#' or ';') or a dollar
+sign which would be interpreted as a variable.
+Double quote '`"`', backslash '`\`' and dollar '`$`' characters in variable
+value must be escaped: use '`\"`' for '`"`' and '`\\`' for '`\`'.
+
+The following escape sequences (beside '`\"`', '`\$"`' and '`\\`') are
+recognized: '`\n`' for newline character (NL), '`\t`' for horizontal tabul=
ation
+(HT, TAB) and '`\b`' for backspace (BS).  No other char escape sequence, n=
or
+octal char sequences are valid.
=20
 Variable value ending in a '`\`' is continued on the next line in the
 customary UNIX fashion.
diff --git a/config.c b/config.c
index 0614c2b..058c0df 100644
--- a/config.c
+++ b/config.c
@@ -43,12 +43,27 @@ static int get_next_char(void)
 static char *parse_value(void)
 {
 	static char value[1024];
-	int quote =3D 0, comment =3D 0, len =3D 0, space =3D 0;
+	int quote =3D 0, comment =3D 0, envvar =3D -1, len =3D 0, space =3D 0;
=20
 	for (;;) {
 		int c =3D get_next_char();
 		if (len >=3D sizeof(value))
 			return NULL;
+		if ((envvar >=3D 0) && !isalnum(c)) {
+			const char *var;
+			value[len] =3D 0;
+			var =3D getenv(&value[envvar]);
+			if (var) {
+				strncpy(&value[envvar], var,
+				        sizeof(value) - envvar);
+				if (value[sizeof(value)-1])
+					return NULL;
+				len =3D envvar + strlen(&value[envvar]);
+			} else {
+				len =3D envvar;
+			}
+			envvar =3D -1;
+		}
 		if (c =3D=3D '\n') {
 			if (quote)
 				return NULL;
@@ -66,6 +81,10 @@ static char *parse_value(void)
 				comment =3D 1;
 				continue;
 			}
+			if (c =3D=3D '$') {
+				envvar =3D len;
+				continue;
+			}
 		}
 		if (space) {
 			if (len)
@@ -87,7 +106,7 @@ static char *parse_value(void)
 				c =3D '\n';
 				break;
 			/* Some characters escape as themselves */
-			case '\\': case '"':
+			case '\\': case '"': case '$':
 				break;
 			/* Reject unknown escape sequences */
 			default:
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3f3fd2d..eb84437 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -513,5 +513,18 @@ git config --list > result
=20
 test_expect_success 'value continued on next line' 'cmp result expect'
=20
+cat > .git/config <<\EOF
+[quoted]
+	withvar =3D "$HOME/foo"
+[unquoted]
+	withvar =3D $HOME/foo
+EOF
+
+test_expect_success 'quoted $VAR' \
+	'test x"\$HOME/foo" =3D x$(git config quoted.withvar)'
+
+test_expect_success 'unquoted $VAR' \
+	'test x"$HOME/foo" =3D x$(git config unquoted.withvar)'
+
 test_done
=20
--=20
1.5.2.1.112.gdb0c


--=20
Martin Waitz

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGY0Kmj/Eaxd/oD7IRAui4AJwKgTqDwXEd77mov8j2ipjPc6W22wCeOvpY
usFJ3jvfDRqqDOTsuaryLag=
=rygI
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
