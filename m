From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] fsck: properly bound "invalid tag name" error message
Date: Mon, 8 Dec 2014 18:28:35 +0700
Message-ID: <20141208112835.GA15919@lanh>
References: <20141208054812.GA30154@peff.net>
 <20141208055706.GA30207@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 12:18:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxwKP-0001ZB-7y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 12:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbaLHLSE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 06:18:04 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:54876 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbaLHLSB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 06:18:01 -0500
Received: by mail-pd0-f171.google.com with SMTP id y13so4992737pdi.16
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 03:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KbgsFq2yIcSJG01bDKKpc172D3iKIq8QuCnlkBIoTx4=;
        b=I2opBhU1OaDDqFvLFEg/5GfESFzjGITQ01KsGRaWzc5PoSe7siG2zlfabd0CW1F6Ew
         /CJLGYG7EF236ka6j3WiGWBRMvjP9Jujd1Y4E65Ght5nDwlqcl+f0BuE37r8AEp/uQ1t
         4bXoinDjoodU+ybRdSTWJlMwE9P/F9IA8+7UC6G+kWeEHd/nQukdN39m0zVW6Hjq9Qw7
         6hWsEoqJATfDWk7wSTW9ZNi/F+i3AtxcbaCc4nB6si4WRItJYs3x0rkb1Z4PquUcc8jM
         MrkEwZeyBJJcMcpzJtXqmO4m7tJ603wMvbYxT8YEcKvVNfEb+KW+qA7yT/7uy2pQiKMr
         o3CA==
X-Received: by 10.68.217.231 with SMTP id pb7mr60166824pbc.124.1418037480843;
        Mon, 08 Dec 2014 03:18:00 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id ca3sm35985926pbb.84.2014.12.08.03.17.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 03:18:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 18:28:35 +0700
Content-Disposition: inline
In-Reply-To: <20141208055706.GA30207@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261009>

On Mon, Dec 08, 2014 at 12:57:06AM -0500, Jeff King wrote:
> I do admit that I am tempted to teach index-pack to always NUL-termin=
ate
> objects in memory that we feed to fsck, just to be on the safe side. =
It
> doesn't cost much, and could prevent a silly mistake (either in the
> future, or one that I missed in my analysis).

I think I'm missing a "but.." here. Maybe "but I didn't have
time". The change looks simple enough. The remaining *alloc in
index-pack is either for arrays, or already NUL-terminated
(patch_delta), or does explicit boundary check (compare_objects).

It may be interesting to go over `git grep alloc\(` and see if we
should use the allocz version instead. I think in some place we do
xmalloc(len + 1) which could be replaced with xmallocz(len)

-- 8< --
Subject: [PATCH] index-pack: terminate object buffers with NUL

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a369f55..4632117 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -447,7 +447,7 @@ static void *unpack_entry_data(unsigned long offset=
, unsigned long size,
 	if (type =3D=3D OBJ_BLOB && size > big_file_threshold)
 		buf =3D fixed_buf;
 	else
-		buf =3D xmalloc(size);
+		buf =3D xmallocz(size);
=20
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
@@ -552,7 +552,7 @@ static void *unpack_data(struct object_entry *obj,
 	git_zstream stream;
 	int status;
=20
-	data =3D xmalloc(consume ? 64*1024 : obj->size);
+	data =3D xmallocz(consume ? 64*1024 : obj->size);
 	inbuf =3D xmalloc((len < 64*1024) ? len : 64*1024);
=20
 	memset(&stream, 0, sizeof(stream));
--=20
2.2.0.60.gb7b3c64

-- 8< --
