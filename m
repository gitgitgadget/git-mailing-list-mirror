From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] t1304: improve setfacl prerequisite setup
Date: Wed, 6 Jun 2012 18:11:06 +0200
Message-ID: <CALbm-EZJeNCts80sA6cxGHgGLUhAHREWRd7pUqZ0nUo22ixu0Q@mail.gmail.com>
References: <vpq4nqqj8ss.fsf@bauges.imag.fr>
	<CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
	<vpqk3zlhorc.fsf@bauges.imag.fr>
	<20120605140449.GA15640@sigill.intra.peff.net>
	<20120605141039.GB15640@sigill.intra.peff.net>
	<20120605142813.GA17238@sigill.intra.peff.net>
	<20120605150550.GA19843@sigill.intra.peff.net>
	<7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
	<20120605164439.GA2694@sigill.intra.peff.net>
	<7v62b5pt2s.fsf@alter.siamese.dyndns.org>
	<20120606132824.GA2597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 18:11:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScIpG-00055P-76
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 18:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222Ab2FFQLJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 12:11:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62114 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795Ab2FFQLH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jun 2012 12:11:07 -0400
Received: by yhmm54 with SMTP id m54so4996980yhm.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=toYCHiK68Tv0QeGzz3B6aANtLVKwBT7Ic+C9oAp1toc=;
        b=UetBP8j0uAM7OM3cCjv5Zqo1CX6Rhj9B74t0KsJTQO37JPIfotII5mDGLV90M3M6Z6
         kqGngIOs8Rivu7XUQOEU540jmmQjqpgtQ+n6Y7T+2ZgFR2XyXcqsGle+5vx255mnG/Qo
         cHxGpW+7CaN1C/SEDLeCmR0Yg0hVAbmB1fEHmtIkFlCk5S74lLOWbM0X+cFUwqfXj14L
         mt3Kueti4oGmRioIQrEZ3OmrAAZHo7w2JsLH4hp7TD6pV1Aa0Su+/BPy6s7QTzX8/qe6
         9DuWadOccJ0UIGEoWKWT5wKuNMaHu+stEbWyvPFnoZ2+XnftRU8Mo3Gj20VsZPdN9M33
         GlBA==
Received: by 10.236.78.195 with SMTP id g43mr1376026yhe.62.1338999066888; Wed,
 06 Jun 2012 09:11:06 -0700 (PDT)
Received: by 10.236.185.40 with HTTP; Wed, 6 Jun 2012 09:11:06 -0700 (PDT)
In-Reply-To: <20120606132824.GA2597@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199335>

Applying that patch, the test t1304 succeeds on my machine.

Tested-by: Stefan Beller <stefanbeller@googlemail.com>

2012/6/6 Jeff King <peff@peff.net>:
> t1304 first runs setfacl as an experiment to see whether the
> filesystem supports ACLs, and skips the remaining tests if
> it does not. However, our setfacl run did not exercise the
> ACLs very well, and some filesystems may support our initial
> setfacl, but not the rest of the test.
>
> In particular, some versions of ecryptfs will erroneously
> apply the umask on top of an inherited directory ACL,
> causing our tests to fail. Let's be more careful and make
> sure both that we can read back the user ACL we set, and
> that the inherited ACL is propagated correctly. The latter
> catches the ecryptfs bug, but may also catch other bugs
> (e.g., an implementation which does not handle inherited
> ACLs at all).
>
> Since we're making the setup more complex, let's move it
> into its own test. This will hide the output for us unless
> the user wants to run "-v" to see it (and we don't need to
> bother printing anything about setfacl failing; the
> remaining tests will properly print "skip" due to the
> missing prerequisite).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The ecryptfs response was that it is probably a bug, so I think we
> should go with this (especially because it is general enough to
> potentially catch other weird errors).
>
> =A0t/t1304-default-acl.sh | 19 +++++++++----------
> =A01 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
> index 2b962cf..79045ab 100755
> --- a/t/t1304-default-acl.sh
> +++ b/t/t1304-default-acl.sh
> @@ -14,16 +14,15 @@ umask 077
> =A0# We need an arbitrary other user give permission to using ACLs. r=
oot
> =A0# is a good candidate: exists on all unices, and it has permission
> =A0# anyway, so we don't create a security hole running the testsuite=
=2E
> -
> -setfacl_out=3D"$(setfacl -m u:root:rwx . 2>&1)"
> -setfacl_ret=3D$?
> -
> -if test $setfacl_ret !=3D 0
> -then
> - =A0 =A0 =A0 say "Unable to use setfacl (output: '$setfacl_out'; ret=
urn code: '$setfacl_ret')"
> -else
> - =A0 =A0 =A0 test_set_prereq SETFACL
> -fi
> +test_expect_success 'checking for a working acl setup' '
> + =A0 =A0 =A0 if setfacl -m d:m:rwx -m u:root:rwx . &&
> + =A0 =A0 =A0 =A0 =A0getfacl . | grep user:root:rwx &&
> + =A0 =A0 =A0 =A0 =A0touch should-have-readable-acl &&
> + =A0 =A0 =A0 =A0 =A0getfacl should-have-readable-acl | egrep "mask::=
?rw-"
> + =A0 =A0 =A0 then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_set_prereq SETFACL
> + =A0 =A0 =A0 fi
> +'
>
> =A0if test -z "$LOGNAME"
> =A0then
> --
> 1.7.11.rc1.4.g0d3b9b3
>
