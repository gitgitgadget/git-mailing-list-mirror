From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1509: update prepare script to be able to run t1509 in
 chroot again
Date: Fri, 3 Apr 2015 08:01:10 -0400
Message-ID: <20150403120109.GB22170@peff.net>
References: <20150331191420.GE22844@google.com>
 <1428055737-8943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 14:01:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye0Ho-0000Rl-0F
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 14:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbbDCMBN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2015 08:01:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:41829 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751435AbbDCMBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 08:01:12 -0400
Received: (qmail 18910 invoked by uid 102); 3 Apr 2015 12:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Apr 2015 07:01:12 -0500
Received: (qmail 20552 invoked by uid 107); 3 Apr 2015 12:01:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Apr 2015 08:01:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2015 08:01:10 -0400
Content-Disposition: inline
In-Reply-To: <1428055737-8943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266704>

On Fri, Apr 03, 2015 at 05:08:57PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> diff --git a/t/t1509/prepare-chroot.sh b/t/t1509/prepare-chroot.sh
> index 6269117..c61afbf 100755
> --- a/t/t1509/prepare-chroot.sh
> +++ b/t/t1509/prepare-chroot.sh
> @@ -14,25 +14,42 @@ xmkdir() {
> =20
>  R=3D"$1"
> =20
> +[ "$UID" -eq 0 ] && die "This script should not be run as root, what=
 if it does rm -rf /?"

This line complains for me. $UID is set in my bash login shell, but not
in the dash shell for this script. Maybe "id -u" instead?

>  xmkdir "$R" "$R/bin" "$R/etc" "$R/lib" "$R/dev"
> -[ -c "$R/dev/null" ] || die "/dev/null is missing. Do mknod $R/dev/n=
ull c 1 3 && chmod 666 $R/dev/null"
> +touch "$R/dev/null"

It is nice not to mknod here, as it requires root. But making /dev/null
a regular file seems a bit flaky. We will constantly overwrite it with
the output of each test, and then pipe that output back into the next
test. The current set of tests in t1509 does not seem to mind, though.

> +# Fake perl to reduce dependency, t1509 does not use perl, but some
> +# env might slip through, see test-lib.sh, unset.*PERL_PATH
> +sed 's|^PERL_PATH=3D*|PERL_PATH=3D/bin/true|' GIT-BUILD-OPTIONS > "$=
R$(pwd)/GIT-BUILD-OPTIONS"

Re-preparing an already-made chroot makes this:

  PERL_PATH=3D/bin/true'/usr/bin/perl'

Did you want "PERL_PATH=3D.*" as your regex?

> -echo "Execute this in root: 'chroot $R /bin/su - $(id -nu)'"
> +cat <<EOF
> +Execute this in root:
> +chroot $R /bin/su - $(id -nu)
> +IKNOWWHATIAMDOING=3DYES ./t1509-root-worktree.sh -v -i
> +EOF

I found the "in root" here (and in the original) confusing. Do you mean
"as root"? I wonder if it would make sense to just show:

  sudo chroot $R /bin/su - $(id -nu)

as the sample command.

Aside from the nits above, I did get it to run t1509 with this. I can't
say I'm incredibly excited about the whole thing, if only because it is
clear that nobody is going to run it regularly (so regressions will
likely go unnoticed, which is the whole point of the test script).  But
perhaps it is better than nothing, and it is not hurting anyone to sit
there and bitrot again. ;)

-Peff
