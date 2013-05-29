From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: 1.8.3 - gitignore not being parsed correctly on OS X; regex support
 is broken?
Date: Wed, 29 May 2013 18:19:34 +0200
Message-ID: <51A62A96.6040009@gmail.com>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com> <CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com> <CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Misty De Meo <misty@brew.sh>,
	=?UTF-8?B?w5h5c3RlaW4gV2FsbGU=?= <oystwa@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 18:19:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhj6J-0002v8-IK
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 18:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776Ab3E2QTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 12:19:42 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:43968 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759301Ab3E2QTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 12:19:37 -0400
Received: by mail-ea0-f178.google.com with SMTP id q16so5391511ead.23
        for <git@vger.kernel.org>; Wed, 29 May 2013 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sdDp6w5Hv3FFfFrnQpZf3g/g/+eYYRtyXphh3t1whSo=;
        b=fpsvyhiWP0eqFseuUOZvi8ri1FIRXbu/JPxfh3Nk1jQQHge6KL1TRdyJjm0EqM1ftr
         7aL6hBjJdiJyhPBhZNO2Oeejf9NBjZENLapfPGQBpvILTrvrNPt5FzJZyuHa0alKn9XX
         5lBFcd2owUBoM1t0EgfI6CI4cA6GLak+V5nQhd75Xon9Ut3CFJ5zT17BYnyDJ2hjrdZO
         Usrv2gk4RbdRVFSpkdHNN+4L6P/0q4t2FvzHSatdCzheasIa2oH/XmRLJ044h+aKjLgw
         UjDLhBKYOjKwpKScglBrDs/Grn36CA6mU51CQAh6KHogF8eu0BbPEJ33suPaZMi9zokk
         92nQ==
X-Received: by 10.15.73.133 with SMTP id h5mr4448367eey.118.1369844375926;
        Wed, 29 May 2013 09:19:35 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w43sm25596895eel.0.2013.05.29.09.19.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 09:19:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225838>

Am 29.05.2013 06:19, schrieb Duy Nguyen:
> On Wed, May 29, 2013 at 10:41 AM, Duy Nguyen <pclouds@gmail.com> wrot=
e:
>> The changes in this area since 1.8.2.3 seem to be Karsten's (I'm not
>> blaming, just wanted to narrow down the problem). The patterns of
>> interest seem to be
>>
>> !/bin
>> /bin/*
>> !/bin/brew
>>
>> Without "!/bin" v1.8.3 seems to behave the same as v1.8.2.3.
>=20
> Karsten, the block "/* Abort if the directory is excluded */" in
> prep_exclude() seems to cause this. I think it goes through the
> exclude patterns, hits "!/bin", believes the patterns do not make
> sense in this context and throws all away.

Yes, I forgot to check the "!" flag to determine if the directory is re=
ally excluded. I'll prepare a patch + test case for this.

@=C3=98ystein: in the meantime, could you check if this fixes the probl=
em for you?

--- 8< ---
diff --git a/dir.c b/dir.c
index a5926fb..13858fe 100644
--- a/dir.c
+++ b/dir.c
@@ -821,6 +821,9 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 				dir->basebuf, stk->baselen - 1,
 				dir->basebuf + current, &dt);
 			dir->basebuf[stk->baselen - 1] =3D '/';
+			if (dir->exclude &&
+			    dir->exclude->flags & EXC_FLAG_NEGATIVE)
+				dir->exclude =3D NULL;
 			if (dir->exclude) {
 				dir->basebuf[stk->baselen] =3D 0;
 				dir->exclude_stack =3D stk;
--=20
