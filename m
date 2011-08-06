From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Sat, 06 Aug 2011 11:40:45 +0200
Message-ID: <4E3D0C1D.9000807@lsrfire.ath.cx>
References: <20110728170222.GB15931@sigill.intra.peff.net> <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com> <20110801174603.GB10302@sigill.intra.peff.net> <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com> <20110801182516.GC10302@sigill.intra.peff.net> <4E371109.7050500@lsrfire.ath.cx> <4E3718B4.6090803@kdbg.org> <4E37202B.80208@lsrfire.ath.cx> <20110802040004.GC17494@sigill.intra.peff.net> <4E3829DC.8070802@lsrfire.ath.cx> <20110802181357.GA1861@sigill.intra.peff.net> <4E388A55.6080606@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 11:41:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpdNW-0001wc-8v
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 11:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab1HFJlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 05:41:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:56806 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab1HFJlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 05:41:03 -0400
Received: from [192.168.2.105] (p4FFDA034.dip.t-dialin.net [79.253.160.52])
	by india601.server4you.de (Postfix) with ESMTPSA id 92B312F8035;
	Sat,  6 Aug 2011 11:41:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <4E388A55.6080606@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178878>

Am 03.08.2011 01:37, schrieb Johannes Sixt:
> Am 02.08.2011 20:13, schrieb Jeff King:
>> Hmm. So it's not _just_ the pipe vs file thing. What's different abo=
ut
>> calling it from the shell, versus the way we call it from git-archiv=
e?
>=20
> When the parent process of an MSYS process is itself an MSYS process,
> such as bash, then the child does not do its own
> binary-mode-vs.-text-mode detection, but just uses whatever it is tol=
d
> by the parent. This is achieved by MSYS's fork emulation.
>=20
> But if the parent is a regular Windows program, such as git(-archive)=
,
> then the autodection happens and file descriptors pointing to files a=
re
> put into text mode.

So here's an ugly patch to implement an internal passthrough filter to
avoid newline conversions.  It makes the tar filter command (gzip etc.)
write to a pipe instead of directly to a file.

The patch does this unconditionally, which is a waste on all unaffected
systems, of course.  We could #ifdef it out, but is there perhaps a nic=
e
way to integrate this functionality into run_command/finish_command?

Ren=C3=A9

---
 archive-tar.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 20af005..22d52c5 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -314,6 +314,25 @@ static int write_tar_archive(const struct archiver=
 *ar,
 	return err;
 }
=20
+static int cat_fn(int in, int out, void *data)
+{
+	for (;;) {
+		char buf[16 * 1024];
+		ssize_t got =3D xread(in, buf, sizeof(buf));
+		if (got =3D=3D 0)
+			break;
+		if (got < 0) {
+			if (errno =3D=3D EPIPE)
+				break;
+			die_errno("read errror");
+		}
+		write_or_die(out, buf, got);
+	}
+	close(in);
+	close(out);
+	return 0;
+}
+
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
@@ -321,6 +340,14 @@ static int write_tar_filter_archive(const struct a=
rchiver *ar,
 	struct child_process filter;
 	const char *argv[2];
 	int r;
+	struct async cat;
+
+	memset(&cat, 0, sizeof(cat));
+	cat.proc =3D cat_fn;
+	cat.in =3D -1;
+	cat.out =3D dup(1);
+	if (start_async(&cat))
+		die("unable to start passthrough filter");
=20
 	if (!ar->data)
 		die("BUG: tar-filter archiver called with no filter defined");
@@ -335,6 +362,7 @@ static int write_tar_filter_archive(const struct ar=
chiver *ar,
 	filter.argv =3D argv;
 	filter.use_shell =3D 1;
 	filter.in =3D -1;
+	filter.out =3D cat.in;
=20
 	if (start_command(&filter) < 0)
 		die_errno("unable to start '%s' filter", argv[0]);
@@ -349,6 +377,9 @@ static int write_tar_filter_archive(const struct ar=
chiver *ar,
 	if (finish_command(&filter) !=3D 0)
 		die("'%s' filter reported error", argv[0]);
=20
+	if (finish_async(&cat))
+		die("passthrough filter reported error");
+
 	strbuf_release(&cmd);
 	return r;
 }
