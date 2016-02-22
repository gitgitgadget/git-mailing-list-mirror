From: Jeff King <peff@peff.net>
Subject: [PATCH v3 06/22] argv-array: add detach function
Date: Mon, 22 Feb 2016 17:44:15 -0500
Message-ID: <20160222224414.GF10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:44:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzDJ-0004ss-Be
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055AbcBVWoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:44:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:47067 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755500AbcBVWoR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:44:17 -0500
Received: (qmail 21614 invoked by uid 102); 22 Feb 2016 22:44:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:17 -0500
Received: (qmail 23022 invoked by uid 107); 22 Feb 2016 22:44:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:44:15 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286976>

The usual pattern for an argv array is to initialize it,
push in some strings, and then clear it when done. Very
occasionally, though, we must do other exotic things with
the memory, like freeing the list but keeping the strings.
Let's provide a detach function so that callers can make use
of our API to build up the array, and then take ownership of
it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-argv-array.txt |  7 +++++++
 argv-array.c                               | 11 +++++++++++
 argv-array.h                               |  1 +
 3 files changed, 19 insertions(+)

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index 8076172..cfc0630 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -56,3 +56,10 @@ Functions
 `argv_array_clear`::
 	Free all memory associated with the array and return it to the
 	initial, empty state.
+
+`argv_array_detach`::
+	Disconnect the `argv` member from the `argv_array` struct and
+	return it. The caller is responsible for freeing the memory used
+	by the array, and by the strings it references. After detaching,
+	the `argv_array` is in a reinitialized state and can be pushed
+	into again.
diff --git a/argv-array.c b/argv-array.c
index eaed477..5d370fa 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -74,3 +74,14 @@ void argv_array_clear(struct argv_array *array)
 	}
 	argv_array_init(array);
 }
+
+const char **argv_array_detach(struct argv_array *array)
+{
+	if (array->argv == empty_argv)
+		return xcalloc(1, sizeof(const char *));
+	else {
+		const char **ret = array->argv;
+		argv_array_init(array);
+		return ret;
+	}
+}
diff --git a/argv-array.h b/argv-array.h
index a2fa0aa..29056e4 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -20,5 +20,6 @@ void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pushv(struct argv_array *, const char **);
 void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
+const char **argv_array_detach(struct argv_array *);
 
 #endif /* ARGV_ARRAY_H */
-- 
2.7.2.645.g4e1306c
