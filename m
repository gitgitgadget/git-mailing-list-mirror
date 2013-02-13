From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/4] count-objects improvements
Date: Wed, 13 Feb 2013 16:13:15 +0700
Message-ID: <1360746799-3668-1-git-send-email-pclouds@gmail.com>
References: <7va9r9igze.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 10:13:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5YOl-0004MU-Rs
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 10:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab3BMJMj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2013 04:12:39 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:43858 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab3BMJMg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 04:12:36 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so454740dak.2
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 01:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=bB2obkdM5B07NgJwDhYG4vHKM6bOle+hgczxV5BYEq8=;
        b=lDbi9Jobv9BSLIzYoquYLJWnIWEdvHahHotpQrUGpWRAppMDZYF6jArPCk+O8i7iCb
         NrjLlYFtrbfrkEwZtpRWamxU3gHFVZ/7cdNdJ3MjWb0xfkUdps4Hafqaw06qvKjQsa3H
         0TOBctErjdYjxN+6OQ8Z9n9z4BlGszyGHoUPoGVhVM2tzwYfpLYhrlm7yk0g2oQ0nxdI
         kdpfpyq37JPgnDsQwikXH4138mRN5EMQAkIV8WsBZ/QMcw/cmefcAWYklD/d6udHL+Z2
         TA29uNXjQ4ERZNErEvNBe7pG7yYWLubXUy56xiu1b/Osb8O3lFc1ypoFqLoxQE2igTrz
         IAqQ==
X-Received: by 10.67.22.33 with SMTP id hp1mr24962275pad.3.1360746755291;
        Wed, 13 Feb 2013 01:12:35 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id l5sm81949166pax.10.2013.02.13.01.12.31
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 01:12:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Feb 2013 16:13:20 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <7va9r9igze.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216239>

On Wed, Feb 13, 2013 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> +/* A hook for count-objects to report invalid files in pack directo=
ry */
>> +extern void (*report_garbage)(const char *desc, const char *path, i=
nt len, const char *name);
>
> We may want to document the strange way the last three parameters
> are used somewhere.  e.g.
>
>         shows "path" (if "name" is NULL), or prepends "path" in
>         front of name (otherwise); only for the latter, "path" can
>         be a string that is not NUL-terminated but its length
>         specified with "len" and in that case a slash is inserted
>         between the path and the "name".
>
> When described clearly, it sounds somewhat ugly and incoherent API,
> even though it covers the immediate need X-<.

One of the reasons why I did not export it explicitly. Changed it to

void (*report_garbage)(const char *desc, const char *path);

and pushed the ugly part back to callers.

> How about doing it something along this line, perhaps?
>
>         int i;
>         int beginning_of_this_name =3D -1;
>         int seen_bits =3D 0; /* 01 for .idx, 02 for .pack */
>         for (i =3D 0; i < list->nr; i++) {
>                 if (beginning_of_this_name < 0)
>                         beginning_of_this_name =3D i;
>                 else if (list->items[i] and list->items[beginning_of_=
this_name]
>                          share the same basename)
>                         ; /* keep scanning */
>                 else {
>                         /* one name ended at (i-1) */
>                         if (seen_bits =3D=3D 3)
>                                 ; /* both .idx and .pack exist; good =
*/
>                         else
>                                 report_garbage_for_one_name(list, beg=
inning_of_this_name, i,
>                                                 seen_bits);
>                         seen_bits =3D 0;
>                         beginning_of_this_name =3D i;
>                 }
>                 if (list->items[i] is ".idx")
>                         seen_bits |=3D 1;
>                 if (list->items[i] is ".pack")
>                         seen_bits |=3D 2;
>
>         }
>         if (0 <=3D beginning_of_this_name && seen_bits !=3D 3)
>                 report_garbages_for_one_name(list, beginning_of_this_=
name, list->nr, seen_bits);
>
> with a helper function report_garbage_for_one_name() that would look =
like this:
>
>         report_garbage_for_one_name(...) {
>                 int j;
>                 const char *msg;
>                 switch (seen_bits) {
>                 case 0: msg =3D "no corresponding .idx nor .pack"; br=
eak;
>                 case 1: msg =3D "no corresponding .pack"; break;
>                 case 2: msg =3D "no corresponding .idx; break;
>                 }
>                 for (j =3D beginning_of_this_name; j < i; j++)
>                         report_garbage(msg, list->items[j]);
>         }
>
> For the above to work, prepare_packed_git_one() needs to retain only =
the
> paths with known extensions in garbage list. "pack-deadbeef.unk" can =
and
> should be reported as a garbage immediately when it is seen without b=
eing
> placed in the list.

Yup. Looks good.

>> +             } else if (has_extension(de->d_name, ".idx")) {
>> +                     struct string_list_item *item;
>> +                     int n =3D strlen(path) - 4;
>> +                     item =3D string_list_append_nodup(&garbage,
>> +                                                     xstrndup(path,=
 n));
>> +                     item->util =3D ".idx";
>> +                     continue;
>> +             } else
>> +                     report_garbage("garbage found", path, 0, NULL)=
;
>
> Hmm, where is a ".keep" file handled in this flow?

Apparently I smoked/drank while coding or something. .idx is supposed
to be .keep. This calls for a test to guard my code (part of this v4).

> The structure of the if/else cascade is much nicer than the earlier
> iterations, but wouldn't it be even more clear to do this?
>
>         if (is .idx file) {
>                 ... do that .idx thing ...
>         }
>
>         if (!report_garbage)
>                 continue; /* it does not matter what the file is */
>
>         if (is .pack) {
>                 ... remember that we saw this .pack ...
>         } else if (is .idx) {
>                 ... remember that we saw this .idx ...
>         } else if (is .keep) {
>                 ... remember that we saw this .keep ...
>         } else {
>                 ... all else --- report as garbage immediately ...
>         }

Done. 2/4 is updated to make sure the "if (is .idx file)" block does
not shortcut the loop with "continue;" so that we always get .idx
file in the end of the loop.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  git-count-objects.txt: describe each line in -v output
  sha1_file: reorder code in prepare_packed_git_one()
  count-objects: report garbage files in pack directory too
  count-objects: report how much disk space taken by garbage files

 Documentation/git-count-objects.txt |  22 ++++++--
 builtin/count-objects.c             |  30 ++++++++---
 cache.h                             |   3 ++
 sha1_file.c                         | 101 ++++++++++++++++++++++++++++=
+++-----
 t/t5304-prune.sh                    |  26 ++++++++++
 5 files changed, 156 insertions(+), 26 deletions(-)

--=20
1.8.1.2.536.gf441e6d
