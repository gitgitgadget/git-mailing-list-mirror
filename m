From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive, cygwin, and --git-dir vs --remote
Date: Thu, 21 May 2009 16:29:42 +0200
Message-ID: <4A156556.900@lsrfire.ath.cx>
References: <e664dae0905180737mae29811ie4cae889b3e3904f@mail.gmail.com> <4A151A15.6040609@lsrfire.ath.cx> <alpine.LSU.2.00.0905211431060.23478@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bob Kagy <bobkagy@gmail.com>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu May 21 16:29:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M79HR-0007Kq-AO
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 16:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbZEUO3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 10:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbZEUO3p
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 10:29:45 -0400
Received: from india601.server4you.de ([85.25.151.105]:36665 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbZEUO3p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 10:29:45 -0400
Received: from [10.0.1.101] (p57B7DF15.dip.t-dialin.net [87.183.223.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 0F64B2F8044;
	Thu, 21 May 2009 16:29:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.LSU.2.00.0905211431060.23478@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119684>

Tony Finch schrieb:
> On Thu, 21 May 2009, Ren=C3=A9 Scharfe wrote:
>> That's strange.  It seems that poll() reports that there is data to =
read
>> from the child (which is running git-upload-archive), even though it
>> already called exit().
>=20
> Poll reports an FD is readable when it reaches EOF.

OK, makes sense.  I still don't understand why upload-archive doesn't g=
et
into an infinite loop on Linux (Fedora 10), though.

>> The following patch works around this issue by terminating the other=
wise
>> endless loop after read() returned nothing for the thousandth time i=
n a
>> row.
>=20
> You should stop reading the first time read() returns 0 i.e. EOF.

Thanks.  In that case the following patch is better.


 builtin-upload-archive.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 0206b41..a3fa5b3 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -80,16 +80,19 @@ static void error_clnt(const char *fmt, ...)
 	die("sent error to the client: %s", buf);
 }
=20
-static void process_input(int child_fd, int band)
+static int process_input(int child_fd, int band)
 {
 	char buf[16384];
 	ssize_t sz =3D read(child_fd, buf, sizeof(buf));
+	if (sz =3D=3D 0)
+		return EOF;
 	if (sz < 0) {
 		if (errno !=3D EAGAIN && errno !=3D EINTR)
 			error_clnt("read error: %s\n", strerror(errno));
-		return;
+		return 0;
 	}
 	send_sideband(1, band, buf, sz, LARGE_PACKET_MAX);
+	return 0;
 }
=20
 int cmd_upload_archive(int argc, const char **argv, const char *prefix=
)
@@ -131,7 +134,7 @@ int cmd_upload_archive(int argc, const char **argv,=
 const char *prefix)
=20
 	while (1) {
 		struct pollfd pfd[2];
-		int status;
+		int status, both_at_eof =3D EOF;
=20
 		pfd[0].fd =3D fd1[0];
 		pfd[0].events =3D POLLIN;
@@ -147,12 +150,12 @@ int cmd_upload_archive(int argc, const char **arg=
v, const char *prefix)
 		}
 		if (pfd[0].revents & POLLIN)
 			/* Data stream ready */
-			process_input(pfd[0].fd, 1);
+			both_at_eof &=3D process_input(pfd[0].fd, 1);
 		if (pfd[1].revents & POLLIN)
 			/* Status stream ready */
-			process_input(pfd[1].fd, 2);
+			both_at_eof &=3D process_input(pfd[1].fd, 2);
 		/* Always finish to read data when available */
-		if ((pfd[0].revents | pfd[1].revents) & POLLIN)
+		if (!both_at_eof)
 			continue;
=20
 		if (waitpid(writer, &status, 0) < 0)
