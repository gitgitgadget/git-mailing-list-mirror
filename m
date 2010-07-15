From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/8] Add memory pool library
Date: Thu, 15 Jul 2010 21:12:13 +0200
Message-ID: <20100715191213.GJ22574@debian>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-4-git-send-email-artagnon@gmail.com>
 <20100715185706.GA2774@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 21:10:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZTpL-0002k6-55
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 21:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934415Ab0GOTK2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 15:10:28 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60852 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934274Ab0GOTK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 15:10:27 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so359118ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wvpXpq2tYv4GQtm4AZSxReWYCW74lkZItV+ezYgD1RE=;
        b=IY9S4IFRvEjUNmJkzP2XF9dGvsph/WN79VN3AMwuAKNyaMvG/J3LfPF9f541f3mGjS
         SqCWjKNQ/sU/ADcc2Y6e5j6JihG/WB4DRhVauIuMP55H8o0fk29q6i6B0MEwrw3XQOFw
         GynpwBkeNl8GbAw83i1X6+01/R8aWi27SD6fM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QwKN6yVunlFKkgSJJraEcA+bt47Cot/5drYHwFBDV5X0EgmlRn3V8Wmdh4tbzehi7Z
         FiEYuDKCN0/Z1485/tw+sNKkRyZtJoZJVlbUVikr+yFUorN0K/cR89mvLH/xRQtyypJT
         GnsNr2OaQLBwAyb2rjj6dYjFe8gFpLBXJ/ZGQ=
Received: by 10.213.27.200 with SMTP id j8mr207703ebc.33.1279221026512;
        Thu, 15 Jul 2010 12:10:26 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm10529425eeh.23.2010.07.15.12.10.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:10:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100715185706.GA2774@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151111>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>=20
> > void pre_commit(void);
> >=20
> > 	Write the pool to file.
>=20
> Except as a proof of concept, this is the wrong API to have.  The pro=
blem
> is that the caller cannot choose the filename, so it ends up being a =
=2Ebin
> file in the current directory, wherever that is.
>=20
> The log message leaves out a subtlety: this also increases the
> =E2=80=98committed=E2=80=99 value, and bookkeeping for that might be =
useful to some
> callers.
>=20
> In other words:
>=20
> > +static MAYBE_UNUSED void pre##_init(void) \
> > +{ \
> > +	struct stat st; \
> > +	pre##_pool.file =3D fopen(#pre ".bin", "a+"); \
> > +	rewind(pre##_pool.file); \
> > +	fstat(fileno(pre##_pool.file), &st); \
> > +	pre##_pool.size =3D st.st_size / sizeof(obj_t); \
> > +	pre##_pool.committed =3D pre##_pool.size; \
> > +	pre##_pool.capacity =3D pre##_pool.size * 2; \
> > +	if (pre##_pool.capacity < initial_capacity) \
> > +		pre##_pool.capacity =3D initial_capacity; \
> > +	pre##_pool.base =3D malloc(pre##_pool.capacity * sizeof(obj_t)); =
\
> > +	fread(pre##_pool.base, sizeof(obj_t), pre##_pool.size, pre##_pool=
=2Efile); \
> > +} \
>=20
> If you just want something working, I=E2=80=99d suggest stubbing this=
 out:
>=20
>  static MAYBE_UNUSED void pre##_init(void) \
>  { \
>  } \
>=20
> It even almost makes sense as API: the _init function does all
> initialization tasks required, which is to say, none.  (The {0, ...}
> initializer already has taken care of setting all fields to 0).
>=20
> > +static MAYBE_UNUSED void pre##_commit(void) \
> > +{ \
> > +	pre##_pool.committed +=3D fwrite(pre##_pool.base + pre##_pool.com=
mitted, \
> > +		sizeof(obj_t), pre##_pool.size - pre##_pool.committed, \
> > +		pre##_pool.file); \
> > +} \
>=20
> This can be simplified
>=20
>  static MAYBE_UNUSED void pre##_commit(void) \
>  { \
> 	pre##_pool.committed =3D pre##_pool.size; \
>  } \
>=20
> In other words, maybe something like this on top?  This includes the
> vestigal _init() function which really should not be there (it is
> confusing that some callers use it and others don=E2=80=99t).  I did =
not
> spend much time on it because in the end I suspect we might throw
> obj_pool away anyway.

Oh, right. I remember that you asked to turn off persistence for this
merge. We can include persistence it in a later series.

Junio: Could you squash this diff into the commit?

diff --git a/vcs-svn/obj_pool.h b/vcs-svn/obj_pool.h
index f60c872..7a256d4 100644
--- a/vcs-svn/obj_pool.h
+++ b/vcs-svn/obj_pool.h
@@ -20,17 +20,6 @@ static struct { \
 } pre##_pool =3D { 0, 0, 0, NULL, NULL}; \
 static MAYBE_UNUSED void pre##_init(void) \
 { \
-	struct stat st; \
-	pre##_pool.file =3D fopen(#pre ".bin", "a+"); \
-	rewind(pre##_pool.file); \
-	fstat(fileno(pre##_pool.file), &st); \
-	pre##_pool.size =3D st.st_size / sizeof(obj_t); \
-	pre##_pool.committed =3D pre##_pool.size; \
-	pre##_pool.capacity =3D pre##_pool.size * 2; \
-	if (pre##_pool.capacity < initial_capacity) \
-		pre##_pool.capacity =3D initial_capacity; \
-	pre##_pool.base =3D malloc(pre##_pool.capacity * sizeof(obj_t)); \
-	fread(pre##_pool.base, sizeof(obj_t), pre##_pool.size, pre##_pool.fil=
e); \
 } \
 static MAYBE_UNUSED uint32_t pre##_alloc(uint32_t count) \
 { \
@@ -62,9 +51,7 @@ static MAYBE_UNUSED obj_t *pre##_pointer(uint32_t off=
set) \
 } \
 static MAYBE_UNUSED void pre##_commit(void) \
 { \
-	pre##_pool.committed +=3D fwrite(pre##_pool.base + pre##_pool.committ=
ed, \
-		sizeof(obj_t), pre##_pool.size - pre##_pool.committed, \
-		pre##_pool.file); \
+	pre##_pool.committed =3D pre##_pool.size; \
 } \
 static MAYBE_UNUSED void pre##_reset(void) \
 { \
