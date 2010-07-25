From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/7] Makefile: Include subdirectories in "make
 cover" reports
Date: Sun, 25 Jul 2010 12:02:42 -0500
Message-ID: <20100725170242.GB25658@burratino>
References: <1280068861-17701-1-git-send-email-avarab@gmail.com>
 <1280068861-17701-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 19:04:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od4cI-0000nT-9u
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab0GYRDw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 13:03:52 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40543 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab0GYRDv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:03:51 -0400
Received: by gyg10 with SMTP id 10so617931gyg.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/jiC2XyXpHgPr9+tqMszlpVLG2hy3GRHd6OTMW6DipQ=;
        b=UMjwSwPPM4Tkz+iVzmek0oAWO8VzfVeDPJA9+H869/TwX5xybKRg+8GSakdu26hvSU
         HrYIe2vWsxsjJyObmeDhQFqr/ADdsyEXyNEtstqxD3T9MpFK713apMVtPbtIldmtlvj+
         Da5lzRgqr8hBom/tD0kz7ShwpaQKqR+0h5m4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GZLdeJMXCvz2z53OmtW044GJ4DoUzrbqZJ13PvHjA+zaxS0yAojI74goRQqh48sne9
         Opl9bnRiM4C+MjsunKv5EhpGYA/1MDQsMwvWoi4fm677CqrVkLAAK3tNgF4BkgI8iodE
         MqgdK45is6PT493GE8B+LkqUmLlEFa7zRenGw=
Received: by 10.151.116.2 with SMTP id t2mr7663559ybm.336.1280077426669;
        Sun, 25 Jul 2010 10:03:46 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id q25sm4835047ybk.6.2010.07.25.10.03.45
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:03:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280068861-17701-3-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151760>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> We generate profiling files in all the $(OBJECTS) dirs. Aggregate
> results from there, and add them to the corresponding clean target.
>=20
> Also expand the gcov arguments. Generate reports for things like "x()
> || y()" using --all-blocks, and add --preserve-paths since we're
> profiling in subdirectories now.

All good things.  It might be good to add a GCOVFLAGS that can be
added to the "make" command line, then.

> +++ b/Makefile
> @@ -2280,8 +2280,11 @@ coverage:
>  	$(MAKE) coverage-build
>  	$(MAKE) coverage-report
> =20
> +object_dirs :=3D $(sort $(dir $(OBJECTS)))
>  coverage-clean:
> -	rm -f *.gcda *.gcno
> +	$(RM) $(addsuffix *.gcov,$(object_dirs))
> +	$(RM) $(addsuffix *.gcda,$(object_dirs))
> +	$(RM) $(addsuffix *.gcno,$(object_dirs))
>  COVERAGE_CFLAGS =3D $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs

What about coverage-untested-functions?

[...]
> @@ -2292,7 +2295,9 @@ coverage-build: coverage-clean
>  		-j1 test
> =20
>  coverage-report:
> -	gcov -b *.c
> +	for dir in $(object_dirs); do \
> +		gcov --preserve-paths --branch-probabilities --all-blocks --object=
-directory=3D$$dir $$dir*.c; \
> +	done

This will not error out if "for" fails; maybe it would make sense to us=
e
set -e or exit.

More importantly, it spews quite a lot of output:

| for dir in ./ block-sha1/ builtin/ compat/ xdiff/; do \
|                 gcov --preserve-paths --branch-probabilities --all-bl=
ocks --object-directory=3D$dir $dir*.c || exit; \
|         done
| ./abspath.gcno:version '405p', prefer '404*'
| ./abspath.gcda:version '405p', prefer version '404*'
| ./advice.gcno:version '405p', prefer '404*'
[...]
| ./ctype.gcno:cannot open graph file
[...]
| File 'wt-status.c'
| Lines executed:36.26% of 535
| Branches executed:39.78% of 279
| Taken at least once:20.43% of 279
| No calls
| wt-status.c:creating 'wt-status.c.gcov'
|
| File 'write_or_die.c'
[...]
| block-sha1/sha1.c:creating 'block-sha1#sha1.c.gcov'
|
| builtin/add.gcno:version '405p', prefer '404*'
[...]
| compat/basename.gcno:cannot open graph file
| compat/cygwin.gcno:cannot open graph file
[...]

Can gcov be convinced to be a little quieter (i.e., only useful warning=
s)?
(I don=E2=80=99t know; just asking.)

Here are the changes I squashed in for testing; please feel free to
take or leave what you like.

diff --git i/Makefile w/Makefile
index a95d260..b791ad5 100644
--- i/Makefile
+++ w/Makefile
@@ -1485,6 +1485,7 @@ ifndef V
 	QUIET_BUILT_IN =3D @echo '   ' BUILTIN $@;
 	QUIET_GEN      =3D @echo '   ' GEN $@;
 	QUIET_LNCP     =3D @echo '   ' LN/CP $@;
+	QUIET_GCOV     =3D @echo '   ' GCOV $@;
 	QUIET_SUBDIR0  =3D +@subdir=3D
 	QUIET_SUBDIR1  =3D ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -2285,9 +2286,11 @@ coverage-clean:
 	$(RM) $(addsuffix *.gcov,$(object_dirs))
 	$(RM) $(addsuffix *.gcda,$(object_dirs))
 	$(RM) $(addsuffix *.gcno,$(object_dirs))
+	$(RM) coverage-untested-functions
=20
 COVERAGE_CFLAGS =3D $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
 COVERAGE_LDFLAGS =3D $(CFLAGS)  -O0 -lgcov
+GCOVFLAGS =3D --preserve-paths --branch-probabilities --all-blocks
=20
 coverage-build: coverage-clean
 	$(MAKE) CFLAGS=3D"$(COVERAGE_CFLAGS)" LDFLAGS=3D"$(COVERAGE_LDFLAGS)"=
 all
@@ -2295,9 +2298,9 @@ coverage-build: coverage-clean
 		-j1 test
=20
 coverage-report:
-	for dir in $(object_dirs); do \
-		gcov --preserve-paths --branch-probabilities --all-blocks --object-d=
irectory=3D$$dir $$dir*.c; \
+	$(QUIET_GCOV)for dir in $(object_dirs); do \
+		gcov $(GCOVFLAGS) --object-directory=3D$$dir $$dir*.c || exit; \
 	done
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
-		| tee coverage-untested-functions
+		> coverage-untested-functions
--=20
