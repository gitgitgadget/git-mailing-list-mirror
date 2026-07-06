Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6123E0C4F
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327125; cv=none; b=PPb5vUKOT1p+13FRH2pz4+7HGfXzsPP2OBXDADYaOZi02EScYhAa8HK6clIHappC5nNqwpkGYyoOQvLEKBsCm38SP2ZpdbW84UgqI49GhS1eiTXNt5p+5Nse9mHyc296XPxJz8SAcivS6PCte2VU7ms86RPrAbvHn8FdtgtdwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327125; c=relaxed/simple;
	bh=aqMLrQv9/SxhLaY2ZCUtJQUAoAMtunVUAAanBOceaew=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rvBYwWLyq9aVcpwBWlC5a+20L6dMw5cKzpAK62fsxl3dj3c1V/FuYkidftecSPM1Jg8su9UYKHsHBr34FrJoF0PybOrqwF0nVMo8lxvfiPK62hG4b43qqWdq5Bh2P9n1K+hg+9h8zzExd3mmc0I7r/Mdflbo2oibohHl8dTeDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=a7f8pE6F; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="a7f8pE6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783327106; x=1783931906; i=l.s.r@web.de;
	bh=cOuX8UwzSj+AF7AYlsNb4HgMoGdUrZENSrZX3RKejpo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=a7f8pE6FMNBWjb508UEIHzYrXnSNbQpc8MVUY0wfELpyG1jiRQeHUSWFuqBoatky
	 L3FXRcCXRPC8Vn0LKZwS0BLokZISThiqMskMRg3B4mH2+h2kcheJN8caXM/DVSG8F
	 rc29RC1RpAxGVTmRGGB50xiG/bXlNDJT/qyy6MxgvyyJXO6VKawDra4Vo+crfi9f/
	 WK2pDUDg7Ijbu9ZUo7/0+SNsVhYxVxbbjB09AiNzsQtObEtk7jyvSyeMz0F4PkRkP
	 lTqKhVXgusdD6gVSZO7m8cg0ZdJGlbYUTrDNsPMAwA5cWHiUOylgn97rEIG2AUKEx
	 BIv4DgnZPq1V1bLcJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7ux6-1wkWjQ1XVK-006RAM; Mon, 06
 Jul 2026 10:38:26 +0200
Message-ID: <92991b5e-0667-4315-89d5-1514a5499297@web.de>
Date: Mon, 6 Jul 2026 10:38:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] blame: reserve mark column only if necessary
To: Laszlo Ersek <laszlo.ersek@posteo.net>, git@vger.kernel.org
References: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IvPGt4PvJsExHppVVT9DcOZwpcyRHQQNPECEZhOq+5Xi9ATV8mC
 UrofvwxVpdT6N8gabyomBFihVjRGimIHr1DKtdRMGMXeGy1hYpGOOeVKJ2goDPlcJmoaw8K
 lJu6mEOL/ct+JS7F03iTVxdq/NZb6jEAMEdFwwe5kDcMd8H7d/Js48iVpEnAcqQhvjLQ/fg
 c/T8FrpgpmdyBS52rD+vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+1JCgqGTC1Y=;jPJ6SPIidSV0O3F6j6lTeV/a9EP
 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
 aEPTTJwZTB4TzSOZx7rgtnX8wxOE5kAyuGY3WSX

git blame prepends commit hashes of boundary commits with "^", ignored
commits with "?" and unblamable commits with "*" and reserves one column
for them by extending the hash abbreviation, to avoid showing ambiguous
hashes.

This reserved column wastes precious screen space, which can be
especially irritating when using the option -b to blank out boundary
commit hashes and not ignoring any commits.  Reserve it only as needed,
i.e. if any of those cases are actually shown.

Pointed-out-by: Laszlo Ersek <laszlo.ersek@posteo.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-blame.adoc | 11 +++---
 builtin/blame.c              | 68 ++++++++++++++++++++++++------------
 t/t8002-blame.sh             |  7 ++--
 3 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index 8808009e87e..2b74e455997 100644
=2D-- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -88,11 +88,12 @@ include::blame-options.adoc[]
 include::diff-algorithm-option.adoc[]
=20
 `--abbrev=3D<n>`::
-	Instead of using the default _7+1_ hexadecimal digits as the
-	abbreviated object name, use _<m>+1_ digits, where _<m>_ is at
-	least _<n>_ but ensures the commit object names are unique.
-	Note that 1 column
-	is used for a caret to mark the boundary commit.
+	Instead of using the default _7_ hexadecimal digits as the
+	abbreviated object name, use at least _<n>_ digits, but ensure
+	the commit object names are unique.
+	If commits marked with caret (boundary), question mark (ignored)
+	or asterisk (unblamable) are shown, extend unmarked object names
+	to align them.
=20
=20
 THE DEFAULT FORMAT
diff --git a/builtin/blame.c b/builtin/blame.c
index ffbd3ce5c5a..5ae39d0458a 100644
=2D-- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -453,6 +453,36 @@ static void determine_line_heat(struct commit_info *c=
i, const char **dest_color)
 	*dest_color =3D colorfield[i].col;
 }
=20
+static inline int maybe_putc(int c, FILE *out)
+{
+	return out ? putc(c, out) : 0;
+}
+
+static size_t print_marks(FILE *out, const struct blame_entry *ent, int o=
pt)
+{
+	size_t len =3D 0;
+
+	if ((ent->suspect->commit->object.flags & UNINTERESTING) &&
+	    !blank_boundary && !(opt & OUTPUT_ANNOTATE_COMPAT)) {
+		maybe_putc('^', out);
+		len++;
+	}
+	if (mark_unblamable_lines && ent->unblamable) {
+		maybe_putc('*', out);
+		len++;
+	}
+	if (mark_ignored_lines && ent->ignored) {
+		maybe_putc('?', out);
+		len++;
+	}
+	return len;
+}
+
+static size_t count_marks(const struct blame_entry *ent, int opt)
+{
+	return print_marks(NULL, ent, opt);
+}
+
 static void emit_other(struct blame_scoreboard *sb, struct blame_entry *e=
nt,
 		       int opt, struct blame_entry *prev_ent)
 {
@@ -499,23 +529,10 @@ static void emit_other(struct blame_scoreboard *sb, =
struct blame_entry *ent,
 		if (color)
 			fputs(color, stdout);
=20
-		if (suspect->commit->object.flags & UNINTERESTING) {
-			if (blank_boundary) {
-				memset(hex, ' ', strlen(hex));
-			} else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
-				length--;
-				putchar('^');
-			}
-		}
-
-		if (mark_unblamable_lines && ent->unblamable) {
-			length--;
-			putchar('*');
-		}
-		if (mark_ignored_lines && ent->ignored) {
-			length--;
-			putchar('?');
-		}
+		if ((suspect->commit->object.flags & UNINTERESTING) &&
+		    blank_boundary)
+			memset(hex, ' ', strlen(hex));
+		length -=3D print_marks(stdout, ent, opt);
=20
 		printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length : GIT_MAX_HEXSZ), =
hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
@@ -647,11 +664,15 @@ static void find_alignment(struct blame_scoreboard *=
sb, int *option)
 	struct blame_entry *e;
 	int compute_auto_abbrev =3D (abbrev < 0);
 	int auto_abbrev =3D DEFAULT_ABBREV;
+	size_t max_marks_count =3D 0;
=20
 	for (e =3D sb->ent; e; e =3D e->next) {
 		struct blame_origin *suspect =3D e->suspect;
 		int num;
+		size_t marks_count =3D count_marks(e, *option);
=20
+		if (max_marks_count < marks_count)
+			max_marks_count =3D marks_count;
 		if (compute_auto_abbrev)
 			auto_abbrev =3D update_auto_abbrev(auto_abbrev, suspect);
 		if (strcmp(suspect->path, sb->path))
@@ -685,8 +706,12 @@ static void find_alignment(struct blame_scoreboard *s=
b, int *option)
 	max_score_digits =3D decimal_width(largest_score);
=20
 	if (compute_auto_abbrev)
-		/* one more abbrev length is needed for the boundary commit */
-		abbrev =3D auto_abbrev + 1;
+		abbrev =3D auto_abbrev;
+	if (abbrev < (int)the_hash_algo->hexsz) {
+		abbrev +=3D max_marks_count;
+		if (abbrev > (int)the_hash_algo->hexsz)
+			abbrev =3D the_hash_algo->hexsz;
+	}
 }
=20
 static void sanity_check_on_fail(struct blame_scoreboard *sb, int baa)
@@ -1047,10 +1072,7 @@ int cmd_blame(int argc,
 	} else if (show_progress < 0)
 		show_progress =3D isatty(2);
=20
-	if (0 < abbrev && abbrev < (int)the_hash_algo->hexsz)
-		/* one more abbrev length is needed for the boundary commit */
-		abbrev++;
-	else if (!abbrev)
+	if (!abbrev)
 		abbrev =3D the_hash_algo->hexsz;
=20
 	if (revs_file && read_ancestry(revs_file))
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 7822947f028..bf04b8273ef 100755
=2D-- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -113,8 +113,7 @@ test_expect_success 'set up abbrev tests' '
 '
=20
 test_expect_success 'blame --abbrev=3D<n> works' '
-	# non-boundary commits get +1 for alignment
-	check_abbrev 31 --abbrev=3D30 HEAD &&
+	check_abbrev 30 --abbrev=3D30 HEAD &&
 	check_abbrev 30 --abbrev=3D30 ^HEAD
 '
=20
@@ -141,10 +140,8 @@ test_expect_success 'blame --abbrev gets truncated wi=
th boundary commit' '
 '
=20
 test_expect_success 'blame --abbrev -b truncates the blank boundary' '
-	# Note that `--abbrev=3D` always gets incremented by 1, which is why we
-	# expect 11 leading spaces and not 10.
 	cat >expect <<-EOF &&
-	$(printf "%11s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) a=
bbrev
+	$(printf "%10s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) a=
bbrev
 	EOF
 	git blame -b --abbrev=3D10 ^HEAD -- abbrev.t >actual &&
 	test_cmp expect actual
=2D-=20
2.55.0
