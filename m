From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] cmd_fetch_pack(): fix constness problem and memory leak
Date: Wed,  2 May 2012 21:38:10 +0700
Message-ID: <1335969490-9181-4-git-send-email-pclouds@gmail.com>
References: <4FA13835.7080204@alum.mit.edu>
 <1335969490-9181-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 16:42:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPalE-0005Zz-TK
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 16:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab2EBOmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 10:42:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42721 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab2EBOmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 10:42:13 -0400
Received: by ghrr11 with SMTP id r11so747882ghr.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MSID+zH+Hab02Hp5hBjdtAfzM9l3fRF28WhVuh0zR8E=;
        b=cRpbKhjg2VkJLHEe0qQ2NTPshOUA+3Wm2IOb5mafnrcLlzaF1ljOLaFMUWKsMnramb
         3oO2uS+xlT3tRcqGy2jRJYRKuG8MYGhiexgQRLp3zyHVo4RFTEgnaGjHVzoIqC4H07iK
         KfKmUwSI1CLIWRH+V4TF2vsqld/fGSv2LVQjYlZQbaQgGOm01XegG8kZpoAbKRCdXHjL
         AHZJbN5C3Pgkz4CMIU9RjXw0Ui6Z1D4nJGnIkNAQ1OFu6oVN/3nBbQxUhzYrL2kj9UWM
         mAW3u8Ceyl8nlYau92mZNWgVAfQn9dXrOVFMkucTVf49dJQq3pRN5TNqSNgw7CEnR7aZ
         8wsQ==
Received: by 10.68.227.169 with SMTP id sb9mr22574926pbc.157.1335969731957;
        Wed, 02 May 2012 07:42:11 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id ry4sm2154249pbc.27.2012.05.02.07.42.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 07:42:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 21:38:41 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335969490-9181-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196829>

=46rom: Michael Haggerty <mhagger@alum.mit.edu>

The old code cast away the constness of the strings passed to the
function in argument argv[], which could result in their being
modified by filter_refs().  Moreover, if refs were passed via stdin,
then the memory allocated for them was never freed (though, of course,
this function is only called once so it is not a real problem).

=46ix both errors by copying *all* reference names into our own array
and always freeing the array at the end of the function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 65ac111..beabdc2 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -902,10 +902,11 @@ static void fetch_pack_setup(void)
=20
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, ret, nr_heads;
+	int i, ret;
 	struct ref *ref =3D NULL;
 	const char *dest =3D NULL;
-	char **heads;
+	int alloc_heads =3D 0, nr_heads =3D 0;
+	char **heads =3D NULL;
 	int fd[2];
 	char *pack_lockfile =3D NULL;
 	char **pack_lockfile_ptr =3D NULL;
@@ -934,8 +935,6 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
=20
 	packet_trace_identity("fetch-pack");
=20
-	nr_heads =3D 0;
-	heads =3D NULL;
 	argc =3D parse_options(argc, argv, prefix, opts, fetch_pack_usage, 0)=
;
 	args.no_progress =3D !progress;
 	if (args.keep_pack > 1)
@@ -945,19 +944,19 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
 	dest =3D argv[0];
 	if (!argc || !dest)
 		usage_with_options(fetch_pack_usage, opts);
-	heads =3D (char **)(argv + 1);
-	nr_heads =3D argc - 1;
+
+	/*
+	 * Copy refs from cmdline to new growable list, then append
+	 * any refs from the standard input.
+	 */
+	ALLOC_GROW(heads, argc - 1, alloc_heads);
+	for (i =3D 1; i < argc; i++)
+		heads[nr_heads++] =3D xstrdup(argv[i]);
=20
 	if (args.stdin_refs) {
-		/*
-		 * Copy refs from cmdline to new growable list, then
-		 * append the refs from the standard input.
-		 */
-		int alloc_heads =3D nr_heads;
-		int size =3D nr_heads * sizeof(*heads);
-		heads =3D memcpy(xmalloc(size), heads, size);
 		if (args.stateless_rpc) {
-			/* in stateless RPC mode we use pkt-line to read
+			/*
+			 * in stateless RPC mode we use pkt-line to read
 			 * from stdin, until we get a flush packet
 			 */
 			static char line[1000];
@@ -1023,6 +1022,10 @@ int cmd_fetch_pack(int argc, const char **argv, =
const char *prefix)
 		ref =3D ref->next;
 	}
=20
+	for (i =3D 0; i < nr_heads; ++i)
+		free(heads[i]);
+	free(heads);
+
 	return ret;
 }
=20
--=20
1.7.8.36.g69ee2
