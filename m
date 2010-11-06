From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/H] Makefile fix for FC13?
Date: Sat, 06 Nov 2010 12:26:10 +0100
Message-ID: <4CD53B52.8050805@drmicha.warpmail.net>
References: <7vr5ezqsv9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 06 12:25:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEgu6-0002bH-IG
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab0KFLZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:25:45 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40266 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751969Ab0KFLZo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 07:25:44 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 497AB54A;
	Sat,  6 Nov 2010 07:25:44 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 06 Nov 2010 07:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=jgRyuWJ1ndhtMCgCz87/IbgfT28=; b=YsXrMErC88svXPDKOmyAM96oUiax4e0nEIlrvMH9/0NhqPAFUO3oM7Gu7FndgpgYEU50bZC47MRxZXFBDOftV6rl51BfEEde3nP9Gpky0+2PYGgNCAY6JWofnIzVK2YqEWhprBTH+uo2MlDZ71r0mOgZLc92Nsi3b2qhG5cA7F0=
X-Sasl-enc: HQGh/RBZJaewfzF34J0w+KYEgfqIrZgTmbjesd3bSk/j 1289042743
Received: from localhost.localdomain (p548596E8.dip0.t-ipconnect.de [84.133.150.232])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6E368404E94;
	Sat,  6 Nov 2010 07:25:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Fedora/3.1.6-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <7vr5ezqsv9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160841>

Junio C Hamano venit, vidit, dixit 05.11.2010 23:59:
> As k.org is migrating to FC13, I'm also adding an FC13 bochs to my
> collection so that I can cut releases for 32-bit i?86 archs.  I noticed
> that the compilation fails with this:
> 
>       LINK git-imap-send
>   /usr/bin/ld: imap-send.o: undefined reference to symbol 'EVP_DecodeBlock'
>   /usr/bin/ld: note: 'EVP_DecodeBlock' is defined in DSO
>   /lib/libcrypto.so.10 so try adding it to the linker command line
> 
> I understand that this is because the linker policy changed in the release
> to make things safer.  My understanding of the rationale for the change
> goes like this:
> 
>   When a binary (e.g. imap-send) wants a symbol X (e.g. EVP_DecodeBlock)
>   from a library A (e.g. -lcrypto), and the binary also wants a different
>   symbol from another library B (e.g. -lssl), and if the library B happens
>   to depend on library A, it used to be sufficient to link the binary with
>   library B, without explicitly linking it with library A, as library A
>   will be pulled in at the runtime because library B wants it anyway.
> 
>   This however would break if library B stops depending on library A
>   (i.e. library B gets updated while remaining compatible with its own
>   older version, but its implementation no longer requries library A).  It
>   is therefore safer to force programs to list their dependencies
>   explicitly at link time.
> 
> So, I need a patch like the following to make things compile on FC13.
> 
> Thoughts?  Ideas for doing this (specifically, "make rpm") in better ways?

I was wondering why I never ran into this on F13 (nor F14). Must have
something to do with "NO_OPENSSL=y" in my config.mak... But I realize
that even with BLK_SHA1 we need openssl for imap+ssl.

I guess this goes to show that a statement like "tested on F13" depends
quite a bit on the config.

The official Fedora packages are built with:

BLK_SHA1 = 1
NEEDS_CRYPTO_WITH_SSL = 1
NO_PYTHON = 1


> On my FC11 bochs and my other Linux boxes, the linker is loose but it does
> not seem to hurt (and I do not think it should, as openssl-dev package
> seems to have almost always shipped with both -lssl and -lcrypto) to add
> this unconditionally.
> 
> diff --git a/Makefile b/Makefile
> index 1f1ce04..18c7e8e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -776,6 +776,7 @@ ifeq ($(uname_S),Linux)
>  	NO_STRLCPY = YesPlease
>  	NO_MKSTEMPS = YesPlease
>  	HAVE_PATHS_H = YesPlease
> +	NEEDS_CRYPTO_WITH_SSL = YesPlease
>  endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>  	NO_STRLCPY = YesPlease
