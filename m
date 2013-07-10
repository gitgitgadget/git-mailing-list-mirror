From: Jeff King <peff@peff.net>
Subject: [PATCH 01/10] zero-initialize object_info structs
Date: Wed, 10 Jul 2013 07:35:26 -0400
Message-ID: <20130710113526.GA21963@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 13:35:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwsgJ-0000jr-On
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab3GJLfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:35:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:47731 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab3GJLfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:35:31 -0400
Received: (qmail 24894 invoked by uid 102); 10 Jul 2013 11:36:47 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:36:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:35:26 -0400
Content-Disposition: inline
In-Reply-To: <20130710113447.GA20113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230042>

The sha1_object_info_extended function expects the caller to
provide a "struct object_info" which contains pointers to
"query" items that will be filled in. The purpose of
providing pointers rather than storing the response directly
in the struct is so that callers can choose not to incur the
expense in finding particular fields that they do not care
about.

Right now the only query item is "sizep", and all callers
set it explicitly to choose whether or not to query it; they
can then leave the rest of the struct uninitialized.

However, as we add new query items, each caller will have to
be updated to explicitly turn off the new ones (by setting
them to NULL).  Instead, let's teach each caller to
zero-initialize the struct, so that they do not have to
learn about each new query item added.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 2 +-
 streaming.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 0af19c0..de06a97 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2428,7 +2428,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
-	struct object_info oi;
+	struct object_info oi = {0};
 
 	oi.sizep = sizep;
 	return sha1_object_info_extended(sha1, &oi);
diff --git a/streaming.c b/streaming.c
index cabcd9d..cac282f 100644
--- a/streaming.c
+++ b/streaming.c
@@ -135,7 +135,7 @@ struct git_istream *open_istream(const unsigned char *sha1,
 				 struct stream_filter *filter)
 {
 	struct git_istream *st;
-	struct object_info oi;
+	struct object_info oi = {0};
 	const unsigned char *real = lookup_replace_object(sha1);
 	enum input_source src = istream_source(real, type, &oi);
 
-- 
1.8.3.rc3.24.gec82cb9
