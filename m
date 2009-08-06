From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/7] block-sha1: try to use rol/ror appropriately
Date: Thu, 6 Aug 2009 20:25:35 +0200
Message-ID: <36ca99e90908061125w71c0294wd4c896dc5fb812fc@mail.gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain>
	 <alpine.LFD.2.01.0908060814050.3390@localhost.localdomain>
	 <alpine.LFD.2.01.0908060815430.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 20:25:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ7es-0005RP-6n
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 20:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbZHFSZh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 14:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbZHFSZh
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 14:25:37 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:46546 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbZHFSZg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 14:25:36 -0400
Received: by bwz9 with SMTP id 9so940939bwz.41
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=24YNb454tx7bwGaHMWe64iX+d+Z7SA9Eq96IcN9wrN8=;
        b=A3/Mx2NS7ZE1wHw6zT1dpZGAYSOg1csedkL7j8UFyOxU5rGT2u8VpTq9d4VQLgyEe0
         mRasbQVri6UMgYqnk2oGqigwqcAlHJBTerdwCnyplYup299yyli0PaexwMSgKs3a4Gkg
         HqkPNU4KVpL3rNyRtAO022JTxdF2ysbB6cfYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tw9FH5NyYTAsIf6j5xZedNWpBYFRTV8nLJqfj69r3r2LepgSOOWPAmAzFjZn8g88uI
         n5ckMO4m5DMl7h+h64PlXPeOR0Lxao02sIzPNRI1IrPy9LvvUE9MhKMBcP99i78FCcuX
         4+uUhNMEy2h0ttgLF/vGn8fEGcqqfAxLj3A5E=
Received: by 10.223.115.201 with SMTP id j9mr61324faq.86.1249583135494; Thu, 
	06 Aug 2009 11:25:35 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0908060815430.3390@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125102>

Hi,

On Thu, Aug 6, 2009 at 17:16, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index eef32f7..a45a3de 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -80,7 +80,19 @@ void blk_SHA1_Final(unsigned char hashout[20], blk=
_SHA_CTX *ctx)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((unsigned int=
 *)hashout)[i] =3D htonl(ctx->H[i]);
> =C2=A0}
>
> -#define SHA_ROT(X,n) (((X) << (n)) | ((X) >> (32-(n))))
> +#if defined(__i386__) || defined(__x86_64__)
> +
> +#define SHA_ASM(op, x, n) ({ unsigned int __res; asm(op " %1,%0":"=3D=
r" (__res):"i" (n), "0" (x)); __res; })
> +#define SHA_ROL(x,n) =C2=A0 SHA_ASM("rol", x, n)
> +#define SHA_ROR(x,n) =C2=A0 SHA_ASM("ror", x, n)
> +
> +#else
> +
> +#define SHA_ROT(X,n) =C2=A0 (((X) << (l)) | ((X) >> (r)))
I suspect, this should be:
#define SHA_ROT(X,l.r)   (((X) << (l)) | ((X) >> (r)))

> +#define SHA_ROL(X,n) =C2=A0 SHA_ROT(X,n,32-(n))
> +#define SHA_ROR(X,n) =C2=A0 SHA_ROT(X,32-(n),n)
> +
> +#endif
>
> =C2=A0static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int =
*data)
> =C2=A0{

Bert
