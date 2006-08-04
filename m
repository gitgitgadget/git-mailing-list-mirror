From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] autoconf: Fixes and improvements (was: What's in git.git)
Date: Fri, 4 Aug 2006 23:33:18 +0200
Message-ID: <200608042333.19011.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Aug 04 23:41:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97PQ-0005gS-RB
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 23:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161496AbWHDVki convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 Aug 2006 17:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161498AbWHDVki
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 17:40:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:18352 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161496AbWHDVkg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 17:40:36 -0400
Received: by nf-out-0910.google.com with SMTP id k26so30469nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 14:40:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=gMyU6nN5f2+QSyrr/SyUFMi/100+eVUgMSbqtAvGNORw/N/UyhUMngn/eJ0xTS28BEA8qjwow4IjN/8ZPJwKK1aRnS19A6kPANR0LGb3gzn0dVE4oDJXU5sqr9H85uOqnlg115Lk0vuhRrmWec07OguaDMiWVqqCuj9n7kf0cB8=
Received: by 10.49.90.4 with SMTP id s4mr6007728nfl;
        Fri, 04 Aug 2006 14:40:36 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r34sm1038674nfc.2006.08.04.14.40.35;
        Fri, 04 Aug 2006 14:40:35 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24844>

Junio C Hamano wrote:

> (1) configure misdetects NO_OPENSSL. =A0The relevant parts are:
>
> =A0 =A0 =A0 =A0 checking for SHA1_Init in -lssl... no
> =A0 =A0 =A0 =A0 checking for SHA1_INIT in -lcrypto... no
>
> =A0 =A0 but I've been building git on Cygwin without NO_OPENSSL (eh,
> =A0 =A0 that's double negation -- what I mean is I've been building
> =A0 =A0 git with -lssl just fine). =A0I think the function to check i=
n
> =A0 =A0 -lcrypto should be SHA1_Init, not SHA1_INIT (trivial patch
> =A0 =A0 attached at the end).

Should be corrected by patches 1 and 3 by Junio C Hamano.
I had just not understood meaning of NEEDS_SSL_WITH_CRYPTO=20
variable.

> (2) NO_STRLCPY is detected to be available by configure. =A0I
> =A0 =A0 think we should update the default in Makefile.

Not adressed.

> (3) NEEDS_LIBICONV is found to be unnecessary by configure, but
> =A0 =A0 the link fails like this without it:
>
> =A0 =A0 =A0 =A0 builtin-mailinfo.o: In function `convert_to_utf8':
> =A0 =A0 =A0 =A0 /git/builtin-mailinfo.c:539: undefined reference to
> `_libiconv_open' /git/builtin-mailinfo.c:560: undefined reference to
> `_libiconv' /git/builtin-mailinfo.c:561: undefined reference to
> `_libiconv_close' collect2: ld returned 1 exit status

Check if patch 2 corrects this error. Patch 5 does the same as patch 2=20
for NEEDS_SOCKET due to cleanup during making this change.

> (4) NO_IPV6 is not detected yet -- you should be able to detect
> =A0 =A0 this by checking for "struct addrinfo". =A0The compilation
> =A0 =A0 fails like this on Cygwin:
>
> =A0 =A0 =A0 =A0 connect.c: In function `git_tcp_connect_sock':
> =A0 =A0 =A0 =A0 connect.c:361: error: storage size of 'hints' isn't k=
nown

Patch 4 adresses this. Perhas one of the checks can be dropped (leaving=
=20
easier or faster one).

> (Z) When configure detects some NO_XXX is unneeded, currently
> =A0 =A0 there is no way for generated config.mak.autogen to override
> =A0 =A0 the default set in Makefile. =A0For example, NO_STRLCPY is se=
t
> =A0 =A0 by Makefile, and the included config.mak.autogen does not
> =A0 =A0 say anything about it even though it knows strlcpy is
> =A0 =A0 usable. =A0It might be better to explicitly undef unneeded
> =A0 =A0 NO_XXX in config.mak.autogen?

Patch 5 tries to address this. Additionally it can be easily seen what=20
was detested... but it is somewhat harder to see which variables are=20
set among unset ones.

--=20
Jakub Narebski
Poland
