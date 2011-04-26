From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] strbuf: allocate enough space when strbuf_setlen() is
 called first time
Date: Tue, 26 Apr 2011 22:09:33 +0700
Message-ID: <20110426150933.GA29121@do>
References: <1303820660-744-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 17:12:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEjwG-0001Ju-UI
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 17:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902Ab1DZPM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 11:12:27 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60132 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756885Ab1DZPM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 11:12:26 -0400
Received: by pvg12 with SMTP id 12so478501pvg.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2s/0n1ZYHuiQevPN2X9mIirC39UWb2CMeZbZkpdWha4=;
        b=s4XsNRGInZyTFClrLcWs9H/cQ9t87QArfzaY+rF7f4ci1fYABxkzcq31mg97AGvo82
         qJgv7M0EjtGZal8f7U8D02nK95f7D+EzN1AzKtWwgoGVLk9GaIEErTRHsAxa7UgcPBoe
         JiKcMunJip2U+Df5GXK2F8g9gMPzQh83NoirQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=F3fdHoz2iY0FyIl319G0qyn4tPrxpEacJGE3FR9pE5E+OQCBMlpeV/8Tfe6KlU3vnV
         bsgtrONUymTEyJH4VwkDUFysrV1NeOjn+0xzdng+YbZWOGrCS/o8/PvHJyXnKXf5nkK1
         4nf7owybj5+0X9xvWTjfG77X9Y2OSQ3et4RwM=
Received: by 10.68.28.132 with SMTP id b4mr1088831pbh.433.1303830745975;
        Tue, 26 Apr 2011 08:12:25 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.248.91])
        by mx.google.com with ESMTPS id b4sm2149587pbo.80.2011.04.26.08.12.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 08:12:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 26 Apr 2011 22:09:34 +0700
Content-Disposition: inline
In-Reply-To: <1303820660-744-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172097>

On Tue, Apr 26, 2011 at 07:24:20PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>  static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
>  	if (!sb->alloc)
> -		strbuf_grow(sb, 0);
> +		strbuf_grow(sb, len);
>  	assert(len < sb->alloc);
>  	sb->len =3D len;
>  	sb->buf[len] =3D '\0';

This should be better. But I fail to see why it corrupts memory :(

@@ -33,9 +33,8 @@ static inline size_t strbuf_avail(const struct strbuf=
 *sb) {
 extern void strbuf_grow(struct strbuf *, size_t);
=20
 static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
-	if (!sb->alloc)
-		strbuf_grow(sb, 0);
-	assert(len < sb->alloc);
+	if (sb->alloc < len + 1)
+		strbuf_grow(sb, len - sb->alloc);
 	sb->len =3D len;
 	sb->buf[len] =3D '\0';
 }

--=20
Duy
