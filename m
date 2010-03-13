From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: "git stash list" shows HEAD reflog
Date: Sat, 13 Mar 2010 13:43:47 -0800
Message-ID: <4B9C0713.30407@pcharlan.com>
References: <op.u9gl97fstuzx1w@cybershadow.mshome.net> <4B9BCD6E.4090902@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vladimir Panteleev <vladimir@thecybershadow.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Mar 13 22:44:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZ7o-0004H9-Gd
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 22:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759326Ab0CMVnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Mar 2010 16:43:51 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:60465 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755523Ab0CMVnu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Mar 2010 16:43:50 -0500
Received: from [192.168.0.119] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id F2C2D8F227;
	Sat, 13 Mar 2010 13:43:47 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4B9BCD6E.4090902@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142108>

On 03/13/2010 09:37 AM, Ren=C3=A9 Scharfe wrote:
> As Vladimir reported, "git log -g refs/stash" surprisingly showed the=
 reflog
> of HEAD if the message in the reflog file was too long.  To fix this,=
 convert
> for_each_recent_reflog_ent() to use strbuf_getwholeline() instead of =
fgets(),
> for safety and to avoid any size limits for reflog entries.

Was the old code actually unsafe?  If not, then perhaps the commit
message would be clearer if ", for safety and" were removed.

--Pete

> Also reverse the logic of the part of the function that only looks at=
 file
> tails.  It used to close the file if fgets() succeeded.  The followin=
g
> fgets() call in the while loop was likely to fail in this case, too, =
so
> passing an offset to for_each_recent_reflog_ent() never worked.  Chan=
ge it to
> error out if strbuf_getwholeline() fails instead.
>=20
> Reported-by: Vladimir Panteleev <vladimir@thecybershadow.net>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  refs.c |   22 ++++++++++++----------
>  1 files changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/refs.c b/refs.c
> index f3fcbe0..63e30d7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1574,7 +1574,7 @@ int for_each_recent_reflog_ent(const char *ref,=
 each_reflog_ent_fn fn, long ofs,
>  {
>  	const char *logfile;
>  	FILE *logfp;
> -	char buf[1024];
> +	struct strbuf sb =3D STRBUF_INIT;
>  	int ret =3D 0;
> =20
>  	logfile =3D git_path("logs/%s", ref);
> @@ -1587,24 +1587,24 @@ int for_each_recent_reflog_ent(const char *re=
f, each_reflog_ent_fn fn, long ofs,
>  		if (fstat(fileno(logfp), &statbuf) ||
>  		    statbuf.st_size < ofs ||
>  		    fseek(logfp, -ofs, SEEK_END) ||
> -		    fgets(buf, sizeof(buf), logfp)) {
> +		    strbuf_getwholeline(&sb, logfp, '\n')) {
>  			fclose(logfp);
> +			strbuf_release(&sb);
>  			return -1;
>  		}
>  	}
> =20
> -	while (fgets(buf, sizeof(buf), logfp)) {
> +	while (!strbuf_getwholeline(&sb, logfp, '\n')) {
>  		unsigned char osha1[20], nsha1[20];
>  		char *email_end, *message;
>  		unsigned long timestamp;
> -		int len, tz;
> +		int tz;
> =20
>  		/* old SP new SP name <email> SP time TAB msg LF */
> -		len =3D strlen(buf);
> -		if (len < 83 || buf[len-1] !=3D '\n' ||
> -		    get_sha1_hex(buf, osha1) || buf[40] !=3D ' ' ||
> -		    get_sha1_hex(buf + 41, nsha1) || buf[81] !=3D ' ' ||
> -		    !(email_end =3D strchr(buf + 82, '>')) ||
> +		if (sb.len < 83 || sb.buf[sb.len - 1] !=3D '\n' ||
> +		    get_sha1_hex(sb.buf, osha1) || sb.buf[40] !=3D ' ' ||
> +		    get_sha1_hex(sb.buf + 41, nsha1) || sb.buf[81] !=3D ' ' ||
> +		    !(email_end =3D strchr(sb.buf + 82, '>')) ||
>  		    email_end[1] !=3D ' ' ||
>  		    !(timestamp =3D strtoul(email_end + 2, &message, 10)) ||
>  		    !message || message[0] !=3D ' ' ||
> @@ -1618,11 +1618,13 @@ int for_each_recent_reflog_ent(const char *re=
f, each_reflog_ent_fn fn, long ofs,
>  			message +=3D 6;
>  		else
>  			message +=3D 7;
> -		ret =3D fn(osha1, nsha1, buf+82, timestamp, tz, message, cb_data);
> +		ret =3D fn(osha1, nsha1, sb.buf + 82, timestamp, tz, message,
> +			 cb_data);
>  		if (ret)
>  			break;
>  	}
>  	fclose(logfp);
> +	strbuf_release(&sb);
>  	return ret;
>  }
> =20
