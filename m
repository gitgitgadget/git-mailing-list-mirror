From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 17:28:35 +0100
Message-ID: <51191C33.8070402@web.de>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wFb-0008BY-1G
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757892Ab3BKQ2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2013 11:28:38 -0500
Received: from mout.web.de ([212.227.15.4]:59455 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757900Ab3BKQ2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:28:37 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M40jS-1UwUhV0zFi-00rnF5; Mon, 11 Feb 2013 17:28:35
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <1360589687-9233-1-git-send-email-kusmabite@gmail.com>
X-Provags-ID: V02:K0:aoSV21Jj9Q8IwG1cDhOwOwX/sAKdzaOuVkvXSOw2mDO
 yybuueXwoyssxmctOPutvvvpIF44Byavj+M7ehMvdFaZO5vvrz
 b86mKEKDwegH6PAU3bJsfmo188LtNdZRHrCkDJPiTWILOxgipa
 C3w6cL4Av4uQVOTt1WzpKvYuxvne0DLubwII0dPjKiGxetuI9c
 DEnXOgZEycC/CcOJvH1NA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216047>

On 11.02.13 14:34, Erik Faye-Lund wrote:
> Even though parse-options doesn't support UTF-8 switches (which
> makes sense; non-ascii switches would be difficult to enter on
> some keyboard layouts), it can be useful to report incorrectly
> entered UTF-8 switches to make the output somewhat less ugly
> for those of us with keyboard layouts with UTF-8 characters on
> it.
>=20
> Make the reporting code grok UTF-8 in the option sequence, and
> write a variable-width output sequence.
>=20
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
> As being both clumsy and Norwegian, I some times to enter the
> Norwegian bizarro-letters ('=C3=A6', '=C3=B8' and '=C3=A5') instead o=
f the
> correct ones when entering command-line options.
>=20
> However, since git only looks at one byte at the time for
> short-options, it ends up reporting a partial UTF-8 sequence
> in such cases, leading to corruption of the output.
>=20
> The "real fix" would probably be to add proper multi-byte
> support to the short-option parser, but this serves little
> purpose in Git; we don't internationalize the command-line
> switches.
>=20
> So perhaps this is a suitable band-aid instead?
>=20
>  parse-options.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/parse-options.c b/parse-options.c
> index 67e98a6..20dc742 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -3,6 +3,7 @@
>  #include "cache.h"
>  #include "commit.h"
>  #include "color.h"
> +#include "utf8.h"
> =20
>  static int parse_options_usage(struct parse_opt_ctx_t *ctx,
>  			       const char * const *usagestr,
> @@ -462,7 +463,9 @@ int parse_options(int argc, const char **argv, co=
nst char *prefix,
>  		if (ctx.argv[0][1] =3D=3D '-') {
>  			error("unknown option `%s'", ctx.argv[0] + 2);
>  		} else {
> -			error("unknown switch `%c'", *ctx.opt);
> +			const char *next =3D ctx.opt;
> +			utf8_width(&next, NULL);
> +			error("unknown switch `%.*s'", (int)(next - ctx.opt), ctx.opt);
>  		}
>  		usage_with_options(usagestr, options);
>  	}
>=20
Would the following do the trick?

diff --git a/parse-options.c b/parse-options.c
index c1c66bd..f800552 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -471,7 +471,7 @@ int parse_options(int argc, const char **argv, cons=
t char *prefix,
                if (ctx.argv[0][1] =3D=3D '-') {
                        error("unknown option `%s'", ctx.argv[0] + 2);
                } else {
-                       error("unknown switch `%c'", *ctx.opt);
+                       error("unknown switch `%s'", ctx.opt);
                }
