From: Michael Cox <mhcox@bluezoosoftware.com>
Subject: Error running/configuring git 1.7.1
Date: Tue, 29 Jun 2010 16:03:50 -0600
Message-ID: <AANLkTimh62uVah77CE9XwHKwhuT4lOUxgRjFWXGuaS1B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 00:04:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTius-0005J2-79
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 00:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013Ab0F2WEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 18:04:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57365 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243Ab0F2WEL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 18:04:11 -0400
Received: by vws5 with SMTP id 5so124485vws.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 15:04:10 -0700 (PDT)
Received: by 10.220.95.199 with SMTP id e7mr4214324vcn.138.1277849050796; Tue, 
	29 Jun 2010 15:04:10 -0700 (PDT)
Received: by 10.220.186.141 with HTTP; Tue, 29 Jun 2010 15:03:50 -0700 (PDT)
X-Originating-IP: [199.64.0.252]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149928>

I downloaded the latest tarball (git-1.7.1) and tried to install it on
Redhat Linux Server release 5.3 (Tikanga) using:

./configure --prefix=$HOME/tool-1.1 --with-curl -with-expat -with-openssl
make
make install

When I try to run

git clone http://www.kernel.org/pub/scm/git/git.git

I get the error message:

fatal: Unable to find remote helper for 'http'

I looked at the config.log file and found the following anomaly:

configure:3165: checking for curl_global_init in -lcurl
configure:3195: cc -o conftest -g -O2   conftest.c -lcurl   >&5
/usr/lib/gcc/i386-redhat-linux/4.1.2/../../../libcurl.so: undefined reference to
 `tld_strerror'
/usr/lib/gcc/i386-redhat-linux/4.1.2/../../../libcurl.so: undefined reference to
 `idna_strerror'
collect2: ld returned 1 exit status
configure:3201: $? = 1
configure: failed program was:
| /* confdefs.h.  */
|
| #define PACKAGE_NAME "git"
| #define PACKAGE_TARNAME "git"
| #define PACKAGE_VERSION "1.7.1"
| #define PACKAGE_STRING "git 1.7.1"
| #define PACKAGE_BUGREPORT "git@vger.kernel.org"
| /* end confdefs.h.  */
|
| /* Override any gcc2 internal prototype to avoid an error.  */
| #ifdef __cplusplus
| extern "C"
| #endif
| /* We use char because int might match the return type of a gcc2
|    builtin and then its argument prototype would still apply.  */
| char curl_global_init ();
| int
| main ()
| {
| curl_global_init ();
|   ;
|   return 0;
| }
configure:3227: result: no

Googling for  tld_strerror and idna_strerror, I found that a library,
libidna contains idna_strerror.  When I run

curl-config --libs

I get

-L/usr/kerberos/lib -lcurl -lgssapi_krb5 -lkrb5 -lk5crypto -lcom_err
-lresolv -ldl -lidn -lssl -lcrypto -lz

So it looks like the configure test should (at least) add -lidna.

I did a "make clean" and re-ran the build using:

LDFLAGS="-lidn -lssl -lcrypto -lz" ./configure --prefix=$HOME/tool-1.1
--with-curl -with-expat -with-openssl
make
make install

Running "git clone http://www.kernel.org/pub/scm/git/git.git" works now.


Michael

P.S.  The same problem occurs on 1.7.0.6.
