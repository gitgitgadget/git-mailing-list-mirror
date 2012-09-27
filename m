From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] revision: add --reflog-message to grep reflog messages
Date: Thu, 27 Sep 2012 18:36:26 +0700
Message-ID: <1348745786-27197-1-git-send-email-pclouds@gmail.com>
References: <7va9wctwg4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 13:43:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THCV5-00074f-K4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 13:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277Ab2I0LnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2012 07:43:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60846 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2I0LnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 07:43:16 -0400
Received: by pbbrr4 with SMTP id rr4so3461031pbb.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=l4ns0OX1X2pxa7WqyN5kQBi+WkiXrMMOgKi8M0fs7+k=;
        b=ThzyRtRT/7JKtLBPH5OE7ifDSLqUco5lNl6OF354Vr0WA7L8OXUVX5B3DtTGu6Hhq+
         DjazX/jugwvNDrL7/pd5QFL5l2MrGpiwNnTO0K5pzHW5j5ln2Z4dDIbxQkZ8w8dSYpid
         H9FTY2D0MgaOuwHqIBJoeB18O3PXTpAxFS/LRWIlFgznUtyUsThgsNm33U5V6App0par
         zpF2yU5P1fZIHDsvFNL+T0XFEU2K7ZEqm1+YxUkeYi2TsA5n5Nokhcb/YwbSjiTavWFs
         MGBVX60GPwJ68hl0gBCM9asckideTeu28f03K2ZHdf8k29gMmPpIoXl3vSdmiAiWT4Zt
         CReA==
Received: by 10.68.224.132 with SMTP id rc4mr10515423pbc.155.1348746195698;
        Thu, 27 Sep 2012 04:43:15 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.51.2])
        by mx.google.com with ESMTPS id y2sm3598136pax.29.2012.09.27.04.43.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Sep 2012 04:43:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 27 Sep 2012 18:36:28 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <7va9wctwg4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206475>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, Sep 27, 2012 at 2:28 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 > The current commit_match() runs grep_buffer() on commit->buffer.  It
 > probably makes sense to instead notice from opt that we are running
 > log with "-g", prepare a temporary strbuf and add in the reflog
 > message to the string in commit->buffer, and run grep_buffer() on
 > that temporary strbuf on it.

 Yeah. I was starting to think that way too, otherwise combining grep
 options would be a mess. I was hoping by injecting a fake reflog
 header, we could simplify reflog exceptions in pretty.c. But it
 was not that easy.

 > I personally think it is sufficient ot just reuse --grep on
 > concatenation of commit->buffer with "Reflog message: checkout:
 > moving from as/check-ignore to pu".

 --grep only reads the commit body. So either we append reflog
 message to commit body, or we put it in the header and add a new
 option for it. I don't like appending things to the commit body as
 --grep may hit reflog message while users do not mean so.

 > If you really want to go fancier, you could add --grep-reflog option
 > that behaves like the existing --author and --committer options to
 > add "header match" elements to the grep expression, splice a fake
 > "reflog " header to the string copied from commit->buffer

 Inserting at the beginning of the commit like your demo patch works
 just fine and is simpler. I'm tempted to take the undocumented option
 name --reflog for this purpose. But it's probably not worth the risk.

 Documentation/rev-list-options.txt |  5 +++++
 grep.c                             |  1 +
 grep.h                             |  5 +++--
 revision.c                         | 19 +++++++++++++++++--
 t/t7810-grep.sh                    |  6 ++++++
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 1fc2a18..aeaa58c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -51,6 +51,11 @@ endif::git-rev-list[]
 	commits whose author matches any of the given patterns are
 	chosen (similarly for multiple `--committer=3D<pattern>`).
=20
+--reflog-message=3D<pattern>::
+	Limit the commits output to ones with reflog entries that
+	match the specified pattern (regular expression). Ignored unless
+	--walk-reflogs is given.
+
 --grep=3D<pattern>::
=20
 	Limit the commits output to ones with log message that
diff --git a/grep.c b/grep.c
index 898be6e..72ac1bf 100644
--- a/grep.c
+++ b/grep.c
@@ -697,6 +697,7 @@ static struct {
 } header_field[] =3D {
 	{ "author ", 7 },
 	{ "committer ", 10 },
+	{ "reflog ", 7 },
 };
=20
 static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
diff --git a/grep.h b/grep.h
index 8a28a67..1416ad7 100644
--- a/grep.h
+++ b/grep.h
@@ -29,9 +29,10 @@ enum grep_context {
=20
 enum grep_header_field {
 	GREP_HEADER_AUTHOR =3D 0,
-	GREP_HEADER_COMMITTER
+	GREP_HEADER_COMMITTER,
+	GREP_HEADER_REFLOG,
+	GREP_HEADER_FIELD_MAX
 };
-#define GREP_HEADER_FIELD_MAX (GREP_HEADER_COMMITTER + 1)
=20
 struct grep_pat {
 	struct grep_pat *next;
diff --git a/revision.c b/revision.c
index ae12e11..837051c 100644
--- a/revision.c
+++ b/revision.c
@@ -1595,6 +1595,9 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 	} else if ((argcount =3D parse_long_opt("committer", argv, &optarg)))=
 {
 		add_header_grep(revs, GREP_HEADER_COMMITTER, optarg);
 		return argcount;
+	} else if ((argcount =3D parse_long_opt("reflog-message", argv, &opta=
rg))) {
+		add_header_grep(revs, GREP_HEADER_REFLOG, optarg);
+		return argcount;
 	} else if ((argcount =3D parse_long_opt("grep", argv, &optarg))) {
 		add_message_grep(revs, optarg);
 		return argcount;
@@ -2212,8 +2215,20 @@ static int commit_match(struct commit *commit, s=
truct rev_info *opt)
 {
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
-	return grep_buffer(&opt->grep_filter,
-			   commit->buffer, strlen(commit->buffer));
+	if (opt->reflog_info) {
+		int retval;
+		struct strbuf buf =3D STRBUF_INIT;
+		strbuf_addstr(&buf, "reflog ");
+		get_reflog_message(&buf, opt->reflog_info);
+		strbuf_addch(&buf, '\n');
+		strbuf_addstr(&buf, commit->buffer);
+		retval =3D grep_buffer(&opt->grep_filter, buf.buf, buf.len);
+		strbuf_release(&buf);
+		return retval;
+	} else {
+		return grep_buffer(&opt->grep_filter,
+				   commit->buffer, strlen(commit->buffer));
+	}
 }
=20
 static inline int want_ancestry(struct rev_info *revs)
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 91db352..a0f519e 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -546,6 +546,12 @@ test_expect_success 'log grep (6)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'log grep (7)' '
+	git log -g --reflog-message=3D"commit: third" --pretty=3Dtformat:%s >=
actual &&
+	echo third >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log with multiple --grep uses union' '
 	git log --grep=3Di --grep=3Dr --format=3D%s >actual &&
 	{
--=20
1.7.12.1.406.g6ab07c4
