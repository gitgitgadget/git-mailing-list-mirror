From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Wed, 02 Jan 2008 17:59:06 +0100
Message-ID: <477BC2DA.6000105@lsrfire.ath.cx>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com> <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 02 18:00:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA6wo-00080Z-1n
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 18:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbYABQ7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 11:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754240AbYABQ7b
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 11:59:31 -0500
Received: from india601.server4you.de ([85.25.151.105]:51834 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbYABQ7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 11:59:31 -0500
Received: from [10.0.1.201] (p57B7F044.dip.t-dialin.net [87.183.240.68])
	by india601.server4you.de (Postfix) with ESMTP id B8EE82F8037;
	Wed,  2 Jan 2008 17:59:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69477>

Johannes Schindelin schrieb:
> Certain codepaths (notably "git log --pretty=3Dformat...") use
> prefixcmp() extensively, with very short prefixes.  In those cases,
> calling strlen() is a wasteful operation, so avoid it.

>  static inline int prefixcmp(const char *str, const char *prefix)
>  {
> -	return strncmp(str, prefix, strlen(prefix));
> +	for (; ; str++, prefix++)
> +		if (!*prefix)
> +			return 0;
> +		else if (*str !=3D *prefix)
> +			return (unsigned char)*prefix - (unsigned char)*str;
>  }
> =20
>  static inline int strtoul_ui(char const *s, int base, unsigned int *=
result)

prefixcmp() was already optimized before -- only for a different use
case.  At a number of callsites the prefix is a string literal, which
allowed the compiler to perform the strlen() call at compile time.

The patch increases the text size considerably: the file "git" is
2,620,938 without and 2,640,450 with the patch in my build (there are
136 callsites in builtin*.c).  The new version of prefixcmp() shouldn't
be inlined any more, as the benefit of doing so is gone.

Is there a portable way to let the preprocessor decide if
prefixcmp_literal() or prefixcmp_generic() is to be used, depending on
the prefix being a string literal or not?

Ren=E9
