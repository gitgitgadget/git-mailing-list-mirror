From: Jed Brown <jed@59a2.org>
Subject: Re: Rationale behind 'extern' on protypes in .h files
Date: Mon, 23 Dec 2013 09:59:25 -0700
Message-ID: <87fvpjqz9u.fsf@jedbrown.org>
References: <CAKTJ_1zecXP03k_2YRnm_26n=anxkG6=k+isZxnnjWgfec70LA@mail.gmail.com> <52B71D24.4000207@googlemail.com> <87eh54spw3.fsf@jedbrown.org> <CAKTJ_1z-pMePmh4phM2TXSMx0kOjGJ0afQ_JRESggi=k6+y-jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
To: Ravi Shekhar Jethani <rsjethani@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 23 17:59:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vv8qv-0005wG-64
	for gcvg-git-2@plane.gmane.org; Mon, 23 Dec 2013 17:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab3LWQ7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Dec 2013 11:59:33 -0500
Received: from jedbrown.org ([198.199.121.66]:60225 "EHLO jedbrown.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757326Ab3LWQ7c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Dec 2013 11:59:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by jedbrown.org (Postfix) with ESMTPSA id 337F180E66;
	Mon, 23 Dec 2013 16:59:30 +0000 (UTC)
In-Reply-To: <CAKTJ_1z-pMePmh4phM2TXSMx0kOjGJ0afQ_JRESggi=k6+y-jA@mail.gmail.com>
User-Agent: Notmuch/0.17~rc2+3~g5fa88cb (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239653>

--=-=-=
Content-Type: text/plain

Ravi Shekhar Jethani <rsjethani@gmail.com> writes:
> To check this I installed the libgit2-dev package which installed:
> /usr/include/git2/*.h , /usr/lib/libgit2.so
> Now, I exported all symbols using:
> $ readelf -s /usr/lib/libgit2.so
> and tried to match these with 'externed' prototypes in the Git source
> directory..no matches.
> I am confused!!!.

libgit2 is an entirely different package from Git.  If you look at the
libgit2 sources (https://github.com/libgit2/libgit2), look in
include/git2/common.h:

/** Declare a public function exported for application use. */
#if __GNUC__ >= 4
# define GIT_EXTERN(type) extern \
                         __attribute__((visibility("default"))) \
                         type
#elif defined(_MSC_VER)
# define GIT_EXTERN(type) __declspec(dllexport) type
#else
# define GIT_EXTERN(type) extern type
#endif


I have always used __attribute__((visibility("default"))), but the gcc
man page says

    extern declarations are not affected by -fvisibility, so a lot of
    code can be recompiled with -fvisibility=hidden with no
    modifications.  However, this means that calls to "extern" functions
    with no explicit visibility use the PLT, so it is more effective to
    use "__attribute ((visibility))" and/or "#pragma GCC visibility" to
    tell the compiler which "extern" declarations should be treated as
    hidden.

However, I don't understand what the first statement means
(documentation bug?) since -fvisibility=hidden causes functions declared
with 'extern' to be hidden.

symbols.c:
EXTERN int foo(void);
int foo(void) {return 1;}

$ gcc -fvisibility=hidden -DEXTERN=extern -shared -o libsymbols.so symbols.c
$ nm -D libsymbols.so | grep foo
$

meanwhile,

$ gcc -fvisibility=hidden -DEXTERN='__attribute((visibility("default")))' -shared -o libsymbols.so symbols.c
$ nm -D libsymbols.so | grep foo
000000000000055c T foo

> Also I checked this:
> $ ldd git
> There is no 'gitish' .so in the output; it seems everything is packed
> inside one executable.
> So your second point 'skipping the PLT...' also doesn't seem to apply here.

My comment applied to shared libraries in general, not specifically to
Git (which isn't a shared library).

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSuGvxAAoJEM+2iNHeMalNM2sP/04z0Mw6ywoamHn8y9v75MbH
3FsPtUcEHio2ddQdKNrIJpO64yuFhM18ZZsFn+dqTSaElJ/hvn85rrxvIQzpDsE9
CwfHgR5MXOl17nB5kYrUIWp4rOM1JZiBJGbgCL92CvKOp3+LpLnw9NG6wPIRHMQv
7eNUpGhPiFyu8oYNNoDFN2/nW1Ta3ojwH7UsY4yms0MNpjf4ZlhWQpcEbEWaO+Ly
rwyDrvo3d6PDoZBSfmOvE8YMcnYrlNKld1oMlBdeUrH+8N+EeQTzM58l1rLd7UD5
hRgMQ0K3GaQ8iVNjxSkhZVueEKESPEOKEdhU/KvO8F3xbDpOZHQV77f5uejUbJcW
cOelfQtKkQR4tARdpHMGGFWabBHn48c0qaWB3aXzxtwhVaxTeeYQ4parFOmefXiL
zur32n9YpaPp1E0uK+bUv5AxAl3QciUPRESidGujmntbznIAwr2DNKbFeFZhQpFt
nIYvB5cEvh34Fd768rKpoR36LGKSfMvuMNwDMu/jmIagVo6GbsVN6hgGdl8G/xZy
+/y+xJi2pfR8TOeTU1lv5M5IaPMLNA1K5j4/t/SGgrIKCweiKF3qrcugILuhQbZG
heH/zC6AtUjKtRVLYsjVJw1f9AXT1KFzFtBybS2SSxXAIOAb28Y9tijEHKkRao/c
9qQbOL9ePAo9yYa71H3s
=l19G
-----END PGP SIGNATURE-----
--=-=-=--
