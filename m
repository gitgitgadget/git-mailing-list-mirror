From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] apply: handle traditional patches with space in
 filename
Date: Wed, 18 Aug 2010 20:50:14 -0500
Message-ID: <20100819015014.GC18922@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C65BCD2.6000701@kdbg.org>
 <20100814022625.GA4199@burratino>
 <201008142037.50833.j6t@kdbg.org>
 <20100819014516.GA7175@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 03:52:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OluIU-0000bJ-QD
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 03:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086Ab0HSBv6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 21:51:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61163 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0HSBv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 21:51:56 -0400
Received: by gyd8 with SMTP id 8so470483gyd.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 18:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MjtaEGDH6Gh6nkLh3skG7KiHh/CTNWrnFpBvZ+ZZ8gA=;
        b=ersFkgyOgEpEvwxRTI9mHjXIHW8A7LssAiCSZCgQWXm21PvXAMYyh9eA3qqmTRix6R
         oiP74+NkSa+UoDQHZlPqJps7QTwYDKGYtYSYO0R+M9OJnXgl9GePYAc3lhU8rYYCfoRY
         Soc72v7WJOc2V1eJRxfJoAyo/kDeXbOJWkAkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OVjq92a974EBuZQD++02WdH72+FI2JB6dsW/nIan6wJeXJHnFTa3N41fMqbSZC71Jk
         iq0Ge1NZwitNsmNYOLOX+HflTW91f0cYwAfhzIZLaUOiyg4h4xZWmkWMJfYfn6h0L+fP
         lYCzqwg+hX1OIi5d9HS1VtDDVDZC0w3++Ih9U=
Received: by 10.101.75.5 with SMTP id c5mr10357954anl.190.1282182715967;
        Wed, 18 Aug 2010 18:51:55 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id c19sm1400716ana.2.2010.08.18.18.51.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 18:51:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100819014516.GA7175@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153904>

To discover filenames from the --- and +++ lines in a traditional
unified diff, currently "git apply" scans forward for a whitespace
character on each line and stops there.  It can't use the whole line
because "diff -u" likes to include timestamps, like so:

 --- foo	2000-07-12 16:56:50.020000414 -0500
 +++ bar	2010-07-12 16:56:50.020000414 -0500

The whitespace-seeking heuristic works great, even when the tab
has been converted to spaces by some email + copy-and-paste
related corruption.

Except for one problem: if the filename itself contains whitespace,
the inferred filename will be too short.

When Giuseppe ran into this problem, it was for a file creation
patch (for debian/licenses/LICENSE.global BSD-style Chromium).
So one can't use the list of files present in the index to deduce an
appropriate filename (not to mention that way lies madness; see
v0.99~402, 2005-05-31).

Instead, look for a timestamp and use that if present to mark the end
of the filename.  If no timestamp is present, the old heuristic is
used, with one exception: the space character \040 is not considered
terminating whitespace any more unless it is followed by a timestamp.

Reported-by: Giuseppe Iuculano <iuculano@debian.org>
Acked-by: Guido G=C3=BCnther <agx@sigxcpu.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for the helpful advice and patience at my use of it.

 builtin/apply.c                  |  193 ++++++++++++++++++++++++++++++=
+++++---
 t/t4135-apply-weird-filenames.sh |    4 +-
 2 files changed, 181 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index efc109e..bd2fcb3 100644
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
+		return find_name_common(line, def, p_value, NULL, TERM_TAB);
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
index 9373f64..1e5aad5 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -59,8 +59,8 @@ try_filename() {
 }
=20
 try_filename 'plain'            'postimage.txt'
-try_filename 'with spaces'      'post image.txt' '' success failure fa=
ilure
-try_filename 'with tab'         'post	image.txt' FUNNYNAMES success fa=
ilure failure
+try_filename 'with spaces'      'post image.txt'
+try_filename 'with tab'         'post	image.txt' FUNNYNAMES
 try_filename 'with backslash'   'post\image.txt' BSLASHPSPEC
 try_filename 'with quote'       '"postimage".txt' FUNNYNAMES success f=
ailure success
=20
--=20
1.7.2.1.544.ga752d.dirty
