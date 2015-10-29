From: Filipe Cabecinhas <filcab@gmail.com>
Subject: Re: git fsck failure on OS X with files >= 4 GiB
Date: Wed, 28 Oct 2015 23:46:38 -0700
Message-ID: <CAEDE853qg_J_asKf4SsE7mB8L7E0Tb3ReJnNWDfAfXfPw+tjhQ@mail.gmail.com>
References: <CAG3jReJn2Pz6-bXLw6baOZaE1BHYiC+1-zN0eagigfG3umWpJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Rafael_Esp=C3=ADndola?= <rafael.espindola@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:46:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zrgyy-000253-7j
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 07:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681AbbJ2Gqk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2015 02:46:40 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37019 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244AbbJ2Gqk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2015 02:46:40 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Oct 2015 02:46:39 EDT
Received: by wmff134 with SMTP id f134so18950900wmf.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=i+hwMD8cYfMi4+wnzSBacb594rjOrlnNTYXfS7KYUak=;
        b=twTAA9XOyONPTJfyJsUHtzQhcUHZdwx0dOOa36hpGXGRMlz/pp2M+yr16C9AddotGA
         0/QrmopTBgtdlg0nWUQlZiIBw8UKzsWSKwnulJ2fKCH8zE6FS+Q0/M4iepIyKtptCAKL
         +d7r/ivSjYlRt2DBN0BiS8Asa0YaaOJBH4usjkr9R2gN6RJNgPp6jRE2XXqMgjFs77V5
         VF99ktqBH7mKDRsxXM79+AB0RsrxXCRvhRw1GgaILnwpX9B3LyOYw7fdSH4ry9Ox4h0+
         38MFAbalcKIwmw7PzdLCVzekS+/4o0Yu8PT0EkhEuDSXJ8/5Fc18JTgXg4Kdj8rc322n
         ac9Q==
X-Received: by 10.28.135.67 with SMTP id j64mr1729152wmd.93.1446101198782;
 Wed, 28 Oct 2015 23:46:38 -0700 (PDT)
Received: by 10.194.59.10 with HTTP; Wed, 28 Oct 2015 23:46:38 -0700 (PDT)
In-Reply-To: <CAG3jReJn2Pz6-bXLw6baOZaE1BHYiC+1-zN0eagigfG3umWpJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280435>

I did some debugging, and it seems CC_SHA1_Update (used by
write_sha1_file_prepare if APPLE_COMMON_CRYPTO is defined in the
Makefile) takes a uint32_t as a "length" parameter, which explains why
it stops working at 4GiB (UINT_MAX+1).

In the OS X 10.11 SDK header CommonCrypto/CommonDigest.h, we have:

typedef uint32_t CC_LONG;       /* 32 bit unsigned integer */
//...
extern int CC_SHA1_Update(CC_SHA1_CTX *c, const void *data, CC_LONG len=
)

A possible fix would be to either call SHA1_Update with a maximum of
UINT_MAX, looping if necessary. Or have a compatibility SHA1_Update
for OS X which can handle data longer than UINT_MAX.

I'm not sure what the git maintainers would prefer.

Regards,

  Filipe


On Wed, Oct 28, 2015 at 4:10 PM, Rafael Esp=C3=ADndola
<rafael.espindola@gmail.com> wrote:
>
> I first noticed this with "2.4.9 (Apple Git-60)", but it reproduces
> with git built from 37023ba381b6d251d7140a997b39b566dbc63c42.
>
> Create two files with just 0s:
>
> -rw-r--r--  1 espindola  staff  4294967296 28 Oct 11:09 exactly-4gib
> -rw-r--r--  1 espindola  staff  4294967295 28 Oct 11:09 one-less-than=
-4gib
>
>
> and run
>
> git init
> git add one-less-than-4gib
> git commit -m bar
> git fsck
> git add exactly-4gib
> git commit -m bar
> git fsck
>
> The first fsck will run with no problems, but the second one fails:
>
> error: packed cfdaf54c9ccfd8f5e4cee562f7d5f92df13d3106 from
> .git/objects/pack/pack-ff08480fd7f767b6bd0aeb559f0f5dea2245b0b3.pack
> is corrupt
>
> Using the very same revision on freebsd doesn't cause any errors.
>
> Cheers,
> Rafael
