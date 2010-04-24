From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] fast-import: validate entire ident string
Date: Sat, 24 Apr 2010 16:10:42 -0500
Message-ID: <20100424211042.GC24948@progeny.tock>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
 <20100424160608.GA14690@progeny.tock>
 <20100424190419.GA7502@spearce.org>
 <20100424203827.GA24948@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 24 23:10:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5mcB-0002lY-8W
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 23:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab0DXVKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 17:10:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54593 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab0DXVKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 17:10:06 -0400
Received: by gwj19 with SMTP id 19so3302445gwj.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 14:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AGD8Ag/PNqSMpikfcrzwT6z7Zszoo1GjKt0wm5qfBFM=;
        b=lz1JlqyKi4pe1x1y+I7OyeQeE/bVpLXf1MitM6cPokGgCQED3DkI2pLZwJHfHGJScn
         yG04AGCIBZyI2RLqk/LvhNDNqrjYKPgkuL7m0CvuhPd43LuSwcIm2/OO1hMb7X/bv0ju
         NZO86tJEg7nfzFC35f5kVpUdUmw9HMf5KMG6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=otr778FxqwTogmgawFzUxwSb4LrnLs7V6v6OZ4Bx1LvTL3D/7n25O23vuj8sXynhLc
         2zpWuNkvXsCNsz75Xpougx5KYu7g8A+zJOpEbeOj3NJaFhbC7f+CEO96mM349sMbMPR0
         d4kYzcrLVCrWgC5gm0Kizy9cfch1tQB7QA0vs=
Received: by 10.100.28.21 with SMTP id b21mr2326762anb.168.1272143405329;
        Sat, 24 Apr 2010 14:10:05 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1768353iwn.14.2010.04.24.14.10.04
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 14:10:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100424203827.GA24948@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145704>

The author, committer, and tagger name and email should not include
any embedded <, >, or newline characters.  The format of the
identification string is

  ('author'|'committer'|'tagger') sp name sp < email > sp date

If an object has no name attached, then git expects to find two spaces
in a row.

Helped-by: Mark Lodato <lodatom@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
=46or malformed input, the parser in pretty.c and =E2=80=98git commit -=
-amend=E2=80=99
tend to end up with different ideas of who the author is.  A lot of
the time, commit --amend gives up with "fatal: invalid commit".

 Documentation/git-fast-import.txt |    9 ++--
 fast-import.c                     |   54 ++++++++++++++++----------
 t/t9300-fast-import.sh            |   75 +++++++++++++++++++++++++++++=
++++++++
 3 files changed, 113 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast=
-import.txt
index 19082b0..ee725c6 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -337,8 +337,8 @@ change to the project.
 ....
 	'commit' SP <ref> LF
 	mark?
-	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
-	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
+	('author' SP <name>? SP LT <email> GT SP <when> LF)?
+	'committer' SP <name>? SP LT <email> GT SP <when> LF
 	data
 	('from' SP <committish> LF)?
 	('merge' SP <committish> LF)?
@@ -393,8 +393,9 @@ Here `<name>` is the person's display name (for exa=
mple
 (``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
 and greater-than (\x3e) symbols.  These are required to delimit
 the email address from the other fields in the line.  Note that
-`<name>` is free-form and may contain any sequence of bytes, except
-`LT` and `LF`.  It is typically UTF-8 encoded.
+`<name>` and `<email>` are free-form and may contain any sequence
+of bytes that are not `LT`, `GT`, or `LF`.  Both are typically UTF-8
+encoded.
=20
 The time of the change is specified by `<when>` using the date format
 that was selected by the \--date-format=3D<fmt> command line option.
diff --git a/fast-import.c b/fast-import.c
index 1701cf1..d919168 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -19,8 +19,8 @@ Format of STDIN stream:
=20
   new_commit ::=3D 'commit' sp ref_str lf
     mark?
-    ('author' (sp name)? sp '<' email '>' sp when lf)?
-    'committer' (sp name)? sp '<' email '>' sp when lf
+    ('author' sp name? sp '<' email '>' sp when lf)?
+    'committer' sp name? sp '<' email '>' sp when lf
     commit_msg
     ('from' sp committish lf)?
     ('merge' sp committish lf)*
@@ -47,7 +47,7 @@ Format of STDIN stream:
=20
   new_tag ::=3D 'tag' sp tag_str lf
     'from' sp committish lf
-    ('tagger' (sp name)? sp '<' email '>' sp when lf)?
+    ('tagger' sp name? sp '<' email '>' sp when lf)?
     tag_msg;
   tag_msg ::=3D data;
=20
@@ -123,9 +123,8 @@ Format of STDIN stream:
   sha1exp ::=3D # Any valid GIT SHA1 expression;
   hexsha1 ::=3D # SHA1 in hexadecimal format;
=20
-     # note: name and email are UTF8 strings, however name must not
-     # contain '<' or lf and email must not contain any of the
-     # following: '<', '>', lf.
+     # note: name and email are UTF8 strings, however name and email
+     # must not contain any of the following: '<', '>', lf.
      #
   name  ::=3D # valid GIT author/committer name;
   email ::=3D # valid GIT author/committer email;
@@ -1929,34 +1928,47 @@ static int validate_raw_date(const char *src, c=
har *result, int maxlen)
 	return 0;
 }
=20
-static char *parse_ident(const char *buf)
+static size_t parse_name_and_email(const char *src, char **result, siz=
e_t extra)
 {
-	const char *gt;
+	const char *lt, *gt;
 	size_t name_len;
-	char *ident;
=20
-	gt =3D strrchr(buf, '>');
-	if (!gt)
-		die("Missing > in ident string: %s", buf);
+	lt =3D src + strcspn(src, "<>\n");
+	if (lt =3D=3D src || lt[-1] !=3D ' ' || *lt !=3D '<')
+		die("Invalid name in ident string: %s", src);
+	gt =3D lt + 1 + strcspn(lt + 1, "<>\n");
+	if (*gt !=3D '>')
+		die("Invalid email in ident string: %s", src);
 	gt++;
 	if (*gt !=3D ' ')
-		die("Missing space after > in ident string: %s", buf);
+		die("Missing space after > in ident string: %s", src);
 	gt++;
-	name_len =3D gt - buf;
-	ident =3D xmalloc(name_len + 24);
-	strncpy(ident, buf, name_len);
+	name_len =3D gt - src;
+	*result =3D xmalloc(name_len + extra);
+	memcpy(*result, src, name_len);
+	return name_len;
+}
+
+static char *parse_ident(const char *buf)
+{
+	const char *date;
+	size_t name_len;
+	char *ident;
+
+	name_len =3D parse_name_and_email(buf, &ident, 24);
+	date =3D buf + name_len;
=20
 	switch (whenspec) {
 	case WHENSPEC_RAW:
-		if (validate_raw_date(gt, ident + name_len, 24) < 0)
-			die("Invalid raw date \"%s\" in ident: %s", gt, buf);
+		if (validate_raw_date(date, ident + name_len, 24) < 0)
+			die("Invalid raw date \"%s\" in ident: %s", date, buf);
 		break;
 	case WHENSPEC_RFC2822:
-		if (parse_date(gt, ident + name_len, 24) < 0)
-			die("Invalid rfc2822 date \"%s\" in ident: %s", gt, buf);
+		if (parse_date(date, ident + name_len, 24) < 0)
+			die("Invalid rfc2822 date \"%s\" in ident: %s", date, buf);
 		break;
 	case WHENSPEC_NOW:
-		if (strcmp("now", gt))
+		if (strcmp("now", date))
 			die("Date in ident must be 'now': %s", buf);
 		datestamp(ident + name_len, 24);
 		break;
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ed653a7..a7e379f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -348,6 +348,81 @@ test_expect_success \
=20
 cat >input <<INPUT_END
 commit refs/heads/branch
+author <$GIT_AUTHOR_EMAIL> Sat, 24 Apr 2010 14:49:52 -0500
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:0=
1 2007 -0500
+data <<COMMIT
+Nameless author, first attempt
+COMMIT
+
+from refs/heads/branch^0
+
+INPUT_END
+test_expect_success 'E: require space after author name' '
+    test_must_fail git fast-import --date-format=3Drfc2822 <input
+'
+
+cat >input <<INPUT_END
+commit refs/heads/branch
+author  <$GIT_AUTHOR_EMAIL> Sat, 24 Apr 2010 14:49:52 -0500
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:0=
1 2007 -0500
+data <<COMMIT
+Nameless author
+COMMIT
+
+from refs/heads/branch^0
+
+INPUT_END
+test_expect_success 'E: do not require author name, though' '
+    git fast-import --date-format=3Drfc2822 <input
+'
+
+cat >input <<INPUT_END
+commit refs/heads/branch
+author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Sat, 24 Apr 2010 14:49:52 =
-0500
+committer C O >Mitter <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:01 2007 -=
0500
+data <<COMMIT
+Odd committer
+COMMIT
+
+from refs/heads/branch^0
+
+INPUT_END
+test_expect_success 'E: unparsable committer' '
+    test_must_fail git fast-import --date-format=3Drfc2822 <input
+'
+
+cat >input <<INPUT_END
+commit refs/heads/branch
+author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Sat, 24 Apr 2010 15:05:27 =
-0500
+committer $GIT_COMMITTER_NAME <aggh@<example.com> Tue Feb 6 12:35:01 2=
007 -0500
+data <<COMMIT
+Odd email
+COMMIT
+
+from refs/heads/branch^0
+
+INPUT_END
+test_expect_success 'E: unparsable email' '
+    test_must_fail git fast-import --date-format=3Drfc2822 <input
+'
+
+cat >input <<INPUT_END
+commit refs/heads/branch
+author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Sat, 24 Apr 2010 15:05:27 =
-0500
+committer $GIT_COMMITTER_NAME <=C3=A4ggh!some!other!machine!example> T=
ue Feb 6 12:35:01 2007 -0500
+data <<COMMIT
+Bang path
+COMMIT
+
+from refs/heads/branch^0
+
+INPUT_END
+test_expect_success 'E: okay email' '
+    git fast-import --date-format=3Drfc2822 <input
+'
+
+cat >input <<INPUT_END
+commit refs/heads/branch
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170783301 -  0500
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 117078330 -0500
 data <<COMMIT
--=20
1.7.1.rc1
