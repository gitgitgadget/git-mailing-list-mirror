From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH] git-mailinfo fixes for patch munging
Date: Fri, 30 Mar 2007 12:18:45 -0400
Message-ID: <20070330161845.GI11029@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 18:20:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXJpw-0007Je-RF
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 18:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbXC3QUV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 30 Mar 2007 12:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbXC3QUV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 12:20:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43896 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872AbXC3QUU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 12:20:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2UGKIbe029018
	for <git@vger.kernel.org>; Fri, 30 Mar 2007 12:20:18 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2UGKDnF005737
	for <git@vger.kernel.org>; Fri, 30 Mar 2007 12:20:13 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2UGKDOX027740
	for <git@vger.kernel.org>; Fri, 30 Mar 2007 12:20:13 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2UGIjqo005823
	for <git@vger.kernel.org>; Fri, 30 Mar 2007 12:18:45 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2UGIjAm005822
	for git@vger.kernel.org; Fri, 30 Mar 2007 12:18:45 -0400
X-Authentication-Warning: drseuss.boston.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Don't translate the patch to UTF-8, instead preserve the data as is.  A=
lso
allow overwriting the primary mail headers (addresses Linus's concern).=
 =20

I also revert a test case that was included in the original patch.  Now=
 it
makes sense why it was the way it was. :)

Cheers,
Don


diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index d94578c..71b6457 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -294,14 +294,14 @@ static char *header[MAX_HDR_PARSED] =3D {
 	"From","Subject","Date",
 };
=20
-static int check_header(char *line, char **hdr_data)
+static int check_header(char *line, char **hdr_data, int overwrite)
 {
 	int i;
=20
 	/* search for the interesting parts */
 	for (i =3D 0; header[i]; i++) {
 		int len =3D strlen(header[i]);
-		if (!hdr_data[i] &&
+		if ((!hdr_data[i] || overwrite) &&
 		    !strncasecmp(line, header[i], len) &&
 		    line[len] =3D=3D ':' && isspace(line[len + 1])) {
 			/* Unwrap inline B and Q encoding, and optionally
@@ -614,6 +614,7 @@ static int find_boundary(void)
=20
 static int handle_boundary(void)
 {
+	char newline[]=3D"\n";
 again:
 	if (!memcmp(line+content_top->boundary_len, "--", 2)) {
 		/* we hit an end boundary */
@@ -628,7 +629,7 @@ again:
 					"can't recover\n");
 			exit(1);
 		}
-		handle_filter("\n");
+		handle_filter(newline);
=20
 		/* skip to the next boundary */
 		if (!find_boundary())
@@ -643,7 +644,7 @@ again:
=20
 	/* slurp in this section's info */
 	while (read_one_header_line(line, sizeof(line), fin))
-		check_header(line, p_hdr_data);
+		check_header(line, p_hdr_data, 1);
=20
 	/* eat the blank line after section info */
 	return (fgets(line, sizeof(line), fin) !=3D NULL);
@@ -699,10 +700,14 @@ static int handle_commit_msg(char *line)
 			if (!*cp)
 				return 0;
 		}
-		if ((still_looking =3D check_header(cp, s_hdr_data)) !=3D 0)
+		if ((still_looking =3D check_header(cp, s_hdr_data, 0)) !=3D 0)
 			return 0;
 	}
=20
+	/* normalize the log message to UTF-8. */
+	if (metainfo_charset)
+		convert_to_utf8(line, charset);
+
 	if (patchbreak(line)) {
 		fclose(cmitmsg);
 		cmitmsg =3D NULL;
@@ -767,12 +772,8 @@ static void handle_body(void)
 				return;
 		}
=20
-		/* Unwrap transfer encoding and optionally
-		 * normalize the log message to UTF-8.
-		 */
+		/* Unwrap transfer encoding */
 		decode_transfer_encoding(line);
-		if (metainfo_charset)
-			convert_to_utf8(line, charset);
=20
 		switch (transfer_encoding) {
 		case TE_BASE64:
@@ -875,7 +876,7 @@ int mailinfo(FILE *in, FILE *out, int ks, const cha=
r *encoding,
=20
 	/* process the email header */
 	while (read_one_header_line(line, sizeof(line), fin))
-		check_header(line, p_hdr_data);
+		check_header(line, p_hdr_data, 1);
=20
 	handle_body();
 	handle_info();
diff --git a/t/t5100/patch0005 b/t/t5100/patch0005
index e7d6f66..7d24b24 100644
--- a/t/t5100/patch0005
+++ b/t/t5100/patch0005
@@ -61,7 +61,7 @@ diff --git a/git-cvsimport-script b/git-cvsimport-scr=
ipt
  		push(@old,$fn);
=20
 --=20
-David K=C3=A5gedal
+David K=E5gedal
 -
 To unsubscribe from this list: send the line "unsubscribe git" in
 the body of a message to majordomo@vger.kernel.org
