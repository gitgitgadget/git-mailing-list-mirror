From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] revision: turn off object/refname ambiguity check for
 --stdin
Date: Tue, 7 Jan 2014 17:11:18 -0500
Message-ID: <20140107221118.GD10161@sigill.intra.peff.net>
References: <20140107220856.GA10074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:11:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0ert-0007j2-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbaAGWLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 17:11:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:56767 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753914AbaAGWLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 17:11:20 -0500
Received: (qmail 27894 invoked by uid 102); 7 Jan 2014 22:11:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 16:11:20 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 17:11:18 -0500
Content-Disposition: inline
In-Reply-To: <20140107220856.GA10074@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240172>

We currently check that any 40-hex object name we receive is
not also a refname, and output a warning if this is the
case.  When "rev-list --stdin" is used to receive object
names, we may receive a large number of inputs, and the cost
of checking each name as a ref is relatively high.

Commit 25fba78d already dropped this warning for "cat-file
--batch-check". The same reasoning applies for "rev-list
--stdin". Let's disable the check in that instance.

Here are before and after numbers:

  $ git rev-list --all >commits

  [before]
  $ best-of-five -i commits ./git rev-list --stdin --no-walk --pretty=raw

  real    0m0.675s
  user    0m0.552s
  sys     0m0.120s

  [after]
  $ best-of-five -i commits ./git rev-list --stdin --no-walk --pretty=raw

  real    0m0.415s
  user    0m0.400s
  sys     0m0.012s

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously we drop this one (and revert 25fba78d) if I can just make the
check faster.

 revision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/revision.c b/revision.c
index a68fde6..87d04dd 100644
--- a/revision.c
+++ b/revision.c
@@ -1576,7 +1576,9 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
+	int save_warning = warn_on_object_refname_ambiguity;
 
+	warn_on_object_refname_ambiguity = 0;
 	strbuf_init(&sb, 1000);
 	while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
 		int len = sb.len;
@@ -1595,6 +1597,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
 	}
+	warn_on_object_refname_ambiguity = save_warning;
 	if (seen_dashdash)
 		read_pathspec_from_stdin(revs, &sb, prune);
 	strbuf_release(&sb);
-- 
1.8.5.2.500.g8060133
