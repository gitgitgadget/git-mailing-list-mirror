From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph
 output into account
Date: Thu, 12 Apr 2012 00:47:50 -0700
Message-ID: <CACz_eyc0AjvU0U2FGzqhUTZ_nncuFoAxZ6VGw0=7LVXH4SLqwA@mail.gmail.com>
References: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
	<1332482108-2659-1-git-send-email-lucian.poston@gmail.com>
	<4F6C4C90.5050702@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Apr 12 09:48:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIEl3-0001Hj-7V
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 09:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762111Ab2DLHrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 03:47:52 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:37061 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab2DLHru convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 03:47:50 -0400
Received: by dake40 with SMTP id e40so2145787dak.11
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YS8oLJASKKVJPFwU5PVM+ZXcEjmd8GT7n/L3cXtkS/c=;
        b=r44Z3J8XdCCvVzcdWNO+HGbC+Wp8u0JpcRR60XZAE3dmYRYYgVs/mP45sS+H0BZ5Jk
         SRztvKagNQz6GaYAgnw2tm6UEFJmrjFd04niiXnNQt6h4i3bPWkJHB1admLqHFugOu3u
         SecYBk+M5fUsbGsCy2d9OAUG2wdzdEHd3CnJgII4wihw3CuMIxAucPsQ8CcEHYnYB/7h
         G48xHjJF0Udi94liDg+B5UIPEleXy/UrZzKHHjRZS1u75YyWuSKu2MlZNg2LCj3LX+Gc
         PCGeBba2PPKFJrY4lH3h2XhpRa3ALd2thBc5ESfDF1ubquWmEYwUIWCNWWbzgkfoEu8B
         H9/Q==
Received: by 10.68.194.1 with SMTP id hs1mr1158582pbc.6.1334216870263; Thu, 12
 Apr 2012 00:47:50 -0700 (PDT)
Received: by 10.68.238.74 with HTTP; Thu, 12 Apr 2012 00:47:50 -0700 (PDT)
In-Reply-To: <4F6C4C90.5050702@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195309>

On Fri, Mar 23, 2012 at 03:12, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
> On 03/23/2012 06:54 AM, Lucian Poston wrote:
>
>> diff --git a/diff.c b/diff.c
>> index 377ec1e..31ba10c 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1383,6 +1383,8 @@ static void show_stats(struct diffstat_t *data=
, struct diff_options *options)
>> =C2=A0 =C2=A0 =C2=A0 int width, name_width, graph_width, number_widt=
h =3D 4, count;
>> =C2=A0 =C2=A0 =C2=A0 const char *reset, *add_c, *del_c;
>> =C2=A0 =C2=A0 =C2=A0 const char *line_prefix =3D "";
>> + =C2=A0 =C2=A0 int line_prefix_length =3D 0;
>> + =C2=A0 =C2=A0 int reserved_character_count;
>> =C2=A0 =C2=A0 =C2=A0 int extra_shown =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 struct strbuf *msg =3D NULL;
>>
>> @@ -1392,6 +1394,7 @@ static void show_stats(struct diffstat_t *data=
, struct diff_options *options)
>> =C2=A0 =C2=A0 =C2=A0 if (options->output_prefix) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D options->ou=
tput_prefix(options, options->output_prefix_data);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line_prefix =3D msg=
->buf;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line_prefix_length =3D o=
ptions->output_prefix_length;
>> =C2=A0 =C2=A0 =C2=A0 }
> Hi,
> line_prefix will only be used once. And options->output_prefix_length=
 will
> be 0 if !options->output_prefix, so line_prefix variable can be elimi=
nated
> and options->output_prefix_length used directly instead.

Rather than adding the line_prefix_length variable, the next patch
will use options->output_prefix_length directly.

>> =C2=A0 =C2=A0 =C2=A0 count =3D options->stat_count ? options->stat_c=
ount : data->nr;
>> @@ -1427,37 +1430,46 @@ static void show_stats(struct diffstat_t *da=
ta, struct diff_options *options)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* We have width =3D stat_width or term_co=
lumns() columns total.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* We want a maximum of min(max_len, stat_=
name_width) for the name part.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* We want a maximum of min(max_change, st=
at_graph_width) for the +- part.
>> - =C2=A0 =C2=A0 =C2=A0* We also need 1 for " " and 4 + decimal_width=
(max_change)
>> - =C2=A0 =C2=A0 =C2=A0* for " | NNNN " and one the empty column at t=
he end, altogether
>> + =C2=A0 =C2=A0 =C2=A0* Each line needs space for the following char=
acters:
>> + =C2=A0 =C2=A0 =C2=A0* =C2=A0 - 1 for the initial " "
>> + =C2=A0 =C2=A0 =C2=A0* =C2=A0 - 4 + decimal_width(max_change) for "=
 | NNNN "
>> + =C2=A0 =C2=A0 =C2=A0* =C2=A0 - 1 for the empty column at the end,
>> + =C2=A0 =C2=A0 =C2=A0* Altogether, the reserved_character_count tot=
als
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* 6 + decimal_width(max_change).
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>> - =C2=A0 =C2=A0 =C2=A0* If there's not enough space, we will use the=
 smaller of
>> - =C2=A0 =C2=A0 =C2=A0* stat_name_width (if set) and 5/8*width for t=
he filename,
>> - =C2=A0 =C2=A0 =C2=A0* and the rest for constant elements + graph p=
art, but no more
>> - =C2=A0 =C2=A0 =C2=A0* than stat_graph_width for the graph part.
>> - =C2=A0 =C2=A0 =C2=A0* (5/8 gives 50 for filename and 30 for the co=
nstant parts + graph
>> - =C2=A0 =C2=A0 =C2=A0* for the standard terminal size).
>> + =C2=A0 =C2=A0 =C2=A0* Additionally, there may be a line_prefix, wh=
ich reduces the available
>> + =C2=A0 =C2=A0 =C2=A0* width by line_prefix_length.
>> + =C2=A0 =C2=A0 =C2=A0*
>> + =C2=A0 =C2=A0 =C2=A0* If there's not enough space, we will use the=
 smaller of stat_name_width
>> + =C2=A0 =C2=A0 =C2=A0* (if set) and 5/8*width for the filename, and=
 the rest for the graph
>> + =C2=A0 =C2=A0 =C2=A0* part, but no more than stat_graph_width for =
the graph part.
>> + =C2=A0 =C2=A0 =C2=A0* Assuming the line prefix is empty, on a stan=
dard 80 column terminal
>> + =C2=A0 =C2=A0 =C2=A0* this ratio results in 50 characters for the =
filename and 20 characters
>> + =C2=A0 =C2=A0 =C2=A0* for the graph (plus the 10 reserved characte=
rs).
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* In other words: stat_width limits the m=
aximum width, and
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* stat_name_width fixes the maximum width=
 of the filename,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* and is also used to divide available co=
lumns if there
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* aren't enough.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 reserved_character_count =3D 6 + number_width;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (options->stat_width =3D=3D -1)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D term_colu=
mns();
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D options->=
stat_width ? options->stat_width : 80;
>>
>> + =C2=A0 =C2=A0 width -=3D line_prefix_length;
>> +
>> =C2=A0 =C2=A0 =C2=A0 if (options->stat_graph_width =3D=3D -1)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options->stat_graph=
_width =3D diff_stat_graph_width;
>>
>> =C2=A0 =C2=A0 =C2=A0 /*
>> - =C2=A0 =C2=A0 =C2=A0* Guarantee 3/8*16=3D=3D6 for the graph part
>> - =C2=A0 =C2=A0 =C2=A0* and 5/8*16=3D=3D10 for the filename part
>> + =C2=A0 =C2=A0 =C2=A0* Guarantees at least 6 characters for the gra=
ph part [16 * 3/8]
>> + =C2=A0 =C2=A0 =C2=A0* and at least 10 for the filename part [16 * =
5/8]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> - =C2=A0 =C2=A0 if (width< =C2=A016 + 6 + number_width)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D 16 + 6 + numbe=
r_width;
>> + =C2=A0 =C2=A0 if (width< =C2=A016 + reserved_character_count)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D 16 + reserved_=
character_count;
>>
>> =C2=A0 =C2=A0 =C2=A0 /*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* First assign sizes that are wanted, ign=
oring available width.
>> @@ -1472,16 +1484,36 @@ static void show_stats(struct diffstat_t *da=
ta, struct diff_options *options)
>> =C2=A0 =C2=A0 =C2=A0 /*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* Adjust adjustable widths not to exceed =
maximum width
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>
> In this part below, you add gratuitous braces around single line if-b=
locks.
> This makes the code (and the diff) longer with no gain.

I prefer gratuitous braces, particularly when conditionals are nested
as they are here. It helps later when maintaining the code if someone
wants to add a debug statement or comment out a line.

I'll remove braces from single line conditionals to keep with the
existing conventions.

>> - =C2=A0 =C2=A0 if (name_width + number_width + 6 + graph_width> =C2=
=A0width) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (graph_width> =C2=A0w=
idth * 3/8 - number_width - 6)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 graph_width =3D width * 3/8 - number_width - 6;
>> + =C2=A0 =C2=A0 if (reserved_character_count + name_width + graph_wi=
dth> =C2=A0width) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Reduce graph_wid=
th to be at most 3/8 of the unreserved space and no
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* less than 6, whi=
ch leaves at least 5/8 for the filename.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (graph_width> =C2=A0w=
idth * 3/8 - reserved_character_count) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 graph_width =3D width * 3/8 - reserved_character_count;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (graph_width< =C2=A06) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graph_width =3D 6;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> This extra test is not necessary. Above, after /* Guarantees at least=
 6 characters
> for the graph part [16 * 3/8] ... */, this should already by so that
> (width * 3/8 - reserved_character_count) is at least 6.

Ahh, this is because the calculations go haywire when the number of
columns is small. I briefly mentioned it here:
http://thread.gmane.org/gmane.comp.version-control.git/193694/focus=3D1=
93744

graph_width actually can have a negative value under certain
conditions, and this check compensates for that edge case. My earlier
patches took a less conservative approach and adjusted the
calculations so that the value of graph_width would be at least 6, but
it caused several tests to regress. Since the intention of the
original graph_width calculation was place a lower bound of 6 on its
value, I simply enforce that here without affecting the general cases,
which will remain unmodified in order to prevent test regressions.

>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If the remaining=
 unreserved space will not accomodate the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* filenames, adjus=
t name_width to use all available remaining space.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Otherwise, assig=
n any extra space to graph_width.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (name_width> =C2=A0wi=
dth - reserved_character_count - graph_width) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 name_width =3D width - reserved_character_count - graph_width;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 graph_width =3D width - reserved_character_count - name_width;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If stat-graph-wi=
dth was specified, limit graph_width to its value.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (options->stat_g=
raph_width&&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graph_widt=
h> =C2=A0options->stat_graph_width)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graph_width> =C2=A0options->stat_graph_=
width) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 graph_width =3D options->stat_graph_width;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (name_width> =C2=A0wi=
dth - number_width - 6 - graph_width)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 name_width =3D width - number_width - 6 - graph_width;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 graph_width =3D width - number_width - 6 - name_width;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> Here, the order of the two tests
> (1) if (options->stat_graph_width && graph_width > options->stat_grap=
h_width)
> (2) if (name_width > width - number_width - 6 - graph_width)
> is reversed. This is not OK, because this means that
> options->stat_graph_width will be used unconditionally, while
> before it was subject to limiting by total width.

If options->stat_graph_width is specified, it should always limit the
value of graph_width, correct? Since (1) is the last test, it can only
decrease the value of graph_width, which would already be limited by
the total width.

I just noticed that name_width isn't being limited to stat_name_width,
if it is specified. I'll add a check for that.

> The tests:
> After the new tests are added, I see:
>
> ok 53 - format-patch ignores COLUMNS (long filename)
> ok 54 - diff respects COLUMNS (long filename)
> ok 55 - show respects COLUMNS (long filename)
> ok 56 - log respects COLUMNS (long filename)
> ok 57 - show respects 80 COLUMNS (long filename) =C2=A0<=3D=3D=3D=3D=3D=
=3D=3D
> ok 58 - log respects 80 COLUMNS (long filename) =C2=A0 <-------
> ok 59 - show respects 80 COLUMNS (long filename) =C2=A0<=3D=3D=3D=3D=3D=
=3D=3D
> ok 60 - log respects 80 COLUMNS (long filename) =C2=A0 <-------
>
> So some tests descriptions are duplicated. Also it would be
> nice to test with --graph in more places. I'm attaching a
> replacement patch which adds more tests. It should go *before*
> your series, and your series should =C2=A0tweak the tests to pass,
> showing what changed.

Thanks, I'll add these.
