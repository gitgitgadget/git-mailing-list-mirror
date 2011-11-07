From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum
 member
Date: Mon, 7 Nov 2011 13:49:13 -0600
Message-ID: <20111107194912.GA12469@elie.hsd1.il.comcast.net>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 20:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNVCC-0007PW-Vo
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 20:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab1KGTtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 14:49:24 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34030 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab1KGTtX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 14:49:23 -0500
Received: by qao25 with SMTP id 25so967450qao.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 11:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wkUSBKvfbQ+pylMABBP7vrch6nGYe+yUfUg0aPiBDFI=;
        b=ma01i72i8DSiqmDzNH9PiybOszYHHMDMaBW1+gmjSfrRhCU1dUmBfyE8McG2NQAB4y
         VPfTGKcLVDV0Z48/YBchyliVGRD8dvVxnD3HrjmIA2D4L+5+yRUTs7RuC3qfdnNK22jk
         Ed/hhGPDNI33xCuaMncVqloL5nbtEyJ1vs370=
Received: by 10.229.246.5 with SMTP id lw5mr3291871qcb.93.1320695363019;
        Mon, 07 Nov 2011 11:49:23 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id cd3sm20740570qab.5.2011.11.07.11.49.21
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 11:49:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1320581184-4557-4-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185020>

Hi,

> --- a/grep.c
> +++ b/grep.c
> @@ -327,7 +327,7 @@ static struct grep_expr *prep_header_patterns(str=
uct grep_opt *opt)
>  	for (p =3D opt->header_list; p; p =3D p->next) {
>  		if (p->token !=3D GREP_PATTERN_HEAD)
>  			die("bug: a non-header pattern in grep header list.");
> -		if (p->field < 0 || GREP_HEADER_FIELD_MAX <=3D p->field)
> +		if (GREP_HEADER_FIELD_MAX <=3D p->field)

I imagine the following would be less controversial.

-- >8 --
=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Subject: grep: get rid of bounds check on "enum grep_header_field" valu=
e

The grep_header_field enum is defined as:

    enum grep_header_field {
    	GREP_HEADER_AUTHOR =3D 0,
    	GREP_HEADER_COMMITTER
    };

Git's grep code sanity-checks the value of p->field before using it in
order to avoid reading and writing past the end of an array.
Unfortunately that test trips up misguided static analyzers like
"gcc -Wtype-limits" that do not recognize that C allows this enum to
be a signed integer type and an "x < 0" comparison really could fire
if someone passed in an uninitialized value.

Let's just drop the check.  Luckily git always does initialize
p->field correctly, and if it were to stop doing so, then hopefully
running the test suite with valgrind would catch it.

Noticed with clang -Wtautological-compare.

[jn: drop the GREP_HEADER_FIELD_MAX <=3D p->field check, too,
 for symmetry]

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 grep.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index b29d09c7..424c46cd 100644
--- a/grep.c
+++ b/grep.c
@@ -327,8 +327,6 @@ static struct grep_expr *prep_header_patterns(struc=
t grep_opt *opt)
 	for (p =3D opt->header_list; p; p =3D p->next) {
 		if (p->token !=3D GREP_PATTERN_HEAD)
 			die("bug: a non-header pattern in grep header list.");
-		if (p->field < 0 || GREP_HEADER_FIELD_MAX <=3D p->field)
-			die("bug: unknown header field %d", p->field);
 		compile_regexp(p, opt);
 	}
=20
--=20
1.7.8.rc0
