From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/45] parse_pathspec and :(glob) magic
Date: Thu, 21 Mar 2013 12:33:26 +0700
Message-ID: <20130321053326.GA17446@duynguyen-vnpc.dek-tpc.internal>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
 <7v1ubaeyph.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 06:34:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIY8h-0006Z7-Pi
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 06:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab3CUFdl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Mar 2013 01:33:41 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:33879 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab3CUFdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 01:33:39 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so1435933dae.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 22:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tqOexW5f9LQ3zMaET0S/iecE9hAJH2FcA6FMjSllj04=;
        b=BjWuZ/lmSQU+teRYnqTs7HokyTQjTVNlox5R3p+/2VOAzUepgcb4Ud5Rhkh6rEgHwz
         1x89CWZtXxUrxHMwTxQaFrSHrZOkGI+OqDo0hCXeDR6oj8zPRrdhCjXj/DBbZhVHpFkh
         2DXCjBQiViGhbu9aUpPXrKSo8kgie3MfjAIn0szDUBaaH3PN4z9t5lTrQ4EBXA3eacbz
         dgHuhwGTGRfwoZmZ2z5ed8KiHCNSenD055SsT9gASv2Ci2B81euLeqVGSLhCRrA7mr2B
         lwlh8xR5pMtWw0U4q+IDat6xcn9YzJGtUKAjSM1I8QN3WxVvmfSUyURCmXSf21D84IwS
         wwgQ==
X-Received: by 10.68.195.70 with SMTP id ic6mr12951041pbc.60.1363844019376;
        Wed, 20 Mar 2013 22:33:39 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id na4sm4743335pbc.8.2013.03.20.22.33.34
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 22:33:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 21 Mar 2013 12:33:26 +0700
Content-Disposition: inline
In-Reply-To: <7v1ubaeyph.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218693>

On Wed, Mar 20, 2013 at 11:02:50AM -0700, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > Junio please pull the series from github [1]....
> > [1] https://github.com/pclouds/git/commits/parse-pathspec
>=20
> Please write it like this:
>=20
>     https://github.com/pclouds/git parse-pathspec
>=20
> so that I can just say
>=20
> 	git fetch <<that thing>>
>         git diff nd/magic-pathspecs FETCH_HEAD

OK

> I am still getting this out of 7300, though.

I still can't reproduce it. But I think I found a bug that
miscalculates prefix length from absolute paths. Does this "fix" your
test?

-- 8< --
diff --git a/setup.c b/setup.c
index 3584f22..6ae147a 100644
--- a/setup.c
+++ b/setup.c
@@ -14,6 +14,7 @@ char *prefix_path_gently(const char *prefix, int *p_l=
en, const char *path)
 		const char *temp =3D real_path(path);
 		sanitized =3D xmalloc(len + strlen(temp) + 1);
 		strcpy(sanitized, temp);
+		*p_len =3D 0;
 	} else {
 		sanitized =3D xmalloc(len + strlen(path) + 1);
 		if (len)

-- 8< --
