From: Jeff King <peff@peff.net>
Subject: [PATCH 7/6] argv-array: drop "detach" code
Date: Thu, 15 May 2014 04:41:03 -0400
Message-ID: <20140515084102.GA28461@sigill.intra.peff.net>
References: <20140515082943.GA26473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 10:41:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkrE1-00040k-Dr
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 10:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbaEOIlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 04:41:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:52069 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751039AbaEOIlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 04:41:05 -0400
Received: (qmail 20726 invoked by uid 102); 15 May 2014 08:41:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 03:41:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 04:41:03 -0400
Content-Disposition: inline
In-Reply-To: <20140515082943.GA26473@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249074>

The argv_array_detach function (and associated free() function) was
really only useful for transferring ownership of the memory to a "struct
child_process". Now that we have an internal argv_array in that struct,
there are no callers left.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a bonus enabled by the earlier patches. However, there is one
commit in pu that uses it when dealing with environment variables.
However, it is actually leaking memory, and should probably just use the
array directly (and it's one of my commits that's due to be re-rolled
anyway).

 Documentation/technical/api-argv-array.txt |  8 --------
 argv-array.c                               | 20 --------------------
 argv-array.h                               |  2 --
 3 files changed, 30 deletions(-)

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index a6b7d83..1a79781 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -53,11 +53,3 @@ Functions
 `argv_array_clear`::
 	Free all memory associated with the array and return it to the
 	initial, empty state.
-
-`argv_array_detach`::
-	Detach the argv array from the `struct argv_array`, transferring
-	ownership of the allocated array and strings.
-
-`argv_array_free_detached`::
-	Free the memory allocated by a `struct argv_array` that was later
-	detached and is now no longer needed.
diff --git a/argv-array.c b/argv-array.c
index 9e960d5..256741d 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -68,23 +68,3 @@ void argv_array_clear(struct argv_array *array)
 	}
 	argv_array_init(array);
 }
-
-const char **argv_array_detach(struct argv_array *array, int *argc)
-{
-	const char **argv =
-		array->argv == empty_argv || array->argc == 0 ? NULL : array->argv;
-	if (argc)
-		*argc = array->argc;
-	argv_array_init(array);
-	return argv;
-}
-
-void argv_array_free_detached(const char **argv)
-{
-	if (argv) {
-		int i;
-		for (i = 0; argv[i]; i++)
-			free((char **)argv[i]);
-		free(argv);
-	}
-}
diff --git a/argv-array.h b/argv-array.h
index 85ba438..c65e6e8 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -19,7 +19,5 @@ LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
-const char **argv_array_detach(struct argv_array *array, int *argc);
-void argv_array_free_detached(const char **argv);
 
 #endif /* ARGV_ARRAY_H */
-- 
2.0.0.rc1.436.g03cb729
