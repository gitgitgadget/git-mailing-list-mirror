From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Sun, 24 Nov 2013 04:07:43 -0500
Message-ID: <20131124090743.GA495@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121160426.GA21843@kitenet.net>
 <20131122020911.GA12042@sigill.intra.peff.net>
 <20131122172859.GA703@kitenet.net>
 <20131124084444.GA23238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sun Nov 24 10:08:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkVfb-0000Fb-PU
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 10:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab3KXJHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 04:07:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:44708 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755382Ab3KXJHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 04:07:45 -0500
Received: (qmail 25384 invoked by uid 102); 24 Nov 2013 09:07:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Nov 2013 03:07:45 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Nov 2013 04:07:43 -0500
Content-Disposition: inline
In-Reply-To: <20131124084444.GA23238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238254>

On Sun, Nov 24, 2013 at 03:44:44AM -0500, Jeff King wrote:

> In any code path where we call parse_object, we double-check that the
> result matches the sha1 we asked for. But low-level commands like
> cat-file just call read_sha1_file directly, and do not have such a
> check. We could add it, but I suspect the processing cost would be
> noticeable.

Curious, I tested this. It is noticeable. Here's the best-of-five
timings for the patch below when running a --batch cat-file on every
object in my git.git repo, using the patch below:

  [before]
  real    0m12.941s
  user    0m12.700s
  sys     0m0.244s

  [after]
  real    0m15.800s
  user    0m15.472s
  sys     0m0.344s

So it's about 20% slower. I don't know what the right tradeoff is. It's
cool to check the data each time we look at it, but it does carry a
performance penalty. I notice elsewhere in git we are inconsistent. If
you call parse_object() on an object, you get the sha1 check. But if you
just call parse_commit() on something you know to be a commit (e.g.,
because you are traversing the history and looked it up as a parent
pointer), you do not. I don't know if that is oversight, or an
intentional performance decision.

-Peff

---
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b2ca775..2b09773 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -199,6 +199,8 @@ static void print_object_or_die(int fd, const unsigned char *sha1,
 	if (type == OBJ_BLOB) {
 		if (stream_blob_to_fd(fd, sha1, NULL, 0) < 0)
 			die("unable to stream %s to stdout", sha1_to_hex(sha1));
+		if (check_sha1_signature(sha1, NULL, 0, NULL) < 0)
+			die("object %s sha1 mismatch", sha1_to_hex(sha1));
 	}
 	else {
 		enum object_type rtype;
@@ -208,6 +210,8 @@ static void print_object_or_die(int fd, const unsigned char *sha1,
 		contents = read_sha1_file(sha1, &rtype, &rsize);
 		if (!contents)
 			die("object %s disappeared", sha1_to_hex(sha1));
+		if (check_sha1_signature(sha1, contents, rsize, typename(rtype)) < 0)
+			die("object %s sha1 mismatch", sha1_to_hex(sha1));
 		if (rtype != type)
 			die("object %s changed type!?", sha1_to_hex(sha1));
 		if (rsize != size)
