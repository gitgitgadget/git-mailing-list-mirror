From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] create_ref_entry(): move check_refname_format() call to
 callers
Date: Sun, 29 Apr 2012 07:58:31 -0400
Message-ID: <20120429115831.GC24254@sigill.intra.peff.net>
References: <1335680288-5128-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sun Apr 29 13:58:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOSm0-0001cL-IA
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 13:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab2D2L6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 07:58:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50752
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803Ab2D2L6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 07:58:34 -0400
Received: (qmail 14160 invoked by uid 107); 29 Apr 2012 11:58:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 Apr 2012 07:58:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Apr 2012 07:58:31 -0400
Content-Disposition: inline
In-Reply-To: <1335680288-5128-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196508>

On Sun, Apr 29, 2012 at 08:18:08AM +0200, mhagger@alum.mit.edu wrote:

> I will work on providing more infrastructure for checking refnames at
> varying levels of strictness, but I don't know enough about the code
> paths to be able to find the places where the strictness levels need
> tweaking.
> 
> For this to work, the various callers of check_refname_format() will
> have to be able to influence the level of strictness that they want to
> enforce.  This patch is one trivial step in that direction.

It seems like the create_ref_entry code paths should _always_ just be
issuing warnings, as they are about reading existing refs, no? The die()
side should only come when we are writing refs.

So something like this patch:

diff --git a/refs.c b/refs.c
index a5802e1..3dba205 100644
--- a/refs.c
+++ b/refs.c
@@ -180,7 +180,7 @@ static struct ref_entry *create_ref_entry(const char *refname,
 
 	if (check_name &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
-		die("Reference has invalid format: '%s'", refname);
+		warning("Reference has invalid format: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(ref->u.value.sha1, sha1);
@@ -926,7 +926,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 	if (flag)
 		*flag = 0;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+	if (!reading && check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		return NULL;
 
 	for (;;) {

which gives me the following behavior on the snippet I posted earlier:

  $ git fsck
  warning: Reference has invalid format: 'refs/tags/foo^?bar'

  $ git rev-parse --verify "$evil"
  711078d8c4c0d26b02afee9f385a64455fe4cccd

  $ git for-each-ref
  warning: Reference has invalid format: 'refs/tags/foo^?bar'
  711078d8c4c0d26b02afee9f385a64455fe4cccd commit refs/heads/master
  711078d8c4c0d26b02afee9f385a64455fe4cccd commit refs/tags/foobar

  $ git tag -l
  warning: Reference has invalid format: 'refs/tags/foo^?bar'
  foo^?bar

  $ git tag fixed "$evil"
  warning: Reference has invalid format: 'refs/tags/foo^?bar'
  $ git rev-parse fixed
  711078d8c4c0d26b02afee9f385a64455fe4cccd
  $ git tag -d "$evil"
  Deleted tag 'foo^?bar' (was 711078d)

-Peff
