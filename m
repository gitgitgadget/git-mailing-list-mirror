From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t5538: fix default http port
Date: Fri, 7 Feb 2014 18:47:27 -0500
Message-ID: <20140207234727.GA17520@sigill.intra.peff.net>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-3-git-send-email-pclouds@gmail.com>
 <20140206193533.GB14552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 00:47:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBv9E-0005SY-Fx
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 00:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbaBGXra convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Feb 2014 18:47:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:46714 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750706AbaBGXr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 18:47:29 -0500
Received: (qmail 12438 invoked by uid 102); 7 Feb 2014 23:47:29 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (8.11.255.29)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Feb 2014 17:47:29 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Feb 2014 18:47:27 -0500
Content-Disposition: inline
In-Reply-To: <20140206193533.GB14552@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241814>

On Thu, Feb 06, 2014 at 02:35:33PM -0500, Jeff King wrote:

> On Thu, Feb 06, 2014 at 10:10:35PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>=20
> > Originally I had t5537 use port 5536 and 5538 use port 5537(!). The=
n
> > Jeff found my fault so I changed port in t5537 from 5536 to 5537 in
> > 3b32a7c (t5537: fix incorrect expectation in test case 10 -
> > 2014-01-08). Which makes it worse because now both t5537 and t5538
> > both use the same port. Fix it.
> [...]

Thinking on this more, I wonder if we should just do something like
this:

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index bfdff2a..c82b4ee 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -64,7 +64,9 @@ case $(uname) in
 esac
=20
 LIB_HTTPD_PATH=3D${LIB_HTTPD_PATH-"$DEFAULT_HTTPD_PATH"}
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'8111'}
+if test -z "$LIB_HTTPD_PORT"; then
+	LIB_HTTPD_PORT=3D${this_test#t}
+fi
=20
 TEST_PATH=3D"$TEST_DIRECTORY"/lib-httpd
 HTTPD_ROOT_PATH=3D"$PWD"/httpd

and drop the manual LIB_HTTPD_PORT setting in each of the test scripts.
That would prevent this type of error in the future, and people can
still override if they want to.

Any test scripts that are not numbered would need to set it, but we
should not have any of those (and if we did, the failure mode would be
OK, as Apache would barf on the bogus port number).

-Peff
