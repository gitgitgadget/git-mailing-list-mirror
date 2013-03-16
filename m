From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] upload-pack: make sure "want" objects are parsed
Date: Sat, 16 Mar 2013 06:27:01 -0400
Message-ID: <20130316102701.GB29533@sigill.intra.peff.net>
References: <20130316102428.GA29358@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 11:27:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGoKr-0005Ck-Rm
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 11:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593Ab3CPK1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 06:27:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53471 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755488Ab3CPK1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 06:27:05 -0400
Received: (qmail 906 invoked by uid 107); 16 Mar 2013 10:28:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Mar 2013 06:28:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Mar 2013 06:27:01 -0400
Content-Disposition: inline
In-Reply-To: <20130316102428.GA29358@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218296>

When upload-pack receives a "want" line from the client, it
adds it to an object array. We call lookup_object to find
the actual object, which will only check for objects already
in memory. This works because we are expecting to find
objects that we already loaded during the ref advertisement.

We use the resulting object structs for a variety of
purposes. Some of them care only about the object flags, but
others care about the type of the object (e.g.,
ok_to_give_up), or even feed them to the revision parser
(when --depth is used), which assumes that objects it
receives are fully parsed.

Once upon a time, this was OK; any object we loaded into
memory would also have been parsed. But since 435c833
(upload-pack: use peel_ref for ref advertisements,
2012-10-04), we try to avoid parsing objects during the ref
advertisement. This means that lookup_object may return an
object with a type of OBJ_NONE. The resulting mess depends
on the exact set of objects, but can include the revision
parser barfing, or the shallow code sending the wrong set of
objects.

This patch teaches upload-pack to parse each "want" object
as we receive it. We do not replace the lookup_object call
with parse_object, as the current code is careful not to let
just any object appear on a "want" line, but rather only one
we have previously advertised (whereas parse_object would
actually load any arbitrary object from disk).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5500-fetch-pack.sh | 9 +++++++++
 upload-pack.c         | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 354d32c..d574085 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -364,6 +364,15 @@ EOF
 	test_cmp count7.expected count7.actual
 '
 
+test_expect_success 'clone shallow with packed refs' '
+	git pack-refs --all &&
+	git clone --depth 1 --branch A "file://$(pwd)/." shallow8 &&
+	echo "in-pack: 4" > count8.expected &&
+	GIT_DIR=shallow8/.git git count-objects -v |
+		grep "^in-pack" > count8.actual &&
+	test_cmp count8.expected count8.actual
+'
+
 test_expect_success 'setup tests for the --stdin parameter' '
 	for head in C D E F
 	do
diff --git a/upload-pack.c b/upload-pack.c
index 6bf81aa..41736ec 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -639,7 +639,7 @@ static void receive_needs(void)
 			use_include_tag = 1;
 
 		o = lookup_object(sha1_buf);
-		if (!o)
+		if (!o || !parse_object(o->sha1))
 			die("git upload-pack: not our ref %s",
 			    sha1_to_hex(sha1_buf));
 		if (!(o->flags & WANTED)) {
-- 
1.8.2.rc2.7.gef06216
