From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/8] bundle: give list_prerequisites() loop body its own
 function
Date: Sat, 26 Jun 2010 01:20:47 -0500
Message-ID: <20100626062047.GD15881@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 554682@bugs.debian.org,
	Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 08:21:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOlG-0007AE-G5
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 08:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084Ab0FZGVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 02:21:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37683 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0FZGU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 02:20:59 -0400
Received: by iwn41 with SMTP id 41so2711526iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4b4PytFILURgC6JoQsxppxcUf0HADSe3G3Rsa51AUTY=;
        b=NGz4PMhxCf2qooWhR3cLf5vgIrtxUVfiVXV5FXMbeRNjy/CyTQkyoVPGjNyCRSfyfv
         MsYXwSMJMR1xFtC9aTQ8tHSYeELumQfZf0t9dMzQ8ZK7skZcE7Fcuv16n6i+254o894R
         Xgy/mnmP4tSJN6nArSSSKUNoeuYWvGvJjyRe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XK2qdA0NCWKJDewutaE9d5smH9dpuj+OsxH0pWkxMOxPo9Eaj8EWnnAXzHiSqHXOcG
         8LoSinEODL5ukOlxcTLelrojW4wXPP3oUglIKqVxPCdZSl2nCIqRPDXZJTNuLCVMjWBV
         pNI/UybEbWQ0UChhQc9Oqk5yWqYvrSyio/Drw=
Received: by 10.231.169.6 with SMTP id w6mr1845767iby.5.1277533258889;
        Fri, 25 Jun 2010 23:20:58 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id cr13sm1700834ibb.11.2010.06.25.23.20.58
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 23:20:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626061735.GA15881@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149731>

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 bundle.c |   57 +++++++++++++++++++++++++++++++--------------------------
 1 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/bundle.c b/bundle.c
index 0dd2acb..e90b5c5 100644
--- a/bundle.c
+++ b/bundle.c
@@ -193,6 +193,33 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 		(revs->min_age == -1 || revs->min_age > date);
 }
 
+static void list_prerequisite(int bundle_fd, struct rev_info *revs,
+		struct commit *rev)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+	enum object_type type;
+	unsigned long size;
+
+	/*
+	 * The commit buffer is needed
+	 * to pretty-print boundary commits.
+	 */
+	rev->buffer = read_sha1_file(rev->object.sha1, &type, &size);
+
+	strbuf_addch(&buf, '-');
+	strbuf_add(&buf, sha1_to_hex(rev->object.sha1), 40);
+	strbuf_addch(&buf, ' ');
+	pretty_print_commit(CMIT_FMT_ONELINE, rev, &buf, &ctx);
+	strbuf_addch(&buf, '\n');
+
+	write_or_die(bundle_fd, buf.buf, buf.len);
+
+	rev->object.flags |= UNINTERESTING;
+	add_pending_object(revs, &rev->object, buf.buf);
+	strbuf_release(&buf);
+}
+
 static int list_prerequisites(int bundle_fd, struct rev_info *revs,
 		int argc, const char * const *argv)
 {
@@ -209,33 +236,11 @@ static int list_prerequisites(int bundle_fd, struct rev_info *revs,
 	if (prepare_revision_walk(&boundary_revs))
 		return error("revision walk setup failed");
 
-	while ((rev = get_revision(&boundary_revs))) {
-		if (rev->object.flags & BOUNDARY) {
-			struct strbuf buf = STRBUF_INIT;
-			struct pretty_print_context ctx = {0};
-			enum object_type type;
-			unsigned long size;
-
-			/*
-			 * The commit buffer is needed
-			 * to pretty-print boundary commits.
-			 */
-			rev->buffer = read_sha1_file(rev->object.sha1,
-							&type, &size);
-
-			strbuf_addch(&buf, '-');
-			strbuf_add(&buf, sha1_to_hex(rev->object.sha1), 40);
-			strbuf_addch(&buf, ' ');
-			pretty_print_commit(CMIT_FMT_ONELINE, rev, &buf, &ctx);
-			strbuf_addch(&buf, '\n');
-			write_or_die(bundle_fd, buf.buf, buf.len);
-
-			rev->object.flags |= UNINTERESTING;
-			add_pending_object(revs, &rev->object, buf.buf);
-			strbuf_release(&buf);
-		} else {
+	while ((rev = get_revision(revs))) {
+		if (rev->object.flags & BOUNDARY)
+			list_prerequisite(bundle_fd, revs, rev);
+		else
 			rev->object.flags |= SHOWN;
-		}
 	}
 	return 0;
 }
-- 
1.7.1.198.g8d802
