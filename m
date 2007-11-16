From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN cc.
Date: Thu, 15 Nov 2007 20:58:55 -0800
Message-ID: <7vd4ua3hww.fsf@gitster.siamese.dyndns.org>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
	<1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, raa.lkml@gmail.com, git@ostkamp.fastmail.fm,
	git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 05:59:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IstIi-0003jX-FA
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 05:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbXKPE7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 23:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbXKPE7M
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 23:59:12 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44996 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbXKPE7K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 23:59:10 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 403D82EF;
	Thu, 15 Nov 2007 23:59:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 688BB9620C;
	Thu, 15 Nov 2007 23:59:25 -0500 (EST)
In-Reply-To: <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
 (=?utf-8?Q?Bj=C3=B6rn?=
	Steinbrink's message of "Thu, 15 Nov 2007 02:15:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65188>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Guido, could you please test this patch?
>
> I have no clue which versions of SUN's cc are affected, so I simply e=
nabled
> the workaround for all versions. Someone with more knowledge about th=
at
> should probably limit the check to only do that for the broken versio=
ns.
>
>  git-compat-util.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

> diff --git a/git-compat-util.h b/git-compat-util.h
> index ede9408..c3ff4b4 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -6,6 +6,8 @@
>  #ifndef FLEX_ARRAY
>  #if defined(__GNUC__) && (__GNUC__ < 3)
>  #define FLEX_ARRAY 0
> +#elif defined(sun) || defined(__SUN__)
> +#define FLEX_ARRAY 1
>  #else
>  #define FLEX_ARRAY /* empty */
>  #endif

This feels a bit too narrow and too broad at the same time,
doesn't it?

As I suspect there are other compilers that do not implement
flexible array members (so you cannot use "member[]") nor older
gcc extension of zero sized member (so you cannot use
"member[0]" either), this checking specifically for Sun is too
narrow.

On the other hand, as you said, this is too broad, because not
everybody may be using the SUN compiler on Sun, nor the version
that does not understand flexible array members.

But being broad should always be safer, albeit a bit wasteful.

How about doing it this way?

  # ifndef FLEX_ARRAY
  #   if defined(__GNUC__)
  #     if (__GNUC__ < 3)
  #       define FLEX_ARRAY 0
  #     else
  #       define FLEX_ARRAY /* empty */
  #     endif
  #   else
        /* more cases we know we can use 0 or empty can come here */
  #   endif
  # endif

  /* if still undefined, default to the safe, old fashioned way */
  # ifndef FLEX_ARRAY
  #   define FLEX_ARRAY 1
  # endif

The basic idea is:

 * The user (from Makefile command line, config.mak, or you
   could add autoconf test) can pass -DFLEX_ARRAY=3D... to specify
   exactly what should happen;

 * Otherwise, if we happen to know for sure that we can use "0"
   or "/* empty */" with the compiler, we define FLEX_ARRAY;
   currently we know such things for gcc.

 * For everybody else, we use safer default of "1".  IOW, if you
   know your compiler does not grok "/* empty */" nor "0", you
   do not have to do anything special but use the default case
   as everybody else.
