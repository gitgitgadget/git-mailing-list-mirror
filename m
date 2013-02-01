From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Fri, 1 Feb 2013 05:40:10 -0500
Message-ID: <20130201104010.GH30644@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <20130130135607.GA23154@lanh>
 <CACsJy8Bqg6knVtddwaGSqtiXzVDgbO1JjbFOPMbF_RqrxM2rFQ@mail.gmail.com>
 <20130131110656.GA28093@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 11:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1E2u-0002sA-VN
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 11:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016Ab3BAKkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 05:40:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55376 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754980Ab3BAKkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 05:40:14 -0500
Received: (qmail 28075 invoked by uid 107); 1 Feb 2013 10:41:37 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 05:41:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 05:40:10 -0500
Content-Disposition: inline
In-Reply-To: <20130131110656.GA28093@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215232>

On Thu, Jan 31, 2013 at 06:06:56PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Wed, Jan 30, 2013 at 09:16:29PM +0700, Duy Nguyen wrote:
> > Perhaps we could store abbrev sha-1 instead of full sha-1. Nice
> > space/time trade-off.
> 
> Following the on-disk format experiment yesterday, I changed the
> format to:
> 
>  - a list a _short_ SHA-1 of cached commits
>  - a list of cache entries, each (5 uint32_t) consists of:
>    - uint32_t for the index in .idx sha-1 table to get full SHA-1 of
>      the commit
>    - uint32_t for timestamp
>    - uint32_t for tree, 1st and 2nd parents for the index in .idx
>      table

BTW, I needed the minor fixups below to silence some warnings from your
patch. Here are the cold and warm cache timings I got, as compared to
stock git and my implementation:

 Pack  |  Cold Revs   |  Warm Revs
-------+--------------+------------
 stock | 12.54        | 4.14
    me |  4.76 (-62%) | 0.66 (-84%)
   duy |  4.36 (-65%) | 0.55 (-86%)

Not surprising; yours is just a bit faster in terms of CPU, and even
gains a little more in the cold cache case. Nice. Of course that is just
gravy on top of the smaller disk usage, too. :)

---
diff --git a/commit-metapack.c b/commit-metapack.c
index c984b8e..78fd961 100644
--- a/commit-metapack.c
+++ b/commit-metapack.c
@@ -106,7 +106,7 @@ int commit_metapack(unsigned char *sha1,
 	for (p = commit_metapacks; p; p = p->next) {
 		struct commit_entry *data;
 		uint32_t p1, p2;
-		unsigned lo, hi, mi;
+		unsigned lo, hi;
 		int pos;
 
 		/* sha1_entry_pos does not work with abbreviated sha-1 */
@@ -161,7 +161,7 @@ static void get_commits(struct metapack_writer *mw,
 	struct write_cb *write_cb = (struct write_cb *)data;
 	enum object_type type = sha1_object_info(sha1, NULL);
 	struct commit *c;
-	int p1, p2;
+	int p1 = -1, p2 = -1;
 
 	if (type != OBJ_COMMIT)
 		return;
diff --git a/commit.c b/commit.c
index b326201..5b776f8 100644
--- a/commit.c
+++ b/commit.c
@@ -309,7 +309,7 @@ static int parse_commit_metapack(struct commit *item)
 
 static int parse_commit_metapack(struct commit *item)
 {
-	unsigned char *tree, *p1, *p2;
+	const unsigned char *tree, *p1, *p2;
 	uint32_t ts;
 
 	if (commit_metapack(item->object.sha1, &ts, &tree, &p1, &p2) < 0)
