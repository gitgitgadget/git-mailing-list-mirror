From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] strbuf: add strbuf_add_cwd()
Date: Sun, 20 Jul 2014 19:33:54 +0700
Message-ID: <CACsJy8BHJ8UFbnEn6C7FiA2SNvL5hZSZg5iDd6CQPDxt+bUJHQ@mail.gmail.com>
References: <53CBA59C.8050901@web.de> <53CBA62A.5010800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8qJy-00024J-KU
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 14:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbaGTMe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 08:34:27 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:34545 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaGTMe0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jul 2014 08:34:26 -0400
Received: by mail-qa0-f44.google.com with SMTP id f12so4368571qad.31
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CdAv1Z5xJ39cC0dNUTq7KzCA9w1dNpRKkNJZJwWEzbQ=;
        b=sGPDaOvaHVR8KnLDm36ymjMBj64NfgB1fqmLHKOA8yVPNucKnckgXR6eH2UQwSc2y2
         ZAmfnQe7Mt1BLBBg3C12ZLiRH70EXIeIYhoe9P6rbZWDCXBYdbQJGN8CiJyk5L6vP6BQ
         JBMgRYpODswye0c1zlqP/FmPsKxGYciPkaNGXzAyRKaOYQFst31dScxXEJukppCfnipR
         f3AcciwfTDyHgcsuG0/pSrDyr+G6+DyMxXkOnCa8P541yQa/24oexaBloafF/zePEcl+
         gpCcPMdtX+wUGHhOqlM4JqlFmXXMkb2IbGw6EbDr15t12AjrtAp0LNm4ZzxhIMwOjHGc
         ctZA==
X-Received: by 10.224.122.83 with SMTP id k19mr30205781qar.78.1405859664969;
 Sun, 20 Jul 2014 05:34:24 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sun, 20 Jul 2014 05:33:54 -0700 (PDT)
In-Reply-To: <53CBA62A.5010800@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253921>

On Sun, Jul 20, 2014 at 6:21 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> +int strbuf_add_cwd(struct strbuf *sb)
> +{
> +       size_t oldalloc =3D sb->alloc;
> +       size_t guessed_len =3D 32;

=46or Linux, I think this is enough to succesfully get cwd in the first
pass. Windows' $HOME is usually deep in C:\Users\Blahblah. Maybe
increase this to 128? And we probably want to keep the guessed value,
so if the first strbuf_add_cwd needs a few rounds to get cwd, the next
strbuf_add_cwd() call does not.

> +
> +       for (;; guessed_len *=3D 2) {
> +               char *cwd;
> +
> +               strbuf_grow(sb, guessed_len);
> +               cwd =3D getcwd(sb->buf + sb->len, sb->alloc - sb->len=
);
> +               if (cwd) {
> +                       strbuf_setlen(sb, sb->len + strlen(cwd));
> +                       return 0;
> +               }
> +               if (errno !=3D ERANGE)
> +                       break;
> +       }
> +       if (oldalloc =3D=3D 0)
> +               strbuf_release(sb);
> +       return -1;
> +}

The loop and the following strbuf_release() are correct. But I wonder
if it's easier to read if you save getcwd in a separate/local strbuf
variable and only concat it to "sb" when you successfully get cwd..
--=20
Duy
