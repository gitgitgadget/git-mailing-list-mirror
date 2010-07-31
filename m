From: "Jasper St. Pierre" <jstpierre@mecheye.net>
Subject: Re: [PATCH v2] Do not unquote + into ' ' in URLs
Date: Sat, 31 Jul 2010 17:18:28 -0400
Message-ID: <AANLkTikY_ayRzdbQ2Qsf6wus+=yg99aTLDTahVXUw0eK@mail.gmail.com>
References: <201007240104.25341.trast@student.ethz.ch> <ed2d311355fca478f97b82f8d955494509d6b9de.1279982471.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, avarab@gmail.com,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jul 31 23:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfJSV-000392-In
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 23:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238Ab0GaVSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 17:18:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62308 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0GaVSv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jul 2010 17:18:51 -0400
Received: by wwj40 with SMTP id 40so2662451wwj.1
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 14:18:49 -0700 (PDT)
Received: by 10.216.59.131 with SMTP id s3mr3166685wec.71.1280611129281; Sat, 
	31 Jul 2010 14:18:49 -0700 (PDT)
Received: by 10.216.46.5 with HTTP; Sat, 31 Jul 2010 14:18:28 -0700 (PDT)
In-Reply-To: <ed2d311355fca478f97b82f8d955494509d6b9de.1279982471.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152339>

Hmm.. could we get a follow-up on this patch? It's annoying because it'=
s both
backwards and forwards incompatible: the %2b workaround doesn't work in
older versions.

On Sat, Jul 24, 2010 at 10:49 AM, Thomas Rast <trast@student.ethz.ch> w=
rote:
> Since 9d2e942 (decode file:// and ssh:// URLs, 2010-05-23) the URL
> logic unquotes escaped URLs. =A0For the %2B type of escape, this is
> conformant with RFC 2396. =A0However, it also unquotes + into a space
> character, which is only appropriate for the query strings in HTTP.
> This notably broke fetching from the gtk+ repository.
>
> We cannot just remove the corresponding code since the same
> url_decode_internal() is also used by the HTTP backend to decode quer=
y
> parameters. =A0Introduce a new argument that controls whether the +
> decoding happens, and use it only in the (client-side) url_decode().
>
> Reported-by: Jasper St. Pierre <jstpierre@mecheye.net>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> I wrote:
>> Junio C Hamano wrote:
>> >
>> > =A0 http-backend.c::get_info_refs()
>> > =A0 =A0-> http-backend.c::get_parameter()
>> > =A0 =A0 =A0-> http-backend.c::get_parameters()
>> > =A0 =A0 =A0 =A0-> url.c::url_decode_parameter_value()
>> > =A0 =A0 =A0 =A0 =A0-> url.c::url_decode_internal()
>>
>> You're right, I forgot about those. =A0I imagine it would be one of =
two
>> cases:
> [...]
>> Shawn, can you help with this?
>
> The third case, of course, is:
>
> * It only uses these functions for parameter decoding, which of cours=
e
> =A0was correct to begin with.
>
> So after hopefully drinking enough coffee, I made this one. =A0The ca=
tch
> is that I'm not entirely clear whether *not* decoding the +
> client-side anywhere in the URL is correct for http:// URLs? =A0If th=
e
> client decodes and re-encodes the URL, then the + would be turned int=
o
> a %2B on the re-encoding. =A0Then again maybe UI-facing URLs should
> never have a query part at all?
>
>
> =A0t/t5601-clone.sh | =A0 10 ++++++++--
> =A0url.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 ++++++-----
> =A02 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 8abb71a..4431dfd 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -178,8 +178,14 @@ test_expect_success 'clone respects global branc=
h.autosetuprebase' '
>
> =A0test_expect_success 'respect url-encoding of file://' '
> =A0 =A0 =A0 =A0git init x+y &&
> - =A0 =A0 =A0 test_must_fail git clone "file://$PWD/x+y" xy-url &&
> - =A0 =A0 =A0 git clone "file://$PWD/x%2By" xy-url
> + =A0 =A0 =A0 git clone "file://$PWD/x+y" xy-url-1 &&
> + =A0 =A0 =A0 git clone "file://$PWD/x%2By" xy-url-2
> +'
> +
> +test_expect_success 'do not query-string-decode + in URLs' '
> + =A0 =A0 =A0 rm -rf x+y &&
> + =A0 =A0 =A0 git init "x y" &&
> + =A0 =A0 =A0 test_must_fail git clone "file://$PWD/x+y" xy-no-plus
> =A0'
>
> =A0test_expect_success 'do not respect url-encoding of non-url path' =
'
> diff --git a/url.c b/url.c
> index 2306236..cd8f74f 100644
> --- a/url.c
> +++ b/url.c
> @@ -67,7 +67,8 @@ static int url_decode_char(const char *q)
> =A0 =A0 =A0 =A0return val;
> =A0}
>
> -static char *url_decode_internal(const char **query, const char *sto=
p_at, struct strbuf *out)
> +static char *url_decode_internal(const char **query, const char *sto=
p_at,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct strbuf *out, int decode_plus)
> =A0{
> =A0 =A0 =A0 =A0const char *q =3D *query;
>
> @@ -90,7 +91,7 @@ static char *url_decode_internal(const char **query=
, const char *stop_at, struct
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c =3D=3D '+')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (decode_plus && c =3D=3D '+')
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addch(out, ' ')=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addch(out, c);
> @@ -110,17 +111,17 @@ char *url_decode(const char *url)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_add(&out, url, colon - url);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0url =3D colon;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 return url_decode_internal(&url, NULL, &out);
> + =A0 =A0 =A0 return url_decode_internal(&url, NULL, &out, 0);
> =A0}
>
> =A0char *url_decode_parameter_name(const char **query)
> =A0{
> =A0 =A0 =A0 =A0struct strbuf out =3D STRBUF_INIT;
> - =A0 =A0 =A0 return url_decode_internal(query, "&=3D", &out);
> + =A0 =A0 =A0 return url_decode_internal(query, "&=3D", &out, 1);
> =A0}
>
> =A0char *url_decode_parameter_value(const char **query)
> =A0{
> =A0 =A0 =A0 =A0struct strbuf out =3D STRBUF_INIT;
> - =A0 =A0 =A0 return url_decode_internal(query, "&", &out);
> + =A0 =A0 =A0 return url_decode_internal(query, "&", &out, 1);
> =A0}
> --
> 1.7.2.278.g76edd.dirty
>
>
