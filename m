From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] rev-list: disable object/refname ambiguity check with
 --stdin
Date: Wed, 12 Mar 2014 16:06:17 -0400
Message-ID: <20140312200617.GB3506@sigill.intra.peff.net>
References: <20140312200348.GB1816@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:06:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpQ2-0000cP-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbaCLUGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:06:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:38305 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752304AbaCLUGT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:06:19 -0400
Received: (qmail 31915 invoked by uid 102); 12 Mar 2014 20:06:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 15:06:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 16:06:17 -0400
Content-Disposition: inline
In-Reply-To: <20140312200348.GB1816@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243980>

This is the "rev-list" analogue to 25fba78 (cat-file:
disable object/refname ambiguity check for batch mode,
2013-07-12).  Like cat-file, "rev-list --stdin" may read a
large number of sha1 object names, and the warning check
introduces a significant slow-down.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/revision.c b/revision.c
index bd027bc..68d1b76 100644
--- a/revision.c
+++ b/revision.c
@@ -1575,6 +1575,10 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
+	int save_warning;
+
+	save_warning = warn_on_object_refname_ambiguity;
+	warn_on_object_refname_ambiguity = 0;
 
 	strbuf_init(&sb, 1000);
 	while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
@@ -1596,7 +1600,9 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 	}
 	if (seen_dashdash)
 		read_pathspec_from_stdin(revs, &sb, prune);
+
 	strbuf_release(&sb);
+	warn_on_object_refname_ambiguity = save_warning;
 }
 
 static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
-- 
1.9.0.403.g7a2f4b0
