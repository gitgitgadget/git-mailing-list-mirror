From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git rev-parse --since=1970-01-01 does not work reliably
Date: Tue, 1 Nov 2011 06:13:20 +0700
Message-ID: <20111031231320.GA3857@do>
References: <20111031161708.GA29924@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 00:14:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL144-0001Ko-PS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 00:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934809Ab1JaXOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Oct 2011 19:14:43 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43599 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934704Ab1JaXOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 19:14:42 -0400
Received: by ywf7 with SMTP id 7so1599736ywf.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 16:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lDG4dF+OXd73WLXFsugFppluxcDwyaU26SCu5MHcSzk=;
        b=u7IhBbPZOAsAJ+Y5MbRiT3R5TaGTJeTJrQblAj83LCl6G85XjVErjDizC7zk1wl3+Z
         fbz+OwEo7TVnjW2LBINv6q94qY6x7c3libLf4UJAazTGye0iv47cu0IhNa3GUlAHSnth
         HwesFJh1iUtGZ8AfsBvPurOpON+RUa94iy2k8=
Received: by 10.68.15.225 with SMTP id a1mr26165679pbd.66.1320102881186;
        Mon, 31 Oct 2011 16:14:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.192.97])
        by mx.google.com with ESMTPS id g1sm54098356pbv.2.2011.10.31.16.14.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 16:14:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 01 Nov 2011 06:13:21 +0700
Content-Disposition: inline
In-Reply-To: <20111031161708.GA29924@altlinux.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184545>

On Mon, Oct 31, 2011 at 08:17:09PM +0400, Dmitry V. Levin wrote:
> Hi,
>=20
> git rev-parse --since=3D1970-01-01 (and other git commands that take
> date string arguments like --since) may fail when --since=3D1970-01-0=
1 is
> given.  Whether it fails or not depends on current time and timezone =
data.
> For example, "TZ=3DEurope/Paris git rev-parse --since=3D1970-01-01" f=
ails two
> hours a day (between 00:00 and 02:00 CET), and those who use more eas=
tern
> timezones are even less lucky.  In artificial timezones like UTC-24 i=
t
> always fails:
>=20
> $ TZ=3DUTC-24 git rev-parse --since=3D1970-01-01
> --max-age=3D18446744073709523490

Out of curiosity, why do you need to work with a time so close to that
date?

> The problem is that several internal git functions implicitly convert
> time_t to unsigned long, so when time_t gets negative, all date strin=
g
> processing breaks.

I don't think it's worth supporting negative time_t, but we should at
least avoid misconversion.

-- 8< --
Subject: [PATCH] Do not accept negative time_t

We use unsigned long internally to present time, negative value just
breaks thing.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 date.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index 353e0a5..9cbd521 100644
--- a/date.c
+++ b/date.c
@@ -653,8 +653,12 @@ int parse_date_basic(const char *date, unsigned lo=
ng *timestamp, int *offset)
 	if (*timestamp =3D=3D -1)
 		return -1;
=20
-	if (!tm_gmt)
+	if (!tm_gmt) {
+		if ((time_t)*timestamp < (time_t)*offset * 60)
+			die("unsupported time before Epoch");
 		*timestamp -=3D *offset * 60;
+	}
+
 	return 0; /* success */
 }
=20
@@ -722,6 +726,8 @@ static unsigned long update_tm(struct tm *tm, struc=
t tm *now, unsigned long sec)
=20
 	n =3D mktime(tm) - sec;
 	localtime_r(&n, tm);
+	if (n < 0)
+		die("unsupported time before Epoch");
 	return n;
 }
=20
--=20
1.7.4.74.g639db
-- 8< --
