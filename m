From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph
 output into account
Date: Thu, 12 Apr 2012 12:17:11 +0200
Message-ID: <4F86ABA7.8080703@in.waw.pl>
References: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com> <1332482108-2659-1-git-send-email-lucian.poston@gmail.com> <4F6C4C90.5050702@in.waw.pl> <CACz_eyc0AjvU0U2FGzqhUTZ_nncuFoAxZ6VGw0=7LVXH4SLqwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 12:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIH5i-0004SF-BD
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 12:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141Ab2DLKRU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 06:17:20 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34728 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756169Ab2DLKRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 06:17:19 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SIH5Z-0006UN-Ru; Thu, 12 Apr 2012 12:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <CACz_eyc0AjvU0U2FGzqhUTZ_nncuFoAxZ6VGw0=7LVXH4SLqwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195324>

On 04/12/2012 09:47 AM, Lucian Poston wrote:
> On Fri, Mar 23, 2012 at 03:12, Zbigniew J=C4=99drzejewski-Szmek
> <zbyszek@in.waw.pl>  wrote:
>> On 03/23/2012 06:54 AM, Lucian Poston wrote:
>>
>>> diff --git a/diff.c b/diff.c
>>> index 377ec1e..31ba10c 100644
>>> --- a/diff.c
>>> +++ b/diff.c
>>> @@ -1383,6 +1383,8 @@ static void show_stats(struct diffstat_t *dat=
a, struct diff_options *options)
>>>        int width, name_width, graph_width, number_width =3D 4, coun=
t;
>>>        const char *reset, *add_c, *del_c;
>>>        const char *line_prefix =3D "";
>>> +     int line_prefix_length =3D 0;
>>> +     int reserved_character_count;
>>>        int extra_shown =3D 0;
>>>        struct strbuf *msg =3D NULL;
>>>
>>> @@ -1392,6 +1394,7 @@ static void show_stats(struct diffstat_t *dat=
a, struct diff_options *options)
>>>        if (options->output_prefix) {
>>>                msg =3D options->output_prefix(options, options->out=
put_prefix_data);
>>>                line_prefix =3D msg->buf;
>>> +             line_prefix_length =3D options->output_prefix_length;
>>>        }
>> Hi,
>> line_prefix will only be used once. And options->output_prefix_lengt=
h will
>> be 0 if !options->output_prefix, so line_prefix variable can be elim=
inated
>> and options->output_prefix_length used directly instead.
>
> Rather than adding the line_prefix_length variable, the next patch
> will use options->output_prefix_length directly.
>
>>>        count =3D options->stat_count ? options->stat_count : data->=
nr;
>>> @@ -1427,37 +1430,46 @@ static void show_stats(struct diffstat_t *d=
ata, struct diff_options *options)
>>>         * We have width =3D stat_width or term_columns() columns to=
tal.
>>>         * We want a maximum of min(max_len, stat_name_width) for th=
e name part.
>>>         * We want a maximum of min(max_change, stat_graph_width) fo=
r the +- part.
>>> -      * We also need 1 for " " and 4 + decimal_width(max_change)
>>> -      * for " | NNNN " and one the empty column at the end, altoge=
ther
>>> +      * Each line needs space for the following characters:
>>> +      *   - 1 for the initial " "
>>> +      *   - 4 + decimal_width(max_change) for " | NNNN "
>>> +      *   - 1 for the empty column at the end,
>>> +      * Altogether, the reserved_character_count totals
>>>         * 6 + decimal_width(max_change).
>>>         *
>>> -      * If there's not enough space, we will use the smaller of
>>> -      * stat_name_width (if set) and 5/8*width for the filename,
>>> -      * and the rest for constant elements + graph part, but no mo=
re
>>> -      * than stat_graph_width for the graph part.
>>> -      * (5/8 gives 50 for filename and 30 for the constant parts +=
 graph
>>> -      * for the standard terminal size).
>>> +      * Additionally, there may be a line_prefix, which reduces th=
e available
>>> +      * width by line_prefix_length.
>>> +      *
>>> +      * If there's not enough space, we will use the smaller of st=
at_name_width
>>> +      * (if set) and 5/8*width for the filename, and the rest for =
the graph
>>> +      * part, but no more than stat_graph_width for the graph part=
=2E
>>> +      * Assuming the line prefix is empty, on a standard 80 column=
 terminal
>>> +      * this ratio results in 50 characters for the filename and 2=
0 characters
>>> +      * for the graph (plus the 10 reserved characters).
>>>         *
>>>         * In other words: stat_width limits the maximum width, and
>>>         * stat_name_width fixes the maximum width of the filename,
>>>         * and is also used to divide available columns if there
>>>         * aren't enough.
>>>         */
>>> +     reserved_character_count =3D 6 + number_width;
>>>
>>>        if (options->stat_width =3D=3D -1)
>>>                width =3D term_columns();
>>>        else
>>>                width =3D options->stat_width ? options->stat_width =
: 80;
>>>
>>> +     width -=3D line_prefix_length;
>>> +
>>>        if (options->stat_graph_width =3D=3D -1)
>>>                options->stat_graph_width =3D diff_stat_graph_width;
>>>
>>>        /*
>>> -      * Guarantee 3/8*16=3D=3D6 for the graph part
>>> -      * and 5/8*16=3D=3D10 for the filename part
>>> +      * Guarantees at least 6 characters for the graph part [16 * =
3/8]
>>> +      * and at least 10 for the filename part [16 * 5/8]
>>>         */
>>> -     if (width<    16 + 6 + number_width)
>>> -             width =3D 16 + 6 + number_width;
>>> +     if (width<    16 + reserved_character_count)
>>> +             width =3D 16 + reserved_character_count;
>>>
>>>        /*
>>>         * First assign sizes that are wanted, ignoring available wi=
dth.
>>> @@ -1472,16 +1484,36 @@ static void show_stats(struct diffstat_t *d=
ata, struct diff_options *options)
>>>        /*
>>>         * Adjust adjustable widths not to exceed maximum width
>>>         */
>>
>> In this part below, you add gratuitous braces around single line if-=
blocks.
>> This makes the code (and the diff) longer with no gain.
>
> I prefer gratuitous braces, particularly when conditionals are nested
> as they are here. It helps later when maintaining the code if someone
> wants to add a debug statement or comment out a line.
>
> I'll remove braces from single line conditionals to keep with the
> existing conventions.
Thanks.

>>> -     if (name_width + number_width + 6 + graph_width>    width) {
>>> -             if (graph_width>    width * 3/8 - number_width - 6)
>>> -                     graph_width =3D width * 3/8 - number_width - =
6;
>>> +     if (reserved_character_count + name_width + graph_width>    w=
idth) {
>>> +             /*
>>> +              * Reduce graph_width to be at most 3/8 of the unrese=
rved space and no
>>> +              * less than 6, which leaves at least 5/8 for the fil=
ename.
>>> +              */
>>> +             if (graph_width>    width * 3/8 - reserved_character_=
count) {
>>> +                     graph_width =3D width * 3/8 - reserved_charac=
ter_count;
>>> +                     if (graph_width<    6) {
>>> +                             graph_width =3D 6;
>>> +                     }
>>> +             }
>> This extra test is not necessary. Above, after /* Guarantees at leas=
t 6 characters
>> for the graph part [16 * 3/8] ... */, this should already by so that
>> (width * 3/8 - reserved_character_count) is at least 6.
>
> Ahh, this is because the calculations go haywire when the number of
> columns is small. I briefly mentioned it here:
> http://thread.gmane.org/gmane.comp.version-control.git/193694/focus=3D=
193744
>
> graph_width actually can have a negative value under certain
> conditions, and this check compensates for that edge case. My earlier
> patches took a less conservative approach and adjusted the
> calculations so that the value of graph_width would be at least 6, bu=
t
> it caused several tests to regress. Since the intention of the
> original graph_width calculation was place a lower bound of 6 on its
> value, I simply enforce that here without affecting the general cases=
,
> which will remain unmodified in order to prevent test regressions.
>
>>> +
>>> +             /*
>>> +              * If the remaining unreserved space will not accomod=
ate the
>>> +              * filenames, adjust name_width to use all available =
remaining space.
>>> +              * Otherwise, assign any extra space to graph_width.
>>> +              */
>>> +             if (name_width>    width - reserved_character_count -=
 graph_width) {
>>> +                     name_width =3D width - reserved_character_cou=
nt - graph_width;
>>> +             } else {
>>> +                     graph_width =3D width - reserved_character_co=
unt - name_width;
>>> +             }
>>> +
>>> +             /*
>>> +              * If stat-graph-width was specified, limit graph_wid=
th to its value.
>>> +              */
>>>                if (options->stat_graph_width&&
>>> -                 graph_width>    options->stat_graph_width)
>>> +                             graph_width>    options->stat_graph_w=
idth) {
>>>                        graph_width =3D options->stat_graph_width;
>>> -             if (name_width>    width - number_width - 6 - graph_w=
idth)
>>> -                     name_width =3D width - number_width - 6 - gra=
ph_width;
>>> -             else
>>> -                     graph_width =3D width - number_width - 6 - na=
me_width;
>>> +             }
>> Here, the order of the two tests
>> (1) if (options->stat_graph_width&&  graph_width>  options->stat_gra=
ph_width)
>> (2) if (name_width>  width - number_width - 6 - graph_width)
>> is reversed. This is not OK, because this means that
>> options->stat_graph_width will be used unconditionally, while
>> before it was subject to limiting by total width.
>
> If options->stat_graph_width is specified, it should always limit the
> value of graph_width, correct? Since (1) is the last test, it can onl=
y
> decrease the value of graph_width, which would already be limited by
> the total width.
Right, but the way the tests are ordered now, we could end up decreasin=
g
name_width first (after (2)) and then graph_width (after (1)), actually
using less than full width.

> I just noticed that name_width isn't being limited to stat_name_width=
,
> if it is specified. I'll add a check for that.
Sounds good.

>> The tests:
>> After the new tests are added, I see:
>>
>> ok 53 - format-patch ignores COLUMNS (long filename)
>> ok 54 - diff respects COLUMNS (long filename)
>> ok 55 - show respects COLUMNS (long filename)
>> ok 56 - log respects COLUMNS (long filename)
>> ok 57 - show respects 80 COLUMNS (long filename)<=3D=3D=3D=3D=3D=3D=3D
>> ok 58 - log respects 80 COLUMNS (long filename)<-------
>> ok 59 - show respects 80 COLUMNS (long filename)<=3D=3D=3D=3D=3D=3D=3D
>> ok 60 - log respects 80 COLUMNS (long filename)<-------
>>
>> So some tests descriptions are duplicated. Also it would be
>> nice to test with --graph in more places. I'm attaching a
>> replacement patch which adds more tests. It should go *before*
>> your series, and your series should  tweak the tests to pass,
>> showing what changed.
>
> Thanks, I'll add these.

Regards,
Zbyszek
