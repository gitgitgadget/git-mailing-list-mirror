From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] cat-file: restore warn_on_object_refname_ambiguity flag
Date: Wed, 12 Mar 2014 16:05:43 -0400
Message-ID: <20140312200542.GA3506@sigill.intra.peff.net>
References: <20140312200348.GB1816@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:05:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpPT-0008UB-63
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbaCLUFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:05:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:38300 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751843AbaCLUFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:05:45 -0400
Received: (qmail 31897 invoked by uid 102); 12 Mar 2014 20:05:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 15:05:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 16:05:43 -0400
Content-Disposition: inline
In-Reply-To: <20140312200348.GB1816@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243979>

Commit 25fba78 turned off the object/refname ambiguity check
during "git cat-file --batch" operations. However, this is a
global flag, so let's restore it when we are done.

This shouldn't make any practical difference, as cat-file
exits immediately afterwards, but is good code hygeine and
would prevent an unnecessary surprise if somebody starts to
call cmd_cat_file later.

Signed-off-by: Jeff King <peff@peff.net>
---
It also matches the restore behavior from the next patch, which adds
similar code to "rev-list --stdin". Which I think makes more sense, as
we often start revision traversals from inside other programs. Though it
is reasonably unlikely to use "--stdin" with such a traversal.

 builtin/cat-file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1664f5c..7073304 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -269,6 +269,7 @@ static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct expand_data data;
+	int save_warning;
 	int retval = 0;
 
 	if (!opt->format)
@@ -298,6 +299,7 @@ static int batch_objects(struct batch_options *opt)
 	 * warn) ends up dwarfing the actual cost of the object lookups
 	 * themselves. We can work around it by just turning off the warning.
 	 */
+	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
@@ -321,6 +323,7 @@ static int batch_objects(struct batch_options *opt)
 	}
 
 	strbuf_release(&buf);
+	warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
 
-- 
1.9.0.403.g7a2f4b0
