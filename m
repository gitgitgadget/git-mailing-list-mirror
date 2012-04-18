From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] argv-array: refactor empty_argv initialization
Date: Wed, 18 Apr 2012 14:08:49 -0700
Message-ID: <20120418210848.GA21301@sigill.intra.peff.net>
References: <20120418210740.GA21214@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:09:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKc7X-0003sY-DE
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 23:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab2DRVIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 17:08:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38001
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab2DRVIw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 17:08:52 -0400
Received: (qmail 20742 invoked by uid 107); 18 Apr 2012 21:09:01 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Apr 2012 17:09:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Apr 2012 14:08:49 -0700
Content-Disposition: inline
In-Reply-To: <20120418210740.GA21214@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195904>

An empty argv-array is initialized to point to a static
empty NULL-terminated array.  The original implementation
separates the actual storage of the NULL-terminator from the
pointer to the list.  This makes the exposed type a "const
char **", which nicely matches the type stored by the
argv-array.

However, this indirection means that one cannot use
empty_argv to initialize a static variable, since it is
not a constant.

Instead, we can expose empty_argv directly, as an array of
pointers. The only place we use it is in the ARGV_ARRAY_INIT
initializer, and it decays to a pointer appropriately there.

Signed-off-by: Jeff King <peff@peff.net>
---
 argv-array.c |    3 +--
 argv-array.h |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/argv-array.c b/argv-array.c
index a4e0420..110a61b 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -2,8 +2,7 @@
 #include "argv-array.h"
 #include "strbuf.h"
 
-static const char *empty_argv_storage = NULL;
-const char **empty_argv = &empty_argv_storage;
+const char *empty_argv[] = { NULL };
 
 void argv_array_init(struct argv_array *array)
 {
diff --git a/argv-array.h b/argv-array.h
index 74dd2b1..c45c698 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -1,7 +1,7 @@
 #ifndef ARGV_ARRAY_H
 #define ARGV_ARRAY_H
 
-extern const char **empty_argv;
+extern const char *empty_argv[];
 
 struct argv_array {
 	const char **argv;
-- 
1.7.9.6.8.g992e5
