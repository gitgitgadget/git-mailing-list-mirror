From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] Don't link with libsocket in MINGW port
Date: Wed, 30 May 2007 09:08:59 -0400
Message-ID: <fcaeb9bf0705300608y6ae9eb12i71635746defbec10@mail.gmail.com>
References: <11804928354163-git-send-email-pclouds@gmail.com>
	 <11804928381837-git-send-email-pclouds@gmail.com>
	 <1180492840102-git-send-email-pclouds@gmail.com>
	 <11804928463543-git-send-email-pclouds@gmail.com>
	 <1180492848275-git-send-email-pclouds@gmail.com>
	 <465D6796.27B65043@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed May 30 15:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtNvo-0004Kx-HQ
	for gcvg-git@gmane.org; Wed, 30 May 2007 15:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbXE3NJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 09:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbXE3NJE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 09:09:04 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:63874 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbXE3NJC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 09:09:02 -0400
Received: by an-out-0708.google.com with SMTP id d31so679643and
        for <git@vger.kernel.org>; Wed, 30 May 2007 06:08:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OUW64kDRzjXVJxulCKE8C2FXX1J+pZkitfiaKHUL+Q/Xaep7UDOYXbYEtqfXy9HLq/VrzKbLgkggTwB6G9dio3SkXFd2mPaTtu3Lz4tHeqWROaXaeYe35zNFAf0pzDbn8LVN1q1eZfnuKlLO+2dQl0zDnI3NiME+qcCKtfCXGZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PkxR8wd0ugcqfvyN9Z0baVLl5ZMif2oDDDfjtrGt9dLQ66aj777pSUL0tlYbSGGyI8p1MsIDTe8qrNlHxoz7h8Mnq0CAzc3dDaXfWZeQmW5oh1LcWQgDKtxZSjpwn7UNGa7w4JZ4ZZiHm0PU5HOdtxAEW4UAm6mTVdjLTGe+uQo=
Received: by 10.100.12.18 with SMTP id 18mr5930475anl.1180530539537;
        Wed, 30 May 2007 06:08:59 -0700 (PDT)
Received: by 10.100.127.2 with HTTP; Wed, 30 May 2007 06:08:59 -0700 (PDT)
In-Reply-To: <465D6796.27B65043@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48758>

On 5/30/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> This looks wrong. NEEDS_SOCKET is set in the architecture sections of
> Makefile where necessary, but the MinGW section doesn't want it and
> doesn't set it. If ./configure sets it, then you should fix
> configure.ac, not work around in Makefile.

I did so because I didn't have SunOS to test so I'd rather not touch
the code detecting NEEDS_SOCKET in configure.ac. How about this patch:

diff --git a/configure.ac b/configure.ac
index 4a12cb0..0516fdb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -173,6 +173,12 @@ test -n "$NEEDS_LIBICONV" && LIBS="$LIBS -liconv"
 AC_CHECK_LIB([c], [socket],
 [NEEDS_SOCKET=],
 [NEEDS_SOCKET=YesPlease])
+if test "$NEEDS_SOCKET" = YesPlease; then # more check
+	AC_CHECK_LIB([socket], [socket],
+	[LIBSOCKET_HAS_SOCKET=],
+	[LIBSOCKET_HAS_SOCKET=1])
+	test -n "$LIBSOCKET_HAS_SOCKET" && NEEDS_SOCKET=
+fi
 AC_SUBST(NEEDS_SOCKET)
 test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"

If someone has a SunOS, please test the above patch. Thanks
-- 
Duy
