From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 08 Aug 2011 19:10:01 +0200
Message-ID: <4E401869.8060702@lsrfire.ath.cx>
References: <20110728170222.GB15931@sigill.intra.peff.net> <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com> <20110801174603.GB10302@sigill.intra.peff.net> <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com> <20110801182516.GC10302@sigill.intra.peff.net> <4E371109.7050500@lsrfire.ath.cx> <4E3718B4.6090803@kdbg.org> <4E37202B.80208@lsrfire.ath.cx> <20110802040004.GC17494@sigill.intra.peff.net> <4E3829DC.8070802@lsrfire.ath.cx> <20110802181357.GA1861@sigill.intra.peff.net> <4E388A55.6080606@kdbg.org> <4E3D0C1D.9000807@lsrfire.ath.cx> <4E3EEF3B.80908@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 08 19:10:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqTLO-0004y0-8W
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 19:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab1HHRKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 13:10:20 -0400
Received: from india601.server4you.de ([85.25.151.105]:50454 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab1HHRKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 13:10:20 -0400
Received: from [192.168.2.105] (p579BE327.dip.t-dialin.net [87.155.227.39])
	by india601.server4you.de (Postfix) with ESMTPSA id 590982F8061;
	Mon,  8 Aug 2011 19:10:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <4E3EEF3B.80908@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178962>

Am 07.08.2011 22:02, schrieb Johannes Sixt:
> Am 06.08.2011 11:40, schrieb Ren=C3=A9 Scharfe:
>> So here's an ugly patch to implement an internal passthrough filter =
to
>> avoid newline conversions.  It makes the tar filter command (gzip et=
c.)
>> write to a pipe instead of directly to a file.
>=20
> *If* we are working around the CRLF conversion issue in git itself,
> wouldn't it be much simpler to just:
>=20
> diff --git a/archive-tar.c b/archive-tar.c
> index 20af005..da3d98a 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -364,9 +364,9 @@ void init_tar_archiver(void)
>  	int i;
>  	register_archiver(&tar_archiver);
>=20
> -	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
> +	tar_filter_config("tar.tgz.command", "gzip -cn | cat", NULL);
>  	tar_filter_config("tar.tgz.remote", "true", NULL);
> -	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
> +	tar_filter_config("tar.tar.gz.command", "gzip -cn | cat", NULL);
>  	tar_filter_config("tar.tar.gz.remote", "true", NULL);
>  	git_config(git_tar_config, NULL);
>  	for (i =3D 0; i < nr_tar_filters; i++) {
>=20
> (provided that 'cat' magically does not suffer from the same problem,
> and I do think that it does not.)

The external cat can indeed be used.  We'd need to do that for user
supplied commands as well, though, like this (ugh):

diff --git a/archive-tar.c b/archive-tar.c
index 20af005..eaa9a1c 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -326,6 +326,9 @@ static int write_tar_filter_archive(const struct ar=
chiver *ar,
 		die("BUG: tar-filter archiver called with no filter defined");
=20
 	strbuf_addstr(&cmd, ar->data);
+#ifdef WIN32
+	strbuf_addstr(&cmd, " | cat");
+#endif
 	if (args->compression_level >=3D 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);
=20

> Anyway, I think it would be better to address the problem on the msys=
git
> side. Perhaps by providing a gzip of a different vintage (e.g. a
> self-compiled one) that does not suffer from the CRLF conversion issu=
e.

Users would probably also need sanitized versions of bzip2 and xz, and
perhaps more.

If MSYS could be asked to refrain from switching file descriptors to te=
xt
mode, e.g. by setting an environment variable, we could solve the issue
in a generic way instead.

Ren=C3=A9
