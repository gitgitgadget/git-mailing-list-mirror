From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [cgit PATCH] Close file descriptor on error in readfile()
Date: Sat, 7 Nov 2009 15:59:00 +0100
Message-ID: <8c5c35580911070659h35c44421q713ddba97318e2b8@mail.gmail.com>
References: <4AF4D4EC.1040806@pixeltards.com> <4AF566C9.5090106@pixeltards.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, steven@uplinklabs.net
To: Rys Sommefeldt <rys@pixeltards.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 15:59:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6mkw-0003Es-NH
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 15:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbZKGO64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 09:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbZKGO6z
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 09:58:55 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45257 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbZKGO6z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2009 09:58:55 -0500
Received: by yxe17 with SMTP id 17so1611589yxe.33
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 06:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8X2Yk6vCQH1sELwbVq5W9KPZdOGzYhObsxLpLLP80b0=;
        b=mq0FBHPyXKhpw/D4gZGv9yW8PVGyYruLKfOHV9Uno69PScsPnkxFGpmFz3h09aa2Nc
         nPSK3QdUoOQmxXWGpJu045wIrNQyKjczzo+9Xmgvr9Zzf6RnmqBi6vlDn5ePUVVP7282
         64dNfk/O022cCc3jiXswClExcyO9f2TNwLawo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GTiLjf2AOg7ylX+DaZfUBxMBzoMrISB/+keFNHvic637jcSpf4DYH/P94ayH8dRDxP
         JGilGcpIQVD0tpRXGvIE2WB1FhdmvRyqPvld76HIa+0gSbnyiigtJj9cCpI1OcU57AZg
         8gV4sGS52eDA5y0jzeqrEqFizPviF5Ds3mdvw=
Received: by 10.150.233.2 with SMTP id f2mr9872362ybh.259.1257605940465; Sat, 
	07 Nov 2009 06:59:00 -0800 (PST)
In-Reply-To: <4AF566C9.5090106@pixeltards.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132365>

On Sat, Nov 7, 2009 at 13:23, Rys Sommefeldt <rys@pixeltards.com> wrote=
:
> Sorry for the earlier HTML email, I'd misconfigured my mail client so=
 accept
> my apologies for that (and thanks Steven). =C2=A0Here's the reworked =
patch:

Thanks. I've applied the following to my stable branch:

diff --git a/shared.c b/shared.c
index d7b2d5a..a27ab30 100644
--- a/shared.c
+++ b/shared.c
@@ -406,12 +406,17 @@ int readfile(const char *path, char **buf, size_t=
 *size)
        fd =3D open(path, O_RDONLY);
        if (fd =3D=3D -1)
                return errno;
-       if (fstat(fd, &st))
+       if (fstat(fd, &st)) {
+               close(fd);
                return errno;
-       if (!S_ISREG(st.st_mode))
+       }
+       if (!S_ISREG(st.st_mode)) {
+               close(fd);
                return EISDIR;
+       }
        *buf =3D xmalloc(st.st_size + 1);
        *size =3D read_in_full(fd, *buf, st.st_size);
        (*buf)[*size] =3D '\0';
+       close(fd);
        return (*size =3D=3D st.st_size ? 0 : errno);
 }

--
larsh
