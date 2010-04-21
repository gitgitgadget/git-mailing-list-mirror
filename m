From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t1304,t2007: quell output to stdout and stderr
Date: Wed, 21 Apr 2010 09:45:35 -0500
Message-ID: <20100421144535.GA8481@progeny.tock>
References: <00e68c9727f8dd3426db6f78d6b583a0dcec4d13.1271858119.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 16:45:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4bBL-0007QC-EV
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 16:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab0DUOpe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 10:45:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45441 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab0DUOpd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 10:45:33 -0400
Received: by pwj9 with SMTP id 9so5136685pwj.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mzaK+ZkH0UfCMKSfE/YFdbGwSEXzgZkh01QkKsr/Ym8=;
        b=QGDltLliwyz3QhOynwchwx6rXDhf0cgCrgaJpu93s7Lqr6La9wMqrhiuti6BNdpeFI
         98VUdAC0NhRrQP0mFCZFnzXMW3cF5U0h2bUdT8ncXNsJmLN7bHi25jHcgHFJYnMMxwm8
         LVA1hpZTEeUs0HC5hY4BL1RHFoW9h0oFDT5EA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FJJYoP05JtZsdRfOBLi/UKf1iF1vHbeTjZlxUrAN/gNKeJ0ux82shfpxJWNR8W7iEJ
         M3hEu03i6MdZ/bV3TnP/h2uLF82elgc6aqULLcz/fErYMA2E4su/a1IuAmYP8zMN5ObB
         kVR4QGLaqA5CaQ9JZrEjCsRgSFrQgnkxw1mnQ=
Received: by 10.142.3.35 with SMTP id 35mr3779491wfc.74.1271861132829;
        Wed, 21 Apr 2010 07:45:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1024256iwn.7.2010.04.21.07.45.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 07:45:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <00e68c9727f8dd3426db6f78d6b583a0dcec4d13.1271858119.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145434>

Hi Michael,

Michael J Gruber wrote:

> --- a/t/t1304-default-acl.sh
> +++ b/t/t1304-default-acl.sh
> @@ -15,7 +15,7 @@ umask 077
>  # is a good candidate: exists on all unices, and it has permission
>  # anyway, so we don't create a security hole running the testsuite.
> =20
> -if ! setfacl -m u:root:rwx .; then
> +if ! setfacl -m u:root:rwx . 2>/dev/null; then
>      say "Skipping ACL tests: unable to use setfacl"
>      test_done
>  fi
[and a similar suppression of =E2=80=98git checkout=E2=80=99 output]

In the spirit of commit 4a45f7d (Use test_expect_success for test
setups, 2010-03-20), might it make sense to turn these into tests?

I am imagining something like this.

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index b26d2e8..8b3ff7a 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -15,7 +15,15 @@ umask 077
 # is a good candidate: exists on all unices, and it has permission
 # anyway, so we don't create a security hole running the testsuite.
=20
-if ! setfacl -m u:root:rwx . 2>/dev/null; then
+test_expect_success 'Setup: try to set an ACL' '
+	if setfacl -m u:root:rwx .
+	then
+		test_set_prereq ACL
+	fi
+'
+
+if ! test_have_prereq ACL
+then
     say "Skipping ACL tests: unable to use setfacl"
     test_done
 fi
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index fc5db05..f8f40e5 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -44,11 +44,12 @@ test_expect_success 'switch from symlink to dir' '
=20
 '
=20
-rm -fr frotz xyzzy nitfol &&
-git checkout -q -f master || exit
-
 test_expect_success 'switch from dir to symlink' '
=20
+	rm -fr frotz xyzzy nitfol &&
+	git rm -fr . &&
+	git checkout -f master &&
+
 	git checkout side
=20
 '
