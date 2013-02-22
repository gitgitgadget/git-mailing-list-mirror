From: =?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
Subject: Crashes while trying to show tag objects with bad timestamps
Date: Sat, 23 Feb 2013 00:30:28 +0200
Message-ID: <kg8ri2$vjb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 23:35:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91D3-000638-IK
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 23:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab3BVWex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 17:34:53 -0500
Received: from plane.gmane.org ([80.91.229.3]:55088 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919Ab3BVWew (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 17:34:52 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U91Cp-0005tA-FN
	for git@vger.kernel.org; Fri, 22 Feb 2013 23:35:03 +0100
Received: from 78-60-211-195.static.zebra.lt ([78.60.211.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 23:35:03 +0100
Received: from grawity by 78-60-211-195.static.zebra.lt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 23:35:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 78-60-211-195.static.zebra.lt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216870>

When messing around with various repositories, I noticed that git 1.8
(currently using 1.8.2.rc0.22.gb3600c3) has problems parsing tag object=
s
that have invalid timestamps.

Times in tag objects appear to be kept as Unix timestamps, but I didn't
realize this at first, and ran something roughly equivalent to:
  git cat-file -p $tagname | git hash-object -w -t tag --stdin
creating a tag object the "tagger" line containing formatted time
instead of a Unix timestamp.

Git doesn't handle the resulting tag objects nicely at all. For example=
,
running `git cat-file -p` on the new object outputs a really odd
timestamp "Thu Jun Thu Jan 1 00:16:09 1970 +0016" (I'm guessing it
parses the year as Unix time), and `git show` outright crashes
(backtrace included below.)

I would have expected both commands to print a "tag object corrupt"
message, or maybe even a more specific "bad timestamp in tagger line"..=
=2E

To reproduce:

printf '%s\n' \
  'object 4b825dc642cb6eb9a060e54bf8d69288fbee4904' 'type tree' \
  'tag test' 'tagger User <user@none> Thu Jun 9 16:44:04 2005 +0000' \
  '' 'Test tag' | git hash-object -w -t tag --stdin | xargs git show


> #0  0x00007f42560bb5f3 in ____strtoull_l_internal () from /usr/lib/li=
bc.so.6
> No symbol table info available.
> #1  0x00000000004b4c81 in pp_user_info (pp=3Dpp@entry=3D0x7fff3c30f1a=
0,=20
>     what=3Dwhat@entry=3D0x50c13b "Tagger", sb=3Dsb@entry=3D0x7fff3c30=
f140,=20
>     line=3D0xc267c7 "Jilles Tjoelker <jilles@stack.nl> Thu Jun 9 16:4=
4:04 2005 +0000\n\nTag 1.0rc1.\n\n", encoding=3D0x507e20 "UTF-8") at pr=
etty.c:431
>         name =3D {alloc =3D 24, len =3D 15, buf =3D 0xc24690 "Jilles =
Tjoelker"}
>         mail =3D {alloc =3D 24, len =3D 15, buf =3D 0xc24750 "jilles@=
stack.nl"}
>         ident =3D {
>           name_begin =3D 0xc267c7 "Jilles Tjoelker <jilles@stack.nl> =
Thu Jun 9 16:44:04 2005 +0000\n\nTag 1.0rc1.\n\n",=20
>           name_end =3D 0xc267d6 " <jilles@stack.nl> Thu Jun 9 16:44:0=
4 2005 +0000\n\nTag 1.0rc1.\n\n",=20
>           mail_begin =3D 0xc267d8 "jilles@stack.nl> Thu Jun 9 16:44:0=
4 2005 +0000\n\nTag 1.0rc1.\n\n", mail_end =3D 0xc267e7 "> Thu Jun 9 16=
:44:04 2005 +0000\n\nTag 1.0rc1.\n\n",=20
>           date_begin =3D 0x0, date_end =3D 0x0, tz_begin =3D 0x0, tz_=
end =3D 0x0}
>         linelen =3D <optimized out>
>         line_end =3D <optimized out>
>         date =3D <optimized out>
>         mailbuf =3D 0xc267d8 "jilles@stack.nl> Thu Jun 9 16:44:04 200=
5 +0000\n\nTag 1.0rc1.\n\n"
>         namebuf =3D 0xc267c7 "Jilles Tjoelker <jilles@stack.nl> Thu J=
un 9 16:44:04 2005 +0000\n\nTag 1.0rc1.\n\n"
>         namelen =3D 33
>         maillen =3D 15
>         max_length =3D 78
>         time =3D <optimized out>
>         tz =3D <optimized out>
> #2  0x0000000000439af5 in show_tagger (buf=3D<optimized out>, len=3D<=
optimized out>,=20
>     rev=3D<optimized out>) at builtin/log.c:400
>         pp =3D {fmt =3D CMIT_FMT_MEDIUM, abbrev =3D 0, subject =3D 0x=
0, after_subject =3D 0x0,=20
>           preserve_subject =3D 0, date_mode =3D DATE_NORMAL, date_mod=
e_explicit =3D 0,=20
>           need_8bit_cte =3D 0, notes_message =3D 0x0, reflog_info =3D=
 0x0,=20
>           output_encoding =3D 0x0, mailmap =3D 0x0, color =3D 0}
>         out =3D {alloc =3D 0, len =3D 0, buf =3D 0x7a8188 <strbuf_slo=
pbuf> ""}
> #3  show_tag_object (rev=3D0x7fff3c30f1f0,=20
>     sha1=3D0xc2be44 "\230\211\275\331\365Q\306z\017\071d\331\035\062\=
247a\347~M8P", <incomplete sequence \303>) at builtin/log.c:427
>         new_offset =3D 151
>         type =3D OBJ_TAG
>         buf =3D 0xc26770 "object ffa28d13e40e03bd367d0219c7eb516be0f1=
80d2\ntype commit\ntag hyperion-1.0rc1\ntagger Jilles Tjoelker <jilles@=
stack.nl> Thu Jun 9 16:44:04 2005 +0000\n\nTag 1.0rc1.\n\n"
>         size =3D 165
>         offset =3D <optimized out>


--=20
Mantas Mikul=C4=97nas <grawity@gmail.com>
