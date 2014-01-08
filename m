From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 23/28] Support shallow fetch/clone over smart-http
Date: Wed, 8 Jan 2014 06:25:43 -0500
Message-ID: <20140108112543.GA4419@sigill.intra.peff.net>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-24-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 12:25:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0rGg-00046L-59
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 12:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbaAHLZr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jan 2014 06:25:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:57162 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755171AbaAHLZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 06:25:45 -0500
Received: (qmail 3476 invoked by uid 102); 8 Jan 2014 11:25:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 05:25:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 06:25:43 -0500
Content-Disposition: inline
In-Reply-To: <1386248575-10206-24-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240208>

On Thu, Dec 05, 2013 at 08:02:50PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/gitremote-helpers.txt |  7 +++++++
>  builtin/fetch-pack.c                | 16 +++++++++++++---
>  remote-curl.c                       | 31 +++++++++++++++++++++++++++=
++--
>  t/t5536-fetch-shallow.sh            | 27 +++++++++++++++++++++++++++

I'm getting test failures in 'next' with GIT_TEST_HTTPD set, and they
are bisectable to this patch (actually, the moral equivalent of it, as
it looks like the commit message was tweaked along with the test number
when it was applied). The failures look like this:

  $ GIT_TEST_HTTPD=3D1 ./t5537-fetch-shallow.sh -v -i
  [...]
  ok 9 - fetch --update-shallow
 =20
  expecting success:=20
          git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PAT=
H/repo.git" &&
          git clone $HTTPD_URL/smart/repo.git clone &&
          (
          cd clone &&
          git fsck &&
          git log --format=3D%s origin/master >actual &&
          cat <<EOF >expect &&
  6
  5
  4
  3
  EOF
          test_cmp expect actual
          )
 =20
  Cloning into bare repository '/home/peff/compile/git/t/trash director=
y.t5537-fetch-shallow/httpd/www/repo.git'...
  remote: Counting objects: 19, done.       =20
  remote: Compressing objects: 100% (7/7), done.       =20
  remote: Total 19 (delta 0), reused 6 (delta 0)       =20
  Receiving objects: 100% (19/19), done.
  Checking connectivity... done.
  Cloning into 'clone'...
  remote: Counting objects: 19, done.       =20
  remote: Compressing objects: 100% (7/7), done.       =20
  remote: Total 19 (delta 0), reused 19 (delta 0)       =20
  Unpacking objects: 100% (19/19), done.
  Checking connectivity... done.
  Checking object directories: 100% (256/256), done.
  --- expect      2014-01-08 11:20:20.178546452 +0000
  +++ actual      2014-01-08 11:20:20.178546452 +0000
  @@ -1,3 +1,4 @@
  +7
   6
   5
   4
  not ok 10 - clone http repository


If you do end up tweaking the test, you may also want to fix:

> +LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5536'}
> +. "$TEST_DIRECTORY"/lib-httpd.sh

Since the test number got switched, it would be nice to tweak the port
number to match it, in case the real t5536 ever starts using lib-httpd.

-Peff
