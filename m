From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mailinfo: Fix getting the subject from the body
Date: Sat, 12 Jul 2008 02:36:57 -0700
Message-ID: <7v3amfxx3a.fsf@gitster.siamese.dyndns.org>
References: <4876820D.4070806@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Don Zickus <dzickus@redhat.com>
To: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Sat Jul 12 11:38:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHbYR-0002hW-8w
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 11:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbYGLJhI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jul 2008 05:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbYGLJhI
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 05:37:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbYGLJhG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jul 2008 05:37:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F654273BA;
	Sat, 12 Jul 2008 05:37:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0478A273B9; Sat, 12 Jul 2008 05:36:59 -0400 (EDT)
In-Reply-To: <4876820D.4070806@etek.chalmers.se> (Lukas =?utf-8?Q?Sandstr?=
 =?utf-8?Q?=C3=B6m's?= message of "Thu, 10 Jul 2008 23:41:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 161C0B48-4FF6-11DD-8B16-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88228>

Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:

> "Subject: " isn't in the static array "header", and thus
> memcmp("Subject: ", header[i], 7) will never match.
>
> Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
> ---
>
> This has been broken since 2007-03-12, with commit
> 87ab799234639c26ea10de74782fa511cb3ca606
> so it might not be very important.
>
>  builtin-mailinfo.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 962aa34..2d1520f 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -334,7 +334,7 @@ static int check_header(char *line, unsigned line=
size, char **hdr_data, int over
>  		return 1;
>  	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
>  		for (i =3D 0; header[i]; i++) {
> -			if (!memcmp("Subject: ", header[i], 9)) {
> +			if (!memcmp("Subject", header[i], 7)) {
>  				if (! handle_header(line, hdr_data[i], 0)) {
>  					return 1;
>  				}

Actually, I do not think your patch alone makes any difference, and the
original code looks somewhat bogus.  If there is no "Subject: " in the
same section of the message (either in e-mail header in which case
hdr_data =3D=3D p_hdr_data[], or in the message body part in which case
hdr_data =3D=3D s_hdr_data[]), hdr_data[1] will be NULL, because the on=
ly
place that allocates the storage for the data is the first loop of this
function that deals with real-RFC2822-header-looking lines.

You'd probably need something like this on top of your patch to actuall=
y
activate the code.

Another thing I noticed and found puzzling is the handling of ">From "
line that is shown in the context below.  check_header() is supposed to
return true when it handled header (i.e. not part of the commit message=
)
and return false when line is not part of the header.  As ">From " is p=
art
of the commit log message, shouldn't it return zero?

Don, this part was what you introduced.  Has this codepath ever been
exercised in the real life?

 builtin-mailinfo.c  |    2 ++
 t/t5100-mailinfo.sh |    2 +-
 t/t5100/sample.mbox |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 2d1520f..13f0502 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -332,12 +332,14 @@ static int check_header(char *line, unsigned line=
size, char **hdr_data, int over
 	/* for inbody stuff */
 	if (!memcmp(">From", line, 5) && isspace(line[5]))
 		return 1;
 	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
 		for (i =3D 0; header[i]; i++) {
 			if (!memcmp("Subject", header[i], 7)) {
+				if (!hdr_data[i])
+					hdr_data[i] =3D xmalloc(linesize + 20);
 				if (! handle_header(line, hdr_data[i], 0)) {
 					return 1;
 				}
 			}
 		}
 	}
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 2d1520f..13f0502 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -335,6 +335,8 @@ static int check_header(char *line, unsigned linesi=
ze, char **hdr_data, int over
 	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
 		for (i =3D 0; header[i]; i++) {
 			if (!memcmp("Subject", header[i], 7)) {
+				if (!hdr_data[i])
+					hdr_data[i] =3D xmalloc(linesize + 20);
 				if (! handle_header(line, hdr_data[i], 0)) {
 					return 1;
 				}
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 577ecc2..e9f3e72 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. ../t5100/sample.mbox >last &&
 	last=3D`cat last` &&
 	echo total is $last &&
-	test `cat last` =3D 9'
+	test `cat last` =3D 10'
=20
 for mail in `echo 00*`
 do
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 0476b96..aba57f9 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -430,3 +430,38 @@ index b426a14..97756ec 100644
 =3D20
 =3D20
  2. When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
+From b9704a518e21158433baa2cc2d591fea687967f6 Mon Sep 17 00:00:00 2001
+From: =3D?UTF-8?q?Lukas=3D20Sandstr=3DC3=3DB6m?=3D <lukass@etek.chalme=
rs.se>
+Date: Thu, 10 Jul 2008 23:41:33 +0200
+Subject: Re: discussion that lead to this patch
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+[PATCH] git-mailinfo: Fix getting the subject from the body
+
+"Subject: " isn't in the static array "header", and thus
+memcmp("Subject: ", header[i], 7) will never match.
+
+Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
+Signed-off-by: Junio C Hamano <gitster@pobox.com>
+---
+ builtin-mailinfo.c |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
+index 962aa34..2d1520f 100644
+--- a/builtin-mailinfo.c
++++ b/builtin-mailinfo.c
+@@ -334,7 +334,7 @@ static int check_header(char *line, unsigned lines=
ize, char **hdr_data, int over
+ 		return 1;
+ 	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
+ 		for (i =3D 0; header[i]; i++) {
+-			if (!memcmp("Subject: ", header[i], 9)) {
++			if (!memcmp("Subject", header[i], 7)) {
+ 				if (! handle_header(line, hdr_data[i], 0)) {
+ 					return 1;
+ 				}
+--=20
+1.5.6.2.455.g1efb2
+
