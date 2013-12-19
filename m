From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: problematic git status output with some translations (such
 as fr_FR)
Date: Thu, 19 Dec 2013 11:43:19 -0800
Message-ID: <20131219194319.GB20443@google.com>
References: <20131008085036.11434.25160.reportbug@x230-buxy.home.ouaza.com>
 <20131219104613.GA18379@x230-buxy.home.ouaza.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Raphael Hertzog <hertzog@debian.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 20:43:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtjVI-0006wP-Tn
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 20:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab3LSTnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Dec 2013 14:43:25 -0500
Received: from mail-gg0-f181.google.com ([209.85.161.181]:46376 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab3LSTnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 14:43:24 -0500
Received: by mail-gg0-f181.google.com with SMTP id y1so385849ggc.26
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 11:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6y+SjUS2pfifUtyDSIFIynoLAU6k3j9WQAigodB8EJA=;
        b=bmsts3KLfsWkRa9q0PqCC/fNz1ETG7pudI3PYmo4S8JADsijww8M1iBH7bm/RYtysP
         nNDP4tzSVOTwsbd2Xm/4HHBZzphMIALbLH8m6k8EIbvUGfA3ygWin81OdiCx5w07IiCE
         adtfnwPwFfmuUGqas3KJKAcYHIR61VSRiamv6Obv8c2gstUXIuOGqGhyZM6+ucfh6++K
         OaGijCp13rYuTTIcIMXX2vctLKneRgBHdB5zN6ePJZWknWXZl1a7JCnZDXBI6hGeZYtH
         N8UhDUl0n/r8QcKm5054lU51dmwbjR9GHWHuZWyyNTpaFgrlp1yy+X0eaa5KNAVzgBV0
         d4tw==
X-Received: by 10.236.37.105 with SMTP id x69mr2696794yha.15.1387482203399;
        Thu, 19 Dec 2013 11:43:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c44sm7557199yho.20.2013.12.19.11.43.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Dec 2013 11:43:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131219104613.GA18379@x230-buxy.home.ouaza.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239537>

Rapha=EBl Hertzog wrote[1]:

> Here's an example of the problematic output:
[...]
> #	modifi=E9 des deux c=F4t=E9s :debian/control

Thanks for the ping, and sorry to leave this hanging before.

[...]
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -255,7 +255,7 @@ static void wt_status_print_unmerged_data(struct =
wt_status *s,
>  	case 6: how =3D _("both added:"); break;
>  	case 7: how =3D _("both modified:"); break;
>  	}
> -	status_printf_more(s, c, "%-20s%s\n", how, one);
> +	status_printf_more(s, c, "%-19s %s\n", how, one);

It looks like the original code is assuming that

 (1) the number of bytes written is the width of a string, so they can
     line up

 (2) the "how" string is always <=3D 19 bytes

Both assumptions are problematic.

Perhaps the value '20' should be dynamic (e.g.,

	min(20,
	    1 + max(utf8_strwidth(all 'how' strings
	                          in the current UI language)))

) to allow the text to always line up?  Ever since 3651e45c
(wt-status: take the alignment burden off translators, 2013-11-05),
wt_status_print_change_data() picks its width dynamically for the same
reason.  So, something like the following (untested)?

This includes the colon in the translated string, to make it easier to
remember to keep the non-breaking space before it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

[1] http://bugs.debian.org/725777

diff --git i/wt-status.c w/wt-status.c
index 4e55810..7b0e5b8 100644
--- i/wt-status.c
+++ w/wt-status.c
@@ -245,27 +245,26 @@ static void wt_status_print_trailer(struct wt_sta=
tus *s)
=20
 #define quote_path quote_path_relative
=20
-static void wt_status_print_unmerged_data(struct wt_status *s,
-					  struct string_list_item *it)
+static const char *wt_status_unmerged_status_string(int stagemask)
 {
-	const char *c =3D color(WT_STATUS_UNMERGED, s);
-	struct wt_status_change_data *d =3D it->util;
-	struct strbuf onebuf =3D STRBUF_INIT;
-	const char *one, *how =3D _("bug");
-
-	one =3D quote_path(it->string, s->prefix, &onebuf);
-	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
-	switch (d->stagemask) {
-	case 1: how =3D _("both deleted:"); break;
-	case 2: how =3D _("added by us:"); break;
-	case 3: how =3D _("deleted by them:"); break;
-	case 4: how =3D _("added by them:"); break;
-	case 5: how =3D _("deleted by us:"); break;
-	case 6: how =3D _("both added:"); break;
-	case 7: how =3D _("both modified:"); break;
+	switch (stagemask) {
+	case 1:
+		return _("both deleted:");
+	case 2:
+		return _("added by us:");
+	case 3:
+		return _("deleted by them:");
+	case 4:
+		return _("added by them:");
+	case 5:
+		return _("deleted by us:");
+	case 6:
+		return _("both added:");
+	case 7:
+		return _("both modified:");
+	default:
+		return NULL;
 	}
-	status_printf_more(s, c, "%-20s%s\n", how, one);
-	strbuf_release(&onebuf);
 }
=20
 static const char *wt_status_diff_status_string(int status)
@@ -292,6 +291,48 @@ static const char *wt_status_diff_status_string(in=
t status)
 	}
 }
=20
+static int maxwidth(const char *(*label)(int), int minval, int maxval)
+{
+	const char *s;
+	int result =3D 0, i;
+
+	for (i =3D minval; i <=3D maxval; i++) {
+		const char *s =3D label(i);
+		int len =3D s ? strlen(s) : 0;
+		if (len > result)
+			result =3D len;
+	}
+	return result;
+}
+
+static void wt_status_print_unmerged_data(struct wt_status *s,
+					  struct string_list_item *it)
+{
+	const char *c =3D color(WT_STATUS_UNMERGED, s);
+	struct wt_status_change_data *d =3D it->util;
+	struct strbuf onebuf =3D STRBUF_INIT;
+	static char *padding;
+	const char *one, *how;
+	int len;
+
+	if (!padding) {
+		int width =3D maxwidth(wt_status_unmerged_status_string, 1, 7);
+		width +=3D strlen(" ");
+		padding =3D xmallocz(width);
+		memset(padding, ' ', width);
+	}
+
+	one =3D quote_path(it->string, s->prefix, &onebuf);
+	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
+
+	how =3D wt_status_unmerged_status_string(d->stagemask);
+	if (!how)
+		how =3D _("bug");
+	len =3D strlen(padding) - utf8_strwidth(how);
+	status_printf_more(s, c, "%s%.*s%s\n", how, len, padding, one);
+	strbuf_release(&onebuf);
+}
+
 static void wt_status_print_change_data(struct wt_status *s,
 					int change_type,
 					struct string_list_item *it)
@@ -309,14 +350,8 @@ static void wt_status_print_change_data(struct wt_=
status *s,
 	int len;
=20
 	if (!padding) {
-		int width =3D 0;
-		/* If DIFF_STATUS_* uses outside this range, we're in trouble */
-		for (status =3D 'A'; status <=3D 'Z'; status++) {
-			what =3D wt_status_diff_status_string(status);
-			len =3D what ? strlen(what) : 0;
-			if (len > width)
-				width =3D len;
-		}
+		/* If DIFF_STATUS_* uses outside the range [A..Z], we're in trouble =
*/
+		int width =3D maxwidth(wt_status_diff_status_string, 'A', 'Z');
 		width +=3D 2;	/* colon and a space */
 		padding =3D xmallocz(width);
 		memset(padding, ' ', width);
