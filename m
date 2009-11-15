From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [RFC] format-patch: Ensure that author and commit time are not lost
Date: Sun, 15 Nov 2009 14:25:21 +0100
Message-ID: <4B000141.5070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 14:25:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9f6s-0007iZ-Dv
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 14:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbZKONZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 08:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbZKONZT
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 08:25:19 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:10439 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbZKONZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 08:25:18 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1612085eyd.19
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 05:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=aBJ2yzuB4RPf6LG4iDoR8SIm6mtD+Ln6mxUHevcKGqI=;
        b=Q+cP2dsYZwQDLFI5fRbQKS+Kbd6ijEl2tMlNFLekKnzzxsCQQdATDUir19NVAWdee2
         PQf+ZdXV7etb5TIQGbgWgM0R/d9G327InbAzJY3l7DmI83x4/H5/o1LcRuXqel9+V/wk
         1EsWbKJ33T8lLKILvlXUWKmkp/ezYktqWsc/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=nhz1sy4GAUyA+NiavTJ+/i29txIsrHzyRnG433AVuqrFxOZJ/eg42oDIOxch74cu87
         mRzDblNhtRAQKaZigfO5r3ZiLtTWpOq+F6XtAsM4gYfHUtsuNKq5AaxLaBtVWMRWxmJX
         Mf7yr/sYSWhgwLne3kPzc2kkin9p6cV3T7x6U=
Received: by 10.213.23.75 with SMTP id q11mr921444ebb.43.1258291522877;
        Sun, 15 Nov 2009 05:25:22 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 23sm4396660eya.36.2009.11.15.05.25.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Nov 2009 05:25:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132936>

'git format-patch' encodes the author of the commit in the From:
header and the time of the commit in the Date: header.
Depending on how the email is sent, however, those headers can be
lost before the email reaches its destination.

Therefore, if the sender of the email (i.e. the configuration
options user.name and user.email) are different from the author
of a commit, insert From: and Date: headers at the beginning of
the body of the commit message.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
The code works, but is not appropriate for 'pu' because a fair
number of test cases will fail.

Some additional work is needed before this functionality can
be considered ready for 'pu'. Since I am rather busy at the
moment, I don't want to spend any more time on this unless I'll
get some indication that this functionality is useful for
someone else.

I would also want some input on whether it would be OK
to make this functionality unconditionally turned on so that
there will always From: and Date: headers in the commit
message.

I suspect that the answer is no, because there might be scripts
that parse the output of format-patch (perhaps to interface
with other source-code control systems).

Assuming that we need an option, should the default be to
produce the extra headers (to make sure that the original
author is not lost) or to not produce any extra headers
(for backwards compatibility)?

I suspect that the answer is that the default should be not
to generate any extra headers not to break any existing
scripts.

To implement an option is not difficult, but will need
changes in a fair number of source files in order to propagate
a boolean down to pretty_print_commit() (either as an
additional argument or possibly as an additional field
in the pretty_print_context struct).

 pretty.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index da15cf2..63268a1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -916,6 +916,36 @@ char *reencode_commit_message(const struct commit =
*commit, const char **encoding
 	return logmsg_reencode(commit, encoding);
 }
=20
+static int sender_is_not_author(const char *message)
+{
+	const char **msg_p =3D &message;
+
+	for (;;) {
+		const char *line =3D *msg_p;
+		int linelen =3D get_one_line(*msg_p);
+		*msg_p +=3D linelen;
+
+		/* Get out of here if the commit has no author. */
+		if (linelen <=3D 1)
+			return 0;
+
+		if (!memcmp(line, "author ", 7)) {
+			size_t name_len =3D strlen(git_default_name);
+			size_t email_len;
+			line +=3D 7;
+			if (strncmp(line, git_default_name, name_len))
+				return 1;
+			line +=3D name_len;
+			if (line[0] !=3D ' ' || line[1] !=3D '<')
+				return 1;
+			line +=3D 2;
+			email_len =3D strlen(git_default_email);
+			return strncmp(line, git_default_email, email_len) ||
+				line[email_len] !=3D '>';
+		}
+	}
+}
+
 void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commi=
t,
 			 struct strbuf *sb,
 			 const struct pretty_print_context *context)
@@ -977,6 +1007,21 @@ void pretty_print_commit(enum cmit_fmt fmt, const=
 struct commit *commit,
 		pp_title_line(fmt, &msg, sb, context->subject,
 			      context->after_subject, encoding, need_8bit_cte);
=20
+	/*
+	 * If we are formatting an email and if the sender is different
+	 * from the author of the commit, include the From: and Date:
+	 * headers in the body of the commit message to make sure they
+	 * are not lost.
+	 */
+	if (fmt =3D=3D CMIT_FMT_EMAIL) {
+		const char *p =3D reencoded ? reencoded : commit->buffer;
+		if (sender_is_not_author(commit->buffer)) {
+			pp_header(fmt, context->abbrev, context->date_mode, encoding,
+				  commit, &p, sb);
+			strbuf_addch(sb, '\n');
+		}
+	}
+
 	beginning_of_body =3D sb->len;
 	if (fmt !=3D CMIT_FMT_ONELINE)
 		pp_remainder(fmt, &msg, sb, indent);
--=20
1.6.5.2.186.geb718e
