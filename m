From: "Gondek, Andreas" <Andreas.Gondek@dwpbank.de>
Subject: AW: Re*: AW: Getting the full path of a conflicting file within a
 custom merge driver?
Date: Fri, 5 Jun 2015 05:56:01 +0000
Message-ID: <D8780C527EB1E642B3150E6D705B46D468839F73@DWPWHMS531.dwpbank.local>
References: <D8780C527EB1E642B3150E6D705B46D468837861@DWPWHMS531.dwpbank.local>
	<xmqqr3pv74ww.fsf@gitster.dls.corp.google.com>
	<D8780C527EB1E642B3150E6D705B46D468837AA7@DWPWHMS531.dwpbank.local>
	<xmqq4mmq3sug.fsf@gitster.dls.corp.google.com>
 <xmqqvbf3t98b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 07:56:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0kc1-0003ea-4N
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 07:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbbFEF4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 01:56:08 -0400
Received: from mail1.dwpbank.de ([145.253.155.114]:10734 "EHLO
	mail1.dwpbank.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbbFEF4F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 01:56:05 -0400
X-IronPort-AV: E=Sophos;i="5.13,556,1427752800"; 
   d="scan'208";a="866566"
Received: from DWPWHMS531.dwpbank.local ([169.254.2.243]) by
 DWPFRMS530.dwpbank.local ([169.254.3.86]) with mapi id 14.03.0195.001; Fri, 5
 Jun 2015 07:56:01 +0200
Thread-Topic: Re*: AW: Getting the full path of a conflicting file within a
 custom merge driver?
Thread-Index: AQHQnxNmFZkB3jpDFkiWOgpbExw8IJ2daX8w
In-Reply-To: <xmqqvbf3t98b.fsf@gitster.dls.corp.google.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.236.155]
x-c2processedorg: 25ee705c-9766-409d-8ffd-513701a730da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270812>

Thanks, thanks, thanks.

One last question. If I don't want to compile Git myself, how long may =
the pu branch take approx. to get into a next release?

Mit freundlichen Gr=FC=DFen

Andreas Gondek
Applications
________________________________

Deutsche WertpapierService Bank AG
ITTAS
Derendorfer Allee 2
40476 D=FCsseldorf
Tel.: +49 69 5099 9503
=46ax: +49 69 5099 85 9503
E-Mail: Andreas.Gondek@dwpbank.de
http://www.dwpbank.de

Deutsche WertpapierService Bank AG | Wildunger Stra=DFe 14 | 60487 Fran=
kfurt am Main=20
Sitz der AG: Frankfurt am Main, HRB 56913 | USt.-ID: DE 813759005=20
Vorstand: Thomas Klanten, Dr. Christian Tonnesen
Aufsichtsrat: Wilfried Groos (Vors.)

-----Urspr=FCngliche Nachricht-----
Von: Junio C Hamano [mailto:jch2355@gmail.com] Im Auftrag von Junio C H=
amano
Gesendet: Freitag, 5. Juni 2015 00:11
An: Gondek, Andreas
Cc: git@vger.kernel.org
Betreff: Re*: AW: Getting the full path of a conflicting file within a =
custom merge driver?

Junio C Hamano <gitster@pobox.com> writes:

> "Gondek, Andreas" <Andreas.Gondek@dwpbank.de> writes:
>
>> thank you for responding this fast. I would suggest providing this=20
>> information as an additional parameter (like %A %O %B and %L) maybe=20
>> %P.
>
> Yes, per-cent plus a letter is more in line with the way information=20
> is passed to the scripts already.  Thanks for making a more sensible=20
> counter-suggestion.  And your %P(ath) sounds like a sensible choice.
>
> It won't be a two-liner, though, as the path is an arbitrary string,=20
> unlike the names of the three temporary files, and needs to be quoted=
=20
> for the shell.
>
> Let me see if I can find time today to cook up something.

I had this in my outbox but then forgot to send it out.

-- >8 --
Subject: ll-merge: pass the original path to external drivers

The interface to custom low-level merge driver was modeled to be capabl=
e of driving programs like "merge" (from the RCS suite) that can produc=
e result solely by looking at three files that hold contents of common =
ancestor, ours and theirs.  The information we feed to the external dri=
vers via the command line placeholders %O, %A, and %B were designed to =
be purely about contents by giving names of the temporary files that ho=
ld these variants without exposing the original pathname.  No matter wh=
ere the result goes, merging the same three variants should produce the=
 same result, contents is the king, that is the Git way.

The external driver interface, however, is meant to help people to step=
 outside the Git worldview, and sometimes people want to know the final=
 path that the resulting merged contents would be stored in.  Expose th=
is to the external drivers via a new placeholder %P.

Requested-by: Andreas Gondek
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * t6026 is ancient and its style may need to be modernised to use
   test_cmp intead of cmp, etc.

 Documentation/gitattributes.txt |  5 ++++-
 ll-merge.c                      | 10 ++++++++--
 t/t6026-merge-attr.sh           | 14 +++++++++-----
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt index 70899b3..81fe586 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -774,7 +774,7 @@ To define a custom merge driver `filfre`, add a sec=
tion to your
 ----------------------------------------------------------------
 [merge "filfre"]
 	name =3D feel-free merge driver
-	driver =3D filfre %O %A %B
+	driver =3D filfre %O %A %B %L %P
 	recursive =3D binary
 ----------------------------------------------------------------
=20
@@ -800,6 +800,9 @@ merge between common ancestors, when there are more=
 than one.
 When left unspecified, the driver itself is used for both  internal me=
rge and the final merge.
=20
+The merge driver can learn the pathname in which the merged result wil=
l=20
+be stored via placeholder `%P`.
+
=20
 `conflict-marker-size`
 ^^^^^^^^^^^^^^^^^^^^^^
diff --git a/ll-merge.c b/ll-merge.c
index 8ea03e5..fc3c049 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -9,6 +9,7 @@
 #include "xdiff-interface.h"
 #include "run-command.h"
 #include "ll-merge.h"
+#include "quote.h"
=20
 struct ll_merge_driver;
=20
@@ -166,17 +167,20 @@ static int ll_ext_merge(const struct ll_merge_dri=
ver *fn,  {
 	char temp[4][50];
 	struct strbuf cmd =3D STRBUF_INIT;
-	struct strbuf_expand_dict_entry dict[5];
+	struct strbuf_expand_dict_entry dict[6];
+	struct strbuf path_sq =3D STRBUF_INIT;
 	const char *args[] =3D { NULL, NULL };
 	int status, fd, i;
 	struct stat st;
 	assert(opts);
=20
+	sq_quote_buf(&path_sq, path);
 	dict[0].placeholder =3D "O"; dict[0].value =3D temp[0];
 	dict[1].placeholder =3D "A"; dict[1].value =3D temp[1];
 	dict[2].placeholder =3D "B"; dict[2].value =3D temp[2];
 	dict[3].placeholder =3D "L"; dict[3].value =3D temp[3];
-	dict[4].placeholder =3D NULL; dict[4].value =3D NULL;
+	dict[4].placeholder =3D "P"; dict[4].value =3D path_sq.buf;
+	dict[5].placeholder =3D NULL; dict[5].value =3D NULL;
=20
 	if (fn->cmdline =3D=3D NULL)
 		die("custom merge driver %s lacks command line.", fn->name); @@ -210=
,6 +214,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	for (i =3D 0; i < 3; i++)
 		unlink_or_warn(temp[i]);
 	strbuf_release(&cmd);
+	strbuf_release(&path_sq);
 	return status;
 }
=20
@@ -269,6 +274,7 @@ static int read_merge_config(const char *var, const=
 char *value, void *cb)
 		 *    %A - temporary file name for our version.
 		 *    %B - temporary file name for the other branches' version.
 		 *    %L - conflict marker length
+		 *    %P - the original path (safely quoted for the shell)
 		 *
 		 * The external merge driver should write the results in the
 		 * file named by %A, and signal that it has done with zero exit diff=
 --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh index 3c21938..0=
4c0509 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -85,11 +85,12 @@ test_expect_success 'retry the merge with longer co=
ntext' '
 cat >./custom-merge <<\EOF
 #!/bin/sh
=20
-orig=3D"$1" ours=3D"$2" theirs=3D"$3" exit=3D"$4"
+orig=3D"$1" ours=3D"$2" theirs=3D"$3" exit=3D"$4" path=3D$5
 (
 	echo "orig is $orig"
 	echo "ours is $ours"
 	echo "theirs is $theirs"
+	echo "path is $path"
 	echo "=3D=3D=3D orig =3D=3D=3D"
 	cat "$orig"
 	echo "=3D=3D=3D ours =3D=3D=3D"
@@ -110,7 +111,7 @@ test_expect_success 'custom merge backend' '
=20
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.custom.driver "./custom-merge %O %A %B 0" &&
+	merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
=20
@@ -121,7 +122,7 @@ test_expect_success 'custom merge backend' '
 	o=3D$(git unpack-file master^:text) &&
 	a=3D$(git unpack-file side^:text) &&
 	b=3D$(git unpack-file master:text) &&
-	sh -c "./custom-merge $o $a $b 0" &&
+	sh -c "./custom-merge $o $a $b 0 'text'" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
 	rm -f $o $a $b
@@ -131,7 +132,7 @@ test_expect_success 'custom merge backend' '
=20
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.custom.driver "./custom-merge %O %A %B 1" &&
+	merge.custom.driver "./custom-merge %O %A %B 1 %P" &&
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
=20
@@ -148,9 +149,12 @@ test_expect_success 'custom merge backend' '
 	o=3D$(git unpack-file master^:text) &&
 	a=3D$(git unpack-file anchor:text) &&
 	b=3D$(git unpack-file master:text) &&
-	sh -c "./custom-merge $o $a $b 0" &&
+	sh -c "./custom-merge $o $a $b 0 'text'" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
+	sed -e 1,3d -e 4q $a >check-3 &&
+	echo "path is text" >expect &&
+	cmp expect check-3 &&
 	rm -f $o $a $b
 '
=20
