From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/5] setup: add gentle version of read_gitfile
Date: Fri, 26 Jun 2015 05:03:31 -0400
Message-ID: <20150626090331.GA4196@peff.net>
References: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
 <1434397195-1823-2-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erik =?utf-8?B?RWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 11:04:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8PYZ-0001JK-R8
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 11:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbbFZJEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2015 05:04:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:52162 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751585AbbFZJDe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 05:03:34 -0400
Received: (qmail 27914 invoked by uid 102); 26 Jun 2015 09:03:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 04:03:34 -0500
Received: (qmail 14382 invoked by uid 107); 26 Jun 2015 09:03:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 05:03:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jun 2015 05:03:31 -0400
Content-Disposition: inline
In-Reply-To: <1434397195-1823-2-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272768>

On Mon, Jun 15, 2015 at 09:39:51PM +0200, Erik Elfstr=C3=B6m wrote:

> +cleanup_return:
>  	free(buf);
> +
> +	if (return_error_code)
> +		*return_error_code =3D error_code;
> +
> +	if (error_code) {
> +		if (return_error_code)
> +			return NULL;
> +
> +		switch (error_code) {
> +		case READ_GITFILE_ERR_STAT_FAILED:
> +		case READ_GITFILE_ERR_NOT_A_FILE:
> +			return NULL;
> +		case READ_GITFILE_ERR_OPEN_FAILED:
> +			die_errno("Error opening '%s'", path);
> +		case READ_GITFILE_ERR_READ_FAILED:
> +			die("Error reading %s", path);
> +		case READ_GITFILE_ERR_INVALID_FORMAT:
> +			die("Invalid gitfile format: %s", path);
> +		case READ_GITFILE_ERR_NO_PATH:
> +			die("No path in gitfile: %s", path);
> +		case READ_GITFILE_ERR_NOT_A_REPO:
> +			die("Not a git repository: %s", dir);
> +		default:
> +			assert(0);
> +		}

I happened to be playing with clang's static analyzer today, and it
noticed that there is a subtle use-after-free here. Here's a patch (on
top of ee/clean-remove-dirs, which is in 'next').

In practice I suspect it prints the right thing on most platforms, just
because nobody else has a chance to clobber the heap. But doing:

  echo "gitdir: /some/not-gitdir/path" >.git
  valgrind git status

does detect the problem.

-- >8 --
Subject: [PATCH] read_gitfile_gently: fix use-after-free

The "dir" variable is a pointer into the "buf" array. When
we hit the cleanup_return path, the first thing we do is
free(buf); but one of the error messages prints "dir", which
will access the memory after the free.

We can fix this by reorganizing the error path a little. We
act on the fatal, error-printing conditions first, as they
want to access memory and do not care about freeing. Then we
free any memory, and finally return.

Signed-off-by: Jeff King <peff@peff.net>
---
We can also spell the "else if" below as:

  if (error_code && !return_error_code)

but IMHO it reads better as I have it here: we report the error code if
the user asked for it, and otherwise follow the print-and-die path. We
could even spell it as just "else" and bump the "0" case down into the
switch statement.

 setup.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/setup.c b/setup.c
index 7b30f32..5eaca48 100644
--- a/setup.c
+++ b/setup.c
@@ -517,19 +517,14 @@ const char *read_gitfile_gently(const char *path,=
 int *return_error_code)
 	path =3D real_path(dir);
=20
 cleanup_return:
-	free(buf);
-
 	if (return_error_code)
 		*return_error_code =3D error_code;
-
-	if (error_code) {
-		if (return_error_code)
-			return NULL;
-
+	else if (error_code) {
 		switch (error_code) {
 		case READ_GITFILE_ERR_STAT_FAILED:
 		case READ_GITFILE_ERR_NOT_A_FILE:
-			return NULL;
+			/* non-fatal; follow return path */
+			break;
 		case READ_GITFILE_ERR_OPEN_FAILED:
 			die_errno("Error opening '%s'", path);
 		case READ_GITFILE_ERR_TOO_LARGE:
@@ -547,7 +542,8 @@ cleanup_return:
 		}
 	}
=20
-	return path;
+	free(buf);
+	return error_code ? NULL : path;
 }
=20
 static const char *setup_explicit_git_dir(const char *gitdirenv,
--=20
2.5.0.rc0.336.g8460790
