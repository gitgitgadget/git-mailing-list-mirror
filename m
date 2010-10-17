From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge-file: correctly find files when called in subdir
Date: Sat, 16 Oct 2010 20:11:11 -0500
Message-ID: <20101017011111.GA26656@burratino>
References: <33ab2f03ed522e1a9be202017b7bbfe35e6d7a99.1287228637.git.trast@student.ethz.ch>
 <AANLkTimzuF3Ku_Jjnq0qKFtrDfAfz8YxChomZr8+Shm1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 03:15:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Hpw-0006dw-VI
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 03:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158Ab0JQBOv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Oct 2010 21:14:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37167 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757115Ab0JQBOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 21:14:51 -0400
Received: by gyg13 with SMTP id 13so448875gyg.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 18:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=X71RKAFVTDyMxWcLfOURYE/KqkuWZpPhnONmDFg/LdY=;
        b=mBohbEJRTuwqC2WZSP/dWmLk3xmgIGnL9DKyWQ5B3Omo33qcBqu1v1HYddVUdDZPkG
         VQ/cU2R3rp8Rb2E6Nhv0mSnz/OOpiyogn7mIfr0QpfkR1e5TUvvV0/FbJrAiPDwR06Pc
         F04mO/gUCOiwgjaIcbVGVFqZC4hgZrMoWTKjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=j9RkU4BzwaJ+FFY9sZ42voO0DcTR/rdqZAw8drw6LnRLmaoOvBnuKJZlmGofft/EwQ
         /hqjwIvERSXOWT/pdNwcoVasSnPQciUKRKmapqxxrRTsn4Z81IFqvzBQHGK0OvVK89zH
         jlYtZqFjZsFi+6GAZOJyoUNS6AEUcGWVG2lmw=
Received: by 10.236.108.175 with SMTP id q35mr3688879yhg.55.1287278085462;
        Sat, 16 Oct 2010 18:14:45 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id n67sm9862727yha.23.2010.10.16.18.14.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 18:14:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimzuF3Ku_Jjnq0qKFtrDfAfz8YxChomZr8+Shm1@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159183>

Bert Wesarg wrote:
> On Sat, Oct 16, 2010 at 13:33, Thomas Rast <trast@student.ethz.ch> wr=
ote:

>> --- a/builtin/merge-file.c
>> +++ b/builtin/merge-file.c
>> @@ -65,10 +66,18 @@ int cmd_merge_file(int argc, const char **argv, =
const char *prefix)
[...]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prefix)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 name =3D prefix_filename(prefix, prefixlen, argv[i]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 name =3D argv[i];
>
> I think you can safe this condition, if you set prefixlen to 0.

I'm not so sure.  On Windows, prefix_filename() starts with

	char *p;
	/* don't add prefix to absolute paths, but still replace '\' by '/' */
	if (is_absolute_path(arg))
		pfx_len =3D 0;
	else
		memcpy(path, pfx, pfx_len);

and memcpy() has undefined behavior when pfx is NULL (even with
pfx_len of 0; see WG14/N1256: 7.21.1 "String function conventions").
Even if the win32api memcpy does the right thing with NULL pfx, I
cannot trust GCC when they are given that kind of license. :)
