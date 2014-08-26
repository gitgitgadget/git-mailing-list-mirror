From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] log-tree: use FLEX_ARRAY in name_decoration
Date: Tue, 26 Aug 2014 06:24:20 -0400
Message-ID: <20140826102420.GC25687@peff.net>
References: <20140826102051.GA4885@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 12:24:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMDvO-0007Sd-TC
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 12:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934606AbaHZKYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 06:24:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59065 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934437AbaHZKYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 06:24:22 -0400
Received: (qmail 9625 invoked by uid 102); 26 Aug 2014 10:24:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 05:24:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 06:24:20 -0400
Content-Disposition: inline
In-Reply-To: <20140826102051.GA4885@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255886>

We are already using the flex-array technique; let's
annotate it with our usual FLEX_ARRAY macro. Besides being
more readable, this is slightly more efficient on compilers
that understand flex-arrays.

Note that we need to bump the allocation in add_name_decoration,
which did not explicitly add one byte for the NUL terminator
of the string we putting into the flex-array (it did not
need to before, because the struct itself was over-allocated
by one byte).

Signed-off-by: Jeff King <peff@peff.net>
---
This could come first in the series, but doing it last means we only
have to update one spot. :)

 commit.h   | 2 +-
 log-tree.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit.h b/commit.h
index 263b49e..1516fc9 100644
--- a/commit.h
+++ b/commit.h
@@ -29,7 +29,7 @@ extern const char *commit_type;
 struct name_decoration {
 	struct name_decoration *next;
 	int type;
-	char name[1];
+	char name[FLEX_ARRAY];
 };
 
 enum decoration_type {
diff --git a/log-tree.c b/log-tree.c
index 7cbc4ee..fb60018 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -77,7 +77,7 @@ int parse_decorate_color_config(const char *var, const int ofs, const char *valu
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj)
 {
 	int nlen = strlen(name);
-	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + nlen);
+	struct name_decoration *res = xmalloc(sizeof(*res) + nlen + 1);
 	memcpy(res->name, name, nlen + 1);
 	res->type = type;
 	res->next = add_decoration(&name_decoration, obj, res);
-- 
2.1.0.346.ga0367b9
