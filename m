From: tboegi@web.de
Subject: [PATCH 3/3] convert.c: Optimize convert_cmp_checkout() for changed file len
Date: Thu, 11 Feb 2016 17:16:13 +0100
Message-ID: <1455207373-24970-1-git-send-email-tboegi@web.de>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 17:15:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTttU-0007j7-VW
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 17:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbcBKQOw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2016 11:14:52 -0500
Received: from mout.web.de ([212.227.17.12]:64984 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbcBKQOu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 11:14:50 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MJCSM-1aSFzm3tU2-002mLO; Thu, 11 Feb 2016 17:14:49
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:VIKvbJJ7Bhj8rQ9D3ZY3xpl0EHG96ODQ2O9Pbea1G8b8iNIczKA
 XPgyzRLKYNVxedee/PTKB3gjTHA+Ea/mUUn7kKGz7BdhvfGlEMGh9A4xM0YxEf4PJAQYAcw
 9OwLo1d6Y6c+EzrWGfazj4VbqjSxp7M/wyeQgPvx3tZrY4aN7GJ0Jm2WznXmz/xALXSAEUs
 do/tI/Thrz6WMbzSATLww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Q8RF/oM0pE=:SYPGrwZFaeDqXu+cFyhora
 DmEpFdw675e8Jh6sdo6KBMfuWYiYNDMbhO+5/yy6BfYcuwxBCvZDYCSvmJc9TGe5WrlaxdmRB
 hoO0VSpJiFi1aaRqhBFscw8SMKzJV/DfIoYowljo73r5AKgRbiZJvOlrF/bgtJbv0P4YnQWvA
 M1gwqiQr0nl8UvDgew9Y7DYUnmPZ/0Q80w0EwlQEklL52Vof1JfYF05i/yHO+vw6wp9bPT+LC
 FIhURtHfG60NH41YZPxpUroVkx+ti6/0/wmQ+SJHaN9q8Sm07xWAJWaUAAtCr8lRW+RJEQVxH
 P9p5PNXFM7n3yy2wtZQ/kA/x1ZD0zRHjpiHD+suZvAHX3ePjiw95QHyRZCaLGXt71L8kcXjtE
 ieZL/V+LUuVjXYfcfeEVA2RJ9IxSI1x/HxVkyjHoan9xTIrwYfFqk+9PqI/Z/SibJMmImuB0N
 UAla3i3MeKe4ox0M99sFzpn4hTPKSYUkGxtmyJ44Qu+U7ncxwtGX9mgS/NzmgzQvhFGzNJKX6
 NOCpZ5CmXAxXkhoFcCo1p2SY9rDyBUsHuTOnjlMjmeL51dgETO5IZrouuyE3gDZr3b1tQ8DuY
 mj7PX9qvdApL4KtDNP3D8h2tX2NTJEtoxgmss0jhP1CFZ+GMFAVuMMnrXZvER6tjovQ5gmChz
 g8t1u1sal728eMi9X6mu+9vg7dDP7DzsXCsdpcky5IjrAiWsrf4yvlOF4km8c8883XshFpvml
 UBqLKOM9QVobXRJhmBkrXLYS+H0dfA944gXmF4EdmdIVtGm9vEinnQsWarPxnriwPyf4LLyd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285986>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Whenever the size of data from convert_to_working_tree() is different
from the length of the file in the working tree, the must be different
and compare_with_fd() can be skipped.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/convert.c b/convert.c
index 9cbc62c..2593367 100644
--- a/convert.c
+++ b/convert.c
@@ -838,30 +838,30 @@ static void convert_attrs(struct conv_attrs *ca, =
const char *path)
 int convert_cmp_checkout(const char *path)
 {
 	struct conv_attrs ca;
-	int match =3D -1; /* no match */
-	int fd;
+	size_t sz;
+	void *data;
+	int match =3D -1; /* no match, or unknown */
 	convert_attrs(&ca, path);
 	if (ca.crlf_action =3D=3D CRLF_BINARY && !ca.drv && !ca.ident)
 	  return -1; /* No eol conversion, no ident, no filter */
=20
-	fd =3D open(path, O_RDONLY);
-	if (fd >=3D 0) {
-		unsigned long sz;
-		void *data;
-		data =3D read_blob_data_from_cache(path, &sz);
-		if (!data)
-			match =3D -1;
-		else {
-			struct strbuf worktree =3D STRBUF_INIT;
-			if (convert_to_working_tree(path, data, sz, &worktree)) {
-				free(data);
-				data =3D strbuf_detach(&worktree, &sz);
+	data =3D read_blob_data_from_cache(path, &sz);
+	if (data) {
+		struct strbuf worktree =3D STRBUF_INIT;
+		struct stat st;
+		if (convert_to_working_tree(path, data, sz, &worktree)) {
+			free(data);
+			data =3D strbuf_detach(&worktree, &sz);
+		}
+		if (!lstat(path, &st) && sz =3D=3D xsize_t(st.st_size)) {
+			int fd =3D open(path, O_RDONLY);
+			if (fd >=3D 0) {
+				if (!compare_with_fd(data, sz, fd))
+					match =3D 0;
+				close(fd);
 			}
-			if (!compare_with_fd(data, sz, fd))
-				match =3D 0;
 		}
 		free(data);
-		close(fd);
 	}
 	return match;
 }
--=20
2.7.0.303.g2c4f448.dirty
