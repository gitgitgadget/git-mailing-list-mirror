From: Jeff King <peff@peff.net>
Subject: [PATCH] attr: don't confuse prefixes with leading directories
Date: Tue, 10 Jan 2012 13:08:21 -0500
Message-ID: <20120110180820.GA15273@sigill.intra.peff.net>
References: <20120110070300.GA17086@sigill.intra.peff.net>
 <4F0BFE6E.6080904@alum.mit.edu>
 <20120110171100.GA18962@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:08:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkg7a-0001F3-Uf
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 19:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab2AJSIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 13:08:24 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33758
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756531Ab2AJSIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 13:08:23 -0500
Received: (qmail 12011 invoked by uid 107); 10 Jan 2012 18:15:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 13:15:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 13:08:21 -0500
Content-Disposition: inline
In-Reply-To: <20120110171100.GA18962@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188272>

When we prepare the attribute stack for a lookup on a path,
we start with the cached stack from the previous lookup
(because it is common to do several lookups in the same
directory hierarchy). So the first thing we must do in
preparing the stack is to pop any entries that point to
directories we are no longer interested in.

For example, if our stack contains gitattributes for:

  foo/bar/baz
  foo/bar
  foo

but we want to do a lookup in "foo/bar/bleep", then we want
to pop the top element, but retain the others.

To do this we walk down the stack from the top, popping
elements that do not match our lookup directory. However,
the test do this simply checked strncmp, meaning we would
mistake "foo/bar/baz" as a leading directory of
"foo/bar/baz_plus". We must also check that the character
after our match is '/', meaning we matched the whole path
component.

There are two special cases to consider:

  1. The top of our attr stack has the empty path. So we
     must not check for '/', but rather special-case the
     empty path, which always matches.

  2. Typically when matching paths in this way, you would
     also need to check for a full string match (i.e., the
     character after is '\0'). We don't need to do so in
     this case, though, because our path string is actually
     just the directory component of the path to a file
     (i.e., we know that it terminates with "/", because the
     filename comes after that).

Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
I wrote it in the minimally-intrusive way, but you could also pull
the "!namelen" case before the strncmp (since a strncmp of size 0 is
always true, anyway). I don't know if it would be more obvious that way.

I prepared this on top of master, but the patch applies (with some
shifted line counts) on older releases, too.

 attr.c                |    3 ++-
 t/t0003-attributes.sh |   10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index 76b079f..fa975da 100644
--- a/attr.c
+++ b/attr.c
@@ -582,7 +582,8 @@ static void prepare_attr_stack(const char *path)
 
 		elem = attr_stack;
 		if (namelen <= dirlen &&
-		    !strncmp(elem->origin, path, namelen))
+		    !strncmp(elem->origin, path, namelen) &&
+		    (!namelen || path[namelen] == '/'))
 			break;
 
 		debug_pop(elem);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index dbb2623..51f3045 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -159,6 +159,16 @@ test_expect_success 'relative paths' '
 	(cd b && attr_check ../a/b/g a/b/g)
 '
 
+test_expect_success 'prefixes are not confused with leading directories' '
+	attr_check a_plus/g unspecified &&
+	cat >expect <<-\EOF &&
+	a/g: test: a/g
+	a_plus/g: test: unspecified
+	EOF
+	git check-attr test a/g a_plus/g >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'core.attributesfile' '
 	attr_check global unspecified &&
 	git config core.attributesfile "$HOME/global-gitattributes" &&
-- 
1.7.9.rc0.33.gd3c17
