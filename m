From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Mon, 29 Dec 2008 23:15:50 +0100
Message-ID: <49594C16.2010406@lsrfire.ath.cx>
References: <1230338961.8363.101.camel@ubuntu.ubuntu-domain> <200812280024.59096.markus.heidelberg@web.de> <4956C47B.4020602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 23:17:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHQQN-0004eu-Uz
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 23:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbYL2WP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 17:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbYL2WP7
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 17:15:59 -0500
Received: from india601.server4you.de ([85.25.151.105]:59523 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbYL2WP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 17:15:58 -0500
Received: from [10.0.1.101] (p57B7FA67.dip.t-dialin.net [87.183.250.103])
	by india601.server4you.de (Postfix) with ESMTPSA id 4F3342F803F;
	Mon, 29 Dec 2008 23:15:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <4956C47B.4020602@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104133>

Ren=C3=A9 Scharfe schrieb:
> Markus Heidelberg schrieb:
>> Sorry, I haven't tested your patch set, what is the output of
>> git-shortlog like now?
>=20
> It's unchanged since it has it's own commit message parser.

=2E.. which displays the first line of the commit message, unlike
--pretty=3Doneline.  Here's a quick fix.  I probably won't have time
to come up with something prettier this year.

Ren=C3=A9


 builtin-shortlog.c |    9 ++++++---
 pretty.c           |    4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index d03f14f..e492906 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -29,6 +29,9 @@ static int compare_by_number(const void *a1, const vo=
id *a2)
 		return -1;
 }
=20
+const char *format_subject(struct strbuf *sb, const char *msg,
+			   const char *line_separator);
+
 static void insert_one_record(struct shortlog *log,
 			      const char *author,
 			      const char *oneline)
@@ -41,6 +44,7 @@ static void insert_one_record(struct shortlog *log,
 	size_t len;
 	const char *eol;
 	const char *boemail, *eoemail;
+	struct strbuf subject =3D STRBUF_INIT;
=20
 	boemail =3D strchr(author, '<');
 	if (!boemail)
@@ -89,9 +93,8 @@ static void insert_one_record(struct shortlog *log,
 	while (*oneline && isspace(*oneline) && *oneline !=3D '\n')
 		oneline++;
 	len =3D eol - oneline;
-	while (len && isspace(oneline[len-1]))
-		len--;
-	buffer =3D xmemdupz(oneline, len);
+	format_subject(&subject, oneline, " ");
+	buffer =3D strbuf_detach(&subject, NULL);
=20
 	if (dot3) {
 		int dot3len =3D strlen(dot3);
diff --git a/pretty.c b/pretty.c
index 343dca5..421d9c5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -486,8 +486,8 @@ static void parse_commit_header(struct format_commi=
t_context *context)
 	context->commit_header_parsed =3D 1;
 }
=20
-static const char *format_subject(struct strbuf *sb, const char *msg,
-				  const char *line_separator)
+const char *format_subject(struct strbuf *sb, const char *msg,
+			   const char *line_separator)
 {
 	int first =3D 1;
=20
