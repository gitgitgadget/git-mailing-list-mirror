From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/5] cat-file: refactor error handling of batch_objects
Date: Tue, 7 Jan 2014 18:57:20 -0500
Message-ID: <20140107235719.GA10657@sigill.intra.peff.net>
References: <20140107235631.GA10503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 00:57:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0gWU-00041q-PQ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 00:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbaAGX5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 18:57:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:56827 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753627AbaAGX5W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 18:57:22 -0500
Received: (qmail 1650 invoked by uid 102); 7 Jan 2014 23:57:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 17:57:22 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 18:57:20 -0500
Content-Disposition: inline
In-Reply-To: <20140107235631.GA10503@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240183>

This just pulls the return value for the function out of the
inner loop, so we can break out of the loop rather than do
an early return. This will make it easier to put any cleanup
for the function in one place.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f8288c8..971cdde 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -263,6 +263,7 @@ static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct expand_data data;
+	int retval = 0;
 
 	if (!opt->format)
 		opt->format = "%(objectname) %(objecttype) %(objectsize)";
@@ -294,8 +295,6 @@ static int batch_objects(struct batch_options *opt)
 	warn_on_object_refname_ambiguity = 0;
 
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
-		int error;
-
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
@@ -310,12 +309,12 @@ static int batch_objects(struct batch_options *opt)
 			data.rest = p;
 		}
 
-		error = batch_one_object(buf.buf, opt, &data);
-		if (error)
-			return error;
+		retval = batch_one_object(buf.buf, opt, &data);
+		if (retval)
+			break;
 	}
 
-	return 0;
+	return retval;
 }
 
 static const char * const cat_file_usage[] = {
-- 
1.8.5.2.500.g8060133
