From: Jeff King <peff@peff.net>
Subject: [PATCH 0/16] skip_prefix refactoring and cleanups
Date: Wed, 18 Jun 2014 15:41:18 -0400
Message-ID: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:41:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLjf-00050m-H4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbaFRTlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2014 15:41:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:46932 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754712AbaFRTlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:41:19 -0400
Received: (qmail 29689 invoked by uid 102); 18 Jun 2014 19:41:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:41:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:41:18 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252032>

A while ago[1] we discussed refactoring skip_prefix (or adding somethin=
g
like it) to make it more natural to call. This morning I decided to tak=
e
a look at doing this, and went down a rabbit hole of cleanups. This is
part one of the result.

The short of it is that skip_prefix can now be used like this:

  if (skip_prefix(arg, "--foo=3D", &value)
	handle_foo(value);

or even:

  /* arg remains valid if we didn't match! */
  if (skip_prefix(arg, "--foo=3D", &arg))
	handle_foo(arg);
  else if (skip_prefix(arg, "--bar", &arg))
	handle_bar(arg);

though the latter form is not always useful if the conditional code
wants to see all of "arg".

  [01/16]: parse_diff_color_slot: drop ofs parameter
  [02/16]: daemon: mark some strings as const
  [03/16]: avoid using skip_prefix as a boolean

    These ones are preparatory cleanup.

  [04/16]: refactor skip_prefix to return a boolean

    The actual refactoring; it changes the existing callers[2] at the
    same time.

  [05/16]: apply: use skip_prefix instead of raw addition
  [06/16]: fast-import: fix read of uninitialized argv memory
  [07/16]: transport-helper: avoid reading past end-of-string

    These three are conversions that actually fix bugs.

  [08/16]: use skip_prefix to avoid magic numbers
  [09/16]: use skip_prefix to avoid repeating strings

    These are the straightforward conversions lumped together by the
    problem they are solving.

  [10/16]: fast-import: use skip_prefix for parsing input
  [11/16]: daemon: use skip_prefix to avoid magic numbers
  [12/16]: stat_opt: check extra strlen call
  [13/16]: fast-import: refactor parsing of spaces
  [14/16]: fetch-pack: refactor parsing in get_ack
  [15/16]: git: avoid magic number with skip_prefix

    These ones are variants of the above two that needed extra
    discussion or attention for various reasons.

  [16/16]: use skip_prefix to avoid repeated calculations

    These ones don't solve a specific problem as the patches above do,
    but I think the code ends up more readable.

My conversions are by now means exhaustive. After grepping through all
of the starts_with up to about http.c, I decided to call it a day. But
we can easily convert more as time goes on.

[1] http://thread.gmane.org/gmane.comp.version-control.git/239438/focus=
=3D239564

    I started from scratch this morning, oblivious to the fact that Ren=
=C3=A9
    posted something very similar to patch 4 in that thread.

[2] I test-merged with 'pu'. There is a minor textual conflict with
    jk/commit-buffer-length that should be easy to resolve. There's als=
o
    one new caller of skip_prefix added in cc/interpret-trailers. It
    needs this fix when merged:

diff --git a/trailer.c b/trailer.c
index eaf692b..987fa29 100644
--- a/trailer.c
+++ b/trailer.c
@@ -377,8 +377,7 @@ static int git_trailer_config(const char *conf_key,=
 const char *value, void *cb)
 	enum trailer_info_type type;
 	int i;
=20
-	trailer_item =3D skip_prefix(conf_key, "trailer.");
-	if (!trailer_item)
+	if (!skip_prefix(conf_key, "trailer.", &trailer_item))
 		return 0;
=20
 	variable_name =3D strrchr(trailer_item, '.');
