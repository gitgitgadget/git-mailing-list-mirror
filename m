From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] use strbuf_getcwd() to get the current working
 directory without fixed-sized buffers
Date: Sun, 20 Jul 2014 22:33:12 -0400
Message-ID: <20140721023312.GC22750@peff.net>
References: <53CBF277.3090101@web.de>
 <53CBF332.2050301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 04:33:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X93Pj-00053Y-9A
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 04:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbaGUCdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 22:33:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:37258 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751998AbaGUCdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 22:33:15 -0400
Received: (qmail 21923 invoked by uid 102); 21 Jul 2014 02:33:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 20 Jul 2014 21:33:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Jul 2014 22:33:12 -0400
Content-Disposition: inline
In-Reply-To: <53CBF332.2050301@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253940>

On Sun, Jul 20, 2014 at 06:49:54PM +0200, Ren=C3=A9 Scharfe wrote:

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 56f85e2..c4958b6 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -535,10 +535,10 @@ int cmd_init_db(int argc, const char **argv, co=
nst char *prefix)
>  		usage(init_db_usage[0]);
>  	}
>  	if (is_bare_repository_cfg =3D=3D 1) {
> -		static char git_dir[PATH_MAX+1];
> -
> -		setenv(GIT_DIR_ENVIRONMENT,
> -			getcwd(git_dir, sizeof(git_dir)), argc > 0);
> +		struct strbuf cwd =3D STRBUF_INIT;
> +		strbuf_getcwd(&cwd);
> +		setenv(GIT_DIR_ENVIRONMENT, cwd.buf, argc > 0);
> +		strbuf_release(&cwd);

Hmm. You are not making anything worse here, as we already do not check
the return value of getcwd. But what happens if it fails? Looks like we
currently get a segfault, and the new code will silently set the
variable to the empty string. Neither is particularly helpful.

Should we be using the xgetcwd helper that you add in the next patch?

> -			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
> +			strbuf_getcwd(&cwd);
> +			setenv(GIT_DIR_ENVIRONMENT, cwd.buf, 0);
> +			strbuf_release(&cwd);

Ditto here.

-Peff
