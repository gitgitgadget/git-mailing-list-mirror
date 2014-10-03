From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] bundle: plug minor memory leak in is_tag_in_date_range()
Date: Fri, 3 Oct 2014 16:40:45 -0700
Message-ID: <20141003234045.GU1175@google.com>
References: <542F25D8.1000900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 04 01:41:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaCT3-0006zN-Tb
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 01:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758972AbaJCXkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Oct 2014 19:40:53 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:48659 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985AbaJCXks (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 19:40:48 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so2257975pab.30
        for <git@vger.kernel.org>; Fri, 03 Oct 2014 16:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=woQi+X3YN11cOzovyD8Osi12Hv8Sv5DpRH02eeeKaWo=;
        b=ov1l+o7ffaSVNc8Qw8yMouoTxH+Mh7M2YqJO0e247nzAzaPEOXdFQ2sduNszhxDILr
         EUCU8376zJ8Ij/z2eH8LSQCiYckzgsx7rjm5TaKeQ7H6viRcfpNv00TfhkabPY9ewtLa
         a9Cs1P7XBVoPr6ZEurd4wD+kIIRnTzwWaL/yYkZKOUzjZt3kZVCfuL7yLACqtl4H2fC5
         GjJUbi83vKPzdGH4Jc5QitHO7wu5qlfPoCmwa6W2u1a5vOUxpwBeB6L+V6faTH52NG2R
         Y5emRFm54S9hRYZ+0oxGK+Axz+GQWR68gy1qamLIenLuvhDof92QwTbXlnJH1qhfGOAv
         CDMQ==
X-Received: by 10.70.89.108 with SMTP id bn12mr3851267pdb.146.1412379647687;
        Fri, 03 Oct 2014 16:40:47 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id td4sm7412903pab.19.2014.10.03.16.40.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Oct 2014 16:40:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <542F25D8.1000900@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257879>

Ren=E9 Scharfe wrote:

> --- a/bundle.c
> +++ b/bundle.c
> @@ -211,24 +211,28 @@ static int is_tag_in_date_range(struct object *=
tag, struct rev_info *revs)
>  	enum object_type type;
>  	char *buf, *line, *lineend;

If buf is initialized to NULL, there is no need for separate out and
out_free labels.

With or without such a change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/bundle.c w/bundle.c
index 4158e11..101cde0 100644
--- i/bundle.c
+++ w/bundle.c
@@ -209,7 +209,7 @@ static int is_tag_in_date_range(struct object *tag,=
 struct rev_info *revs)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf, *line, *lineend;
+	char *buf =3D NULL, *line, *lineend;
 	unsigned long date;
 	int result =3D 1;
=20
@@ -221,17 +221,16 @@ static int is_tag_in_date_range(struct object *ta=
g, struct rev_info *revs)
 		goto out;
 	line =3D memmem(buf, size, "\ntagger ", 8);
 	if (!line++)
-		goto out_free;
+		goto out;
 	lineend =3D memchr(line, '\n', buf + size - line);
 	line =3D memchr(line, '>', lineend ? lineend - line : buf + size - li=
ne);
 	if (!line++)
-		goto out_free;
+		goto out;
 	date =3D strtoul(line, NULL, 10);
 	result =3D (revs->max_age =3D=3D -1 || revs->max_age < date) &&
 		(revs->min_age =3D=3D -1 || revs->min_age > date);
-out_free:
-	free(buf);
 out:
+	free(buf);
 	return result;
 }
=20
