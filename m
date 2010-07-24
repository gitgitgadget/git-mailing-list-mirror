From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] apply: Handle traditional patches with space in
 filename
Date: Fri, 23 Jul 2010 20:20:58 -0500
Message-ID: <20100724012058.GD13670@burratino>
References: <20100724010618.GA13670@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Giuseppe Iuculano <iuculano@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 03:22:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcTRH-00030e-4V
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 03:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378Ab0GXBV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 21:21:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54514 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167Ab0GXBV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 21:21:59 -0400
Received: by iwn7 with SMTP id 7so752464iwn.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 18:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yB++t/P2BrODy946j1ztmAnXtIV1TAUFTYeiSp4ngCY=;
        b=ZlC7CFZQfTirr3OPscZ45fc6yHIiMtPdo2HKq9qDJkRySRLDws8nWnlgarHyKQWjQU
         iFaqGHQn2E3Yirs/kNosEI5EwyepMIUGKm6FwxkEJbvC8C5HVGB+ymVao8ogUvi+BtR1
         4NP611YluG4nM+O0ihYa3agIOZcCYnrx61G/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MuSqVryIFjhddPmmj8iragbH+NTKIn4Drn13cKBW0fytPrbwSbhr6h95fLucICuff6
         3X6ssrzkoPpwaeivCLBjZzNU9GqimBLbOtY7vepR4OFNRG+oeFcTRgj3zVB4Eyf6GY9Z
         0f1sM84AsvFE/8/HaBU+fiGEV2Oh4qm4qxadY=
Received: by 10.231.34.70 with SMTP id k6mr4481377ibd.25.1279934517915;
        Fri, 23 Jul 2010 18:21:57 -0700 (PDT)
Received: from burratino ([64.134.164.56])
        by mx.google.com with ESMTPS id g31sm772448ibh.16.2010.07.23.18.21.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 18:21:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724010618.GA13670@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151596>

To discover filenames from the --- and +++ lines in a traditional
unified diff, currently =E2=80=98git apply=E2=80=99 scans forward for a=
 whitespace
character on each line and stops there.  It can=E2=80=99t use the whole=
 line
because =E2=80=98diff -u=E2=80=99 likes to include timestamps, like so:

 --- foo	2000-07-12 16:56:50.020000414 -0500
 +++ bar	2010-07-12 16:56:50.020000414 -0500

The whitespace-seeking heuristic works great, even when the tab
has been converted to spaces by some email + copy-and-paste
related corruption.

Except for one problem: if the filename itself contains whitespace,
the inferred filename will be too short.

When Giuseppe ran into this problem, it was for a file creation
patch (filename =E2=80=98debian/licenses/LICENSE.global BSD-style Chrom=
ium=E2=80=99).
So one can=E2=80=99t use the list of files present in the index to dedu=
ce an
appropriate filename (not to mention that way lies madness; see
v0.99~402, 2005-05-31).

Instead, look for a timestamp and use that if present to mark the end
of the filename.  If no timestamp is present, the old heuristic is
used, with one exception: the space character \040 is not considered
terminating whitespace any more unless it is followed by a timestamp.

Reported-by: Giuseppe Iuculano <iuculano@debian.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Guido G=C3=BCnther <agx@sigxcpu.org>
---
Guido, I have carried over your ack from <http://bugs.debian.org/578752=
>.
I hope that is okay.  And to both Guido and Giuseppe, sorry to have
taken so long on this.

That is the end of the series.  I hope it was not too unpleasant a read=
=2E
As always, thoughts, improvements, bugs welcome.

Regards,
Jonathan

 builtin/apply.c                  |  193 ++++++++++++++++++++++++++++++=
+++++---
 t/t4135-apply-weird-filenames.sh |    4 +-
 2 files changed, 181 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index efc109e..b975c99 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -449,23 +449,157 @@ static char *find_name_gnu(const char *line, cha=
r *def, int p_value)
 	return squash_slash(strbuf_detach(&name, NULL));
 }
=20
-static char *find_name(const char *line, char *def, int p_value, int t=
erminate)
+static size_t tz_len(const char *line, size_t len)
+{
+	const char *tz, *p;
+
+	if (len < strlen(" +0500") || line[len-strlen(" +0500")] !=3D ' ')
+		return 0;
+	tz =3D line + len - strlen(" +0500");
+
+	if (tz[1] !=3D '+' && tz[1] !=3D '-')
+		return 0;
+
+	for (p =3D tz + 2; p !=3D line + len; p++)
+		if (!isdigit(*p))
+			return 0;
+
+	return line + len - tz;
+}
+
+static size_t date_len(const char *line, size_t len)
+{
+	const char *date, *p;
+
+	if (len < strlen("72-02-05") || line[len-strlen("-05")] !=3D '-')
+		return 0;
+	p =3D date =3D line + len - strlen("72-02-05");
+
+	if (!isdigit(*p++) || !isdigit(*p++) || *p++ !=3D '-' ||
+	    !isdigit(*p++) || !isdigit(*p++) || *p++ !=3D '-' ||
+	    !isdigit(*p++) || !isdigit(*p++))	/* Not a date. */
+		return 0;
+
+	if (date - line >=3D strlen("19") &&
+	    isdigit(date[-1]) && isdigit(date[-2]))	/* 4-digit year */
+		date -=3D strlen("19");
+
+	return line + len - date;
+}
+
+static size_t short_time_len(const char *line, size_t len)
+{
+	const char *time, *p;
+
+	if (len < strlen(" 07:01:32") || line[len-strlen(":32")] !=3D ':')
+		return 0;
+	p =3D time =3D line + len - strlen(" 07:01:32");
+
+	/* Permit 1-digit hours? */
+	if (*p++ !=3D ' ' ||
+	    !isdigit(*p++) || !isdigit(*p++) || *p++ !=3D ':' ||
+	    !isdigit(*p++) || !isdigit(*p++) || *p++ !=3D ':' ||
+	    !isdigit(*p++) || !isdigit(*p++))	/* Not a time. */
+		return 0;
+
+	return line + len - time;
+}
+
+static size_t fractional_time_len(const char *line, size_t len)
+{
+	const char *p;
+	size_t n;
+
+	/* Expected format: 19:41:17.620000023 */
+	if (!len || !isdigit(line[len - 1]))
+		return 0;
+	p =3D line + len - 1;
+
+	/* Fractional seconds. */
+	while (p > line && isdigit(*p))
+		p--;
+	if (*p !=3D '.')
+		return 0;
+
+	/* Hours, minutes, and whole seconds. */
+	n =3D short_time_len(line, p - line);
+	if (!n)
+		return 0;
+
+	return line + len - p + n;
+}
+
+static size_t trailing_spaces_len(const char *line, size_t len)
+{
+	const char *p;
+
+	/* Expected format: ' ' x (1 or more)  */
+	if (!len || line[len - 1] !=3D ' ')
+		return 0;
+
+	p =3D line + len;
+	while (p !=3D line) {
+		p--;
+		if (*p !=3D ' ')
+			return line + len - (p + 1);
+	}
+
+	/* All spaces! */
+	return len;
+}
+
+static size_t diff_timestamp_len(const char *line, size_t len)
+{
+	const char *end =3D line + len;
+	size_t n;
+
+	/*
+	 * Posix: 2010-07-05 19:41:17
+	 * GNU: 2010-07-05 19:41:17.620000023 -0500
+	 */
+
+	if (!isdigit(end[-1]))
+		return 0;
+
+	n =3D tz_len(line, end - line);
+	end -=3D n;
+
+	n =3D short_time_len(line, end - line);
+	if (!n)
+		n =3D fractional_time_len(line, end - line);
+	end -=3D n;
+
+	n =3D date_len(line, end - line);
+	if (!n)	/* No date.  Too bad. */
+		return 0;
+	end -=3D n;
+
+	if (end =3D=3D line)	/* No space before date. */
+		return 0;
+	if (end[-1] =3D=3D '\t') {	/* Success! */
+		end--;
+		return line + len - end;
+	}
+	if (end[-1] !=3D ' ')	/* No space before date. */
+		return 0;
+
+	/* Whitespace damage. */
+	end -=3D trailing_spaces_len(line, end - line);
+	return line + len - end;
+}
+
+static char *find_name_common(const char *line, char *def, int p_value=
,
+				const char *end, int terminate)
 {
 	int len;
 	const char *start =3D NULL;
=20
-	if (*line =3D=3D '"') {
-		char *name =3D find_name_gnu(line, def, p_value);
-		if (name)
-			return name;
-	}
-
 	if (p_value =3D=3D 0)
 		start =3D line;
-	for (;;) {
+	while (line !=3D end) {
 		char c =3D *line;
=20
-		if (isspace(c)) {
+		if (!end && isspace(c)) {
 			if (c =3D=3D '\n')
 				break;
 			if (name_terminate(start, line-start, c, terminate))
@@ -505,6 +639,37 @@ static char *find_name(const char *line, char *def=
, int p_value, int terminate)
 	return squash_slash(xmemdupz(start, len));
 }
=20
+static char *find_name(const char *line, char *def, int p_value, int t=
erminate)
+{
+	if (*line =3D=3D '"') {
+		char *name =3D find_name_gnu(line, def, p_value);
+		if (name)
+			return name;
+	}
+
+	return find_name_common(line, def, p_value, NULL, terminate);
+}
+
+static char *find_name_traditional(const char *line, char *def, int p_=
value)
+{
+	size_t len =3D strlen(line);
+	size_t date_len;
+
+	if (*line =3D=3D '"') {
+		char *name =3D find_name_gnu(line, def, p_value);
+		if (name)
+			return name;
+	}
+
+	len =3D strchrnul(line, '\n') - line;
+	date_len =3D diff_timestamp_len(line, len);
+	if (!date_len)
+		return find_name(line, def, p_value, TERM_TAB);
+	len -=3D date_len;
+
+	return find_name_common(line, def, p_value, line + len, 0);
+}
+
 static int count_slashes(const char *cp)
 {
 	int cnt =3D 0;
@@ -527,7 +692,7 @@ static int guess_p_value(const char *nameline)
=20
 	if (is_dev_null(nameline))
 		return -1;
-	name =3D find_name(nameline, NULL, 0, TERM_SPACE | TERM_TAB);
+	name =3D find_name_traditional(nameline, NULL, 0);
 	if (!name)
 		return -1;
 	cp =3D strchr(name, '/');
@@ -646,16 +811,16 @@ static void parse_traditional_patch(const char *f=
irst, const char *second, struc
 	if (is_dev_null(first)) {
 		patch->is_new =3D 1;
 		patch->is_delete =3D 0;
-		name =3D find_name(second, NULL, p_value, TERM_SPACE | TERM_TAB);
+		name =3D find_name_traditional(second, NULL, p_value);
 		patch->new_name =3D name;
 	} else if (is_dev_null(second)) {
 		patch->is_new =3D 0;
 		patch->is_delete =3D 1;
-		name =3D find_name(first, NULL, p_value, TERM_SPACE | TERM_TAB);
+		name =3D find_name_traditional(first, NULL, p_value);
 		patch->old_name =3D name;
 	} else {
-		name =3D find_name(first, NULL, p_value, TERM_SPACE | TERM_TAB);
-		name =3D find_name(second, name, p_value, TERM_SPACE | TERM_TAB);
+		name =3D find_name_traditional(first, NULL, p_value);
+		name =3D find_name_traditional(second, name, p_value);
 		if (has_epoch_timestamp(first)) {
 			patch->is_new =3D 1;
 			patch->is_delete =3D 0;
diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-fil=
enames.sh
index 2dcb040..52f9f5b 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -94,8 +94,8 @@ try_filename() {
 }
=20
 try_filename 'plain'            'postimage.txt'
-try_filename 'with spaces'      'post image.txt' success failure failu=
re
-try_filename 'with tab'         'post	image.txt' success failure failu=
re
+try_filename 'with spaces'      'post image.txt'
+try_filename 'with tab'         'post	image.txt'
 try_filename 'with backslash'   'post\image.txt'
 try_filename 'with quote'       '"postimage".txt' success failure succ=
ess
=20
--=20
1.7.2.rc3
