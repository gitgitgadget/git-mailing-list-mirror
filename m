X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
From: Bennett Todd <bet@rahul.net>
Subject: static linking lib order problem
Date: Mon, 20 Nov 2006 17:32:25 +0000
Message-ID: <20061120173225.GA16161@rahul.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
NNTP-Posting-Date: Mon, 20 Nov 2006 17:33:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31925>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmD0w-0006We-KT for gcvg-git@gmane.org; Mon, 20 Nov
 2006 18:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966259AbWKTRci (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 12:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966261AbWKTRci
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 12:32:38 -0500
Received: from og.latency.net ([64.21.79.2]:37639 "EHLO og.latency.net") by
 vger.kernel.org with ESMTP id S966259AbWKTRch (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 12:32:37 -0500
Received: by og.latency.net (Postfix, from userid 1053) id 176F613FB2E; Mon,
 20 Nov 2006 12:32:37 -0500 (EST)
Received: from pic.bent.dom (localhost [127.0.0.1]) by og.latency.net
 (Postfix) with ESMTP id F3B7313FB69 for <git@vger.kernel.org>; Mon, 20 Nov
 2006 12:32:32 -0500 (EST)
Received: (from bet@localhost, uid 500) by pic.bent.dom (femail 0.97) 20 Nov
 2006 17:32:26 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I build git for Bent Linux, with

	make prefix=/usr NEEDS_LIBICONV=YesPlease

It develops compile and link lines that look like:

gcc -g -O2 -Wall  -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY -o git-http-fetch   fetch.o http.o http-fetch.o \
                libgit.a xdiff/lib.a -lz  -liconv  -lcrypto -lcurl -lexpat

which produce vast numbers of errors, which look like

/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.1/../../../libcurl.a(ssluse.o)(.text.rand_enough+0x4): In function `rand_enough':
: undefined reference to `RAND_status'
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.1/../../../libcurl.a(ssluse.o)(.text.ossl_seed+0x2b): In function `ossl_seed':
: undefined reference to `RAND_load_file'
[...]
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.1/../../../libcurl.a(http_ntlm.o)(.text.Curl_output_ntlm+0x370): In function `Curl_output_ntlm':
: undefined reference to `MD5_Update'
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.1/../../../libcurl.a(http_ntlm.o)(.text.Curl_output_ntlm+0x37d): In function `Curl_output_ntlm':
: undefined reference to `MD5_Final'
collect2: ld returned 1 exit status
make: *** [git-http-fetch] Error 1

I've been kludging around it with this patch:

diff -ru git-1.4.4.orig/Makefile git-1.4.4/Makefile
--- git-1.4.4.orig/Makefile	2006-11-15 07:22:27.000000000 +0000
+++ git-1.4.4/Makefile	2006-11-15 20:49:26.000000000 +0000
@@ -439,7 +439,7 @@
 		BASIC_CFLAGS += -I$(CURLDIR)/include
 		CURL_LIBCURL = -L$(CURLDIR)/lib -R$(CURLDIR)/lib -lcurl
 	else
-		CURL_LIBCURL = -lcurl
+		CURL_LIBCURL = -lcurl -lssl -lcrypto
 	endif
 	PROGRAMS += git-http-fetch$X
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)

just because I didn't take the time to understand the git build
process's library conf system.

-Bennett

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFYeapHZWg9mCTffwRAlgwAJ49jD1bmJyKqffOObvDYg0e1hnkLACfV68w
D9AKge2mYnHp/uynRnqFMXE=
=kvpj
-----END PGP SIGNATURE-----

