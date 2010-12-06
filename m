From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] imap-send: link against libcrypto for HMAC and others
Date: Mon, 06 Dec 2010 00:28:24 -0500
Message-ID: <1291613304.3339.12.camel@fixed-disk>
References: <7vwro2sd83.fsf@alter.siamese.dyndns.org>
	 <1290629033-20566-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Diego Elio =?ISO-8859-1?Q?Petten=F2?= <flameeyes@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 06:34:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPTiy-0007kC-PQ
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 06:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854Ab0LFFev convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 00:34:51 -0500
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:59831 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750733Ab0LFFeu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 00:34:50 -0500
X-AuditID: 12074424-b7b0bae000000a05-40-4cfc75f99758
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id 14.09.02565.9F57CFC4; Mon,  6 Dec 2010 00:34:49 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id oB65YmlC016199;
	Mon, 6 Dec 2010 00:34:49 -0500
Received: from [18.111.114.115] ([18.111.114.115])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oB65Yk2I014777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 Dec 2010 00:34:47 -0500 (EST)
In-Reply-To: <1290629033-20566-1-git-send-email-flameeyes@gmail.com>
X-Mailer: Evolution 2.32.1 
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162973>

On Wed, 2010-11-24 at 21:03 +0100, Diego Elio Petten=C3=B2 wrote:
> When using stricter linkers, such as GNU gold or Darwin ld, transitiv=
e
> dependencies are not counted towards symbol resolution. If we don't
> link imap-send to libcrypto, we'll have undefined references to the
> HMAC_*, EVP_* and ERR_* functions families.
> [=E2=80=A6]
>  git-imap-send$X: imap-send.o $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,=
$^) \
> -		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
> +		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)

This broke the build with NO_OPENSSL=3D1, so Debian will need to revert
it:

    CC imap-send.o
    LINK git-imap-send
/usr/bin/ld: cannot find -lcrypto
collect2: ld returned 1 exit status
make[1]: *** [git-imap-send] Error 1

Also, the Makefile already has a NEEDS_CRYPTO_WITH_SSL flag that=E2=80=99=
s
automatically set on Darwin, Windows, and MinGW.  We shouldn=E2=80=99t =
have two
mechanisms for addressing the same problem; maybe we just need to enabl=
e
the existing flag on more (or all) platforms?

Anders
