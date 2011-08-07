From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Sun, 07 Aug 2011 22:02:03 +0200
Message-ID: <4E3EEF3B.80908@kdbg.org>
References: <20110728170222.GB15931@sigill.intra.peff.net> <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com> <20110801174603.GB10302@sigill.intra.peff.net> <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com> <20110801182516.GC10302@sigill.intra.peff.net> <4E371109.7050500@lsrfire.ath.cx> <4E3718B4.6090803@kdbg.org> <4E37202B.80208@lsrfire.ath.cx> <20110802040004.GC17494@sigill.intra.peff.net> <4E3829DC.8070802@lsrfire.ath.cx> <20110802181357.GA1861@sigill.intra.peff.net> <4E388A55.6080606@kdbg.org> <4E3D0C1D.9000807@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 07 22:02:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq9Y9-0004ci-DD
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 22:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab1HGUCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Aug 2011 16:02:11 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:54725 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754687Ab1HGUCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 16:02:09 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2D5AAA7EB4;
	Sun,  7 Aug 2011 22:02:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DDA5D19F440;
	Sun,  7 Aug 2011 22:02:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <4E3D0C1D.9000807@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178925>

Am 06.08.2011 11:40, schrieb Ren=C3=A9 Scharfe:
> So here's an ugly patch to implement an internal passthrough filter t=
o
> avoid newline conversions.  It makes the tar filter command (gzip etc=
=2E)
> write to a pipe instead of directly to a file.

*If* we are working around the CRLF conversion issue in git itself,
wouldn't it be much simpler to just:

diff --git a/archive-tar.c b/archive-tar.c
index 20af005..da3d98a 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -364,9 +364,9 @@ void init_tar_archiver(void)
 	int i;
 	register_archiver(&tar_archiver);

-	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tgz.command", "gzip -cn | cat", NULL);
 	tar_filter_config("tar.tgz.remote", "true", NULL);
-	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tar.gz.command", "gzip -cn | cat", NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
 	git_config(git_tar_config, NULL);
 	for (i =3D 0; i < nr_tar_filters; i++) {

(provided that 'cat' magically does not suffer from the same problem,
and I do think that it does not.)

Anyway, I think it would be better to address the problem on the msysgi=
t
side. Perhaps by providing a gzip of a different vintage (e.g. a
self-compiled one) that does not suffer from the CRLF conversion issue.

-- Hannes
