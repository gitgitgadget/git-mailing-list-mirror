From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] fetch: plug two leaks on error exit in store_updated_refs
Date: Fri, 7 Oct 2011 14:49:12 +0800
Message-ID: <CALUzUxp4Eo7j=kM7YPJbj70-rwuyFK5V1mZZMY7vBwwPYWS6gQ@mail.gmail.com>
References: <20111007014136.GB10839@localhost>
	<4E8E98A7.8010008@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Wilson <cwilson@vigilantsw.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Oct 07 08:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC4FD-0007rr-5B
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 08:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab1JGGtO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 02:49:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39326 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188Ab1JGGtO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 02:49:14 -0400
Received: by gyg10 with SMTP id 10so3338753gyg.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 23:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3q7Ay+8TXXYX80gwbEY8xWNA8au1ycnkGpisGh1dboU=;
        b=txoGFXy9z7ka0JdrriJcUAjLVVlvcLasSdC+CFQRCFs05sOacZ/u7Nwvj3yZbkm62a
         FLWbqSqzxR1eg2pt0bhjlcKgnCDqbXpGgsxpRt7Efwg8KyZ7XWlhlUa2B5KEdudNbD7p
         KxTz7td6K+w5FI4/UpmyidzFO5plh3jaQYmWo=
Received: by 10.68.19.4 with SMTP id a4mr11749409pbe.14.1317970152873; Thu, 06
 Oct 2011 23:49:12 -0700 (PDT)
Received: by 10.142.103.15 with HTTP; Thu, 6 Oct 2011 23:49:12 -0700 (PDT)
In-Reply-To: <4E8E98A7.8010008@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183060>

On Fri, Oct 7, 2011 at 2:13 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7a4e41c..79db796 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -379,8 +379,12 @@ static int store_updated_refs(const char *raw_ur=
l, const char *remote_name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0url =3D xstrdup("foreign");
>
> =A0 =A0 =A0 =A0rm =3D ref_map;
> - =A0 =A0 =A0 if (check_everything_connected(iterate_ref_map, 0, &rm)=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error(_("%s did not send all nec=
essary objects\n"), url);
> + =A0 =A0 =A0 if (check_everything_connected(iterate_ref_map, 0, &rm)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error(_("%s did not send all necessary =
objects\n"), url);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(url);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclose(fp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0for (rm =3D ref_map; rm; rm =3D rm->next) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ref *ref =3D NULL;
> --
> 1.7.7

How about reusing the function's cleanup calls, like this?

-- >8 --
diff --git a/builtin/fetch.c b/builtin/fetch.c
index fc254b6..56267c4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -423,8 +423,10 @@ static int store_updated_refs(const char
*raw_url, const char *remote_name,
 	else
 		url =3D xstrdup("foreign");

-	if (check_everything_connected(ref_map, 0))
-		return error(_("%s did not send all necessary objects\n"), url);
+	if (check_everything_connected(ref_map, 0)) {
+		rc =3D error(_("%s did not send all necessary objects\n"), url);
+		goto abort;
+	}

 	for (rm =3D ref_map; rm; rm =3D rm->next) {
 		struct ref *ref =3D NULL;
@@ -506,12 +508,15 @@ static int store_updated_refs(const char
*raw_url, const char *remote_name,
 				fprintf(stderr, " %s\n", note);
 		}
 	}
-	free(url);
-	fclose(fp);
+
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "
 		      "branches"), remote_name);
+
+abort:
+	free(url);
+	fclose(fp);
 	return rc;
 }

--

--=20
Cheers,
Ray Chuan
