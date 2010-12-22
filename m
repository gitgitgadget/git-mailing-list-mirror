From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] get_sha1: allow users to extend ..^{%..} syntax
Date: Wed, 22 Dec 2010 22:33:46 +0700
Message-ID: <1293032026-32704-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 22 16:35:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVQir-00009J-Vm
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 16:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677Ab0LVPfS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Dec 2010 10:35:18 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43761 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0LVPfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 10:35:17 -0500
Received: by pwj3 with SMTP id 3so314711pwj.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 07:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=MojZxN7I+sOMbUOGGxb31m3RmYvlGVi5Hcx/1Wr3eUY=;
        b=iA+GdA8i4sJ1GKLOJ/3Q5VEtdrrMAwpOiwIw+p8luIDFv/Hig/MMRFSLl0m/aaFhnA
         832/ijP9jAkITXZpa7ULOkgqsLuh7iw0s64Ldi7S6UbT/S0GUGN4xiwNuSF6HfqFgB7y
         KgkFYB77XoCDTb+i8A61izoo2fhVukd7/xfQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=wenhomnF23bYS2g720SWOr19B+9Edr++bVZ4b5cVyo/Pivl8qxNX79gW9ZWUPFIs/W
         8JBCdPh+zIUfJ2ysb/00L4CG8ALSm/gNUIMeTq/CSMus13nNJUqILURvxqVD9rL8NvbF
         +HVs43zEENqUke2qgV2zoDOSCh7xzpYIk0SlI=
Received: by 10.142.188.2 with SMTP id l2mr5627702wff.320.1293032116578;
        Wed, 22 Dec 2010 07:35:16 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id f5sm9289165wfg.2.2010.12.22.07.35.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 07:35:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 22 Dec 2010 22:33:48 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164090>

This allows users to add abitrary sth^{%foo} syntax that translates
from an SHA-1 to another SHA-1, where "foo" refers to an alias
"sha1-foo" or "foo". If either is found, %sha1% in the alias will be
replaced with SHA-1 of "sth". The alias command is supposed to print
translated SHA-1 to stdout.

Another syntax is sth^{%foo:args} where %arg% in the alias will be
replaced with "args" from the syntax. This gives users much more
flexibilty in extending SHA-1 syntax. I'm not sure if I should support
multiple arguments though.

My mind is still with the :/ syntax. So as an example,

git config alias.sha1-topic 'rev-list --merges --grep=3D%arg% --max-cou=
nt=3D1 %sha1%'
git rev-parse origin/pu^{%topic:nd/struct-pathspec}

would give me sha-1 of my topic. This is supposed to be faster than
standard :/ syntax because it only searches merges. I can also make it
more accurate to my liking by adjust --grep=3D freely. Unfortunately
git-rev-list takes ~1 sec to run. Maybe I can detect rev-list command
and run it internally without run_command().

The intention is that a similar syntax can be used for branch
translation too, i.e ref@{%...}.

One of the rising issues is that every time this syntax is evaluated,
external process will be run again. Some cache might help. I should
also take alias code out of git.c for reuse here.

So comments? (This patch looks bad, I know)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_name.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index c5c59ce..6b40cec 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -6,6 +6,7 @@
 #include "tree-walk.h"
 #include "refs.h"
 #include "remote.h"
+#include "run-command.h"
=20
 static int get_sha1_oneline(const char *, unsigned char *, struct comm=
it_list *);
=20
@@ -529,6 +530,86 @@ struct object *peel_to_type(const char *name, int =
namelen,
 	}
 }
=20
+static int peel_alias_onion(const char *name, int len, const char *sp,
+			    unsigned char *sha1)
+{
+	int alias_len;
+	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf cmd =3D STRBUF_INIT;
+	struct child_process cp;
+	const char **argv;
+	int count, hex_len;
+	char *s, *arg;
+	char hex[40];
+
+	len--;			/* remove the last '}' */
+	arg =3D strchr(sp, ':');
+	if (arg)
+		alias_len =3D arg - sp;
+	else
+		alias_len =3D len - (sp - name);
+	strbuf_add(&sb, "sha1-", 5);
+	strbuf_add(&sb, sp, alias_len);
+	s =3D alias_lookup(sb.buf);
+	if (!s) {
+		strbuf_reset(&sb);
+		strbuf_add(&sb, sp, alias_len);
+		s =3D alias_lookup(sb.buf);
+	}
+	strbuf_release(&sb);
+	if (!s)
+		return error("unable to find alias for %s", name);
+
+	strbuf_attach(&cmd, s, strlen(s), strlen(s)+1);
+	s =3D strstr(cmd.buf, "%sha1%");
+	if (!s) {
+		error("%%sha1%% not found, not an sha1 alias:\n%s", cmd.buf);
+		strbuf_release(&cmd);
+		return -1;
+	}
+	strbuf_splice(&cmd, s - cmd.buf, 6, sha1_to_hex(sha1), 40);
+	if (arg) {
+		int arg_len =3D len - (++arg - name);
+		s =3D strstr(cmd.buf, "%arg%");
+		if (!s) {
+			error("%%arg%% not found, not an sha1 alias:\n%s", cmd.buf);
+			strbuf_release(&cmd);
+			return -1;
+		}
+		strbuf_splice(&cmd, s - cmd.buf, 5, arg, arg_len);
+	}
+
+	count =3D split_cmdline(cmd.buf, &argv);
+	if (count < 0) {
+		error("Bad alias.%s string: %s", cmd.buf, split_cmdline_strerror(cou=
nt));
+		strbuf_release(&cmd);
+		return -1;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd =3D 1;
+	cp.in =3D 0;
+	cp.out =3D -1;
+	cp.argv =3D argv;
+	trace_argv_printf(argv, "trace: sha1 alias expansion: %s =3D>", cmd.b=
uf);
+	if (start_command(&cp)) {
+		error("Failed to run %s", cmd.buf);
+		strbuf_release(&cmd);
+		return -1;
+	}
+	hex_len =3D xread(cp.out, hex, 40);
+	close(cp.out);
+	if (finish_command(&cp)) {
+		error("Failed to finish %s", cmd.buf);
+		strbuf_release(&cmd);
+		return -1;
+	}
+	strbuf_release(&cmd);
+	if (hex_len !=3D 40 || get_sha1_hex(hex, sha1))
+		return error("failed to get result SHA-1 from ...%s", sp-3);
+	return 0;
+}
+
 static int peel_onion(const char *name, int len, unsigned char *sha1)
 {
 	unsigned char outer[20];
@@ -566,6 +647,12 @@ static int peel_onion(const char *name, int len, u=
nsigned char *sha1)
 		expected_type =3D OBJ_NONE;
 	else if (sp[0] =3D=3D '/')
 		expected_type =3D OBJ_COMMIT;
+	else if (sp[0] =3D=3D '%') {
+		if (get_sha1_1(name, sp - name - 2, outer))
+			return -1;
+		hashcpy(sha1, outer);
+		return peel_alias_onion(name, len, sp + 1, sha1);
+	}
 	else
 		return -1;
=20
--=20
1.7.3.3.476.g10a82
