From: dev <dev@cor0.com>
Subject: Re: "trace.c", line 219: error: identifier redeclared: trace_strbuf
Date: Sun, 7 Sep 2014 13:19:19 -0400 (EDT)
Message-ID: <2059998579.17018.1410110359755.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
References: <893371408.24076.1410031614959.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <540B742F.5030700@web.de>
Reply-To: dev <dev@cor0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,
	=?UTF-8?Q?=22Ren=C3=A9_Scharfe=22?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:19:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQg7k-0008HV-Lj
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 19:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbaIGRT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Sep 2014 13:19:26 -0400
Received: from atl4mhob06.myregisteredsite.com ([209.17.115.44]:42321 "EHLO
	atl4mhob06.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752583AbaIGRT0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 Sep 2014 13:19:26 -0400
Received: from atl4oxapp01pod2.mgt.hosting.qts.netsol.com ([10.30.77.37])
	by atl4mhob06.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s87HJJZv029648;
	Sun, 7 Sep 2014 13:19:19 -0400
In-Reply-To: <540B742F.5030700@web.de>
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v6.20.7-Rev18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256622>



On September 6, 2014 at 4:53 PM "Ren=C3=A9 Scharfe" <l.s.r@web.de> wrot=
e:
> Am 06.09.2014 um 21:26 schrieb dev:
> >
> >
<snip>
> >
> > Solaris 10 with Oracle Studio 12.3 compiler tools. A lengthy
> > maillist
> > discussion last week sorted out the previous release of git just
> > fine however this release fails to build.
> >
>
> The issue was introduced with e05bed96 (trace: add 'file:line' to all
> trace output).
>
> -- >8 --
> Subject: [PATCH] trace: correct trace_strbuf() parameter type for
> !HAVE_VARIADIC_MACROS
>
> Reported-by: dev <dev@cor0.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/trace.c b/trace.c
> index 54aaee5..b6f25a2 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -216,7 +216,7 @@ void trace_argv_printf(const char **argv, const
> char *format, ...)
>    va_end(ap);
>  }
>=20
> -void trace_strbuf(const char *key, const struct strbuf *data)
> +void trace_strbuf(struct trace_key *key, const struct strbuf *data)
>  {
>    trace_strbuf_fl(NULL, 0, key, data);
>  }
> --
> 2.1.0
>

Thank you for the reply and the info.  I backed that out and things get
worse :

$ diff -h trace.c.backup trace.c
219,221c219,221
< void trace_strbuf(const char *key, const struct strbuf *data)
< {
<       trace_strbuf_fl(NULL, 0, key, data);
---
> void trace_strbuf(struct trace_key *key, const struct strbuf *data)
> {
>         trace_strbuf_fl(NULL, 0, key, data);


$ gmake CFLAGS=3D"$CFLAGS" LDFLAGS=3D"$LD_OPTIONS" NEEDS_LIBICONV=3DYes=
 \
> SHELL_PATH=3D/usr/local/bin/bash \
> SANE_TOOL_PATH=3D/usr/local/bin \
> USE_LIBPCRE=3D1 LIBPCREDIR=3D/usr/local CURLDIR=3D/usr/local \
> EXPATDIR=3D/usr/local NEEDS_LIBINTL_BEFORE_LIBICONV=3D1 \
> NEEDS_SOCKET=3D1 NEEDS_RESOLV=3D1 USE_NSEC=3D1 \
> PERL_PATH=3D/usr/local/bin/perl \
> TAR=3D/usr/bin/tar \
> NO_PYTHON=3D1 DEFAULT_PAGER=3D/usr/xpg4/bin/more \
> DEFAULT_EDITOR=3D/usr/local/bin/vim DEFAULT_HELP_FORMAT=3Dman \
> prefix=3D/usr/local
    CC trace.o
"trace.c", line 390: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 392: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 393: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 401: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 403: error: reference to static identifier "offset" in
extern inline function
cc: acomp failed for trace.c
gmake: *** [trace.o] Error 2
$

So is there a possible 2.1.1 coming along shortly ?

dev
