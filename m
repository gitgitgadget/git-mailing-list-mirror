From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph
 output into account
Date: Fri, 23 Mar 2012 11:12:32 +0100
Message-ID: <4F6C4C90.5050702@in.waw.pl>
References: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com> <1332482108-2659-1-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 11:12:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB1UD-0003D9-6X
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 11:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095Ab2CWKMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 06:12:40 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56122 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756601Ab2CWKMj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 06:12:39 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.2.82])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SB1U6-0001tR-2J; Fri, 23 Mar 2012 11:12:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <1332482108-2659-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193750>

On 03/23/2012 06:54 AM, Lucian Poston wrote:

> diff --git a/diff.c b/diff.c
> index 377ec1e..31ba10c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1383,6 +1383,8 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
>   	int width, name_width, graph_width, number_width =3D 4, count;
>   	const char *reset, *add_c, *del_c;
>   	const char *line_prefix =3D "";
> +	int line_prefix_length =3D 0;
> +	int reserved_character_count;
>   	int extra_shown =3D 0;
>   	struct strbuf *msg =3D NULL;
>=20
> @@ -1392,6 +1394,7 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
>   	if (options->output_prefix) {
>   		msg =3D options->output_prefix(options, options->output_prefix_da=
ta);
>   		line_prefix =3D msg->buf;
> +		line_prefix_length =3D options->output_prefix_length;
>   	}
Hi,
line_prefix will only be used once. And options->output_prefix_length w=
ill
be 0 if !options->output_prefix, so line_prefix variable can be elimina=
ted
and options->output_prefix_length used directly instead.

>   	count =3D options->stat_count ? options->stat_count : data->nr;
> @@ -1427,37 +1430,46 @@ static void show_stats(struct diffstat_t *dat=
a, struct diff_options *options)
>   	 * We have width =3D stat_width or term_columns() columns total.
>   	 * We want a maximum of min(max_len, stat_name_width) for the name=
 part.
>   	 * We want a maximum of min(max_change, stat_graph_width) for the =
+- part.
> -	 * We also need 1 for " " and 4 + decimal_width(max_change)
> -	 * for " | NNNN " and one the empty column at the end, altogether
> +	 * Each line needs space for the following characters:
> +	 *   - 1 for the initial " "
> +	 *   - 4 + decimal_width(max_change) for " | NNNN "
> +	 *   - 1 for the empty column at the end,
> +	 * Altogether, the reserved_character_count totals
>   	 * 6 + decimal_width(max_change).
>   	 *
> -	 * If there's not enough space, we will use the smaller of
> -	 * stat_name_width (if set) and 5/8*width for the filename,
> -	 * and the rest for constant elements + graph part, but no more
> -	 * than stat_graph_width for the graph part.
> -	 * (5/8 gives 50 for filename and 30 for the constant parts + graph
> -	 * for the standard terminal size).
> +	 * Additionally, there may be a line_prefix, which reduces the avai=
lable
> +	 * width by line_prefix_length.
> +	 *
> +	 * If there's not enough space, we will use the smaller of stat_nam=
e_width
> +	 * (if set) and 5/8*width for the filename, and the rest for the gr=
aph
> +	 * part, but no more than stat_graph_width for the graph part.
> +	 * Assuming the line prefix is empty, on a standard 80 column termi=
nal
> +	 * this ratio results in 50 characters for the filename and 20 char=
acters
> +	 * for the graph (plus the 10 reserved characters).
>   	 *
>   	 * In other words: stat_width limits the maximum width, and
>   	 * stat_name_width fixes the maximum width of the filename,
>   	 * and is also used to divide available columns if there
>   	 * aren't enough.
>   	 */
> +	reserved_character_count =3D 6 + number_width;
>=20
>   	if (options->stat_width =3D=3D -1)
>   		width =3D term_columns();
>   	else
>   		width =3D options->stat_width ? options->stat_width : 80;
>=20
> +	width -=3D line_prefix_length;
> +
>   	if (options->stat_graph_width =3D=3D -1)
>   		options->stat_graph_width =3D diff_stat_graph_width;
>=20
>   	/*
> -	 * Guarantee 3/8*16=3D=3D6 for the graph part
> -	 * and 5/8*16=3D=3D10 for the filename part
> +	 * Guarantees at least 6 characters for the graph part [16 * 3/8]
> +	 * and at least 10 for the filename part [16 * 5/8]
>   	 */
> -	if (width<  16 + 6 + number_width)
> -		width =3D 16 + 6 + number_width;
> +	if (width<  16 + reserved_character_count)
> +		width =3D 16 + reserved_character_count;
>=20
>   	/*
>   	 * First assign sizes that are wanted, ignoring available width.
> @@ -1472,16 +1484,36 @@ static void show_stats(struct diffstat_t *dat=
a, struct diff_options *options)
>   	/*
>   	 * Adjust adjustable widths not to exceed maximum width
>   	 */

In this part below, you add gratuitous braces around single line if-blo=
cks.
This makes the code (and the diff) longer with no gain.

> -	if (name_width + number_width + 6 + graph_width>  width) {
> -		if (graph_width>  width * 3/8 - number_width - 6)
> -			graph_width =3D width * 3/8 - number_width - 6;
> +	if (reserved_character_count + name_width + graph_width>  width) {
> +		/*
> +		 * Reduce graph_width to be at most 3/8 of the unreserved space an=
d no
> +		 * less than 6, which leaves at least 5/8 for the filename.
> +		 */
> +		if (graph_width>  width * 3/8 - reserved_character_count) {
> +			graph_width =3D width * 3/8 - reserved_character_count;
> +			if (graph_width<  6) {
> +				graph_width =3D 6;
> +			}
> +		}
This extra test is not necessary. Above, after /* Guarantees at least 6=
 characters
for the graph part [16 * 3/8] ... */, this should already by so that
(width * 3/8 - reserved_character_count) is at least 6.

> +
> +		/*
> +		 * If the remaining unreserved space will not accomodate the
> +		 * filenames, adjust name_width to use all available remaining spa=
ce.
> +		 * Otherwise, assign any extra space to graph_width.
> +		 */
> +		if (name_width>  width - reserved_character_count - graph_width) {
> +			name_width =3D width - reserved_character_count - graph_width;
> +		} else {
> +			graph_width =3D width - reserved_character_count - name_width;
> +		}
> +
> +		/*
> +		 * If stat-graph-width was specified, limit graph_width to its val=
ue.
> +		 */
>   		if (options->stat_graph_width&&
> -		    graph_width>  options->stat_graph_width)
> +				graph_width>  options->stat_graph_width) {
>   			graph_width =3D options->stat_graph_width;
> -		if (name_width>  width - number_width - 6 - graph_width)
> -			name_width =3D width - number_width - 6 - graph_width;
> -		else
> -			graph_width =3D width - number_width - 6 - name_width;
> +		}
Here, the order of the two tests
(1) if (options->stat_graph_width && graph_width > options->stat_graph_=
width)
(2) if (name_width > width - number_width - 6 - graph_width)
is reversed. This is not OK, because this means that
options->stat_graph_width will be used unconditionally, while
before it was subject to limiting by total width.

>   	}
>=20
>   	/*

The tests:
After the new tests are added, I see:

ok 53 - format-patch ignores COLUMNS (long filename)
ok 54 - diff respects COLUMNS (long filename)
ok 55 - show respects COLUMNS (long filename)
ok 56 - log respects COLUMNS (long filename)
ok 57 - show respects 80 COLUMNS (long filename)  <=3D=3D=3D=3D=3D=3D=3D
ok 58 - log respects 80 COLUMNS (long filename)   <-------
ok 59 - show respects 80 COLUMNS (long filename)  <=3D=3D=3D=3D=3D=3D=3D
ok 60 - log respects 80 COLUMNS (long filename)   <-------

So some tests descriptions are duplicated. Also it would be
nice to test with --graph in more places. I'm attaching a
replacement patch which adds more tests. It should go *before*
your series, and your series should  tweak the tests to pass,
showing what changed.

------- 8< --------
=46rom 348d96dd9ae4a4ffd04aea4497b237a794e37727 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Zbigniew=3D20J=3DC4=3D99drzejewski-Szmek?=3D <zbysz=
ek@in.waw.pl>
Date: Fri, 23 Mar 2012 11:04:21 +0100
Subject: [PATCH] t4052: test --stat output with --graph
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Add tests which show that the width of the --prefix added by --graph
is not taken into consideration when the diff stat output width is
calculated.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t4052-stat-output.sh |   78 ++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 328aa8f..da14984 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -82,11 +82,15 @@ test_expect_success 'preparation for big change tes=
ts' '
 cat >expect80 <<'EOF'
  abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
 EOF
-
+cat >expect80-graph <<'EOF'
+|  abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
+EOF
 cat >expect200 <<'EOF'
  abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
-
+cat >expect200-graph <<'EOF'
+|  abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (big change)" '
@@ -94,6 +98,14 @@ do
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
+
+	test "$cmd" !=3D diff || continue
+
+	test_expect_success "$cmd --graph $verb COLUMNS (big change)" '
+		COLUMNS=3D200 git $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect200 diff HEAD^ HEAD --stat
@@ -104,7 +116,9 @@ EOF
 cat >expect40 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++
 EOF
-
+cat >expect40-graph <<'EOF'
+|  abcd | 1000 ++++++++++++++++++++++++++
+EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb not enough COLUMNS (big change)" '
@@ -118,6 +132,20 @@ do
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
+
+	test "$cmd" !=3D diff || continue
+
+	test_expect_success "$cmd --graph $verb not enough COLUMNS (big chang=
e)" '
+		COLUMNS=3D40 git $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
+
+	test_expect_success "$cmd --graph $verb statGraphWidth config" '
+		git -c diff.statGraphWidth=3D26 $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect40 diff HEAD^ HEAD --stat
@@ -129,6 +157,9 @@ EOF
 cat >expect <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++
 EOF
+cat >expect-graph <<'EOF'
+|  abcd | 1000 ++++++++++++++++++++++++++
+EOF
 while read cmd args
 do
 	test_expect_success "$cmd --stat=3Dwidth with big change" '
@@ -143,11 +174,25 @@ do
 		test_cmp expect actual
 	'
=20
-	test_expect_success "$cmd --stat-graph--width with big change" '
+	test_expect_success "$cmd --stat-graph-width with big change" '
 		git $cmd $args --stat-graph-width=3D26 >output
 		grep " | " output >actual &&
 		test_cmp expect actual
 	'
+
+	test "$cmd" !=3D diff || continue
+
+	test_expect_success "$cmd --stat-width=3Dwidth --graph with big chang=
e" '
+		git $cmd $args --stat-width=3D40 --graph >output
+		grep " | " output >actual &&
+		test_cmp expect-graph actual
+	'
+
+	test_expect_success "$cmd --stat-graph-width --graph with big change"=
 '
+		git $cmd $args --stat-graph-width=3D26 --graph >output
+		grep " | " output >actual &&
+		test_cmp expect-graph actual
+	'
 done <<\EOF
 format-patch -1 --stdout
 diff HEAD^ HEAD --stat
@@ -164,6 +209,9 @@ test_expect_success 'preparation for long filename =
tests' '
 cat >expect <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
 EOF
+cat >expect-graph <<'EOF'
+|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
+EOF
 while read cmd args
 do
 	test_expect_success "$cmd --stat=3Dwidth with big change is more bala=
nced" '
@@ -171,6 +219,14 @@ do
 		grep " | " output >actual &&
 		test_cmp expect actual
 	'
+
+	test "$cmd" !=3D diff || continue
+
+	test_expect_success "$cmd --stat=3Dwidth --graph with big change is b=
alanced" '
+		git $cmd $args --stat-width=3D60 --graph >output &&
+		grep " | " output >actual &&
+		test_cmp expect-graph actual
+	'
 done <<\EOF
 format-patch -1 --stdout
 diff HEAD^ HEAD --stat
@@ -181,9 +237,15 @@ EOF
 cat >expect80 <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++
 EOF
+cat >expect80-graph <<'EOF'
+|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++=
+++++++++++
+EOF
 cat >expect200 <<'EOF'
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
+cat >expect200-graph <<'EOF'
+|  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (long filename)" '
@@ -191,6 +253,14 @@ do
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
+
+	test "$cmd" !=3D diff || continue
+
+	test_expect_success "$cmd --graph $verb COLUMNS (long filename)" '
+		COLUMNS=3D200 git $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect200 diff HEAD^ HEAD --stat
--=20
1.7.10.rc1.225.gba57e


------- >8 --------
