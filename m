From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/7] Add API for string-specific memory pool
Date: Sat, 29 May 2010 06:38:00 -0500
Message-ID: <20100529113800.GA7925@progeny.tock>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
 <1274650832-7411-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 13:37:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIKMH-0006fs-My
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 13:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab0E2Lhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 07:37:36 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43455 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab0E2Lhf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 07:37:35 -0400
Received: by gwaa12 with SMTP id a12so1652706gwa.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 04:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HsLASzF5lhLaDvW1vKsZS1fhqpdI6i8uioCDGJNfp5w=;
        b=srji8yuU2JyskVYw405p653e9FprdjmABb2KGIIVKVcsBFDkE/oHP+6tX58hHSURFZ
         tmSvJ8Oo7oPK0x64rxaIvGaKV5BnxGZkrhfK8hBgVJKzhsRyZx7PdF3AAXuA4zaNHNLM
         /5lpNaH29xv4gB7hlc2x7iCUQohYk/ZfgFdwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Io4rS00Ao1IoJgDOqFsDYxXdZZFgdkpvGpNAkSBawTRD1GPUTrlBzVMDtEBsv+fu94
         Oe/mQEjzBmhucsjwzVEcqoCOMIjcY+RZmElFoiv/XBJXwId7FndVv9JZNt2cIgN3e7nc
         E6ufzdJM1VnKBGBZISrLImYr/A4eruJD+HMFg=
Received: by 10.231.158.131 with SMTP id f3mr2126501ibx.54.1275133054193;
        Sat, 29 May 2010 04:37:34 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm15653859ibg.18.2010.05.29.04.37.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 04:37:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1274650832-7411-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147964>

Ramkumar Ramachandra wrote:

> string_pool uses the macros in the memory pool library to create a
> memory pool for strings and expose an API for handling the
> strings.

This interns strings so they can be compared by address.  Interesting.
The use of offsets instead of pointers here mean it is possible to
back the pool by a file, if I understand correctly.

> Taken directly from David Michael Barr's svn-dump-fast-export
> repository.

Missing From: and sign-off.

[...]
> +static int node_indentity_cmp(node_t *a, node_t *b)
> +{
> +    int r =3D node_value_cmp(a, b);
> +    return r ? r : (((uintptr_t) a) > ((uintptr_t) b))
> +        - (((uintptr_t) a) < ((uintptr_t) b));

nitpick: could use fewer parentheses.

	return r ? r : (((uintptr_t) a > (uintptr_t) b) - ...

Are the casts to uintptr_t necessary?  C99 says, under "Relational
operators", paragraph 5:

  When two pointers are compared, the result depends on the relative
  locations in the address space of the objects pointed to. If two
  pointers to object or incomplete types both point to the same
  object, or both point one past the last element of the same array
  object, they compare equal. If the objects pointed to are members of
  the same aggregate object,
  [etc]

which seems to suggest that no, simple expressions like (a > b) should
be okay, but then it finishes with

  In all other cases, the behavior is undefined.

so I guess it is safer to keep the casts.

> diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
> new file mode 100644
> index 0000000..fb9e6b8
> --- /dev/null
> +++ b/vcs-svn/string_pool.h
> @@ -0,0 +1,11 @@
> +#ifndef STRING_POOL_H_
> +#define	STRING_POOL_H_

style nitpick: should use space instead of tab

> +
> +#include <stdint.h>
> +#include <stdio.h>

Should use "../git-compat-util.h" for portability: unfortunately, some
platforms git supports still don=E2=80=99t have stdint.h iirc.

Except as noted above,

  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the pleasant read.
Jonathan
