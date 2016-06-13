From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] parse_opt_string_list: stop allocating new strings
Date: Mon, 13 Jun 2016 01:39:12 -0400
Message-ID: <20160613053912.GA23880@sigill.intra.peff.net>
References: <20160613053203.GB3950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 07:39:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCKal-0004EH-6y
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 07:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbcFMFjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 01:39:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:53621 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932127AbcFMFjP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 01:39:15 -0400
Received: (qmail 26395 invoked by uid 102); 13 Jun 2016 05:39:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 01:39:14 -0400
Received: (qmail 10361 invoked by uid 107); 13 Jun 2016 05:39:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 01:39:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 01:39:12 -0400
Content-Disposition: inline
In-Reply-To: <20160613053203.GB3950@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297155>

The parse_opt_string_list callback is basically a thin
wrapper to string_list_append() any string options we get.
However, it calls:

  string_list_append(v, xstrdup(arg));

which duplicates the option value. This is wrong for two
reasons:

  1. If the string list has strdup_strings set, then we are
     making an extra copy, which is simply leaked.

  2. If the string list does not have strdup_strings set,
     then we pass memory ownership to the string list, but
     it does not realize this. If we later call
     string_list_clear(), which can happen if "--no-foo" is
     passed, then we will leak all of the existing entries.

Instead, we should just pass the argument straight to
string_list_append, and it can decide whether to copy or not
based on its strdup_strings flag.

It's possible that some (buggy) caller could be relying on
this extra copy (e.g., because it parses some options from
an allocated argv array and then frees the array), but it's
not likely. For one, we generally only use parse_options on
the argv given to us in main(). And two, such a caller is
broken anyway, because other option types like OPT_STRING()
do not make such a copy.  This patch brings us in line with
them.

Noticed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>
Signed-off-by: Jeff King <peff@peff.net>
---
 parse-options-cb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 239898d..ba5acf3 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -144,7 +144,7 @@ int parse_opt_string_list(const struct option *opt,=
 const char *arg, int unset)
 	if (!arg)
 		return -1;
=20
-	string_list_append(v, xstrdup(arg));
+	string_list_append(v, arg);
 	return 0;
 }
=20
--=20
2.9.0.rc2.149.gd580ccd
